import Flutter
import UIKit

@main
@objc class AppDelegate: FlutterAppDelegate {
    private let channelName = "com.example/platform_channel/getNativeData"
    private let CHANNEL = "com.example.datetime_example/dateTime"
  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {
    let controller = window?.rootViewController as! FlutterViewController
    let methodChannel = FlutterMethodChannel(name: channelName, binaryMessenger: controller.binaryMessenger)
    let library_channel = FlutterMethodChannel(name: CHANNEL, binaryMessenger: controller.binaryMessenger)

    library_channel.setMethodCallHandler { [weak self] (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "getCurrentDateTime" {
          let currentDateTime = Date().description
          result(currentDateTime)
      } else {
          result(FlutterMethodNotImplemented)
      }
    }

    methodChannel.setMethodCallHandler { (call: FlutterMethodCall, result: @escaping FlutterResult) in
      if call.method == "getNativeMessage" {
        let message = "iOS Native Message!"
        result(message)
      } else {
        result(FlutterMethodNotImplemented)
      }
    }
    GeneratedPluginRegistrant.register(with: self)
    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }
}
