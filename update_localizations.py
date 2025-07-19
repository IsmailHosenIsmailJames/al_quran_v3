import json
import os

translations = {
    "ar": "الوصول السريع",
    "az": "Sürətli Giriş",
    "bn": "দ্রুত অ্যাক্সেস",
    "de": "Schnellzugriff",
    "es": "Acceso rápido",
    "fa": "دسترسی سریع",
    "fr": "Accès rapide",
    "ha": "Samun Sauri",
    "hi": "त्वरित पहुँच",
    "id": "Akses Cepat",
    "it": "Accesso rapido",
    "ja": "クイックアクセス",
    "kk": "Жылдам қатынау",
    "ko": "빠른 접근",
    "ku": "Gihîştina Lezgîn",
    "ms": "Akses Pantas",
    "pa": "ਤੁਰੰਤ ਪਹੁੰਚ",
    "ps": "چټک لاسرسی",
    "pt": "Acesso rápido",
    "ru": "Быстрый доступ",
    "so": "Helitaan Degdeg ah",
    "sw": "Ufikiaji wa Haraka",
    "ta": "விரைவான அணுகல்",
    "tr": "Hızlı Erişim",
    "ug": "تېز زىيارەت",
    "ur": "فوری رسائی",
    "vi": "Truy cập nhanh",
    "yo": "Wiwọle Yara",
    "zh": "快速访问"
}

for lang, translation in translations.items():
    file_path = f"lib/l10n/app_{lang}.arb"
    if os.path.exists(file_path):
        with open(file_path, 'r+', encoding='utf-8') as f:
            content = f.read()
            last_brace_index = content.rfind('}')
            if last_brace_index != -1:
                content_before_brace = content[:last_brace_index].rstrip()
                if content_before_brace.endswith(','):
                    content_before_brace = content_before_brace.rstrip(',')
                
                new_key_value = f'"quickAccess": {json.dumps(translation, ensure_ascii=False)}'
                
                if f'"quickAccess":' not in content_before_brace:
                    new_content = content_before_brace + ',\n  ' + new_key_value + '\n}'
                    f.seek(0)
                    f.write(new_content)
                    f.truncate()
                    print(f"Updated {file_path}")
                else:
                    print(f"Key already exists in {file_path}")

print("Localization update complete.")
