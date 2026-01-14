//
//  SoundManager.swift
//  ARViewer
//
//  Manages audio playback for game sound effects
//

import AVFoundation

enum SoundEffect: String {
    case explosion = "explosion"
    case collision = "collision"
    case torpedo = "torpedo"
}

/// Handles sound effect playback with proper resource management
final class SoundManager {

    static let shared = SoundManager()

    private var players: [SoundEffect: AVAudioPlayer] = [:]
    private let playbackQueue = DispatchQueue(label: "com.arshooter.sound", qos: .userInitiated)

    private init() {
        preloadSounds()
    }

    // MARK: - Public API

    /// Plays a sound effect asynchronously
    /// - Parameter effect: The type of sound effect to play
    func play(_ effect: SoundEffect) {
        playbackQueue.async { [weak self] in
            self?.playSound(effect)
        }
    }

    // MARK: - Private Methods

    private func preloadSounds() {
        for effect in [SoundEffect.explosion, .collision, .torpedo] {
            loadSound(effect)
        }
    }

    private func loadSound(_ effect: SoundEffect) {
        guard let url = Bundle.main.url(forResource: effect.rawValue, withExtension: "mp3") else {
            print("SoundManager: Could not find sound file '\(effect.rawValue).mp3'")
            return
        }

        do {
            let player = try AVAudioPlayer(contentsOf: url)
            player.prepareToPlay()
            players[effect] = player
        } catch {
            print("SoundManager: Failed to load '\(effect.rawValue)': \(error.localizedDescription)")
        }
    }

    private func playSound(_ effect: SoundEffect) {
        // If we have a preloaded player, use a copy to allow overlapping sounds
        if let originalPlayer = players[effect],
           let url = originalPlayer.url {
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.play()
            } catch {
                print("SoundManager: Failed to play '\(effect.rawValue)': \(error.localizedDescription)")
            }
        } else {
            // Fallback: try to load and play directly
            guard let url = Bundle.main.url(forResource: effect.rawValue, withExtension: "mp3") else {
                return
            }
            do {
                let player = try AVAudioPlayer(contentsOf: url)
                player.play()
            } catch {
                print("SoundManager: Failed to play '\(effect.rawValue)': \(error.localizedDescription)")
            }
        }
    }
}
