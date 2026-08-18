import json
import os

languages = [
    "en", "ar", "az", "bn", "de", "es", "fa", "fr", "hi", "id", "it", "ja", 
    "kk", "ko", "ms", "pa", "ps", "pt", "ru", "sw", "ta", "tr", "ur", "vi", "zh"
]

translations = {
    "continueReading": {
        "en": "Continue Reading", "bn": "পড়া চালিয়ে যান", "ar": "متابعة القراءة",
        "tr": "Okumaya Devam Et", "ur": "پڑھنا جاری رکھیں", "fa": "ادامه خواندن",
        "id": "Lanjutkan Membaca", "ms": "Teruskan Membaca", "fr": "Continuer la lecture",
        "de": "Weiterlesen", "es": "Continuar leyendo", "ru": "Продолжить чтение",
        "hi": "पढ़ना जारी रखें", "pt": "Continuar lendo", "it": "Continua a leggere",
        "ja": "続きを読む", "ko": "계속 읽기", "zh": "继续阅读", "vi": "Tiếp tục đọc",
        "sw": "Endelea Kusoma", "az": "Oxumağa davam et", "kk": "Оқуды жалғастыру",
        "pa": "ਪੜ੍ਹਨਾ ਜਾਰੀ ਰੱਖੋ", "ps": "لوستلو ته دوام ورکړئ", "ta": "தொடர்ந்து படிக்கவும்"
    },
    "lastRead": {
        "en": "Last Read", "bn": "সর্বশেষ পাঠ", "ar": "آخر قراءة",
        "tr": "Son Okunan", "ur": "آخری بار پڑھا گیا", "fa": "آخرین خوانده شده",
        "id": "Terakhir Dibaca", "ms": "Terakhir Dibaca", "fr": "Dernière lecture",
        "de": "Zuletzt gelesen", "es": "Última lectura", "ru": "Последнее прочитанное",
        "hi": "अंतिम बार पढ़ा गया", "pt": "Última leitura", "it": "Ultima lettura",
        "ja": "最後に読んだ", "ko": "마지막으로 읽은 곳", "zh": "上次阅读", "vi": "Đọc lần cuối",
        "sw": "Iliyosomwa Mwisho", "az": "Son oxunan", "kk": "Соңғы оқылған",
        "pa": "ਆਖਰੀ ਵਾਰ ਪੜ੍ਹਿਆ", "ps": "وروستی لوستل شوی", "ta": "கடைசியாக படித்தது"
    },
    "resume": {
        "en": "Resume", "bn": "শুরু করুন", "ar": "استئناف",
        "tr": "Devam Et", "ur": "دوبارہ شروع کریں", "fa": "از سرگیری",
        "id": "Lanjut", "ms": "Sambung", "fr": "Reprendre",
        "de": "Fortsetzen", "es": "Reanudar", "ru": "Возобновить",
        "hi": "पुनरारंभ", "pt": "Retomar", "it": "Riprendi",
        "ja": "再開", "ko": "재개", "zh": "继续", "vi": "Tiếp tục",
        "sw": "Rejelea", "az": "Davam et", "kk": "Жалғастыру",
        "pa": "ਮੁੜ ਸ਼ੁਰੂ ਕਰੋ", "ps": "بیا پیل کړئ", "ta": "மீண்டும் தொடங்கு"
    },
    "startReading": {
        "en": "Start Reading", "bn": "পড়া শুরু করুন", "ar": "ابدأ القراءة",
        "tr": "Okumaya Başla", "ur": "پڑھنا شروع کریں", "fa": "شروع خواندن",
        "id": "Mulai Membaca", "ms": "Mula Membaca", "fr": "Commencer la lecture",
        "de": "Mit dem Lesen beginnen", "es": "Empezar a leer", "ru": "Начать чтение",
        "hi": "पढ़ना शुरू करें", "pt": "Começar a ler", "it": "Inizia a leggere",
        "ja": "読み始める", "ko": "읽기 시작", "zh": "开始阅读", "vi": "Bắt đầu đọc",
        "sw": "Anza Kusoma", "az": "Oxumağa başla", "kk": "Оқуды бастау",
        "pa": "ਪੜ੍ਹਨਾ ਸ਼ੁਰੂ ਕਰੋ", "ps": "لوستل پیل کړئ", "ta": "படிக்கத் தொடங்குங்கள்"
    },
    "verses": {
        "en": "Verses", "bn": "আয়াত", "ar": "آيات",
        "tr": "Ayet", "ur": "آیات", "fa": "آیات",
        "id": "Ayat", "ms": "Ayat", "fr": "Versets",
        "de": "Verse", "es": "Versículos", "ru": "Аяты",
        "hi": "आयतें", "pt": "Versículos", "it": "Versetti",
        "ja": "節", "ko": "구절", "zh": "节", "vi": "Câu",
        "sw": "Aya", "az": "Ayələr", "kk": "Аяттар",
        "pa": "ਆਇਤਾਂ", "ps": "آیاتونه", "ta": "வசனங்கள்"
    },
    "ayah": {
        "en": "Ayah", "bn": "আয়াত", "ar": "آية",
        "tr": "Ayet", "ur": "آیت", "fa": "آیه",
        "id": "Ayat", "ms": "Ayat", "fr": "Verset",
        "de": "Vers", "es": "Versículo", "ru": "Аят",
        "hi": "आयत", "pt": "Versículo", "it": "Versetto",
        "ja": "節", "ko": "구절", "zh": "节", "vi": "Câu",
        "sw": "Aya", "az": "Ayə", "kk": "Аят",
        "pa": "ਆਇਤ", "ps": "آیت", "ta": "வசனம்"
    },
    "edit": {
        "en": "Edit", "bn": "সম্পাদনা", "ar": "تعديل",
        "tr": "Düzenle", "ur": "ترمیم", "fa": "ویرایش",
        "id": "Edit", "ms": "Sunting", "fr": "Modifier",
        "de": "Bearbeiten", "es": "Editar", "ru": "Редактировать",
        "hi": "संपादित करें", "pt": "Editar", "it": "Modifica",
        "ja": "編集", "ko": "편집", "zh": "编辑", "vi": "Chỉnh sửa",
        "sw": "Hariri", "az": "Düzəliş et", "kk": "Өңдеу",
        "pa": "ਸੰਪਾਦਿਤ ਕਰੋ", "ps": "سمون", "ta": "திருத்து"
    },
    "makki": {
        "en": "Makki", "bn": "মাক্কী", "ar": "مكية",
        "tr": "Mekkî", "ur": "مکی", "fa": "مکی",
        "id": "Makkiyah", "ms": "Makkiyyah", "fr": "Mecquoise",
        "de": "Mekkanisch", "es": "Mequí", "ru": "Мекканская",
        "hi": "मक्की", "pt": "Mequense", "it": "Meccana",
        "ja": "マッカ啓示", "ko": "메카 계시", "zh": "麦加降示", "vi": "Mecca",
        "sw": "Makkiyah", "az": "Məkkə", "kk": "Меккелік",
        "pa": "ਮੱਕੀ", "ps": "مکي", "ta": "மக்கீ"
    },
    "madani": {
        "en": "Madani", "bn": "মাদানী", "ar": "مدنية",
        "tr": "Medenî", "ur": "مدنی", "fa": "مدنی",
        "id": "Madaniyah", "ms": "Madaniyyah", "fr": "Médinoise",
        "de": "Medinensisch", "es": "Mediní", "ru": "Мединская",
        "hi": "मदनी", "pt": "Medinense", "it": "Medinese",
        "ja": "マディーナ啓示", "ko": "메디나 계시", "zh": "麦地那降示", "vi": "Medina",
        "sw": "Madaniyah", "az": "Mədinə", "kk": "Мәдиналық",
        "pa": "ਮਦਨੀ", "ps": "مدني", "ta": "மதனீ"
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
            if key not in data:
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