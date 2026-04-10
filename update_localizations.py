import json
import os

translations = {
   
    "close": {
        "ar": "إغلاق", "az": "Bağla", "bn": "বন্ধ করুন", "de": "Schließen", "es": "Cerrar", "fa": "بستن", "fr": "Fermer", "hi": "बंद करें", "id": "Tutup", "it": "Chiudi", "ja": "閉じる", "kk": "Жабу", "ko": "닫기", "ms": "Tutup", "pa": "ਬੰਦ ਕਰੋ", "ps": "بندول", "pt": "Fechar", "ru": "Закрыть", "sw": "Funga", "ta": "மூடு", "tr": "Kapat", "ur": "بند کریں", "vi": "Đóng", "zh": "关闭"
    },
    "circleJojomInQuranScript": {
        "ar": "دائرة جزم/سكون في خط القرآن",
        "az": "Quran skriptində dairəvi cəzm/sükun",
        "bn": "কুরআন স্ক্রিপ্টে বৃত্তাকার জজম/সুকুন",
        "de": "Kreis Jojom/Sukun in der Koran-Schrift",
        "es": "Círculo Jojom/Sukun en la escritura del Corán",
        "fa": "دایره جزم/سکون در خط قرآن",
        "fr": "Cercle Jojom/Sukun dans l'écriture du Coran",
        "hi": "कुरान लिपि में गोल जज़्म/सुकून",
        "id": "Lingkaran Jojom/Sukun dalam Skrip Quran",
        "it": "Cerchio Jojom/Sukun nella scrittura del Corano",
        "ja": "コーラン文字の円形スクーン",
        "kk": "Құран жазуындағы дөңгелек жәзм/сукун",
        "ko": "꾸란 스크립트의 원형 수쿤",
        "ms": "Bulatan Jojom/Sukun dalam Skrip Quran",
        "pa": "ਕੁਰਾਨ ਸਕ੍ਰਿਪਟ ਵਿੱਚ ਗੋਲ ਜਜ਼ਮ/ਸੁਕੂਨ",
        "ps": "په قرآني رسم الخط کې د جزم/سکون دائره",
        "pt": "Círculo Jojom/Sukun na escrita do Alcorão",
        "ru": "Круглый джазм/сукун в кораническом письме",
        "sw": "Duara la Jojom/Sukun katika Maandishi ya Quran",
        "ta": "குர்ஆன் எழுத்தில் வட்ட ஜஜம்/சுகூன்",
        "tr": "Kur'an Hattında Yuvarlak Cezm/Sükun",
        "ur": "قرآن اسکرپٹ میں جزم/سکون کا دائرہ",
        "vi": "Vòng tròn Jojom/Sukun dalam văn bản Quran",
        "zh": "古兰经手稿中的圆形静符"
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