# ARShooter

A basic Augmented Reality shooter made with ARKit (and hence only useable with the iOS 11 beta).

Star if you're interested in a [tutorial](http://texnotes.me/post/5/).

![status](https://user-images.githubusercontent.com/13244177/26856310-c307c046-4ad7-11e7-9689-7dba5ed01845.gif "Status GIF")

### Update: Associated tutorial is now available [here](http://texnotes.me/post/5/)

## Requirements

* Xcode 9 Beta
* iOS 11 Beta
* A9 or better chip for ARWorldTrackingSessionConfiguration

> Note: The app automatically detects if your device supports the ARWorldTrackingSessionConfiguration. If not, it will use the less immersive ARSessionConfiguration, which is to be supported by all devices. However, at the current time (Beta 1), ARSessionConfiguration is also only supported by devices with an A9 or better chip. See the [release notes](http://www.redmondpie.com/ios-11-beta-1-release-notes-changes-and-known-issues-according-to-apple/) for details. **This means you need an iPhone 6S or better to use ARKit at the current time.**
