# ARShooter

[![License](https://img.shields.io/badge/license-Apache--2.0-blue.svg)](#license)

ARShooter is an open source Augmented Reality shooter made with ARKit and written in Swift. Hence, it is only useable with iOS 11.

For more details on how to get started with ARKit and make your own AR Shooter, take a look at the complementary (and complimentary) [tutorial](http://texnotes.me/post/5/).

![status](https://user-images.githubusercontent.com/13244177/26912181-a08e94cc-4bc7-11e7-9261-2ed24e69f1f7.gif "Status GIF")

## Requirements

* Xcode 9
* iOS 11
* A9 or better chip for ARWorldTrackingConfiguration

> Note: The app automatically detects if your device supports the ARWorldTrackingConfiguration. If not, it will use the less immersive AROrientationTrackingConfiguration, which is supported by all devices.

## Communication

- If you **found a bug**, open an issue after checking the [FAQ](#faq).
- If you **have a feature request**, open an issue.
- If you **want to contribute**, submit a pull request.

## Download

Simply navigate to your directory of interest, then clone.

```bash
$ git clone https://github.com/farice/ARShooter.git
```

If you'd like bullets to disappear rather than collect in the space around you, then switch to the `bullets-disappear` branch

```bash
 $ git checkout bullets-disappear
```

Finally, open the `*.xcodeproj` file and build to your [supported device](#requirements)

## FAQ

### I am getting the SCNMatrix error:

`Cannot invoke initializer for type 'SCNMatrix4' with an argument list of type '(matrix_float4x4)'`

Please update to the latest Xcode version (this error is a result of a syntactical change made in Beta 2). If you insist on using Xcode Beta 1, then simply replace SCNMatrix4 with SCNMatrix4FromMat4.

---

## Thanks

ARShooter has been featured by

* [ManiacDev](https://maniacdev.com/2017/06/arshooter-an-example-shooter-created-using-ios-11s-arkit)
* [Gank](http://gank.io/2017/06/09)
* [Swift News](http://swiftnews.curated.co/issues/134)
* [Juejin](https://juejin.im/)

## License

ARShooter is released under the Apache license. [See LICENSE](https://github.com/farice/ARShooter/blob/master/LICENSE) for details.
