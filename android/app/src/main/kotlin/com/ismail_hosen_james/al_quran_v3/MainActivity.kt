package com.ismail_hosen_james.al_quran_v3

import android.app.Activity
import android.app.NotificationChannel
import android.app.NotificationManager
import android.content.Context
import android.content.Intent
import android.media.AudioAttributes
import android.media.MediaPlayer
import android.media.Ringtone
import android.media.RingtoneManager
import android.net.Uri
import android.os.Build
import com.ryanheise.audioservice.AudioServiceActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodCall
import io.flutter.plugin.common.MethodChannel

class MainActivity : AudioServiceActivity() {
    private val CHANNEL = "com.ismail_hosen_james.al_quran_v3/ringtone"
    private val RINGTONE_PICKER_REQUEST_CODE = 9912

    private var pendingResult: MethodChannel.Result? = null
    private var currentRingtone: Ringtone? = null
    private var currentMediaPlayer: MediaPlayer? = null

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)

        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL)
            .setMethodCallHandler { call, result ->
                when (call.method) {
                    "openRingtonePicker" -> {
                        openRingtonePicker(call, result)
                    }
                    "playRingtone" -> {
                        playRingtone(call, result)
                    }
                    "stopRingtone" -> {
                        stopRingtone()
                        result.success(true)
                    }
                    "getRingtones" -> {
                        getRingtones(result)
                    }
                    "createOrUpdateNotificationChannel" -> {
                        createOrUpdateNotificationChannel(call, result)
                    }
                    else -> {
                        result.notImplemented()
                    }
                }
            }
    }

    private fun openRingtonePicker(call: MethodCall, result: MethodChannel.Result) {
        if (pendingResult != null) {
            result.error("ALREADY_ACTIVE", "A ringtone picker is already open", null)
            return
        }
        pendingResult = result

        val currentUriStr = call.argument<String>("currentUri")
        val titleStr = call.argument<String>("title") ?: "Select Prayer Reminder Sound"

        val intent = Intent(RingtoneManager.ACTION_RINGTONE_PICKER).apply {
            putExtra(RingtoneManager.EXTRA_RINGTONE_TYPE, RingtoneManager.TYPE_ALL)
            putExtra(RingtoneManager.EXTRA_RINGTONE_SHOW_DEFAULT, true)
            putExtra(RingtoneManager.EXTRA_RINGTONE_SHOW_SILENT, false)
            putExtra(RingtoneManager.EXTRA_RINGTONE_TITLE, titleStr)
            if (!currentUriStr.isNullOrEmpty()) {
                try {
                    putExtra(RingtoneManager.EXTRA_RINGTONE_EXISTING_URI, Uri.parse(currentUriStr))
                } catch (_: Exception) {}
            }
        }

        try {
            startActivityForResult(intent, RINGTONE_PICKER_REQUEST_CODE)
        } catch (e: Exception) {
            pendingResult = null
            result.error("PICKER_ERROR", e.message, null)
        }
    }

    override fun onActivityResult(requestCode: Int, resultCode: Int, data: Intent?) {
        super.onActivityResult(requestCode, resultCode, data)

        if (requestCode == RINGTONE_PICKER_REQUEST_CODE) {
            val res = pendingResult
            pendingResult = null

            if (res != null) {
                if (resultCode == Activity.RESULT_OK && data != null) {
                    @Suppress("DEPRECATION")
                    val uri: Uri? = data.getParcelableExtra(RingtoneManager.EXTRA_RINGTONE_PICKED_URI)
                    if (uri != null) {
                        val title = try {
                            RingtoneManager.getRingtone(this, uri)?.getTitle(this) ?: "Custom Sound"
                        } catch (_: Exception) {
                            "Custom Sound"
                        }
                        res.success(mapOf("uri" to uri.toString(), "title" to title))
                    } else {
                        // Default sound chosen in picker
                        res.success(mapOf("uri" to "", "title" to "Default"))
                    }
                } else {
                    // Cancelled
                    res.success(null)
                }
            }
        }
    }

    private fun playRingtone(call: MethodCall, result: MethodChannel.Result) {
        stopRingtone()
        val uriStr = call.argument<String>("uri")

        try {
            if (uriStr.isNullOrEmpty() || uriStr == "default" || uriStr == "resource://raw/notification_sound") {
                val rawResId = resources.getIdentifier("notification_sound", "raw", packageName)
                if (rawResId != 0) {
                    currentMediaPlayer = MediaPlayer.create(this, rawResId)?.apply {
                        setOnCompletionListener {
                            stopRingtone()
                        }
                        start()
                    }
                    result.success(true)
                    return
                }
            }

            val uri = when (uriStr) {
                "system_alarm" -> RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM)
                "system_ringtone" -> RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE)
                "system_notification" -> RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
                else -> if (!uriStr.isNullOrEmpty()) Uri.parse(uriStr) else RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
            }

            currentRingtone = RingtoneManager.getRingtone(applicationContext, uri)?.apply {
                if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.P) {
                    isLooping = false
                }
                play()
            }
            result.success(true)
        } catch (e: Exception) {
            result.error("PLAY_ERROR", e.message, null)
        }
    }

    private fun stopRingtone() {
        try {
            currentRingtone?.stop()
            currentRingtone = null
        } catch (_: Exception) {}

        try {
            currentMediaPlayer?.stop()
            currentMediaPlayer?.release()
            currentMediaPlayer = null
        } catch (_: Exception) {}
    }

    private fun getRingtones(result: MethodChannel.Result) {
        try {
            val ringtoneManager = RingtoneManager(this)
            ringtoneManager.setType(RingtoneManager.TYPE_NOTIFICATION or RingtoneManager.TYPE_ALARM)
            val cursor = ringtoneManager.cursor
            val list = mutableListOf<Map<String, String>>()

            while (cursor.moveToNext()) {
                val title = cursor.getString(RingtoneManager.TITLE_COLUMN_INDEX)
                val uri = ringtoneManager.getRingtoneUri(cursor.position).toString()
                list.add(mapOf("title" to title, "uri" to uri))
            }
            result.success(list)
        } catch (e: Exception) {
            result.error("QUERY_ERROR", e.message, null)
        }
    }

    private fun createOrUpdateNotificationChannel(call: MethodCall, result: MethodChannel.Result) {
        val channelKey = call.argument<String>("channelKey") ?: "prayer_reminder"
        val channelName = call.argument<String>("channelName") ?: "Prayer Reminders"
        val soundUriStr = call.argument<String>("soundUri")
        val isAlarm = call.argument<Boolean>("isAlarm") ?: false

        if (Build.VERSION.SDK_INT >= Build.VERSION_CODES.O) {
            try {
                val notificationManager = getSystemService(Context.NOTIFICATION_SERVICE) as NotificationManager

                val soundUri: Uri = when {
                    soundUriStr.isNullOrEmpty() || soundUriStr == "default" || soundUriStr == "resource://raw/notification_sound" -> {
                        val rawResId = resources.getIdentifier("notification_sound", "raw", packageName)
                        if (rawResId != 0) {
                            Uri.parse("android.resource://$packageName/$rawResId")
                        } else {
                            RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
                        }
                    }
                    soundUriStr == "system_alarm" -> RingtoneManager.getDefaultUri(RingtoneManager.TYPE_ALARM)
                    soundUriStr == "system_ringtone" -> RingtoneManager.getDefaultUri(RingtoneManager.TYPE_RINGTONE)
                    soundUriStr == "system_notification" -> RingtoneManager.getDefaultUri(RingtoneManager.TYPE_NOTIFICATION)
                    else -> Uri.parse(soundUriStr)
                }

                val audioAttributes = AudioAttributes.Builder()
                    .setContentType(AudioAttributes.CONTENT_TYPE_SONIFICATION)
                    .setUsage(AudioAttributes.USAGE_NOTIFICATION)
                    .build()

                // If channel exists, delete before recreating to ensure sound update is applied by Android OS
                val existingChannel = notificationManager.getNotificationChannel(channelKey)
                if (existingChannel != null) {
                    notificationManager.deleteNotificationChannel(channelKey)
                }

                val channel = NotificationChannel(
                    channelKey,
                    channelName,
                    NotificationManager.IMPORTANCE_HIGH
                ).apply {
                    description = "Notifications for prayer time reminders"
                    setSound(soundUri, audioAttributes)
                    enableVibration(true)
                    enableLights(true)
                    setShowBadge(true)
                }

                notificationManager.createNotificationChannel(channel)
                result.success(true)
            } catch (e: Exception) {
                result.error("CHANNEL_ERROR", e.message, null)
            }
        } else {
            result.success(true)
        }
    }

    override fun onDestroy() {
        stopRingtone()
        super.onDestroy()
    }
}
