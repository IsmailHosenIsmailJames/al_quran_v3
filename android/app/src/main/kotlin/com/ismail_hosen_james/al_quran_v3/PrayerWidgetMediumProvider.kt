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

class PrayerWidgetMediumProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        val isSystemDark = (context.resources.configuration.uiMode and Configuration.UI_MODE_NIGHT_MASK) == Configuration.UI_MODE_NIGHT_YES
        val isDark = widgetData.getBoolean("is_dark_mode", isSystemDark)

        // Explicit high-contrast colors for Dark and Light mode
        val headerLocationColor = if (isDark) Color.WHITE else Color.parseColor("#111827")
        val headerDateColor = if (isDark) Color.parseColor("#9CA3AF") else Color.parseColor("#6B7280")
        val countdownBadgeColor = if (isDark) Color.parseColor("#6EE7B7") else Color.parseColor("#047857")

        val activeTextColor = Color.WHITE
        val inactiveTitleColor = if (isDark) Color.parseColor("#D1D5DB") else Color.parseColor("#4B5563")
        val inactiveTimeColor = if (isDark) Color.WHITE else Color.parseColor("#111827")

        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.prayer_widget_medium).apply {
                val locationName = widgetData.getString("location_name", "Prayer Times") ?: "Prayer Times"
                val dateText = widgetData.getString("date_text", "Today") ?: "Today"
                val nextPrayerName = widgetData.getString("next_prayer_name", "Upcoming") ?: "Upcoming"
                val countdownText = widgetData.getString("next_prayer_countdown", "") ?: ""

                val nextBadge = if (countdownText.isNotEmpty()) {
                    "Next: $nextPrayerName $countdownText"
                } else {
                    "Next: $nextPrayerName"
                }

                setTextViewText(R.id.tv_med_location, locationName)
                setTextColor(R.id.tv_med_location, headerLocationColor)

                setTextViewText(R.id.tv_med_date, dateText)
                setTextColor(R.id.tv_med_date, headerDateColor)

                setTextViewText(R.id.tv_med_next_badge, nextBadge)
                setTextColor(R.id.tv_med_next_badge, countdownBadgeColor)

                // 5 Prayers Names
                setTextViewText(R.id.tv_fajr_title, widgetData.getString("fajr_name", "Fajr"))
                setTextViewText(R.id.tv_dhuhr_title, widgetData.getString("dhuhr_name", "Dhuhr"))
                setTextViewText(R.id.tv_asr_title, widgetData.getString("asr_name", "Asr"))
                setTextViewText(R.id.tv_maghrib_title, widgetData.getString("maghrib_name", "Maghrib"))
                setTextViewText(R.id.tv_isha_title, widgetData.getString("isha_name", "Isha"))

                // 5 Prayers Times
                setTextViewText(R.id.tv_fajr_time, widgetData.getString("fajr_time", "--:--"))
                setTextViewText(R.id.tv_dhuhr_time, widgetData.getString("dhuhr_time", "--:--"))
                setTextViewText(R.id.tv_asr_time, widgetData.getString("asr_time", "--:--"))
                setTextViewText(R.id.tv_maghrib_time, widgetData.getString("maghrib_time", "--:--"))
                setTextViewText(R.id.tv_isha_time, widgetData.getString("isha_time", "--:--"))

                // Active Highlights
                val fajrActive = widgetData.getBoolean("fajr_is_active", false)
                val dhuhrActive = widgetData.getBoolean("dhuhr_is_active", false)
                val asrActive = widgetData.getBoolean("asr_is_active", false)
                val maghribActive = widgetData.getBoolean("maghrib_is_active", false)
                val ishaActive = widgetData.getBoolean("isha_is_active", false)

                // Fajr
                setInt(R.id.ll_fajr, "setBackgroundResource", if (fajrActive) R.drawable.widget_active_pill else R.drawable.widget_item_bg)
                setTextColor(R.id.tv_fajr_title, if (fajrActive) activeTextColor else inactiveTitleColor)
                setTextColor(R.id.tv_fajr_time, if (fajrActive) activeTextColor else inactiveTimeColor)

                // Dhuhr
                setInt(R.id.ll_dhuhr, "setBackgroundResource", if (dhuhrActive) R.drawable.widget_active_pill else R.drawable.widget_item_bg)
                setTextColor(R.id.tv_dhuhr_title, if (dhuhrActive) activeTextColor else inactiveTitleColor)
                setTextColor(R.id.tv_dhuhr_time, if (dhuhrActive) activeTextColor else inactiveTimeColor)

                // Asr
                setInt(R.id.ll_asr, "setBackgroundResource", if (asrActive) R.drawable.widget_active_pill else R.drawable.widget_item_bg)
                setTextColor(R.id.tv_asr_title, if (asrActive) activeTextColor else inactiveTitleColor)
                setTextColor(R.id.tv_asr_time, if (asrActive) activeTextColor else inactiveTimeColor)

                // Maghrib
                setInt(R.id.ll_maghrib, "setBackgroundResource", if (maghribActive) R.drawable.widget_active_pill else R.drawable.widget_item_bg)
                setTextColor(R.id.tv_maghrib_title, if (maghribActive) activeTextColor else inactiveTitleColor)
                setTextColor(R.id.tv_maghrib_time, if (maghribActive) activeTextColor else inactiveTimeColor)

                // Isha
                setInt(R.id.ll_isha, "setBackgroundResource", if (ishaActive) R.drawable.widget_active_pill else R.drawable.widget_item_bg)
                setTextColor(R.id.tv_isha_title, if (ishaActive) activeTextColor else inactiveTitleColor)
                setTextColor(R.id.tv_isha_time, if (ishaActive) activeTextColor else inactiveTimeColor)

                // Deep link on click
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                    Uri.parse("al-quran://prayer")
                )
                setOnClickPendingIntent(R.id.widget_medium_root, pendingIntent)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
