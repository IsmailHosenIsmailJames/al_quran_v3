import json
import os

translations = {
    "tajweedGuide": {
        "ar": "دليل التجويد",
        "az": "Təcvid Bələdçisi",
        "bn": "তাজবীদ গাইড",
        "de": "Tajweed-Anleitung",
        "es": "Guía de Tajweed",
        "fa": "راهنمای تجوید",
        "fr": "Guide du Tajweed",
        "ha": "Jagoran Tajwidi",
        "hi": "तजवीद गाइड",
        "id": "Panduan Tajwid",
        "it": "Guida al Tajweed",
        "ja": "タジュウィードガイド",
        "kk": "Тәжуид нұсқаулығы",
        "ko": "타지위드 가이드",
        "ku": "Rêberê Tecwîdê",
        "ms": "Panduan Tajwid",
        "pa": "ਤਜਵੀਦ ਗਾਈਡ",
        "ps": "د تجوید لارښود",
        "pt": "Guia de Tajweed",
        "ru": "Руководство по таджвиду",
        "so": "Hagaha Tajweedka",
        "sw": "Mwongozo wa Tajweed",
        "ta": "தஜ்வீத் வழிகாட்டி",
        "tr": "Tecvid Rehberi",
        "ug": "تەجۋىد قوللانمىسى",
        "ur": "تجوید گائیڈ",
        "vi": "Hướng dẫn Tajweed",
        "yo": "Itọsọna Tajweed",
        "zh": "泰吉威德指南"
    },
    "initiallyScrollAyah": {
        "ar": "التمرير في البداية إلى الآية",
        "az": "Başlanğıcda ayəyə sürüşdürün",
        "bn": "প্রাথমিকভাবে আয়াতে স্ক্রোল করুন",
        "de": "Zuerst zu Ayah scrollen",
        "es": "Desplazarse inicialmente a la aleya",
        "fa": "در ابتدا به آیه بروید",
        "fr": "Faire défiler initialement jusqu'à l'ayah",
        "ha": "Da farko gungura zuwa ayah",
        "hi": "शुरू में आयत पर स्क्रॉल करें",
        "id": "Awalnya gulir ke ayat",
        "it": "Inizialmente scorri fino all'ayah",
        "ja": "最初にアヤにスクロールします",
        "kk": "Бастапқыда аятқа жылжыңыз",
        "ko": "처음에 ayah로 스크롤",
        "ku": "Di destpêkê de biçin ayetê",
        "ms": "Tatal pada mulanya ke ayah",
        "pa": "ਸ਼ੁਰੂ ਵਿੱਚ ਆਯਾਹ 'ਤੇ ਸਕ੍ਰੋਲ ਕਰੋ",
        "ps": "په پیل کې آیت ته سکرول کړئ",
        "pt": "Inicialmente, role para o ayah",
        "ru": "Первоначально прокрутите до аята",
        "so": "Marka hore u gudub aayadda",
        "sw": "Awali tembeza hadi kwenye ayah",
        "ta": "ஆரம்பத்தில் ஆயாவுக்கு உருட்டவும்",
        "tr": "Başlangıçta ayete gidin",
        "ug": "ئالدى بىلەن ئايەتكە سürün",
        "ur": "ابتدائی طور پر آیت پر سکرول کریں",
        "vi": "Ban đầu cuộn đến ayah",
        "yo": "Wiwọle Yara",
        "zh": "最初滚动到 ayah"
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
                        print(f"Key already exists in {file_path}")

print("Localization update complete.")