import json
import os

translations = {
    "ar": "التمرير مع التلاوة",
    "az": "Tilavətlə Sürüşdürün",
    "bn": "তিলাওয়াতের সাথে স্ক্রোল করুন",
    "de": "Scrollen mit Rezitation",
    "es": "Desplazarse con recitación",
    "fa": "پیمایش با تلاوت",
    "fr": "Faire défiler avec récitation",
    "ha": "Gungura da Karatu",
    "hi": "सस्वर पाठ के साथ स्क्रॉल करें",
    "id": "Gulir dengan Bacaan",
    "it": "Scorri con la recitazione",
    "ja": "朗読でスクロール",
    "kk": "Оқумен айналдыру",
    "ko": "낭송으로 스크롤",
    "ku": "Bi xwendinê bigerin",
    "ms": "Tatal dengan Bacaan",
    "pa": "ਪਾਠ ਦੇ ਨਾਲ ਸਕ੍ਰੋਲ ਕਰੋ",
    "ps": "د تلاوت سره سکرول کړئ",
    "pt": "Rolar com recitação",
    "ru": "Прокрутка с чтением",
    "so": "Ku rogrogasho akhris",
    "sw": "Tembeza na Kisomo",
    "ta": "పారాయణంతో స్క్రోల్ చేయండి",
    "tr": "Okunuşla Kaydır",
    "ug": "قىرائەت بىلەن سىيرىڭ",
    "ur": "تلاوت کے ساتھ سکرول کریں۔",
    "vi": "Cuộn với đọc thuộc lòng",
    "yo": "Yi lọ pẹlu kika",
    "zh": "滚动背诵"
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
                
                new_key_value = f'"scrollWithRecitation": {json.dumps(translation, ensure_ascii=False)}'
                
                if f'"scrollWithRecitation":' not in content_before_brace:
                    new_content = content_before_brace + ',\n  ' + new_key_value + '\n}'
                    f.seek(0)
                    f.write(new_content)
                    f.truncate()
                    print(f"Updated {file_path}")
                else:
                    print(f"Key already exists in {file_path}")

print("Localization update complete.")