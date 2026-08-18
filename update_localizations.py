import json
import os

languages = [
    "en", "ar", "az", "bn", "de", "es", "fa", "fr", "hi", "id", "it", "ja", 
    "kk", "ko", "ms", "pa", "ps", "pt", "ru", "sw", "ta", "tr", "ur", "vi", "zh"
]

translations = {
    "actualTime": {
        "en": "Actual: {time}",
        "bn": "প্রকৃত সময়: {time}",
        "ar": "الوقت الفعلي: {time}",
        "az": "Faktiki: {time}",
        "de": "Tatsächlich: {time}",
        "es": "Hora real: {time}",
        "fa": "زمان واقعی: {time}",
        "fr": "Heure réelle : {time}",
        "hi": "वास्तविक समय: {time}",
        "id": "Waktu Sebenarnya: {time}",
        "it": "Ora effettiva: {time}",
        "ja": "実際: {time}",
        "kk": "Нақты уақыт: {time}",
        "ko": "실제 시간: {time}",
        "ms": "Waktu Sebenar: {time}",
        "pa": "ਅਸਲ ਸਮਾਂ: {time}",
        "ps": "اصلي وخت: {time}",
        "pt": "Horário real: {time}",
        "ru": "Фактическое: {time}",
        "sw": "Wakati Halisi: {time}",
        "ta": "உண்மையான நேரம்: {time}",
        "tr": "Gerçek Vakit: {time}",
        "ur": "اصل وقت: {time}",
        "vi": "Thời gian thực: {time}",
        "zh": "实际时间：{time}"
    },
    "nextPrayerLabel": {
        "en": "Next: {prayerName}",
        "bn": "পরবর্তী: {prayerName}",
        "ar": "التالي: {prayerName}",
        "az": "Növbəti: {prayerName}",
        "de": "Nächste: {prayerName}",
        "es": "Siguiente: {prayerName}",
        "fa": "بعدی: {prayerName}",
        "fr": "Suivant : {prayerName}",
        "hi": "अगला: {prayerName}",
        "id": "Berikutnya: {prayerName}",
        "it": "Successiva: {prayerName}",
        "ja": "次: {prayerName}",
        "kk": "Келесі: {prayerName}",
        "ko": "다음: {prayerName}",
        "ms": "Seterusnya: {prayerName}",
        "pa": "ਅਗਲਾ: {prayerName}",
        "ps": "راتلونکی: {prayerName}",
        "pt": "Próxima: {prayerName}",
        "ru": "Следующая: {prayerName}",
        "sw": "Inayofuata: {prayerName}",
        "ta": "அடுத்தது: {prayerName}",
        "tr": "Sonraki: {prayerName}",
        "ur": "اگلی: {prayerName}",
        "vi": "Tiếp theo: {prayerName}",
        "zh": "下一番：{prayerName}"
    },
    "currentPrayerLabel": {
        "en": "Now: {prayerName}",
        "bn": "এখন: {prayerName}",
        "ar": "الآن: {prayerName}",
        "az": "İndi: {prayerName}",
        "de": "Jetzt: {prayerName}",
        "es": "Ahora: {prayerName}",
        "fa": "اکنون: {prayerName}",
        "fr": "En ce moment : {prayerName}",
        "hi": "अभी: {prayerName}",
        "id": "Sekarang: {prayerName}",
        "it": "Ora: {prayerName}",
        "ja": "現在: {prayerName}",
        "kk": "Қазір: {prayerName}",
        "ko": "지금: {prayerName}",
        "ms": "Sekarang: {prayerName}",
        "pa": "ਹੁਣ: {prayerName}",
        "ps": "اوس: {prayerName}",
        "pt": "Agora: {prayerName}",
        "ru": "Сейчас: {prayerName}",
        "sw": "Sasa: {prayerName}",
        "ta": "இப்போது: {prayerName}",
        "tr": "Şimdi: {prayerName}",
        "ur": "ابھی: {prayerName}",
        "vi": "Hiện tại: {prayerName}",
        "zh": "当前：{prayerName}"
    },
    "startsAt": {
        "en": "{prayerName} starts at {time}",
        "bn": "{prayerName} শুরু {time}",
        "ar": "يبدأ {prayerName} في {time}",
        "az": "{prayerName} {time} başlayır",
        "de": "{prayerName} beginnt um {time}",
        "es": "{prayerName} comienza a las {time}",
        "fa": "{prayerName} در {time} شروع می‌شود",
        "fr": "{prayerName} commence à {time}",
        "hi": "{prayerName} {time} पर शुरू होता है",
        "id": "{prayerName} dimulai pukul {time}",
        "it": "{prayerName} inizia alle {time}",
        "ja": "{prayerName}の開始時刻 {time}",
        "kk": "{prayerName} уақыты: {time}",
        "ko": "{prayerName} 시작 시간 {time}",
        "ms": "{prayerName} bermula jam {time}" ,
        "pa": "{prayerName} {time} ਸ਼ੁਰੂ ਹੁੰਦਾ ਹੈ",
        "ps": "{prayerName} په {time} پیل کیږي",
        "pt": "{prayerName} começa às {time}",
        "ru": "{prayerName} начинается в {time}",
        "sw": "{prayerName} inaanza saa {time}",
        "ta": "{prayerName} தொடங்கும் நேரம் {time}",
        "tr": "{prayerName} {time} vaktinde başlar",
        "ur": "{prayerName} کا آغاز {time}",
        "vi": "{prayerName} bắt đầu lúc {time}",
        "zh": "{prayerName} 开始于 {time}"
    }
}

for lang in languages:
    file_path = f"lib/l10n/app_{lang}.arb"
    if os.path.exists(file_path):
        with open(file_path, 'r', encoding='utf-8') as f:
            try:
                data = json.load(f)
            except Exception as e:
                print(f"Error loading {file_path}: {e}")
                continue

        updated = False
        for key, lang_map in translations.items():
            val = lang_map.get(lang, lang_map.get("en"))
            if key not in data:
                data[key] = val
                updated = True

        if updated:
            with open(file_path, 'w', encoding='utf-8') as f:
                json.dump(data, f, ensure_ascii=False, indent=2)
                f.write('\n')
            print(f"Updated {file_path}")
        else:
            print(f"No new keys needed for {file_path}")
    else:
        print(f"File {file_path} does not exist.")

print("All language ARB files updated successfully.")