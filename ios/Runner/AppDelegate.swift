import UIKit
import Flutter

@UIApplicationMain
@objc class AppDelegate: FlutterAppDelegate {

  var handler: StreamHandlerSwift = StreamHandlerSwift()
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
 
   GeneratedPluginRegistrant.register(with: self)
     guard let controller = window?.rootViewController as? FlutterViewController else {
      fatalError("rootViewController is not type FlutterViewController")
    }   
   let channel = FlutterEventChannel(
            name: "com.example.tipti_test.flutter_event_channel/gyroscope_data", binaryMessenger: controller.binaryMessenger)
    channel.setStreamHandler(handler)   
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

    
}
