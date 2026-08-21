package com.ismail_hosen_james.al_quran_v3

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.content.res.Configuration
import android.graphics.Color
import android.net.Uri
import android.widget.RemoteViews
import com.ismail_hosen_james.al_bayan_quran.R
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetProvider

class PrayerWidgetSmallProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        val isSystemDark = (context.resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_YES
        val isDark = widgetData.getBoolean("is_dark_mode", isSystemDark)

        val locationColor = if (isDark) Color.WHITE else Color.parseColor("#111827")
        val nextPrayerTitleColor = if (isDark) Color.parseColor("#34D399") else Color.parseColor("#059669")
        val nextPrayerTimeColor = if (isDark) Color.WHITE else Color.parseColor("#111827")
        val countdownBadgeColor = if (isDark) Color.parseColor("#6EE7B7") else Color.parseColor("#047857")

        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.prayer_widget_small).apply {
                val locationName = widgetData.getString("location_name", "Prayer Times") ?: "Prayer Times"
                val nextPrayerName = widgetData.getString("next_prayer_name", "Upcoming") ?: "Upcoming"
                val nextPrayerTime = widgetData.getString("next_prayer_time", "--:--") ?: "--:--"
                val countdownText = widgetData.getString("next_prayer_countdown", "Upcoming") ?: "Upcoming"

                setTextViewText(R.id.tv_location, locationName)
                setTextColor(R.id.tv_location, locationColor)

                setTextViewText(R.id.tv_next_prayer_name, nextPrayerName)
                setTextColor(R.id.tv_next_prayer_name, nextPrayerTitleColor)

                setTextViewText(R.id.tv_next_prayer_time, nextPrayerTime)
                setTextColor(R.id.tv_next_prayer_time, nextPrayerTimeColor)

                setTextViewText(R.id.tv_countdown, countdownText)
                setTextColor(R.id.tv_countdown, countdownBadgeColor)

                // Deep link on click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                    Uri.parse("al-quran://prayer")
                )
                setOnClickPendingIntent(R.id.widget_small_root, pendingIntent)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
