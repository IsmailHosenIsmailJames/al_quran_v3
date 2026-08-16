import json
import os

translations = {
    "streamingAndNetwork": {
        "en": "Streaming & Network",
        "ar": "البث والشبكة",
        "az": "Yayım və Şəbəkə",
        "bn": "স্ট্রিমিং ও নেটওয়ার্ক",
        "de": "Streaming & Netzwerk",
        "es": "Transmisión y red",
        "fa": "پخش جریانی و شبکه",
        "fr": "Streaming et réseau",
        "hi": "स्ट्रीमिंग और नेटवर्क",
        "id": "Streaming & Jaringan",
        "it": "Streaming e rete",
        "ja": "ストリーミングとネットワーク",
        "kk": "Стриминг және желі",
        "ko": "스트리밍 및 네트워크",
        "ms": "Penstriman & Rangkaian",
        "pa": "ਸਟ੍ਰੀਮਿੰਗ ਅਤੇ ਨੈੱਟਵਰਕ",
        "ps": "سټریمینګ او شبکه",
        "pt": "Transmissão e rede",
        "ru": "Стриминг и сеть",
        "sw": "Utiririshaji na Mtandao",
        "ta": "ஸ்ட்ரீமிங் மற்றும் பிணையம்",
        "tr": "Akış ve Ağ",
        "ur": "اسٹریمنگ اور نیٹ ورک",
        "vi": "Phát trực tuyến & Mạng",
        "zh": "流媒体与网络"
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