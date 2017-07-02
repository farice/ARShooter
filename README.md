# ARShooter

A basic Augmented Reality shooter made with ARKit (and hence only useable with the iOS 11 beta).

For more details check out the associated [tutorial](http://texnotes.me/post/5/).

![status](https://user-images.githubusercontent.com/13244177/26912181-a08e94cc-4bc7-11e7-9261-2ed24e69f1f7.gif "Status GIF")

## Requirements

* Xcode 9 Beta 2
* iOS 11 Beta 2
* A9 or better chip for ARWorldTrackingSessionConfiguration

> Note: The app automatically detects if your device supports the ARWorldTrackingSessionConfiguration. If not, it will use the less immersive ARSessionConfiguration, which is to be supported by all devices. However, at the current time (Beta 2), ARSessionConfiguration is also only supported by devices with an A9 or better chip. See the [release notes](https://9to5mac.com/2017/06/21/apple-ios-11-beta-2/) for details. **This means you need an iPhone 6S or better to use ARKit at the current time.**

> I am seeing the error: Cannot invoke initializer for type 'SCNMatrix4' with an argument list of type '(matrix_float4x4)'

Please update to the latest Xcode beta (this error is a result of a syntactical change made in Beta 2). If you insist on using Xcode Beta 1, then simply replace SCNMatrix4 with SCNMatrix4FromMat4. 
