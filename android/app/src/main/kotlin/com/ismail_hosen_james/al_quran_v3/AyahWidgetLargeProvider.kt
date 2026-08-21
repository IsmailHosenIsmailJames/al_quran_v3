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

class AyahWidgetLargeProvider : HomeWidgetProvider() {
    override fun onUpdate(
        context: Context,
        appWidgetManager: AppWidgetManager,
        appWidgetIds: IntArray,
        widgetData: SharedPreferences
    ) {
        appWidgetIds.forEach { widgetId ->
            val views = RemoteViews(context.packageName, R.layout.ayah_widget_large).apply {
                val surahName = widgetData.getString("ayah_surah_name", "Al-Baqarah") ?: "Al-Baqarah"
                val surahArabic = widgetData.getString("ayah_surah_arabic_name", "البقرة") ?: "البقرة"
                val surahType = widgetData.getString("ayah_surah_type", "Medinan • 286 Verses") ?: "Medinan • 286 Verses"
                val reference = widgetData.getString("ayah_reference", "2:255") ?: "2:255"
                val arabicText = widgetData.getString("ayah_arabic_text", "اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ") ?: "اللَّهُ لَا إِلَٰهَ إِلَّا هُوَ الْحَيُّ الْقَيُّومُ ۚ لَا تَأْخُذُهُ سِنَةٌ وَلَا نَوْمٌ ۚ لَهُ مَا فِي السَّمَاوَاتِ وَمَا فِي الْأَرْضِ"
                val translationText = widgetData.getString("ayah_translation_text", "Allah - there is no deity except Him, the Ever-Living, the Sustainer of all existence. Neither drowsiness overtakes Him nor sleep. To Him belongs whatever is in the heavens and whatever is on the earth.") ?: "Allah - there is no deity except Him, the Ever-Living, the Sustainer of all existence. Neither drowsiness overtakes Him nor sleep. To Him belongs whatever is in the heavens and whatever is on the earth."
                val surahId = widgetData.getInt("ayah_surah_id", 2)
                val ayahNumber = widgetData.getInt("ayah_number", 255)

                val badgeText = "Ayah $ayahNumber"

                setTextViewText(R.id.tv_ayah_large_surah_name, surahName)
                setTextViewText(R.id.tv_ayah_large_surah_arabic, surahArabic)
                setTextViewText(R.id.tv_ayah_large_surah_type, surahType)
                setTextViewText(R.id.tv_ayah_large_reference, badgeText)
                setTextViewText(R.id.tv_ayah_large_arabic, arabicText)
                setTextViewText(R.id.tv_ayah_large_translation, translationText)

                // Deep link on click: al-quran://ayah?surah=X&ayah=Y
                val pendingIntent = HomeWidgetLaunchIntent.getActivity(
                    context,
                    MainActivity::class.java,
                    Uri.parse("al-quran://ayah?surah=$surahId&ayah=$ayahNumber")
                )
                setOnClickPendingIntent(R.id.widget_ayah_large_root, pendingIntent)
            }

            appWidgetManager.updateAppWidget(widgetId, views)
        }
    }
}
