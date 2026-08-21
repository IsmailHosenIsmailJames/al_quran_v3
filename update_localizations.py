import json
import os

languages = [
    "en", "ar", "az", "bn", "de", "es", "fa", "fr", "hi", "id", "it", "ja", 
    "kk", "ko", "ms", "pa", "ps", "pt", "ru", "sw", "ta", "tr", "ur", "vi", "zh"
]

translations = {
    "muted": {
        "en": "Muted", "bn": "মিউট", "ar": "مكتوم",
        "tr": "Sessiz", "ur": "خاموش", "fa": "بی‌صدا",
        "id": "Dibisukan", "ms": "Dibisukan", "fr": "Muet",
        "de": "Stumm", "es": "Silenciado", "ru": "Без звука",
        "hi": "म्यूट", "pt": "Silenciado", "it": "Disattivato",
        "ja": "消音", "ko": "음소거", "zh": "静音", "vi": "Tắt tiếng",
        "sw": "Kimya", "az": "Səssiz", "kk": "Дыбыссыз",
        "pa": "ਮਿਊਟ", "ps": "بې غږه", "ta": "அமைதி"
    },
    "alerts": {
        "en": "Alerts", "bn": "অ্যালার্ট", "ar": "تنبيهات",
        "tr": "Uyarılar", "ur": "اطلاعات", "fa": "هشدارها",
        "id": "Pemberitahuan", "ms": "Pemberitahuan", "fr": "Alertes",
        "de": "Benachrichtigungen", "es": "Alertas", "ru": "Оповещения",
        "hi": "अलर्ट", "pt": "Alertas", "it": "Avvisi",
        "ja": "通知", "ko": "알림", "zh": "提醒", "vi": "Thông báo",
        "sw": "Tahadhari", "az": "Xəbərdarlıqlar", "kk": "Ескертулер",
        "pa": "ਚੇਤਾਵਨੀਆਂ", "ps": "خبرتیاوې", "ta": "விழிப்பூட்டல்கள்"
    },
    "off": {
        "en": "Off", "bn": "বন্ধ", "ar": "إيقاف",
        "tr": "Kapalı", "ur": "بند", "fa": "خاموش",
        "id": "Mati", "ms": "Mati", "fr": "Désactivé",
        "de": "Aus", "es": "Desactivado", "ru": "Выкл",
        "hi": "बंद", "pt": "Desligado", "it": "Spento",
        "ja": "オフ", "ko": "꺼짐", "zh": "关闭", "vi": "Tắt",
        "sw": "Imezimwa", "az": "Bağlı", "kk": "Өшірулі",
        "pa": "ਬੰਦ", "ps": "بند", "ta": "முடக்கு"
    },
    "on": {
        "en": "On", "bn": "চালু", "ar": "تشغيل",
        "tr": "Açık", "ur": "آن", "fa": "روشن",
        "id": "Aktif", "ms": "Aktif", "fr": "Activé",
        "de": "Ein", "es": "Activado", "ru": "Вкл",
        "hi": "चालू", "pt": "Ligado", "it": "Acceso",
        "ja": "オン", "ko": "켜짐", "zh": "开启", "vi": "Bật",
        "sw": "Imewashwa", "az": "Açıq", "kk": "Қосулы",
        "pa": "ਚਾਲੂ", "ps": "روښانه", "ta": "இயக்கு"
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
            if key not in data or data[key] != val:
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