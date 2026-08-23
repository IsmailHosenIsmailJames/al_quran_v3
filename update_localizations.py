import json
import os

languages = [
    "en", "ar", "az", "bn", "de", "es", "fa", "fr", "hi", "id", "it", "ja", 
    "kk", "ko", "ms", "pa", "ps", "pt", "ru", "sw", "ta", "tr", "ur", "vi", "zh"
]

translations = {
    "alHadith": {
        "en": "Al Hadith", "bn": "আল হাদিস", "ar": "الحديث الشريف",
        "tr": "Hadis-i Şerif", "ur": "الحدیث", "fa": "الحدیث",
        "id": "Al Hadits", "ms": "Al Hadis", "fr": "Al Hadith",
        "de": "Al Hadith", "es": "Al Hadiz", "ru": "Аль-Хадис",
        "hi": "अल हदीस", "pt": "Al Hadith", "it": "Al Hadith",
        "ja": "アル・ハディース", "ko": "알 하디스", "zh": "圣训", "vi": "Al Hadith",
        "sw": "Al Hadith", "az": "Əl-Hədis", "kk": "Әл-Хадис",
        "pa": "ਅਲ ਹਦੀਸ", "ps": "الحدیث", "ta": "அல் ஹதீஸ்"
    },
    "hadithCompanion": {
        "en": "Companion", "bn": "সহযোগী", "ar": "مرافق",
        "tr": "Yoldaş", "ur": "ہمراہی", "fa": "همراه",
        "id": "Pendamping", "ms": "Pendamping", "fr": "Compagnon",
        "de": "Begleiter", "es": "Compañero", "ru": "Спутник",
        "hi": "सहयोगी", "pt": "Companheiro", "it": "Compagno",
        "ja": "コンパニオン", "ko": "동반자", "zh": "伴侣", "vi": "Đồng hành",
        "sw": "Mwenza", "az": "Yoldaş", "kk": "Серіктес",
        "pa": "ਸਾਥੀ", "ps": "ملګری", "ta": "துணை"
    },
    "hadithCompanionDesc": {
        "en": "Sahih Bukhari, Muslim & authentic Sunnah collections.",
        "bn": "সহীহ বুখারী, মুসলিম এবং নির্ভরযোগ্য হাদীস সংকলন।",
        "ar": "صحيح البخاري ومسلم ومجموعات الحديث النبوي الشريف.",
        "tr": "Sahih-i Buhari, Müslim ve sahih hadis külliyatı.",
        "ur": "صحیح بخاری، مسلم اور مستند حدیث کے مجموعے۔",
        "fa": "صحیح بخاری، مسلم و مجموعه‌های معتبر حدیث.",
        "id": "Shahih Bukhari, Muslim & kumpulan hadits shahih.",
        "ms": "Shahih Bukhari, Muslim & koleksi hadis sahih.",
        "fr": "Sahih al-Bukhari, Muslim et collections de hadiths authentiques.",
        "de": "Sahih al-Bukhari, Muslim & authentische Hadith-Sammlungen.",
        "es": "Sahih al-Bujari, Muslim y colecciones de hadices auténticos.",
        "ru": "Сахих аль-Бухари, Муслим и достоверные сборники хадисов.",
        "hi": "सहीह बुखारी, मुस्लिम और प्रामाणिक हदीस संग्रह।",
        "pt": "Sahih al-Bukhari, Muslim e coleções autênticas de hadiths.",
        "it": "Sahih al-Bukhari, Muslim e collezioni di hadith autentici.",
        "ja": "サヒーフ・アル＝ブハーリー、ムスリム、真正ハディース集。",
        "ko": "사히 알 부하리, 무슬림 및 신뢰할 수 있는 하디스 모음집.",
        "zh": "布哈里圣训实录、穆斯林圣训实录及权威圣训集。",
        "vi": "Sahih al-Bukhari, Muslim & các bộ sưu tập Hadith xác thực.",
        "sw": "Sahih al-Bukhari, Muslim na mikusanyo sahihi ya Hadithi.",
        "az": "Səhih əl-Buxari, Müslüm və mötəbər hədis topluları.",
        "kk": "Сахих әл-Бұхари, Мүслим және сенімді хадистер жинағы.",
        "pa": "ਸਹੀਹ ਅਲ-ਬੁਖਾਰੀ, ਮੁਸਲਿਮ ਅਤੇ ਪ੍ਰਮਾਣਿਕ ਹਦੀਸ ਸੰਗ੍ਰਹਿ।",
        "ps": "صحیح البخاري، مسلم او د مستندو احادیثو ټولګې.",
        "ta": "ஸஹீஹ் அல்-புகாரி, முஸ்லிம் மற்றும் ஆதாரப்பூர்வமான ஹதீஸ் தொகுப்புகள்."
    },
    "open": {
        "en": "Open", "bn": "খুলুন", "ar": "فتح",
        "tr": "Aç", "ur": "کھولیں", "fa": "باز کردن",
        "id": "Buka", "ms": "Buka", "fr": "Ouvrir",
        "de": "Öffnen", "es": "Abrir", "ru": "Открыть",
        "hi": "खोलें", "pt": "Abrir", "it": "Apri",
        "ja": "開く", "ko": "열기", "zh": "打开", "vi": "Mở",
        "sw": "Fungua", "az": "Aç", "kk": "Ашу",
        "pa": "ਖੋਲ੍ਹੋ", "ps": "خلاصول", "ta": "திறக்க"
    },
    "install": {
        "en": "Install", "bn": "ইনস্টল", "ar": "تثبيت",
        "tr": "Yükle", "ur": "انسٹال", "fa": "نصب",
        "id": "Instal", "ms": "Pasang", "fr": "Installer",
        "de": "Installieren", "es": "Instalar", "ru": "Установить",
        "hi": "इंस्टॉल", "pt": "Instalar", "it": "Installa",
        "ja": "インストール", "ko": "설치", "zh": "安装", "vi": "Cài đặt",
        "sw": "Sakinisha", "az": "Quraşdır", "kk": "Орнату",
        "pa": "ਇੰਸਟਾਲ", "ps": "نصب کول", "ta": "நிறுவுக"
    },
    "companionApps": {
        "en": "Companion Apps", "bn": "সহযোগী অ্যাপসমূহ", "ar": "التطبيقات المرافقة",
        "tr": "Kardeş Uygulamalar", "ur": "ہمراہی ایپس", "fa": "برنامه‌های همراه",
        "id": "Aplikasi Pendamping", "ms": "Aplikasi Pendamping", "fr": "Applications Compagnes",
        "de": "Begleitende Apps", "es": "Aplicaciones Compañeras", "ru": "Сопутствующие приложения",
        "hi": "सहयोगी ऐप्स", "pt": "Aplicativos Companheiros", "it": "App Compagne",
        "ja": "コンパニオンアプリ", "ko": "동반 앱", "zh": "配套应用", "vi": "Ứng dụng đồng hành",
        "sw": "Programu Sahaba", "az": "Köməkçi Tətbiqlər", "kk": "Серіктес қолданбалар",
        "pa": "ਸਾਥੀ ਐਪਸ", "ps": "ملګري اپلیکیشنونه", "ta": "துணை பயன்பாடுகள்"
    },
    "hadithCollectionsBrief": {
        "en": "Bukhari, Muslim & more", "bn": "বুখারী, মুসলিম এবং অন্যান্য", "ar": "البخاري ومسلم والمزيد",
        "tr": "Buhari, Müslim ve fazlası", "ur": "بخاری، مسلم اور مزید", "fa": "بخاری، مسلم و غیره",
        "id": "Bukhari, Muslim & lainnya", "ms": "Bukhari, Muslim & lain-lain", "fr": "Bukhari, Muslim et plus",
        "de": "Bukhari, Muslim & mehr", "es": "Bujari, Muslim y más", "ru": "Бухари, Муслим и др.",
        "hi": "बुखारी, मुस्लिम और अन्य", "pt": "Bukhari, Muslim e mais", "it": "Bukhari, Muslim e altri",
        "ja": "ブハーリー、ムスリムなど", "ko": "부하리, 무슬림 등", "zh": "布哈里、穆斯林等", "vi": "Bukhari, Muslim & thêm",
        "sw": "Bukhari, Muslim na zaidi", "az": "Buxari, Müslüm və s.", "kk": "Бұхари, Мүслим және т.б.",
        "pa": "ਬੁਖਾਰੀ, ਮੁਸਲਿਮ ਅਤੇ ਹੋਰ", "ps": "بخاري، مسلم او نور", "ta": "புகாரி, முஸ்லிம் மற்றும் பல"
    },
    "explore": {
        "en": "Explore", "bn": "দেখুন", "ar": "استكشاف",
        "tr": "Keşfet", "ur": "دیکھیں", "fa": "کاوش",
        "id": "Jelajahi", "ms": "Terokai", "fr": "Explorer",
        "de": "Erkunden", "es": "Explorar", "ru": "Обзор",
        "hi": "देखें", "pt": "Explorar", "it": "Esplora",
        "ja": "探索", "ko": "탐색", "zh": "探索", "vi": "Khám phá",
        "sw": "Chunguza", "az": "Kəşf et", "kk": "Зерттеу",
        "pa": "ਖੋਜੋ", "ps": "پلټنه", "ta": "ஆராய்க"
    },
    "ourIslamicCompanionApps": {
        "en": "Our Islamic Companion Apps", "bn": "আমাদের অন্যান্য ইসলামিক অ্যাপসমূহ", "ar": "تطبيقاتنا الإسلامية المرافقة",
        "tr": "İslami Kardeş Uygulamalarımız", "ur": "ہماری اسلامی ہمراہی ایپس", "fa": "برنامه‌های همراه اسلامی ما",
        "id": "Aplikasi Pendamping Islami Kami", "ms": "Aplikasi Pendamping Islam Kami", "fr": "Nos Applications Islamiques Compagnes",
        "de": "Unsere islamischen Begleit-Apps", "es": "Nuestras Aplicaciones Islámicas Compañeras", "ru": "Наши исламские приложения-спутники",
        "hi": "हमारे इस्लामिक सहयोगी ऐप्स", "pt": "Nossos Aplicativos Islâmicos Companheiros", "it": "Le Nostre App Islamiche Compagne",
        "ja": "私たちのイスラム・コンパニオンアプリ", "ko": "우리의 이슬람 동반 앱", "zh": "我们的伊斯兰配套应用", "vi": "Ứng dụng đồng hành Hồi giáo của chúng tôi",
        "sw": "Programu Zetu za Kiislamu za Mwenza", "az": "İslami Köməkçi Tətbiqlərimiz", "kk": "Біздің ислами серіктес қолданбаларымыз",
        "pa": "ਸਾਡੀਆਂ ਇਸਲਾਮੀ ਸਾਥੀ ਐਪਸ", "ps": "زموږ اسلامي ملګري اپلیکیشنونه", "ta": "எங்கள் இஸ்லாமிய துணை பயன்பாடுகள்"
    },
    "ourIslamicCompanionAppsDesc": {
        "en": "Developed purely for the sake of Allah (Sadaqah Jariyah) with 100% free and ad-free experience for the Muslim Ummah.",
        "bn": "মুসলিম উম্মাহর জন্য সম্পূর্ণ বিনামূল্যে ও বিজ্ঞাপনহীনভাবে আল্লাহর সন্তুষ্টির উদ্দেশ্যে (সদকায়ে জারিয়া) তৈরি।",
        "ar": "تم تطويرها خالصًا لوجه الله (صدقة جارية) ومجانية وخالية من الإعلانات بنسبة 100% للأمة الإسلامية.",
        "tr": "Müslüman Ümmeti için tamamen Allah rızası için (Sadaka-i Cariye) %100 ücretsiz ve reklamsız olarak geliştirilmiştir.",
        "ur": "مسلم امت کے لیے خالصتاً رضائے الٰہی (صدقہ جاریہ) کے لیے 100٪ مفت اور اشتہارات سے پاک تیار کی گئی ہے۔",
        "fa": "صرفاً برای رضای خدا (صدقه جاریه) با تجربه‌ای ۱۰۰٪ رایگان و بدون تبلیغات برای امت اسلامی توسعه یافته است.",
        "id": "Dikembangkan semata-mata karena Allah (Sedekah Jariyah) dengan pengalaman 100% gratis dan bebas iklan untuk Umat Muslim.",
        "ms": "Dibangunkan semata-mata kerana Allah (Sedekah Jariyah) dengan pengalaman 100% percuma dan tanpa iklan untuk Umat Islam.",
        "fr": "Développé uniquement pour l'amour d'Allah (Sadaqah Jariyah) avec une expérience 100% gratuite et sans publicité pour la Oummah musulmane.",
        "de": "Ausschließlich um Allahs willen (Sadaqah Jariyah) entwickelt, mit einer 100% kostenlosen und werbefreien Erfahrung für die muslimische Ummah.",
        "es": "Desarrollado exclusivamente por el amor de Allah (Sadaqah Yariyah) con una experiencia 100% gratuita y sin anuncios para la Ummah musulmana.",
        "ru": "Разработано исключительно ради Аллаха (Садака Джария) — 100% бесплатно и без рекламы для мусульманской уммы.",
        "hi": "मुस्लिम उम्माह के लिए पूरी तरह से अल्लाह की खातिर (सदका-ए-जारिया) 100% मुफ्त और विज्ञापन-मुक्त अनुभव के साथ विकसित किया गया।",
        "pt": "Desenvolvido puramente pelo amor de Allah (Sadaqah Jariyah) com uma experiência 100% gratuita e sem anúncios para a Ummah Muçulmana.",
        "it": "Sviluppato puramente per la causa di Allah (Sadaqah Jariyah) con un'esperienza al 100% gratuita e senza pubblicità per la Ummah musulmana.",
        "ja": "ムスリム・ウンマのために、アッラーのために（サダカ・ジャーリヤ）100％無料・広告なしで開発されました。",
        "ko": "무슬림 움마를 위해 오직 알라를 위해 (사다카 자리야) 100% 무료 및 광고 없는 경험으로 개발되었습니다.",
        "zh": "完全为了真主的喜悦（持久的施舍）而开发，为穆斯林群体提供100%免费且无广告的体验。",
        "vi": "Được phát triển hoàn toàn vì Allah (Sadaqah Jariyah) với trải nghiệm miễn phí 100% và không có quảng cáo cho Cộng đồng Hồi giáo.",
        "sw": "Imeundwa kwa ajili ya Mwenyezi Mungu pekee (Sadaqah Jariyah) ikiwa na uzoefu wa 100% bila malipo na bila matangazo kwa Umma wa Kiislamu.",
        "az": "Müsəlman Ümməti üçün tamamilə Allah rizası üçün (Sədəqeyi-Cariyə) 100% pulsuz və reklamsız hazırlanmışdır.",
        "kk": "Мұсылман Үмметі үшін Алланың разылығы үшін (Садақа Джария) 100% тегін және жарнамасыз жасалған.",
        "pa": "ਮੁਸਲਿਮ ਉਮਾਹ ਲਈ ਪੂਰੀ ਤਰ੍ਹਾਂ ਅੱਲ੍ਹਾ ਦੀ ਖਾਤਰ (ਸਦਕਾ-ਏ-ਜਾਰੀਆ) 100% ਮੁਫਤ ਅਤੇ ਵਿਗਿਆਪਨ-ਮੁਕਤ ਅਨੁਭਵ ਨਾਲ ਵਿਕਸਤ ਕੀਤਾ ਗਿਆ।",
        "ps": "د مسلمان امت لپاره یوازې د الله تعالی د رضا (صدقه جاریه) لپاره په ۱۰۰٪ وړیا او له اعلاناتو پرته تجربه جوړ شوی.",
        "ta": "முஸ்லிம் உம்மாவிற்காக முழுக்க முழுக்க அல்லாஹ்வின் திருப்திக்காக (ஸதகதுல் ஜாரியா) 100% இலவச மற்றும் விளம்பரமில்லாத அனுபவத்துடன் உருவாக்கப்பட்டது."
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