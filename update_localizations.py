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
        "ug": "تەجۋىد قولlanmىسى",
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
    },
    "audioDownload": {
        "ar": "تحميل الصوت",
        "az": "Səs Yükləmə",
        "bn": "অডিও ডাউনলোড",
        "de": "Audio-Download",
        "es": "Descarga de audio",
        "fa": "دانلود صوتی",
        "fr": "Téléchargement audio",
        "ha": "Sauke Sauti",
        "hi": "ऑडियो डाउनलोड",
        "id": "Unduhan Audio",
        "it": "Download audio",
        "ja": "オーディオのダウンロード",
        "kk": "Аудио жүктеу",
        "ko": "오디오 다운로드",
        "ku": "Daxistina Deng",
        "ms": "Muat Turun Audio",
        "pa": "ਆਡੀਓ ਡਾਊਨਲੋਡ",
        "ps": "آډیو ډاونلوډ",
        "pt": "Download de áudio",
        "ru": "Загрузка аудио",
        "so": "Soo Dejinta Codka",
        "sw": "Upakuaji wa Sauti",
        "ta": "ஆடியோ பதிவிறக்கம்",
        "tr": "Ses İndirme",
        "ug": "ئاۋاز چۈشۈرۈش",
        "ur": "آڈیو ڈاؤن لوڈ",
        "vi": "Tải xuống âm thanh",
        "yo": "Gbigba Ohun",
        "zh": "音频下载"
    },
    "download": {
        "ar": "تحميل",
        "az": "Yüklə",
        "bn": "ডাউনলোড",
        "de": "Herunterladen",
        "es": "Descargar",
        "fa": "دانلود",
        "fr": "Télécharger",
        "ha": "Sauke",
        "hi": "डाउनलोड",
        "id": "Unduh",
        "it": "Scarica",
        "ja": "ダウンロード",
        "kk": "Жүктеп алу",
        "ko": "다운로드",
        "ku": "Daxistin",
        "ms": "Muat turun",
        "pa": "ਡਾਊਨਲੋਡ",
        "ps": "ډاونلوډ",
        "pt": "Baixar",
        "ru": "Скачать",
        "so": "Soo dejin",
        "sw": "Pakua",
        "ta": "பதிவிறக்க",
        "tr": "İndir",
        "ug": "چۈشۈرۈش",
        "ur": "ڈاؤن لوڈ",
        "vi": "Tải xuống",
        "yo": "Ṣe igbasilẹ",
        "zh": "下载"
    },
    "audioDownloadAlert": {
        "ar": "تحتاج إلى تحميل {requiredDownload} من {totalVersesCount} آيات.",
        "az": "{totalVersesCount} ayədən {requiredDownload} yükləmək lazımdır.",
        "bn": "{totalVersesCount} আয়াতের মধ্যে {requiredDownload} টি ডাউনলোড করতে হবে।",
        "de": "Muss {requiredDownload} von {totalVersesCount} Ayahs herunterladen.",
        "es": "Necesitas descargar {requiredDownload} de {totalVersesCount} aleyas.",
        "fa": "نیاز به دانلود {requiredDownload} از {totalVersesCount} آیه است.",
        "fr": "Nécessité de télécharger {requiredDownload} des {totalVersesCount} ayahs.",
        "ha": "Ana buƙatar sauke {requiredDownload} daga cikin {totalVersesCount} ayahs.",
        "hi": "{totalVersesCount} आयतों में से {requiredDownload} डाउनलोड करने की आवश्यकता है।",
        "id": "Perlu mengunduh {requiredDownload} dari {totalVersesCount} ayat.",
        "it": "Necessario scaricare {requiredDownload} di {totalVersesCount} ayah.",
        "ja": "{totalVersesCount}アーヤのうち{requiredDownload}をダウンロードする必要があります。",
        "kk": "{totalVersesCount} аяттың {requiredDownload} жүктеп алу қажет.",
        "ko": "{totalVersesCount}개의 아야 중 {requiredDownload}개를 다운로드해야 합니다.",
        "ku": "Pêdivî ye ku {requiredDownload} ji {totalVersesCount} ayetan were daxistin.",
        "ms": "Perlu memuat turun {requiredDownload} daripada {totalVersesCount} ayahs.",
        "pa": "{totalVersesCount} ਆਇਤਾਂ ਵਿੱਚੋਂ {requiredDownload} ਨੂੰ ਡਾਊਨਲੋਡ ਕਰਨ ਦੀ ਲੋੜ ਹੈ।",
        "ps": "د {totalVersesCount} آیتونو څخه {requiredDownload} ډاونلوډ کولو ته اړتیا لرئ.",
        "pt": "Precisa baixar {requiredDownload} de {totalVersesCount} ayahs.",
        "ru": "Необходимо загрузить {requiredDownload} из {totalVersesCount} аятов.",
        "so": "Waxaa loo baahan yahay in la soo dejiyo {requiredDownload} ka mid ah {totalVersesCount} aayadood.",
        "sw": "Unahitaji kupakua {requiredDownload} kati ya {totalVersesCount} ayah.",
        "ta": "{totalVersesCount} வசனங்களில் {requiredDownload} வசனங்களைப் பதிவிறக்க வேண்டும்.",
        "tr": "{totalVersesCount} ayetten {requiredDownload} tanesini indirmeniz gerekiyor.",
        "ug": "{totalVersesCount} ئايەتنىڭ {requiredDownload} نى چۈشۈرۈش كېرەك.",
        "ur": "{totalVersesCount} آیات میں سے {requiredDownload} ڈاؤن لوڈ کرنے کی ضرورت ہے۔",
        "vi": "Cần tải xuống {requiredDownload} trong tổng số {totalVersesCount} ayah.",
        "yo": "Nilo lati ṣe igbasilẹ {requiredDownload} ti {totalVersesCount} ayahs.",
        "zh": "需要下载 {totalVersesCount} 节经文中的 {requiredDownload} 节。"
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