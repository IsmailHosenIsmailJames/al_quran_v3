import json
import os

translations = {
    "heading": {
        "en": "Heading",
        "ar": "الاتجاه",
        "az": "İstiqamət",
        "bn": "হেডিং",
        "de": "Ausrichtung",
        "es": "Rumbo",
        "fa": "جهت",
        "fr": "Cap",
        "hi": "दिशा",
        "id": "Arah",
        "it": "Rilevamento",
        "ja": "方位",
        "kk": "Бағыт",
        "ko": "방위",
        "ms": "Haluan",
        "pa": "ਦਿਸ਼ਾ",
        "ps": "لارښود",
        "pt": "Rumo",
        "ru": "Направление",
        "sw": "Mwelekeo",
        "ta": "திசை",
        "tr": "Pusula Yönü",
        "ur": "رخ",
        "vi": "Hướng",
        "zh": "朝向"
    },
    "alignedWithKaaba": {
        "en": "Aligned with Kaaba",
        "ar": "محاذٍ للكعبة",
        "az": "Kəbə ilə eyni istiqamətdə",
        "bn": "কাবার সাথে সারিবদ্ধ",
        "de": "Ausgerichtet auf die Kaaba",
        "es": "Alineado con la Kaaba",
        "fa": "هم‌راستا با کعبه",
        "fr": "Aligné avec la Kaaba",
        "hi": "काबा के साथ संरेखित",
        "id": "Sejajar dengan Ka'bah",
        "it": "Allineato con la Kaaba",
        "ja": "カアバ神殿に合致",
        "kk": "Қағбамен бағытталған",
        "ko": "카바와 정렬됨",
        "ms": "Sejajar dengan Kaabah",
        "pa": "ਕਾਬਾ ਨਾਲ ਮਿਲਿਆ ਹੋਇਆ",
        "ps": "له کعبې سره برابر شوی",
        "pt": "Alinhado com a Caaba",
        "ru": "Направлено на Каабу",
        "sw": "Imelingana na Kaaba",
        "ta": "காபாவுடன் சீரமைக்கப்பட்டுள்ளது",
        "tr": "Kabe ile Hizalandı",
        "ur": "کعبہ کے ساتھ درست سمت",
        "vi": "Đã hướng đúng Kaaba",
        "zh": "已对准克尔白"
    },
    "turnRight": {
        "en": "Turn {degrees}° Right",
        "ar": "أدر {degrees}° إلى اليمين",
        "az": "{degrees}° Sağa dönün",
        "bn": "{degrees}° ডানদিকে ঘুরুন",
        "de": "Drehe {degrees}° nach rechts",
        "es": "Gira {degrees}° a la derecha",
        "fa": "{degrees}° به راست بچرخید",
        "fr": "Tournez de {degrees}° à droite",
        "hi": "{degrees}° दाहिने मुड़ें",
        "id": "Putar {degrees}° ke Kanan",
        "it": "Gira di {degrees}° a destra",
        "ja": "右に {degrees}° 回ってください",
        "kk": "{degrees}° оңға бұрылыңыз",
        "ko": "오른쪽으로 {degrees}° 회전",
        "ms": "Pusing {degrees}° ke Kanan",
        "pa": "{degrees}° ਸੱਜੇ ਮੁੜੋ",
        "ps": "{degrees}° ښي لور ته وګرځئ",
        "pt": "Vire {degrees}° à direita",
        "ru": "Поверните на {degrees}° вправо",
        "sw": "Geuka {degrees}° Kulia",
        "ta": "{degrees}° வலதுபுறம் திரும்பவும்",
        "tr": "{degrees}° Sağa Dönün",
        "ur": "{degrees}° دائیں طرف مڑیں",
        "vi": "Xoay {degrees}° sang Phải",
        "zh": "向右旋转 {degrees}°"
    },
    "turnLeft": {
        "en": "Turn {degrees}° Left",
        "ar": "أدر {degrees}° إلى اليسار",
        "az": "{degrees}° Sola dönün",
        "bn": "{degrees}° বামদিকে ঘুরুন",
        "de": "Drehe {degrees}° nach links",
        "es": "Gira {degrees}° a la izquierda",
        "fa": "{degrees}° به چپ بچرخید",
        "fr": "Tournez de {degrees}° à gauche",
        "hi": "{degrees}° बाएँ मुड़ें",
        "id": "Putar {degrees}° ke Kiri",
        "it": "Gira di {degrees}° a sinistra",
        "ja": "左に {degrees}° 回ってください",
        "kk": "{degrees}° солға бұрылыңыз",
        "ko": "왼쪽으로 {degrees}° 회전",
        "ms": "Pusing {degrees}° ke Kiri",
        "pa": "{degrees}° ਖੱਬੇ ਮੁੜੋ",
        "ps": "{degrees}° چپې لور ته وګرځئ",
        "pt": "Vire {degrees}° à esquerda",
        "ru": "Поверните на {degrees}° влево",
        "sw": "Geuka {degrees}° Shoto",
        "ta": "{degrees}° இடதுபுறம் திரும்பவும்",
        "tr": "{degrees}° Sola Dönün",
        "ur": "{degrees}° بائیں طرف مڑیں",
        "vi": "Xoay {degrees}° sang Trái",
        "zh": "向左旋转 {degrees}°"
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