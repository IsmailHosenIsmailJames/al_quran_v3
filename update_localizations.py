import json
import os

languages = [
    "en", "ar", "az", "bn", "de", "es", "fa", "fr", "hi", "id", "it", "ja", 
    "kk", "ko", "ms", "pa", "ps", "pt", "ru", "sw", "ta", "tr", "ur", "vi", "zh"
]

translations = {
   
    "explore": {
        "en": "Explore", "bn": "দেখুন", "ar": "استكشاف",
        "tr": "Keşfet", "ur": "دیکھیں", "fa": "کاوش",
        "id": "Jelajahi", "ms": "Terokai", "fr": "Explorer",
        "de": "Erkunden", "es": "Explorar", "ru": "Обзор",
        "hi": "देखें", "pt": "Explorar", "it": "Esplora",
        "ja": "探索", "ko": "탐색", "zh": "探索", "vi": "Khám phá",
        "sw": "Chunguza", "az": "Kəşf et", "kk": "Зерттеу",
        "pa": "ਖੋਜੋ", "ps": "پلټنه", "ta": "ஆராய்க"
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