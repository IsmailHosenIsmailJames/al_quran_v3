package com.ismail_hosen_james.al_quran_v3

import android.appwidget.AppWidgetManager
import android.content.Context
import android.content.SharedPreferences
import android.net.Uri
import android.widget.RemoteViews
import com.ismail_hosen_james.al_bayan_quran.R
import es.antonborri.home_widget.HomeWidgetLaunchIntent
import es.antonborri.home_widget.HomeWidgetPlugin
import es.antonborri.home_widget.HomeWidgetProvider

class AyahWidgetSmallProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.ayah_widget_small).apply {
                val surahName = widgetData.getString("ayah_surah_name", "Al-Baqarah") ?: "Al-Baqarah"
                val reference = widgetData.getString("ayah_reference", "2:255") ?: "2:255"
                val arabicText = widgetData.getString("ayah_arabic_text", "اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ") ?: "اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ"
                val translationText = widgetData.getString("ayah_translation_text", "Allah - there is no deity except Him, the Ever-Living, Sustainer.") ?: "Allah - there is no deity except Him, the Ever-Living, Sustainer."
                val surahId = widgetData.getInt("ayah_surah_id", 2)
                val ayahNumber = widgetData.getInt("ayah_number", 255)

                setTextViewText(R.id.tv_ayah_small_surah_name, surahName)
                setTextViewText(R.id.tv_ayah_small_reference, reference)
                setTextViewText(R.id.tv_ayah_small_arabic, arabicText)
                setTextViewText(R.id.tv_ayah_small_translation, translationText)

                // Deep link on click: al-quran://ayah?surah=X&ayah=Y
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                    Uri.parse("al-quran://ayah?surah=$surahId&ayah=$ayahNumber")
                )
                setOnClickPendingIntent(R.id.widget_ayah_small_root, pendingIntent)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
