package com.example.platform_channel_example

import android.os.Bundle
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel
import java.util.*

class MainActivity: FlutterActivity() {
    private val CHANNEL = "com.example/platform_channel/getNativeData"
    private val DATETIME_LIBRARY_CHANNEL = "com.example.datetime_example/dateTime"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                if (call.method == "getNativeMessage") {
                    val message = "Android Native Message!"
                    result.success(message)
                } else {
                    result.notImplemented()
                }
            }
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, DATETIME_LIBRARY_CHANNEL).setMethodCallHandler { call, result ->
                if (call.method == "getCurrentDateTime") {
                    val currentDateTime = Calendar.getInstance().time.toString()
                    result.success(currentDateTime)
                } else {
                    result.notImplemented()
                }
            }
    }
}
