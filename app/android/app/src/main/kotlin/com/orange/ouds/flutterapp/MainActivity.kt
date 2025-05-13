package com.orange.ouds.flutterapp

import com.orange.ouds.flutterapp.navigation.SystemSettingsNavigator
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    private val CHANNEL = "app.channel.shared.data"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler {
                call, result ->
            if (call.method == "openLanguageSettings") {
                SystemSettingsNavigator.openAppLanguageSettings(this)
                result.success(null)
            } else {
                result.notImplemented()
            }
        }
    }
}