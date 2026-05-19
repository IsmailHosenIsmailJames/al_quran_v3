import json
import os

translations = {
    "welcomeToAlQuran": {
        "ar": "مرحبًا بك في القرآن الكريم", "az": "Qurani-Kərimə xoş gəlmisiniz", "bn": "আল-কুরআনে আপনাকে স্বাগতম", "de": "Willkommen bei Al-Quran", "en": "Welcome to Al-Quran", "es": "Bienvenido a Al-Quran", "fa": "به القرآن خوش آمدید", "fr": "Bienvenue sur Al-Quran", "hi": "अल-क़ुरआन में आपका स्वागत है", "id": "Selamat datang di Al-Quran", "it": "Benvenuto su Al-Quran", "ja": "アル・コーランへようこそ", "kk": "Құран Кәрімге қош келдіңіз", "ko": "알 꾸란에 오신 것을 환영합니다", "ms": "Selamat datang ke Al-Quran", "pa": "ਅਲ-کੁਰਾਨ ਵਿੱਚ ਤੁਹਾਡਾ ਸੁਆਗਤ ਹੈ", "ps": "القرآن ته ښه راغلاست", "pt": "Bem-vindo ao Al-Quran", "ru": "Добро пожаловать в Аль-Коран", "sw": "Karibu kwenye Al-Quran", "ta": "அல்-குர்ஆனிற்கு உங்களை வரவேற்கிறோம்", "tr": "Kur'an-ı Kerim'e Hoş Geldiniz", "ur": "القرآن میں خوش آمدید", "vi": "Chào mừng bạn đến với Al-Quran", "zh": "欢迎来到古兰经"
    },
    "quranFoundationSyncDesc": {
        "ar": "تواصل مع مؤسسة القرآن لمزامنة إشاراتك المرجعية وملاحظاتك وتقدم القراءة عبر جميع أجهزتك.", "az": "Əlfəcinlərinizi, qeydlərinizi və oxuma tərəqqinizi bütün cihazlarınızda sinxronlaşdırmaq üçün Quran Fondu ilə əlaqə saxlayın.", "bn": "আপনার সমস্ত ডিভাইসে বুকমার্ক, নোট এবং পড়ার অগ্রগতি সিঙ্ক করতে কুরআন ফাউন্ডেশনের সাথে সংযুক্ত হন।", "de": "Verbinden Sie sich mit der Quran Foundation, um Ihre Lesezeichen, Notizen und Ihren Lesefortschritt auf all Ihren Geräten zu synchronisieren.", "en": "Connect with the Quran Foundation to sync your bookmarks, notes, and reading progress across all your devices.", "es": "Conéctese con la Fundación Corán para sincronizar sus marcadores, notas y progreso de lectura en todos sus dispositivos.", "fa": "برای همگام‌سازی نشانک‌ها، یادداشت‌ها و پیشرفت خواندن خود در همه دستگاه‌های خود، با بنیاد قرآن ارتباط برقرار کنید.", "fr": "Connectez-vous avec la Fondation Coran pour synchroniser vos signets, vos notes et votre progression de lecture sur tous vos appareils.", "hi": "अपने सभी उपकरणों पर अपने बुकमार्क, नोट्स और पढ़ने की प्रगति को सिंक करने के लिए कुरान फाउंडेशन से जुड़ें।", "id": "Hubungkan dengan Quran Foundation untuk menyinkronkan penanda buku, catatan, dan kemajuan membaca Anda di semua perangkat Anda.", "it": "Connettiti con la Quran Foundation per sincronizzare i tuoi segnalibri, note e progressi di lettura su tutti i tuoi dispositivi.", "ja": "Quran Foundationと接続して、すべてのデバイスでブックマーク、メモ、読書の進行状況を同期します。", "kk": "Бетбелгілерді, жазбаларды және оқу прогресін барлық құрылғыларыңызда синхрондау үшін Құран қорына қосылыңыз.", "ko": "모든 기기에서 북마크, 메모 및 읽기 진행 상황을 동기화하려면 꾸란 재단과 연결하세요.", "ms": "Hubungkan dengan Yayasan Al-Quran untuk menyinkronkan penanda buku, nota, dan kemajuan membaca anda di semua peranti anda.", "pa": "ਆਪਣੇ ਸਾਰੇ ਡਿਵਾਈਸਾਂ ਵਿੱਚ ਆਪਣੇ ਬੁੱਕਮਾਰਕਸ, ਨੋਟਸ ਅਤੇ ਪੜ੍ਹਨ ਦੀ ਪ੍ਰਗਤੀ ਨੂੰ ਸਿੰਕ ਕਰਨ ਲਈ ਕੁਰਾਨ ਫਾਊਂਡੇਸ਼ਨ ਨਾਲ ਜੁੜੋ।", "ps": "په خپلو ټولو وسیلو کې د خپلو بک مارکونو، نوټونو او لوستلو پرمختګ همغږي کولو لپاره د قرآن بنسټ سره وصل شئ.", "pt": "Conecte-se com a Fundação Alcorão para sincronizar seus favoritos, notas e progresso de leitura em todos os seus dispositivos.", "ru": "Подключитесь к Фонду Корана, чтобы синхронизировать закладки, заметки и прогресс чтения на всех ваших устройствах.", "sw": "Ungana na Quran Foundation ili kusawazisha vialamisho vyako, madokezo, na maendeleo ya kusoma kwenye vifaa vyako vyote.", "ta": "உங்கள் எல்லா சாதனங்களிலும் உங்கள் புக்மார்க்குகள், குறிப்புகள் மற்றும் வாసిப்பு முன்னேற்றத்தை ஒத்திசைக்க குர்ஆன் அறக்கட்டளையுடன் இணையுங்கள்.", "tr": "Yer işaretlerinizi, notlarınızı ve okuma ilerlerinizi tüm cihazlarınızda senkronize etmek için Kuran Vakfı ile bağlantı kurun.", "ur": "اپنے تمام آلات پر اپنے بُک مارکس، نوٹس اور پڑھنے کی پیشرفت کو مطابقت پذیر بنانے کے لیے قرآن فاؤنڈیشن سے جڑیں۔", "vi": "Kết nối với Tổ chức Quran để đồng bộ hóa các dấu trang, ghi chú và tiến trình đọc trên tất cả các thiết bị của bạn.", "zh": "与古兰经基金会连接，以在您的所有设备上同步书签、笔记和阅读进度。"
    },
    "loginWithQuranFoundation": {
        "ar": "تسجيل الدخول مع مؤسسة القرآن", "az": "Quran Fondu ilə daxil ol", "bn": "কুরআন ফাউন্ডেশনের সাথে লগইন করুন", "de": "Mit der Quran Foundation anmelden", "en": "Login with Quran Foundation", "es": "Iniciar sesión con la Fundación Corán", "fa": "ورود با بنیاد قرآن", "fr": "Se connecter avec la Fondation Coran", "hi": "कुरान फाउंडेशन के साथ लॉगिन करें", "id": "Masuk dengan Quran Foundation", "it": "Accedi con la Quran Foundation", "ja": "Quran Foundationでログイン", "kk": "Құран қорымен кіру", "ko": "꾸란 재단으로 로그인", "ms": "Log masuk dengan Yayasan Al-Quran", "pa": "ਕੁਰਾਨ ਫਾਊਂਡੇਸ਼ਨ ਨਾਲ ਲੌਗਇਨ ਕਰੋ", "ps": "د قرآن بنسټ سره ننوتل", "pt": "Entrar com a Fundação Alcorão", "ru": "Войти через Фонд Корана", "sw": "Ingia na Quran Foundation", "ta": "குர்ஆன் அறக்கட்டளையுடன் உள்நுழைக", "tr": "Kuran Vakfı ile Giriş Yap", "ur": "قرآن فاؤنڈیشن کے ساتھ لاگ ان کریں", "vi": "Đăng nhập với Tổ chức Quran", "zh": "使用古兰经基金会登录"
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