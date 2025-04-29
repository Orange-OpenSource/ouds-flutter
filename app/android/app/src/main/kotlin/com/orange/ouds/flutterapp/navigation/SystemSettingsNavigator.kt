package com.orange.ouds.flutterapp.navigation

import android.content.Context
import android.content.Intent
import android.net.Uri
import android.os.Build
import android.provider.Settings
import android.util.Log

object SystemSettingsNavigator {

    fun openAppLanguageSettings(context: Context) {
        val intent = if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.TIRAMISU) {
            Intent(Settings.ACTION_APP_LOCALE_SETTINGS, Uri.parse("package:${context.packageName}"))
        } else {
            Intent(Settings.ACTION_LOCALE_SETTINGS)
        }.apply {
            addFlags(Intent.FLAG_ACTIVITY_NEW_TASK)
        }

        if (intent.resolveActivity(context.packageManager) != null) {
            context.startActivity(intent)
        } else {
            Log.e("SystemSettings", "No activity found to handle intent: ${intent.action}")
        }
    }
}