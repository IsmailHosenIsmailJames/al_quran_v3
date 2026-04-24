import json
import os

translations = {
    "hijri": {
        "ar": "هجري", "az": "Hicri", "bn": "হিজরি", "de": "Hidschri", "es": "Hégira", "fa": "هجری", "fr": "Hégirien", "hi": "हिजरी", "id": "Hijriah", "it": "Egira", "ja": "ヒジュラ暦", "kk": "Хижра", "ko": "히즈라", "ms": "Hijrah", "pa": "ਹਿਜਰੀ", "ps": "هجري", "pt": "Hégira", "ru": "Хиджра", "sw": "Hijria", "ta": "ஹிஜ்ரி", "tr": "Hicri", "ur": "ہجری", "vi": "Hijri", "zh": "回历"
    },
    "gregorian": {
        "ar": "ميلادي", "az": "Qriqorian", "bn": "গ্রেগরিয়ান", "de": "Gregorianisch", "es": "Gregoriano", "fa": "میلادی", "fr": "Grégorien", "hi": "ग्रेगोरियन", "id": "Masehi", "it": "Gregoriano", "ja": "グレゴリオ暦", "kk": "Григориан", "ko": "그레고리력", "ms": "Masihi", "pa": "ਗ੍ਰੈਗੋਰੀਅਨ", "ps": "ګریګورین", "pt": "Gregoriano", "ru": "Григорианский", "sw": "Gregori", "ta": "கிரிகோரியன்", "tr": "Miladi", "ur": "عیسوی", "vi": "Dương lịch", "zh": "公历"
    },
    "prayerTimesCalender": {
        "ar": "تقويم أوقات الصلاة", "az": "Namaz Vaxtları Təqvimi", "bn": "নামাজের সময়সূচী ক্যালেন্ডার", "de": "Gebetszeitenkalender", "es": "Calendario de Tiempos de Oración", "fa": "تقویم اوقات شرعی", "fr": "Calendrier des heures de prière", "hi": "प्रार्थना के समय का कैलेंडर", "id": "Kalender Waktu Salat", "it": "Calendario dei tempi di preghiera", "ja": "礼拝時間カレンダー", "kk": "Намаз уақыттарының күнтізбесі", "ko": "기도 시간 달력", "ms": "Kalendar Waktu Solat", "pa": "ਪ੍ਰਾਰਥਨਾ ਦੇ ਸਮੇਂ ਦਾ ਕੈਲੰਡਰ", "ps": "د لمانځه وختونو کیلنڈر", "pt": "Calendário de Horários de Oração", "ru": "Календарь времени молитв", "sw": "Kalenda ya Nyakati za Swala", "ta": "தொழுகை நேரங்கள் நாட்காட்டி", "tr": "Namaz Vakitleri Takvimi", "ur": "نماز کے اوقات کا کیلنڈر", "vi": "Lịch Thời gian Cầu nguyện", "zh": "祈祷时间日历"
    }
}

for key, lang_translations in translations.items():
    for lang, translation in lang_translations.items():
        file_path = f"lib/l10n/app_{lang}.arb"
        if os.path.exists(file_path):
            with open(file_path, 'r+', encoding='utf-8') as f:
                content = f.read()
                last_brace_index = content.rfind('}')
                if last_brace_index != -1:
                    content_before_brace = content[:last_brace_index].rstrip()
                    if content_before_brace.endswith(','):
                        content_before_brace = content_before_brace.rstrip(',')
                    
                    new_key_value = f'"{key}": {json.dumps(translation, ensure_ascii=False)}'
                    
                    if f'"{key}":' not in content_before_brace:
                        new_content = content_before_brace + ',\n  ' + new_key_value + '\n}'
                        f.seek(0)
                        f.write(new_content)
                        f.truncate()
                        print(f"Updated {file_path}")
                    else:
                        print(f"Key '{key}' already exists in {file_path}, skipping.")
        else:
            print(f"File {file_path} does not exist, skipping.")

print("Localization update complete.")