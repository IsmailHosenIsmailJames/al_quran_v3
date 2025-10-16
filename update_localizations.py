import json
import os

translations = {
    "am": {
        "ar": "صباحًا",
        "az": "AM",
        "bn": "AM",
        "de": "AM",
        "es": "AM",
        "fa": "ق.ظ",
        "fr": "AM",
        "ha": "AM",
        "hi": "AM",
        "id": "AM",
        "it": "AM",
        "ja": "午前",
        "kk": "AM",
        "ko": "오전",
        "ku": "AM",
        "ms": "AM",
        "pa": "AM",
        "ps": "سهار",
        "pt": "AM",
        "ru": "AM",
        "so": "AM",
        "sw": "AM",
        "ta": "AM",
        "tr": "ÖÖ",
        "ug": "ئەتىگەن",
        "ur": "صبح",
        "vi": "SA",
        "yo": "AM",
        "zh": "上午"
    },
    "pm": {
        "ar": "مساءً",
        "az": "PM",
        "bn": "PM",
        "de": "PM",
        "es": "PM",
        "fa": "ب.ظ",
        "fr": "PM",
        "ha": "PM",
        "hi": "PM",
        "id": "PM",
        "it": "PM",
        "ja": "午後",
        "kk": "PM",
        "ko": "오후",
        "ku": "PM",
        "ms": "PM",
        "pa": "PM",
        "ps": "غرمه",
        "pt": "PM",
        "ru": "PM",
        "so": "PM",
        "sw": "PM",
        "ta": "PM",
        "tr": "ÖS",
        "ug": "چۈشتىن كېيىن",
        "ur": "شام",
        "vi": "CH",
        "yo": "PM",
        "zh": "下午"
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