import json
import os

languages = [
    "en", "ar", "az", "bn", "de", "es", "fa", "fr", "hi", "id", "it", "ja", 
    "kk", "ko", "ms", "pa", "ps", "pt", "ru", "sw", "ta", "tr", "ur", "vi", "zh"
]

translations = {
    "back": {
        "en": "Back", "bn": "ফিরে যান", "ar": "رجوع",
        "tr": "Geri", "ur": "واپس", "fa": "بازگشت",
        "id": "Kembali", "ms": "Kembali", "fr": "Retour",
        "de": "Zurück", "es": "Atrás", "ru": "Назад",
        "hi": "पीछे", "pt": "Voltar", "it": "Indietro",
        "ja": "戻る", "ko": "뒤로", "zh": "返回", "vi": "Quay lại",
        "sw": "Nyuma", "az": "Geri", "kk": "Артқа",
        "pa": "ਵਾਪਸ", "ps": "شاته", "ta": "பின்செல்"
    },
    "script": {
        "en": "Script", "bn": "স্ক্রিপ্ট", "ar": "رسم الخط",
        "tr": "Yazı", "ur": "رسم الخط", "fa": "رسم الخط",
        "id": "Skrip", "ms": "Skrip", "fr": "Écriture",
        "de": "Schrift", "es": "Escritura", "ru": "Шрифт",
        "hi": "स्क्रिप्ट", "pt": "Escrita", "it": "Scrittura",
        "ja": "書体", "ko": "서체", "zh": "字体", "vi": "Chữ viết",
        "sw": "Nakala", "az": "Xətt", "kk": "Жазу",
        "pa": "ਸਕ੍ਰਿਪਟ", "ps": "لیک", "ta": "எழுத்துரு"
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