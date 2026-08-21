import json
import os

languages = [
    "en", "ar", "az", "bn", "de", "es", "fa", "fr", "hi", "id", "it", "ja", 
    "kk", "ko", "ms", "pa", "ps", "pt", "ru", "sw", "ta", "tr", "ur", "vi", "zh"
]

translations = {
    "muted": {
        "en": "Muted", "bn": "মিউট", "ar": "مكتوم",
        "tr": "Sessiz", "ur": "خاموش", "fa": "بی‌صدا",
        "id": "Dibisukan", "ms": "Dibisukan", "fr": "Muet",
        "de": "Stumm", "es": "Silenciado", "ru": "Без звука",
        "hi": "म्यूट", "pt": "Silenciado", "it": "Disattivato",
        "ja": "消音", "ko": "음소거", "zh": "静音", "vi": "Tắt tiếng",
        "sw": "Kimya", "az": "Səssiz", "kk": "Дыбыссыз",
        "pa": "ਮਿਊਟ", "ps": "بې غږه", "ta": "அமைதி"
    },
    "alerts": {
        "en": "Alerts", "bn": "অ্যালার্ট", "ar": "تنبيهات",
        "tr": "Uyarılar", "ur": "اطلاعات", "fa": "هشدارها",
        "id": "Pemberitahuan", "ms": "Pemberitahuan", "fr": "Alertes",
        "de": "Benachrichtigungen", "es": "Alertas", "ru": "Оповещения",
        "hi": "अलर्ट", "pt": "Alertas", "it": "Avvisi",
        "ja": "通知", "ko": "알림", "zh": "提醒", "vi": "Thông báo",
        "sw": "Tahadhari", "az": "Xəbərdarlıqlar", "kk": "Ескертулер",
        "pa": "ਚੇਤਾਵਨੀਆਂ", "ps": "خبرتیاوې", "ta": "விழிப்பூட்டல்கள்"
    },
    "off": {
        "en": "Off", "bn": "বন্ধ", "ar": "إيقاف",
        "tr": "Kapalı", "ur": "بند", "fa": "خاموش",
        "id": "Mati", "ms": "Mati", "fr": "Désactivé",
        "de": "Aus", "es": "Desactivado", "ru": "Выкл",
        "hi": "बंद", "pt": "Desligado", "it": "Spento",
        "ja": "オフ", "ko": "꺼짐", "zh": "关闭", "vi": "Tắt",
        "sw": "Imezimwa", "az": "Bağlı", "kk": "Өшірулі",
        "pa": "ਬੰਦ", "ps": "بند", "ta": "முடக்கு"
    },
    "on": {
        "en": "On", "bn": "চালু", "ar": "تشغيل",
        "tr": "Açık", "ur": "آن", "fa": "روشن",
        "id": "Aktif", "ms": "Aktif", "fr": "Activé",
        "de": "Ein", "es": "Activado", "ru": "Вкл",
        "hi": "चालू", "pt": "Ligado", "it": "Acceso",
        "ja": "オン", "ko": "켜짐", "zh": "开启", "vi": "Bật",
        "sw": "Imewashwa", "az": "Açıq", "kk": "Қосулы",
        "pa": "ਚਾਲੂ", "ps": "روښانه", "ta": "இயக்கு"
    },
    "homeAndLockWidgets": {
        "en": "Home & Lock Widgets", "bn": "হোম ও লক স্ক্রিন উইজেট", "ar": "ويدجت الشاشة الرئيسية والقفل",
        "tr": "Ana Ekran ve Kilit Ekranı Araçları", "ur": "ہوم اور لاک اسکرین وجٹس", "fa": "ویجت‌های صفحه اصلی و قفل",
        "id": "Widget Layar Utama & Kunci", "ms": "Widget Skrin Utama & Kunci", "fr": "Widgets Écran d'accueil et Verrouillage",
        "de": "Start- & Sperrbildschirm-Widgets", "es": "Widgets de inicio y bloqueo", "ru": "Виджеты экрана и блокировки",
        "hi": "होम और लॉक स्क्रीन विजेट", "pt": "Widgets de Início e Bloqueio", "it": "Widget Schermata Home e Blocco",
        "ja": "ホーム＆ロック画面ウィジェット", "ko": "홈 및 잠금 화면 위젯", "zh": "主屏幕和锁定屏幕小组件", "vi": "Tiện ích Màn hình chính & Khóa",
        "sw": "Vidijeti za Skrini ya Nyumbani na Kufunga", "az": "Əsas və Kilid Ekranı Vidcetləri", "kk": "Басты және құлыптау экраны виджеттері",
        "pa": "ਹੋਮ ਅਤੇ ਲੌਕ ਸਕ੍ਰੀਨ ਵਿਜੇਟਸ", "ps": "د کور او لاک سکرین ویجټونه", "ta": "முகப்பு மற்றும் பூட்டுத்திரை விட்ஜெட்டுகள்"
    },
    "glanceableWidgets": {
        "en": "Glanceable Widgets", "bn": "একনজরে উইজেট", "ar": "أدوات سهلة وسريعة",
        "tr": "Hızlı Bakış Araçları", "ur": "فوری نگاہ وجٹس", "fa": "ویجت‌های در یک نگاه",
        "id": "Widget Sekilas", "ms": "Widget Sekilas Pandang", "fr": "Widgets Aperçu Rapide",
        "de": "Widgets auf einen Blick", "es": "Widgets de un vistazo", "ru": "Удобные виджеты",
        "hi": "त्वरित विजेट", "pt": "Widgets Rápidos", "it": "Widget a Colpo d'Occhio",
        "ja": "ひと目でわかるウィジェット", "ko": "한눈에 보는 위젯", "zh": "一览小组件", "vi": "Tiện ích xem nhanh",
        "sw": "Vidijeti za Mtazamo wa Haraka", "az": "Baxış Vidcetləri", "kk": "Қысқаша шолу виджеттері",
        "pa": "ਇੱਕ ਝਲਕ ਵਿਜੇਟਸ", "ps": "په یوه نظر کې ویجټونه", "ta": "விரைவு பார்வை விட்ஜெட்டுகள்"
    },
    "glanceableWidgetsDesc": {
        "en": "Display daily verses and prayer times on your home screen and lock screen.",
        "bn": "আপনার হোম স্ক্রিন ও লক স্ক্রিনে প্রতিদিনের আয়াত ও নামাজের সময় প্রদর্শন করুন।",
        "ar": "عرض الآيات اليومية وأوقات الصلاة على شاشتك الرئيسية وشاشة القفل.",
        "tr": "Ana ekranınızda ve kilit ekranınızda günlük ayetleri ve namaz vakitlerini görüntüleyin.",
        "ur": "اپنی ہوم اسکرین اور لاک اسکرین پر روزانہ کی آیات اور نماز کے اوقات دیکھیں۔",
        "fa": "آیات روزانه و اوقات نماز را روی صفحه اصلی و قفل خود نمایش دهید.",
        "id": "Tampilkan ayat harian dan jadwal sholat di layar utama dan layar kunci Anda.",
        "ms": "Pamerkan ayat harian dan waktu solat pada skrin utama dan skrin kunci anda.",
        "fr": "Affichez les versets quotidiens et les heures de prière sur votre écran d'accueil et de verrouillage.",
        "de": "Tägliche Verse und Gebetszeiten auf Ihrem Start- und Sperrbildschirm anzeigen.",
        "es": "Muestra versículos diarios y horarios de oración en tu pantalla de inicio y bloqueo.",
        "ru": "Отображайте ежедневные аяты и время молитв на главном экране и экране блокировки.",
        "hi": "अपने होम स्क्रीन और लॉक स्क्रीन पर दैनिक आयतें और नमाज़ का समय प्रदर्शित करें।",
        "pt": "Exiba versículos diários e horários de oração na tela inicial e na tela de bloqueio.",
        "it": "Mostra i versetti quotidiani e gli orari di preghiera sulla schermata iniziale e di blocco.",
        "ja": "ホーム画面とロック画面に毎日の聖句と礼拝時間を表示します。",
        "ko": "홈 화면과 잠금 화면에 매일의 구절과 기도 시간을 표시합니다.",
        "zh": "在主屏幕和锁定屏幕上显示每日经文和礼拜时间。",
        "vi": "Hiển thị các câu kinh hàng ngày và thời gian cầu nguyện trên màn hình chính và màn hình khóa.",
        "sw": "Onyesha aya za kila siku na nyakati za sala kwenye skrini yako ya nyumbani na kufunga.",
        "az": "Əsas və kilid ekranınızda gündəlik ayələri və namaz vaxtlarını göstərin.",
        "kk": "Басты және құлыптау экранында күнделікті аяттар мен намаз уақыттарын көрсетіңіз.",
        "pa": "ਆਪਣੀ ਹੋਮ ਸਕ੍ਰੀਨ ਅਤੇ ਲੌਕ ਸਕ੍ਰੀਨ 'ਤੇ ਰੋਜ਼ਾਨਾ ਦੀਆਂ ਆਇਤਾਂ ਅਤੇ ਨਮਾਜ਼ ਦੇ ਸਮੇਂ ਪ੍ਰਦਰਸ਼ਿਤ ਕਰੋ।",
        "ps": "د خپل کور او لاک سکرین پر مخ ورځني آیتونه او د لمانځه وختونه وښایاست.",
        "ta": "உங்கள் முகப்புத்திரை மற்றும் பூட்டுத்திரையில் தினசரி வசனங்கள் மற்றும் தொழுகை நேரங்களைக் காட்டுங்கள்."
    },
    "ayahWidgetDisplayMode": {
        "en": "Ayah Widget Display Mode", "bn": "আয়াত উইজেট ডিসপ্লে মোড", "ar": "وضع عرض ويدجت الآية",
        "tr": "Ayet Widget Görüntüleme Modu", "ur": "آیت وجٹ ڈسپلے موڈ", "fa": "حالت نمایش ویجت آیه",
        "id": "Mode Tampilan Widget Ayat", "ms": "Mod Paparan Widget Ayat", "fr": "Mode d'affichage du Widget Verset",
        "de": "Anzeigemodus des Vers-Widgets", "es": "Modo de visualización del widget de versículo", "ru": "Режим отображения виджета аятов",
        "hi": "आयत विजेट डिस्प्ले मोड", "pt": "Modo de Exibição do Widget de Versículos", "it": "Modalità di Visualizzazione Widget Versetto",
        "ja": "アーヤウィジェット表示モード", "ko": "구절 위젯 표시 모드", "zh": "经文小组件显示模式", "vi": "Chế độ hiển thị tiện ích câu kinh",
        "sw": "Njia ya Kuonyesha Vidijeti ya Aya", "az": "Ayə Vidceti Göstərmə Modu", "kk": "Аят виджетін көрсету режимі",
        "pa": "ਆਇਤ ਵਿਜੇਟ ਡਿਸਪਲੇ ਮੋਡ", "ps": "د آیت ویجټ ښودلو حالت", "ta": "வசனம் விட்ஜெட் காட்சி முறை"
    },
    "dailyInspiringAyah": {
        "en": "Daily Inspiring Ayah (Curated)", "bn": "প্রতিদিনের অনুপ্রেরণামূলক আয়াত (নির্বাচিত)", "ar": "آية يومية ملهمة (مختارة)",
        "tr": "Günlük İlham Veren Ayet (Seçilmiş)", "ur": "روزانہ متاثر کن آیت (منتخب)", "fa": "آیه الهام‌بخش روزانه (منتخب)",
        "id": "Ayat Inspiratif Harian (Pilihan)", "ms": "Ayat Inspirasi Harian (Pilihan)", "fr": "Verset Inspirant Quotidien (Sélectionné)",
        "de": "Täglicher inspirierender Vers (Ausgewählt)", "es": "Versículo inspirador diario (Seleccionado)", "ru": "Ежедневный вдохновляющий аят (Избранное)",
        "hi": "दैनिक प्रेरणादायक आयत (चयनित)", "pt": "Versículo Inspirador Diário (Selecionado)", "it": "Versetto Ispiratore Quotidiano (Selezionato)",
        "ja": "毎日の心に響くアーヤ（厳選）", "ko": "매일 영감을 주는 구절 (엄선)", "zh": "每日启迪经文（精选）", "vi": "Câu kinh truyền cảm hứng hàng ngày (Chọn lọc)",
        "sw": "Aya ya Kila Siku ya Kutia Moyo (Iliyochaguliwa)", "az": "Gündəlik İlhamverici Ayə (Seçilmiş)", "kk": "Күнделікті ғибратты аят (Таңдалған)",
        "pa": "ਰੋਜ਼ਾਨਾ ਪ੍ਰੇਰਨਾਦਾਇਕ ਆਇਤ (ਚੁਣੀ ਗਈ)", "ps": "ورځنی الهام بخښونکی آیت (غوره شوی)", "ta": "தினசரி ஊக்கமளிக்கும் வசனம் (தேர்ந்தெடுக்கப்பட்டது)"
    },
    "dailyInspiringAyahDesc": {
        "en": "Changes every day at midnight with 365+ profound verses.",
        "bn": "৩৬৫+ নির্বাচিত আয়াত নিয়ে প্রতিদিন মধ্যরাতে স্বয়ংক্রিয়ভাবে পরিবর্তিত হয়।",
        "ar": "يتغير كل يوم عند منتصف الليل مع أكثر من 365 آية مختارة بعناية.",
        "tr": "365'ten fazla seçilmiş ayetle her gün gece yarısı değişir.",
        "ur": "365 سے زائد منتخب آیات کے ساتھ ہر روز آدھی رات کو تبدیل ہوتا ہے۔",
        "fa": "هر روز نیمه‌شب با بیش از ۳۶۵ آیه عمیق و برگزیده تغییر می‌کند.",
        "id": "Berganti setiap hari tengah malam dengan 365+ ayat pilihan yang mendalam.",
        "ms": "Bertukar setiap hari pada tengah malam dengan 365+ ayat pilihan yang mendalam.",
        "fr": "Change chaque jour à minuit avec plus de 365 versets profonds sélectionnés.",
        "de": "Wechselt jeden Tag um Mitternacht mit über 365 tiefgründigen Versen.",
        "es": "Cambia cada día a medianoche con más de 365 versículos profundos seleccionados.",
        "ru": "Обновляется каждый день в полночь из коллекции более 365 избранных аятов.",
        "hi": "365+ गहन आयतों के साथ हर रात आधी रात को बदलता है।",
        "pt": "Muda todos os dias à meia-noite com mais de 365 versículos profundos.",
        "it": "Cambia ogni giorno a mezzanotte con oltre 365 versetti profondi.",
        "ja": "厳選された365以上の深遠な聖句で、毎日午前0時に更新されます。",
        "ko": "365개 이상의 엄선된 깊은 구절로 매일 자정에 변경됩니다.",
        "zh": "每天午夜更新，精选365+篇深刻经文。",
        "vi": "Thay đổi mỗi ngày vào lúc nửa đêm với hơn 365 câu kinh sâu sắc được chọn lọc.",
        "sw": "Hubadilika kila siku usiku wa manane na aya 365+ zenye maana nzito.",
        "az": "365-dən çox seçilmiş ayə ilə hər gün gecə yarısı dəyişir.",
        "kk": "365-тен астам таңдаулы аятпен күн сайын түн ортасында жаңарады.",
        "pa": "365+ ਚੁਣੀਆਂ ਹੋਈਆਂ ਆਇਤਾਂ ਨਾਲ ਹਰ ਰੋਜ਼ ਅੱਧੀ ਰਾਤ ਨੂੰ ਬਦਲਦਾ ਹੈ।",
        "ps": "هره ورځ په نیمه شپه کې له ۳۶۵ څخه زیاتو غوره شویو آیتونو سره بدلیږي.",
        "ta": "365+ ஆழமான வசனங்களுடன் தினமும் நள்ளிரவில் மாறும்."
    },
    "lastReadAyah": {
        "en": "Last Read Ayah", "bn": "সর্বশেষ পঠিত আয়াত", "ar": "آخر آية مقروءة",
        "tr": "Son Okunan Ayet", "ur": "آخری پڑھی گئی آیت", "fa": "آخرین آیه خوانده شده",
        "id": "Ayat Terakhir Dibaca", "ms": "Ayat Terakhir Dibaca", "fr": "Dernier Verset Lu",
        "de": "Zuletzt gelesener Vers", "es": "Último versículo leído", "ru": "Последний прочитанный аят",
        "hi": "अंतिम पढ़ी गई आयत", "pt": "Último Versículo Lido", "it": "Ultimo Versetto Letto",
        "ja": "最後に読んだアーヤ", "ko": "마지막으로 읽은 구절", "zh": "上次阅读经文", "vi": "Câu kinh đọc gần nhất",
        "sw": "Aya ya Mwisho Kusomwa", "az": "Son Oxunmuş Ayə", "kk": "Соңғы оқылған аят",
        "pa": "ਆਖਰੀ ਪੜ੍ਹੀ ਗਈ ਆਇਤ", "ps": "وروستی لوستل شوی آیت", "ta": "கடைசியாக வாசித்த வசனம்"
    },
    "lastReadAyahDesc": {
        "en": "Syncs with your latest reading position for instant 1-tap resume.",
        "bn": "সহজ ১-ট্যাপে পড়া চালিয়ে নিতে আপনার সর্বশেষ পঠিত স্থানের সাথে সিঙ্ক হয়।",
        "ar": "يتزامن مع آخر موضع قراءة للمتابعة الفورية بنقرة واحدة.",
        "tr": "Tek dokunuşla hemen devam etmek için son okuma konumunuzla senkronize olur.",
        "ur": "ایک ٹیپ میں دوبارہ پڑھنا جاری رکھنے کے لیے آخری مقام سے ہم آہنگ ہوتا ہے۔",
        "fa": "با آخرین موقعیت خواندن شما برای ادامه آسان همگام می‌شود.",
        "id": "Menyelaraskan dengan posisi membaca terakhir untuk melanjutkan dengan 1 ketukan.",
        "ms": "Menyelaras dengan kedudukan bacaan terakhir untuk menyambung semula dengan 1 ketukan.",
        "fr": "Se synchronise avec votre dernière position de lecture pour reprendre en un clic.",
        "de": "Synchronisiert sich mit Ihrer letzten Leseposition für die Fortsetzung mit einem Fingertipp.",
        "es": "Se sincroniza con tu última posición de lectura para continuar con un toque.",
        "ru": "Синхронизируется с последним прочитанным местом для мгновенного продолжения.",
        "hi": "1-टैप में पढ़ना जारी रखने के लिए आपकी अंतिम पढ़ने की स्थिति के साथ सिंक होता है।",
        "pt": "Sincroniza com sua última posição de leitura para retomar com 1 toque.",
        "it": "Si sincronizza con la tua ultima posizione di lettura per riprendere con un tocco.",
        "ja": "最後に読んだ場所と同期し、ワンタップで続きを読むことができます。",
        "ko": "한 번의 탭으로 즉시 다시 읽을 수 있도록 마지막 읽은 위치와 동기화됩니다.",
        "zh": "与您最新的阅读位置同步，一键快速继续阅读。",
        "vi": "Đồng bộ hóa với vị trí đọc gần nhất để tiếp tục chỉ bằng 1 lần chạm.",
        "sw": "Hulandana na eneo lako la mwisho la usomaji ili kuendelea kwa mguso mmoja.",
        "az": "Bir toxunuşla davam etmək üçün son oxu mövqeyinizlə sinxronlaşır.",
        "kk": "Бір түрту арқылы жалғастыру үшін соңғы оқу орныңызбен синхрондалады.",
        "pa": "ਇੱਕ ਟੈਪ ਨਾਲ ਪੜ੍ਹਨਾ ਜਾਰੀ ਰੱਖਣ ਲਈ ਤੁਹਾਡੀ ਆਖਰੀ ਸਥਿਤੀ ਨਾਲ ਸਿੰਕ ਹੁੰਦਾ ਹੈ।",
        "ps": "په یو ټک سره لوستلو ته دوام ورکولو لپاره ستاسو د وروستي لوستلو موقعیت سره همغږي کیږي.",
        "ta": "1-தட்டலில் வாசிப்பைத் தொடர உங்கள் கடைசி வாசிப்பு நிலையுடன் ஒத்திசைகிறது."
    },
    "pinnedCustomVerse": {
        "en": "Pinned Custom Verse", "bn": "পিন করা নিজস্ব আয়াত", "ar": "آية مخصصة مثبتة",
        "tr": "Sabitlenmiş Özel Ayet", "ur": "پن کردہ پسندیدہ آیت", "fa": "آیه سفارشی سنجاق‌شده",
        "id": "Ayat Kustom Disematkan", "ms": "Ayat Tersuai Disematkan", "fr": "Verset Personnalisé Épinglé",
        "de": "Angehefteter individueller Vers", "es": "Versículo personalizado fijado", "ru": "Закрепленный аят",
        "hi": "पिन की गई आयत", "pt": "Versículo Personalizado Fixado", "it": "Versetto Personalizzato Fissato",
        "ja": "固定されたカスタムアーヤ", "ko": "고정된 사용자 지정 구절", "zh": "固定自定义经文", "vi": "Câu kinh ghim tùy chỉnh",
        "sw": "Aya Maalum Iliyobandikwa", "az": "Sancılanmış Xüsusi Ayə", "kk": "Бекітілген арнайы аят",
        "pa": "ਪਿੰਨ ਕੀਤੀ ਗਈ ਆਇਤ", "ps": "ټاکل شوی ځانګړی آیت", "ta": "பின் செய்யப்பட்ட தனிப்பயன் வசனம்"
    },
    "randomDailyAyah": {
        "en": "Random Daily Ayah", "bn": "দৈবচয়ন দৈনিক আয়াত", "ar": "آية يومية عشوائية",
        "tr": "Rastgele Günlük Ayet", "ur": "روزانہ کی بے ترتیب آیت", "fa": "آیه تصادفی روزانه",
        "id": "Ayat Harian Acak", "ms": "Ayat Harian Rawak", "fr": "Verset Quotidien Aléatoire",
        "de": "Zufälliger täglicher Vers", "es": "Versículo diario aleatorio", "ru": "Случайный ежедневный аят",
        "hi": "यादृच्छिक दैनिक आयत", "pt": "Versículo Diário Aleatório", "it": "Versetto Giornaliero Casuale",
        "ja": "ランダムな毎日のアーヤ", "ko": "무작위 일일 구절", "zh": "随机每日经文", "vi": "Câu kinh ngẫu nhiên hàng ngày",
        "sw": "Aya ya Nasibu ya Kila Siku", "az": "Təsadüfi Gündəlik Ayə", "kk": "Кездейсоқ күнделікті аят",
        "pa": "ਬੇਤਰਤੀਬ ਰੋਜ਼ਾਨਾ ਆਇਤ", "ps": "تصادفي ورځنی آیت", "ta": "சீரற்ற தினசரி வசனம்"
    },
    "randomDailyAyahDesc": {
        "en": "Picks a random verse every day for fresh reflection.",
        "bn": "নতুন ভাবনার জন্য প্রতিদিন একটি নতুন আয়াত নির্বাচন করে।",
        "ar": "يختار آية عشوائية كل يوم للتأمل والتفكر المتجدد.",
        "tr": "Taze bir tefekkür için her gün rastgele bir ayet seçer.",
        "ur": "نئی فکر اور غور و تدبر کے لیے ہر روز ایک نئی آیت کا انتخاب کرتا ہے۔",
        "fa": "هر روز آیه‌ای تصادفی را برای تأمل تازه انتخاب می‌کند.",
        "id": "Memilih ayat acak setiap hari untuk refleksi yang segar.",
        "ms": "Memilih ayat rawak setiap hari untuk renungan yang segar.",
        "fr": "Choisit un verset aléatoire chaque jour pour une nouvelle réflexion.",
        "de": "Wählt jeden Tag einen zufälligen Vers für neue Reflexionen aus.",
        "es": "Elige un versículo aleatorio cada día para una nueva reflexión.",
        "ru": "Выбирает случайный аят каждый день для нового размышления.",
        "hi": "ताज़ा चिंतन के लिए हर दिन एक यादृच्छिक आयत चुनता है।",
        "pt": "Escolhe um versículo aleatório todos os dias para uma nova reflexão.",
        "it": "Sceglie un versetto casuale ogni giorno per una nuova riflessione.",
        "ja": "毎日の新たな瞑想のために、ランダムに聖句を選択します。",
        "ko": "새로운 묵상을 위해 매일 무작위 구절을 선택합니다.",
        "zh": "每天随机选择一篇经文，带来崭新的感悟与思考。",
        "vi": "Chọn một câu kinh ngẫu nhiên mỗi ngày để suy ngẫm mới mẻ.",
        "sw": "Huchagua aya ya nasibu kila siku kwa ajili ya tafakuri mpya.",
        "az": "Hər gün yeni düşüncələr üçün təsadüfi bir ayə seçir.",
        "kk": "Күнделікті жаңа ой-толғау үшін кездейсоқ аят таңдайды.",
        "pa": "ਨਵੇਂ ਵਿਚਾਰਾਂ ਲਈ ਹਰ ਰੋਜ਼ ਇੱਕ ਬੇਤਰਤੀਬ ਆਇਤ ਚੁਣਦਾ ਹੈ।",
        "ps": "د نوي فکر او تدبر لپاره هره ورځ یو تصادفي آیت غوره کوي.",
        "ta": "புதிய சிந்தனைக்காக தினமும் ஒரு சீரற்ற வசனத்தைத் தேர்ந்தெடுக்கிறது."
    },
    "updateAllWidgetsNow": {
        "en": "Update All Widgets Now", "bn": "সকল উইজেট এখনই আপডেট করুন", "ar": "تحديث جميع الأدوات الآن",
        "tr": "Tüm Widget'ları Şimdi Güncelle", "ur": "تمام وجٹس کو ابھی اپ ڈیٹ کریں", "fa": "به‌روزرسانی همه ویجت‌ها",
        "id": "Perbarui Semua Widget Sekarang", "ms": "Kemas Kini Semua Widget Sekarang", "fr": "Mettre à jour tous les widgets",
        "de": "Alle Widgets jetzt aktualisieren", "es": "Actualizar todos los widgets ahora", "ru": "Обновить все виджеты сейчас",
        "hi": "सभी विजेट अभी अपडेट करें", "pt": "Atualizar Todos os Widgets Agora", "it": "Aggiorna Tutti i Widget Ora",
        "ja": "すべてのウィジェットを今すぐ更新", "ko": "지금 모든 위젯 업데이트", "zh": "立即更新所有小组件", "vi": "Cập nhật tất cả tiện ích ngay",
        "sw": "Sasisha Vidijeti Zote Sasa", "az": "Bütün Vidcetləri İndi Yeniləyin", "kk": "Барлық виджеттерді қазір жаңарту",
        "pa": "ਸਾਰੇ ਵਿਜੇਟਸ ਹੁਣੇ ਅਪਡੇਟ ਕਰੋ", "ps": "همدا اوس ټول ویجټونه تازه کړئ", "ta": "அனைத்து விட்ஜெட்டுகளையும் இப்போது புதுப்பிக்கவும்"
    },
    "widgetsUpdatedSuccessfully": {
        "en": "Widgets updated successfully!", "bn": "উইজেট সফলভাবে আপডেট করা হয়েছে!", "ar": "تم تحديث الأدوات بنجاح!",
        "tr": "Widget'lar başarıyla güncellendi!", "ur": "وجٹس کامیابی کے ساتھ اپ ڈیٹ ہو گئے!", "fa": "ویجت‌ها با موفقیت به‌روزرسانی شدند!",
        "id": "Widget berhasil diperbarui!", "ms": "Widget berjaya dikemas kini!", "fr": "Widgets mis à jour avec succès !",
        "de": "Widgets erfolgreich aktualisiert!", "es": "¡Widgets actualizados con éxito!", "ru": "Виджеты успешно обновлены!",
        "hi": "विजेट सफलतापूर्वक अपडेट किए गए!", "pt": "Widgets atualizados com sucesso!", "it": "Widget aggiornati con successo!",
        "ja": "ウィジェットが正常に更新されました！", "ko": "위젯이 성공적으로 업데이트되었습니다!", "zh": "小组件已成功更新！", "vi": "Tiện ích đã được cập nhật thành công!",
        "sw": "Vidijeti zimesasishwa kikamilifu!", "az": "Vidcetlər uğurla yeniləndi!", "kk": "Виджеттер сәтті жаңартылды!",
        "pa": "ਵਿਜੇਟਸ ਸਫਲਤਾਪੂਰਵਕ ਅਪਡੇਟ ਹੋ ਗਏ!", "ps": "ویجټونه په بریالیتوب سره تازه شول!", "ta": "விட்ஜெட்டுகள் வெற்றிகரமாகப் புதுப்பிக்கப்பட்டன!"
    },
    "ayahPinnedToWidgets": {
        "en": "Ayah pinned to Home & Lock Screen Widgets!", "bn": "আয়াতটি হোম ও লক স্ক্রিন উইজেটে পিন করা হয়েছে!", "ar": "تم تثبيت الآية في ويدجت الشاشة الرئيسية والقفل!",
        "tr": "Ayet Ana Ekran ve Kilit Ekranı Araçlarına sabitlendi!", "ur": "آیت ہوم اور لاک اسکرین وجٹس پر پن ہو گئی!", "fa": "آیه در ویجت‌های صفحه اصلی و قفل سنجاق شد!",
        "id": "Ayat disematkan ke Widget Layar Utama & Kunci!", "ms": "Ayat disematkan pada Widget Skrin Utama & Kunci!", "fr": "Verset épinglé sur les widgets d'accueil et de verrouillage !",
        "de": "Vers an Start- & Sperrbildschirm-Widgets angeheftet!", "es": "¡Versículo fijado en los widgets de inicio y bloqueo!", "ru": "Аят закреплен на виджетах экрана и блокировки!",
        "hi": "आयत होम और लॉक स्क्रीन विजेट पर पिन की गई!", "pt": "Versículo fixado nos Widgets de Início e Bloqueio!", "it": "Versetto fissato sui Widget della Schermata Home e Blocco!",
        "ja": "アーヤがホーム＆ロック画面ウィジェットに固定されました！", "ko": "구절이 홈 및 잠금 화면 위젯에 고정되었습니다!", "zh": "经文已固定到主屏幕和锁定屏幕小组件！", "vi": "Câu kinh đã được ghim vào tiện ích Màn hình chính & Khóa!",
        "sw": "Aya imebandikwa kwenye Vidijeti za Skrini ya Nyumbani na Kufunga!", "az": "Ayə Əsas və Kilid Ekranı Vidcetlərinə sancıldı!", "kk": "Аят басты және құлыптау экраны виджеттеріне бекітілді!",
        "pa": "ਆਇਤ ਹੋਮ ਅਤੇ ਲੌਕ ਸਕ੍ਰੀਨ ਵਿਜੇਟਸ 'ਤੇ ਪਿੰਨ ਕੀਤੀ ਗਈ!", "ps": "آیت د کور او لاک سکرین ویجټونو ته وټاکل شو!", "ta": "வசனம் முகப்பு மற்றும் பூட்டுத்திரை விட்ஜெட்டுகளில் பின் செய்யப்பட்டது!"
    },
    "pinToWidgets": {
        "en": "Pin to Home & Lock Widgets", "bn": "উইজেটে পিন করুন", "ar": "تثبيت في ويدجت الشاشة",
        "tr": "Widget'lara Sabitle", "ur": "وجٹس پر پن کریں", "fa": "سنجاق به ویجت‌ها",
        "id": "Sematkan ke Widget", "ms": "Sematkan ke Widget", "fr": "Épingler aux widgets",
        "de": "An Widgets anheften", "es": "Fijar en widgets", "ru": "Закрепить на виджетах",
        "hi": "विजेट पर पिन करें", "pt": "Fixar nos Widgets", "it": "Fissa sui Widget",
        "ja": "ウィジェットに固定", "ko": "위젯에 고정", "zh": "固定到小组件", "vi": "Ghim vào tiện ích",
        "sw": "Bandika kwenye Vidijeti", "az": "Vidcetlərə Sanc", "kk": "Виджеттерге бекіту",
        "pa": "ਵਿਜੇਟਸ 'ਤੇ ਪਿੰਨ ਕਰੋ", "ps": "ویجټونو ته وټاکئ", "ta": "விட்ஜெட்டுகளில் பின் செய்க"
    },
    "selectPinnedAyah": {
        "en": "Select Pinned Ayah", "bn": "পিন করার আয়াত নির্বাচন করুন", "ar": "اختر الآية للتثبيت",
        "tr": "Sabitlenecek Ayeti Seçin", "ur": "پن کرنے کے لیے آیت منتخب کریں", "fa": "انتخاب آیه برای سنجاق",
        "id": "Pilih Ayat yang Disematkan", "ms": "Pilih Ayat untuk Disematkan", "fr": "Sélectionner le verset à épingler",
        "de": "Anzuheftenden Vers auswählen", "es": "Seleccionar versículo para fijar", "ru": "Выберите аят для закрепления",
        "hi": "पिन करने के लिए आयत चुनें", "pt": "Selecionar Versículo para Fixar", "it": "Seleziona Versetto da Fissare",
        "ja": "固定するアーヤを選択", "ko": "고정할 구절 선택", "zh": "选择固定经文", "vi": "Chọn câu kinh để ghim",
        "sw": "Chagua Aya ya Kubandika", "az": "Sancılacaq Ayəni Seçin", "kk": "Бекітілетін аятты таңдаңыз",
        "pa": "ਪਿੰਨ ਕਰਨ ਲਈ ਆਇਤ ਚੁਣੋ", "ps": "د ټاکلو لپاره آیت وټاکئ", "ta": "பின் செய்ய வேண்டிய வசனத்தைத் தேர்ந்தெடுக்கவும்"
    },
    "saveAndApplyToWidget": {
        "en": "Save & Apply to Widget", "bn": "সংরক্ষণ ও উইজেটে প্রয়োগ করুন", "ar": "حفظ وتطبيق على الويدجت",
        "tr": "Kaydet ve Widget'a Uygula", "ur": "محفوظ کریں اور وجٹ پر لاگو کریں", "fa": "ذخیره و اعمال روی ویجت",
        "id": "Simpan & Terapkan ke Widget", "ms": "Simpan & Gunakan pada Widget", "fr": "Enregistrer et appliquer au widget",
        "de": "Speichern & auf Widget anwenden", "es": "Guardar y aplicar al widget", "ru": "Сохранить и применить к виджету",
        "hi": "सहेजें और विजेट पर लागू करें", "pt": "Salvar e Aplicar ao Widget", "it": "Salva e Applica al Widget",
        "ja": "保存してウィジェットに適用", "ko": "저장 및 위젯에 적용", "zh": "保存并应用到小组件", "vi": "Lưu & Áp dụng cho tiện ích",
        "sw": "Hifadhi na Utumie kwenye Vidijeti", "az": "Yadda Saxla və Vidcetə Tətbiq Et", "kk": "Сақтау және виджетке қолдану",
        "pa": "ਸੁਰੱਖਿਅਤ ਕਰੋ ਅਤੇ ਵਿਜੇਟ 'ਤੇ ਲਾਗੂ ਕਰੋ", "ps": "خوندي کړئ او ویجټ ته یې پلي کړئ", "ta": "சேமித்து விட்ஜெட்டுக்கு பயன்படுத்துக"
    },
    "howToAddWidgets": {
        "en": "How to Add Widgets", "bn": "উইজেট যুক্ত করার নিয়ম", "ar": "كيفية إضافة الأدوات",
        "tr": "Widget Nasıl Eklenir", "ur": "وجٹس کیسے شامل کریں", "fa": "نحوه افزودن ویجت‌ها",
        "id": "Cara Menambahkan Widget", "ms": "Cara Menambah Widget", "fr": "Comment ajouter des widgets",
        "de": "So fügen Sie Widgets hinzu", "es": "Cómo agregar widgets", "ru": "Как добавить виджеты",
        "hi": "विजेट कैसे जोड़ें", "pt": "Como Adicionar Widgets", "it": "Come Aggiungere Widget",
        "ja": "ウィジェットの追加方法", "ko": "위젯 추가 방법", "zh": "如何添加小组件", "vi": "Cách thêm tiện ích",
        "sw": "Jinsi ya Kuongeza Vidijeti", "az": "Vidcetləri Necə Əlavə Etməli", "kk": "Виджеттерді қалай қосуға болады",
        "pa": "ਵਿਜੇਟਸ ਕਿਵੇਂ ਸ਼ਾਮਲ ਕਰੀਏ", "ps": "ویجټونه څنګه اضافه کړئ", "ta": "விட்ஜெட்டுகளை எவ்வாறு சேர்ப்பது"
    },
    "customizeWidgetAyahAndPrayers": {
        "en": "Customize Widget Ayah & Prayers", "bn": "উইজেটের আয়াত ও নামাজের সময় কাস্টমাইজ করুন", "ar": "تخصيص آيات وصلوات الويدجت",
        "tr": "Widget Ayet ve Namaz Vakitlerini Özelleştirin", "ur": "وجٹ آیات اور نماز کے اوقات کو حسب ضرورت بنائیں", "fa": "سفارشی‌سازی آیه و نمازهای ویجت",
        "id": "Kustomisasi Ayat & Jadwal Sholat Widget", "ms": "Sesuaikan Ayat & Solat Widget", "fr": "Personnaliser les versets et prières du widget",
        "de": "Widget-Verse und Gebete anpassen", "es": "Personalizar versículo y oraciones del widget", "ru": "Настроить аят и молитвы в виджете",
        "hi": "विजेट आयत और नमाज़ को कस्टमाइज़ करें", "pt": "Personalizar Versículos e Orações do Widget", "it": "Personalizza Versetto e Preghiere del Widget",
        "ja": "ウィジェットのアーヤと礼拝をカスタマイズ", "ko": "위젯 구절 및 기도 맞춤설정", "zh": "自定义小组件经文和礼拜", "vi": "Tùy chỉnh câu kinh & cầu nguyện trên tiện ích",
        "sw": "Binafsisha Aya na Sala za Vidijeti", "az": "Vidcet Ayəsini və Namazlarını Fərdiləşdirin", "kk": "Виджет аяты мен намаздарын баптау",
        "pa": "ਵਿਜੇਟ ਆਇਤ ਅਤੇ ਨਮਾਜ਼ ਨੂੰ ਅਨੁਕੂਲਿਤ ਕਰੋ", "ps": "د ویجټ آیت او لمونځونه تنظیم کړئ", "ta": "விட்ஜெட் வசனம் மற்றும் தொழுகைகளைத் தனிப்பயனாக்குக"
    },
    "customizeWidgetAyahAndPrayersDesc": {
        "en": "Choose between daily curated, last read, or custom pinned verses",
        "bn": "প্রতিদিনের নির্বাচিত, সর্বশেষ পঠিত বা নিজের পছন্দের পিন করা আয়াত বেছে নিন",
        "ar": "اختر بين الآيات اليومية المختارة، أو آخر قراءة، أو آية مثبتة مخصصة",
        "tr": "Günlük seçilmiş, son okunan veya özel sabitlenmiş ayetler arasından seçim yapın",
        "ur": "روزانہ کی منتخب، آخری پڑھی گئی، یا کسٹم پن کردہ آیات میں سے انتخاب کریں",
        "fa": "بین آیات منتخب روزانه، آخرین خوانده شده یا آیات سنجاق‌شده سفارشی انتخاب کنید",
        "id": "Pilih antara ayat pilihan harian, terakhir dibaca, atau ayat kustom disematkan",
        "ms": "Pilih antara ayat pilihan harian, terakhir dibaca, atau ayat tersuai disematkan",
        "fr": "Choisissez entre des versets quotidiens sélectionnés, le dernier lu ou un verset épinglé",
        "de": "Wählen Sie zwischen täglich ausgewählten, zuletzt gelesenen oder angehefteten Versen",
        "es": "Elige entre versículos seleccionados diarios, último leído o versículos fijados",
        "ru": "Выберите между ежедневными избранными, последними прочитанными или закрепленными аятами",
        "hi": "दैनिक चयनित, अंतिम पढ़ी गई, या कस्टम पिन की गई आयतों के बीच चुनें",
        "pt": "Escolha entre versículos selecionados diários, últimos lidos ou fixados",
        "it": "Scegli tra versetti selezionati ogni giorno, ultimi letti o fissati",
        "ja": "毎日の厳選、最後に読んだ、または固定されたアーヤから選択",
        "ko": "매일 엄선된 구절, 마지막으로 읽은 구절, 고정된 맞춤 구절 중에서 선택",
        "zh": "在每日精选、上次阅读或自定义固定经文之间进行选择",
        "vi": "Chọn giữa các câu kinh được chọn lọc hàng ngày, đọc gần nhất hoặc câu kinh đã ghim",
        "sw": "Chagua kati ya aya zilizochaguliwa za kila siku, za mwisho kusomwa, au zilizobandikwa",
        "az": "Gündəlik seçilmiş, son oxunmuş və ya xüsusi sancılmış ayələr arasında seçim edin",
        "kk": "Күнделікті таңдалған, соңғы оқылған немесе бекітілген аяттар арасынан таңдаңыз",
        "pa": "ਰੋਜ਼ਾਨਾ ਚੁਣੀਆਂ ਗਈਆਂ, ਆਖਰੀ ਪੜ੍ਹੀਆਂ ਗਈਆਂ, ਜਾਂ ਪਿੰਨ ਕੀਤੀਆਂ ਆਇਤਾਂ ਵਿੱਚੋਂ ਚੁਣੋ",
        "ps": "د ورځني غوره شوي، وروستي لوستل شوي، یا ټاکل شوي ځانګړي آیتونو ترمنځ وټاکئ",
        "ta": "தினசரி தேர்ந்தெடுக்கப்பட்ட, கடைசியாக வாசித்த அல்லது தனிப்பயன் பின் செய்த வசனங்களுக்கு இடையே தேர்வுசெய்க"
    },
    "accountAndSync": {
        "en": "Account & Cloud Sync", "bn": "অ্যাকাউন্ট ও ক্লাউড সিঙ্ক", "ar": "الحساب والمزامنة السحابية",
        "tr": "Hesap ve Bulut Senkronizasyonu", "ur": "اکاؤنٹ اور کلاؤڈ سنک", "fa": "حساب کاربری و همگام‌سازی ابری",
        "id": "Akun & Sinkronisasi Cloud", "ms": "Akaun & Penyegerakan Awan", "fr": "Compte et Synchronisation Cloud",
        "de": "Konto & Cloud-Synchronisierung", "es": "Cuenta y sincronización en la nube", "ru": "Аккаунт и облачная синхронизация",
        "hi": "अकाउंट और क्लाउड सिंक", "pt": "Conta e Sincronização na Nuvem", "it": "Account e Sincronizzazione Cloud",
        "ja": "アカウントとクラウド同期", "ko": "계정 및 클라우드 동기화", "zh": "账户与云端同步", "vi": "Tài khoản & Đồng bộ đám mây",
        "sw": "Akaunti na Usawazishaji wa Wingu", "az": "Hesab və Bulud Sinxronizasiyası", "kk": "Тіркелгі және бұлттық синхрондау",
        "pa": "ਖਾਤਾ ਅਤੇ ਕਲਾਉਡ ਸਿੰਕ", "ps": "حساب او کلاوډ همغږي", "ta": "கணக்கு மற்றும் கிளவுட் ஒத்திசைவு"
    },
    "signIn": {
        "en": "Sign In", "bn": "সাইন ইন", "ar": "تسجيل الدخول",
        "tr": "Giriş Yap", "ur": "سائن ان", "fa": "ورود",
        "id": "Masuk", "ms": "Log Masuk", "fr": "Se connecter",
        "de": "Anmelden", "es": "Iniciar sesión", "ru": "Войти",
        "hi": "साइन इन", "pt": "Entrar", "it": "Accedi",
        "ja": "サインイン", "ko": "로그인", "zh": "登录", "vi": "Đăng nhập",
        "sw": "Ingia", "az": "Daxil ol", "kk": "Кіру",
        "pa": "ਸਾਈਨ ਇਨ", "ps": "ننوتل", "ta": "உள்நுழைக"
    },
    "signUp": {
        "en": "Create Account", "bn": "অ্যাকাউন্ট তৈরি করুন", "ar": "إنشاء حساب",
        "tr": "Hesap Oluştur", "ur": "اکاؤنٹ بنائیں", "fa": "ایجاد حساب",
        "id": "Buat Akun", "ms": "Cipta Akaun", "fr": "Créer un compte",
        "de": "Konto erstellen", "es": "Crear cuenta", "ru": "Создать аккаунт",
        "hi": "अकाउंट बनाएं", "pt": "Criar Conta", "it": "Crea Account",
        "ja": "アカウント作成", "ko": "계정 만들기", "zh": "创建账户", "vi": "Tạo tài khoản",
        "sw": "Fungua Akaunti", "az": "Hesab Yarat", "kk": "Тіркелгі жасау",
        "pa": "ਖਾਤਾ ਬਣਾਓ", "ps": "حساب جوړ کړئ", "ta": "கணக்கை உருவாக்குக"
    },
    "signOut": {
        "en": "Sign Out", "bn": "সাইন আউট", "ar": "تسجيل الخروج",
        "tr": "Çıkış Yap", "ur": "سائن آؤٹ", "fa": "خروج",
        "id": "Keluar", "ms": "Log Keluar", "fr": "Se déconnecter",
        "de": "Abmelden", "es": "Cerrar sesión", "ru": "Выйти",
        "hi": "साइन आउट", "pt": "Sair", "it": "Esci",
        "ja": "サインアウト", "ko": "로그아웃", "zh": "退出登录", "vi": "Đăng xuất",
        "sw": "Toka", "az": "Çıxış", "kk": "Шығу",
        "pa": "ਸਾਈਨ ਆਊਟ", "ps": "وتل", "ta": "வெளியேறுக"
    },
    "deleteAccount": {
        "en": "Delete Account & Data", "bn": "অ্যাকাউন্ট ও ডেটা মুছুন", "ar": "حذف الحساب والبيانات",
        "tr": "Hesabı ve Verileri Sil", "ur": "اکاؤنٹ اور ڈیٹا ڈیلیٹ کریں", "fa": "حذف حساب و داده‌ها",
        "id": "Hapus Akun & Data", "ms": "Padam Akaun & Data", "fr": "Supprimer le compte et les données",
        "de": "Konto & Daten löschen", "es": "Eliminar cuenta y datos", "ru": "Удалить аккаунт и данные",
        "hi": "अकाउंट और डेटा हटाएं", "pt": "Excluir Conta e Dados", "it": "Elimina Account e Dati",
        "ja": "アカウントとデータを削除", "ko": "계정 및 데이터 삭제", "zh": "删除账户和数据", "vi": "Xóa tài khoản & Dữ liệu",
        "sw": "Futa Akaunti na Data", "az": "Hesabı və Məlumatları Sil", "kk": "Тіркелгі мен деректерді жою",
        "pa": "ਖਾਤਾ ਅਤੇ ਡਾਟਾ ਮਿਟਾਓ", "ps": "حساب او معلومات ړنګ کړئ", "ta": "கணக்கு மற்றும் தரவை நீக்குக"
    },
    "deleteAccountTitle": {
        "en": "Delete Account?", "bn": "অ্যাকাউন্ট মুছে ফেলবেন?", "ar": "هل تريد حذف الحساب؟",
        "tr": "Hesap Silinsin mi?", "ur": "کیا اکاؤنٹ ڈیلیٹ کرنا ہے؟", "fa": "حساب حذف شود؟",
        "id": "Hapus Akun?", "ms": "Padam Akaun?", "fr": "Supprimer le compte ?",
        "de": "Konto löschen?", "es": "¿Eliminar cuenta?", "ru": "Удалить аккаунт?",
        "hi": "अकाउंट हटाएं?", "pt": "Excluir Conta?", "it": "Eliminare l'account?",
        "ja": "アカウントを削除しますか？", "ko": "계정을 삭제하시겠습니까?", "zh": "删除账户？", "vi": "Xóa tài khoản?",
        "sw": "Kufuta Akaunti?", "az": "Hesab Silinsin?", "kk": "Тіркелгіні жою керек пе?",
        "pa": "ਕੀ ਖਾਤਾ ਮਿਟਾਉਣਾ ਹੈ?", "ps": "ایا حساب ړنګ کړئ؟", "ta": "கணக்கை நீக்கவா?"
    },
    "deleteAccountWarning": {
        "en": "This will permanently delete your account and all your synchronized notes, bookmarks, and reading history from the cloud. This action cannot be undone.",
        "bn": "এটি স্থায়ীভাবে আপনার অ্যাকাউন্ট এবং ক্লাউডে সংরক্ষিত সমস্ত নোট, বুকমার্ক ও পঠন ইতিহাস মুছে ফেলবে। এই কাজটি পূর্বাবস্থায় ফিরিয়ে আনা যাবে না।",
        "ar": "سيؤدي هذا إلى حذف حسابك وجميع ملاحظاتك وإشاراتك المرجعية وسجل القراءة المتزامن سحابيًا نهائيًا. لا يمكن التراجع عن هذا الإجراء.",
        "tr": "Bu işlem hesabınızı ve buluttaki tüm senkronize notlarınızı, yer imlerinizi ve okuma geçmişinizi kalıcı olarak silecektir. Bu işlem geri alınamaz.",
        "ur": "یہ مستقل طور پر آپ کا اکاؤنٹ اور کلاؤڈ سے آپ کے تمام مطابقت پذیر نوٹس، بک مارکس اور پڑھنے کی تاریخ کو حذف کر دے گا۔ اس عمل کو واپس نہیں لایا جا سکتا۔",
        "fa": "این عمل حساب شما و تمام یادداشت‌ها، نشانک‌ها و تاریخچه خواندن همگام‌شده در ابر را برای همیشه حذف خواهد کرد. این عمل غیرقابل بازگشت است.",
        "id": "Ini akan menghapus akun Anda dan semua catatan, bookmark, dan riwayat membaca yang disinkronkan dari cloud secara permanen. Tindakan ini tidak dapat dibatalkan.",
        "ms": "Ini akan memadamkan akaun anda dan semua nota, penanda halaman, dan sejarah bacaan yang diselaraskan dari awan secara kekal. Tindakan ini tidak boleh dibatalkan.",
        "fr": "Cela supprimera définitivement votre compte et toutes vos notes, favoris et historiques de lecture synchronisés dans le cloud. Cette action est irréversible.",
        "de": "Dadurch werden Ihr Konto und alle synchronisierten Notizen, Lesezeichen und Ihr Leseverlauf dauerhaft aus der Cloud gelöscht. Diese Aktion kann nicht rückgängig gemacht werden.",
        "es": "Esto eliminará permanentemente tu cuenta y todas tus notas, marcadores e historial de lectura sincronizados en la nube. Esta acción no se puede deshacer.",
        "ru": "Это навсегда удалит ваш аккаунт и все синхронизированные заметки, закладки и историю чтения из облака. Это действие нельзя отменить.",
        "hi": "यह आपके खाते और क्लाउड से आपके सभी समन्वयित नोट्स, बुकमार्क और पढ़ने के इतिहास को स्थायी रूप से हटा देगा। यह क्रिया पूर्ववत नहीं की जा सकती।",
        "pt": "Isso excluirá permanentemente sua conta e todas as suas notas, favoritos e histórico de leitura sincronizados na nuvem. Esta ação não pode ser desfeita.",
        "it": "Questo eliminerà definitivamente il tuo account e tutte le note, i segnalibri e la cronologia di lettura sincronizzati dal cloud. Questa azione non può essere annullata.",
        "ja": "これにより、アカウントとクラウド上の同期されたすべてのメモ、ブックマーク、読書履歴が完全に削除されます。この操作は元に戻せません。",
        "ko": "이렇게 하면 계정과 클라우드에 동기화된 모든 메모, 북마크, 읽기 기록이 영구적으로 삭제됩니다. 이 작업은 취소할 수 없습니다.",
        "zh": "这将永久删除您的账户以及云端同步的所有笔记、书签和阅读历史记录。此操作无法撤消。",
        "vi": "Thao tác này sẽ xóa vĩnh viễn tài khoản của bạn và tất cả các ghi chú, dấu trang và lịch sử đọc đã đồng bộ khỏi đám mây. Hành động này không thể hoàn tác.",
        "sw": "Hii itafuta akaunti yako kabisa na maelezo yote, alamisho, na historia ya usomaji iliyosawazishwa kutoka kwa wingu. Hatua hii haiwezi kutenduliwa.",
        "az": "Bu, hesabınızı və buluddakı bütün sinxronlaşdırılmış qeydlərinizi, əlfəcinlərinizi və oxu tarixçənizi həmişəlik siləcək. Bu əməliyyat geri qaytarıla bilməz.",
        "kk": "Бұл сіздің тіркелгіңізді және бұлттағы барлық синхрондалған жазбаларыңызды, бетбелгілеріңізді және оқу тарихыңызды біржола жояды. Бұл әрекетті қайтару мүмкін емес.",
        "pa": "ਇਹ ਤੁਹਾਡੇ ਖਾਤੇ ਅਤੇ ਕਲਾਉਡ ਤੋਂ ਤੁਹਾਡੇ ਸਾਰੇ ਸਮਕਾਲੀ ਨੋਟਸ, ਬੁੱਕਮਾਰਕਸ ਅਤੇ ਪੜ੍ਹਨ ਦੇ ਇਤਿਹਾਸ ਨੂੰ ਪੱਕੇ ਤੌਰ 'ਤੇ ਮਿਟਾ ਦੇਵੇਗਾ। ਇਸ ਕਾਰਵਾਈ ਨੂੰ ਵਾਪਸ ਨਹੀਂ ਲਿਆ ਜਾ ਸਕਦਾ।",
        "ps": "دا به ستاسو حساب او ستاسو ټول همغږي شوي نوټونه، بک مارکونه، او د لوستلو تاریخ د تل لپاره له کلاوډ څخه ړنګ کړي. دا عمل نشي بیرته کیدی.",
        "ta": "இது உங்கள் கணக்கையும் கிளவுடில் ஒத்திசைக்கப்பட்ட உங்கள் அனைத்து குறிப்புகள், புக்மார்க்குகள் மற்றும் வாசிப்பு வரலாற்றையும் நிரந்தரமாக நீக்கும். இந்த செயலை செயல்தவிர்க்க முடியாது."
    },
    "deleteAccountConfirm": {
        "en": "Yes, Delete Everything", "bn": "হ্যাঁ, সবকিছু মুছুন", "ar": "نعم، احذف كل شيء",
        "tr": "Evet, Her Şeyi Sil", "ur": "ہاں، سب کچھ حذف کریں", "fa": "بله، همه چیز را حذف کن",
        "id": "Ya, Hapus Semuanya", "ms": "Ya, Padam Semua", "fr": "Oui, tout supprimer",
        "de": "Ja, alles löschen", "es": "Sí, eliminar todo", "ru": "Да, удалить всё",
        "hi": "हाँ, सब कुछ हटाएं", "pt": "Sim, Excluir Tudo", "it": "Sì, elimina tutto",
        "ja": "はい、すべて削除します", "ko": "예, 모두 삭제합니다", "zh": "是的，删除全部", "vi": "Có, xóa tất cả",
        "sw": "Ndiyo, Futa Kila Kitu", "az": "Bəli, Hər Şeyi Sil", "kk": "Иә, бәрін жою",
        "pa": "ਹਾਂ, ਸਭ ਕੁਝ ਮਿਟਾਓ", "ps": "هو، ټول ړنګ کړئ", "ta": "ஆம், அனைத்தையும் நீக்கு"
    },
    "syncNow": {
        "en": "Sync Now", "bn": "এখনই সিঙ্ক করুন", "ar": "المزامنة الآن",
        "tr": "Şimdi Senkronize Et", "ur": "ابھی سنک کریں", "fa": "همگام‌سازی اکنون",
        "id": "Sinkronkan Sekarang", "ms": "Segerak Sekarang", "fr": "Synchroniser maintenant",
        "de": "Jetzt synchronisieren", "es": "Sincronizar ahora", "ru": "Синхронизировать сейчас",
        "hi": "अभी सिंक करें", "pt": "Sincronizar Agora", "it": "Sincronizza Ora",
        "ja": "今すぐ同期", "ko": "지금 동기화", "zh": "立即同步", "vi": "Đồng bộ ngay",
        "sw": "Sawazisha Sasa", "az": "İndi Sinxronlaşdırın", "kk": "Қазір синхрондау",
        "pa": "ਹੁਣੇ ਸਿੰਕ ਕਰੋ", "ps": "همدا اوس همغږي کړئ", "ta": "இப்போது ஒத்திசைக்க"
    },
    "syncing": {
        "en": "Syncing...", "bn": "সিঙ্ক হচ্ছে...", "ar": "جارٍ المزامنة...",
        "tr": "Senkronize ediliyor...", "ur": "سنک ہو رہا ہے...", "fa": "در حال همگام‌سازی...",
        "id": "Menyinkronkan...", "ms": "Menyegerakkan...", "fr": "Synchronisation...",
        "de": "Synchronisierung...", "es": "Sincronizando...", "ru": "Синхронизация...",
        "hi": "सिंक हो रहा है...", "pt": "Sincronizando...", "it": "Sincronizzazione in corso...",
        "ja": "同期中...", "ko": "동기화 중...", "zh": "正在同步...", "vi": "Đang đồng bộ...",
        "sw": "Inasawazisha...", "az": "Sinxronlaşdırılır...", "kk": "Синхрондалуда...",
        "pa": "ਸਿੰਕ ਹੋ ਰਿਹਾ ਹੈ...", "ps": "د همغږۍ په حال کې...", "ta": "ஒத்திசைக்கிறது..."
    },
    "syncSuccess": {
        "en": "Data synchronized successfully!", "bn": "ডেটা সফলভাবে সিঙ্ক হয়েছে!", "ar": "تمت مزامنة البيانات بنجاح!",
        "tr": "Veriler başarıyla senkronize edildi!", "ur": "ڈیٹا کامیابی کے ساتھ مطابقت پذیر ہو گیا!", "fa": "داده‌ها با موفقیت همگام‌سازی شدند!",
        "id": "Data berhasil disinkronkan!", "ms": "Data berjaya diselaraskan!", "fr": "Données synchronisées avec succès !",
        "de": "Daten erfolgreich synchronisiert!", "es": "¡Datos sincronizados con éxito!", "ru": "Данные успешно синхронизированы!",
        "hi": "डेटा सफलतापूर्वक सिंक हो गया!", "pt": "Dados sincronizados com sucesso!", "it": "Dati sincronizzati con successo!",
        "ja": "データが正常に同期されました！", "ko": "데이터가 성공적으로 동기화되었습니다!", "zh": "数据同步成功！", "vi": "Dữ liệu đã được đồng bộ thành công!",
        "sw": "Data imesawazishwa kikamilifu!", "az": "Məlumatlar uğurla sinxronlaşdırıldı!", "kk": "Деректер сәтті синхрондалды!",
        "pa": "ਡਾਟਾ ਸਫਲਤਾਪੂਰਵਕ ਸਿੰਕ ਹੋ ਗਿਆ!", "ps": "معلومات په بریالیتوب سره همغږي شول!", "ta": "தரவு வெற்றிகரமாக ஒத்திசைக்கப்பட்டது!"
    },
    "syncFailed": {
        "en": "Sync failed. Please check your internet connection.", "bn": "সিঙ্ক ব্যর্থ হয়েছে। ইন্টারনেট সংযোগ পরীক্ষা করুন।", "ar": "فشلت المزامنة. يرجى التحقق من اتصال الإنترنت.",
        "tr": "Senkronizasyon başarısız oldu. Lütfen internet bağlantınızı kontrol edin.", "ur": "سنک ناکام ہو گیا۔ انٹرنیٹ کنکشن چیک کریں۔", "fa": "همگام‌سازی ناموفق بود. اتصال اینترنت خود را بررسی کنید.",
        "id": "Sinkronisasi gagal. Silakan periksa koneksi internet Anda.", "ms": "Penyegerakan gagal. Sila periksa sambungan internet anda.",
        "fr": "Échec de la synchronisation. Veuillez vérifier votre connexion Internet.",
        "de": "Synchronisierung fehlgeschlagen. Bitte überprüfen Sie Ihre Internetverbindung.", "es": "Error de sincronización. Verifica tu conexión a internet.", "ru": "Ошибка синхронизации. Проверьте интернет-соединение.",
        "hi": "सिंक विफल रहा। कृपया अपना इंटरनेट कनेक्शन जांचें।", "pt": "Falha na sincronização. Verifique sua conexão com a internet.", "it": "Sincronizzazione non riuscita. Controlla la tua connessione Internet.",
        "ja": "同期に失敗しました。インターネット接続を確認してください。", "ko": "동기화에 실패했습니다. 인터넷 연결을 확인하세요.", "zh": "同步失败。请检查您的网络连接。", "vi": "Đồng bộ thất bại. Vui lòng kiểm tra kết nối internet của bạn.",
        "sw": "Usawazishaji umeshindwa. Tafadhali angalia muunganisho wako wa intaneti.", "az": "Sinxronizasiya uğursuz oldu. İnternet bağlantınızı yoxlayın.", "kk": "Синхрондау сәтсіз аяқталды. Интернет байланысын тексеріңіз.",
        "pa": "ਸਿੰਕ ਅਸਫਲ ਰਿਹਾ। ਕਿਰਪਾ ਕਰਕੇ ਆਪਣਾ ਇੰਟਰਨੈੱਟ ਕਨੈਕਸ਼ਨ ਜਾਂਚੋ।", "ps": "همغږي ناکامه شوه. مهرباني وکړئ خپل د انټرنیټ اړیکه وګورئ.", "ta": "ஒத்திசைவு தோல்வியடைந்தது. உங்கள் இணைய இணைப்பைச் சரிபார்க்கவும்."
    },
    "googleSignIn": {
        "en": "Continue with Google", "bn": "Google দিয়ে এগিয়ে যান", "ar": "المتابعة باستخدام Google",
        "tr": "Google ile Devam Et", "ur": "Google کے ساتھ جاری رکھیں", "fa": "ادامه با گوگل",
        "id": "Lanjutkan dengan Google", "ms": "Teruskan dengan Google", "fr": "Continuer avec Google",
        "de": "Mit Google fortfahren", "es": "Continuar con Google", "ru": "Продолжить с Google",
        "hi": "Google के साथ जारी रखें", "pt": "Continuar com o Google", "it": "Continua con Google",
        "ja": "Googleで続行", "ko": "Google로 계속", "zh": "通过 Google 继续", "vi": "Tiếp tục với Google",
        "sw": "Endelea na Google", "az": "Google ilə davam edin", "kk": "Google арқылы жалғастыру",
        "pa": "Google ਨਾਲ ਜਾਰੀ ਰੱਖੋ", "ps": "د ګوګل سره دوام ورکړئ", "ta": "Google உடன் தொடரவும்"
    },
    "email": {
        "en": "Email Address", "bn": "ইমেইল ঠিকানা", "ar": "البريد الإلكتروني",
        "tr": "E-posta Adresi", "ur": "ای میل پتہ", "fa": "آدرس ایمیل",
        "id": "Alamat Email", "ms": "Alamat E-mel", "fr": "Adresse e-mail",
        "de": "E-Mail-Adresse", "es": "Correo electrónico", "ru": "Электронная почта",
        "hi": "ईमेल पता", "pt": "Endereço de E-mail", "it": "Indirizzo Email",
        "ja": "メールアドレス", "ko": "이메일 주소", "zh": "电子邮箱", "vi": "Địa chỉ Email",
        "sw": "Barua pepe", "az": "E-poçt Ünvanı", "kk": "Электрондық пошта",
        "pa": "ਈਮੇਲ ਪਤਾ", "ps": "بریښنالیک پته", "ta": "மின்னஞ்சல் முகவரி"
    },
    "password": {
        "en": "Password", "bn": "পাসওয়ার্ড", "ar": "كلمة المرور",
        "tr": "Şifre", "ur": "پاس ورڈ", "fa": "رمز عبور",
        "id": "Kata Sandi", "ms": "Kata Laluan", "fr": "Mot de passe",
        "de": "Passwort", "es": "Contraseña", "ru": "Пароль",
        "hi": "पासवर्ड", "pt": "Senha", "it": "Password",
        "ja": "パスワード", "ko": "비밀번호", "zh": "密码", "vi": "Mật khẩu",
        "sw": "Nenosiri", "az": "Şifrə", "kk": "Құпия сөз",
        "pa": "ਪਾਸਵਰਡ", "ps": "پټ نوم", "ta": "கடவுச்சொல்"
    },
    "fullName": {
        "en": "Full Name", "bn": "পূর্ণ নাম", "ar": "الاسم الكامل",
        "tr": "Tam İsim", "ur": "پورا نام", "fa": "نام کامل",
        "id": "Nama Lengkap", "ms": "Nama Penuh", "fr": "Nom complet",
        "de": "Vollständiger Name", "es": "Nombre completo", "ru": "Полное имя",
        "hi": "पूरा नाम", "pt": "Nome Completo", "it": "Nome Completo",
        "ja": "氏名", "ko": "전체 이름", "zh": "全名", "vi": "Họ và tên",
        "sw": "Jina Kamili", "az": "Tam Ad", "kk": "Толық аты-жөні",
        "pa": "ਪੂਰਾ ਨਾਮ", "ps": "بشپړ نوم", "ta": "முழுப் பெயர்"
    },
    "forgotPassword": {
        "en": "Forgot Password?", "bn": "পাসওয়ার্ড ভুলে গেছেন?", "ar": "هل نسيت كلمة المرور؟",
        "tr": "Şifrenizi mi unuttunuz?", "ur": "پاس ورڈ بھول گئے؟", "fa": "رمز عبور را فراموش کرده‌اید؟",
        "id": "Lupa Kata Sandi?", "ms": "Lupa Kata Laluan?", "fr": "Mot de passe oublié ?",
        "de": "Passwort vergessen?", "es": "¿Olvidaste tu contraseña?", "ru": "Забыли пароль?",
        "hi": "पासवर्ड भूल गए?", "pt": "Esqueceu a senha?", "it": "Password dimenticata?",
        "ja": "パスワードをお忘れですか？", "ko": "비밀번호를 잊으셨나요?", "zh": "忘记密码？", "vi": "Quên mật khẩu?",
        "sw": "Umesahau Nenosiri?", "az": "Şifrəni unutmusunuz?", "kk": "Құпия сөзді ұмыттыңыз ба?",
        "pa": "ਕੀ ਪਾਸਵਰਡ ਭੁੱਲ ਗਏ ਹੋ?", "ps": "پټ نوم مو هېر شوی؟", "ta": "கடவுச்சொல்லை மறந்துவிட்டீர்களா?"
    },
    "sendResetLink": {
        "en": "Send Reset Link", "bn": "রিসেট লিংক পাঠান", "ar": "إرسال رابط إعادة التعيين",
        "tr": "Sıfırlama Bağlantısı Gönder", "ur": "ری سیٹ لنک بھیجیں", "fa": "ارسال پیوند بازنشانی",
        "id": "Kirim Tautan Reset", "ms": "Hantar Pautan Tetap Semula", "fr": "Envoyer le lien de réinitialisation",
        "de": "Link zum Zurücksetzen senden", "es": "Enviar enlace de restablecimiento", "ru": "Отправить ссылку для сброса",
        "hi": "रीसेट लिंक भेजें", "pt": "Enviar Link de Redefinição", "it": "Invia Link di Reimpostazione",
        "ja": "リセットリンクを送信", "ko": "재설정 링크 보내기", "zh": "发送重置链接", "vi": "Gửi liên kết đặt lại",
        "sw": "Tuma Kiungo cha Kuweka Upya", "az": "Sıfırlama Linki Göndər", "kk": "Қалпына келтіру сілтемесін жіберу",
        "pa": "ਰੀਸੈੱਟ ਲਿੰਕ ਭੇਜੋ", "ps": "د بیا تنظیم لینک واستوئ", "ta": "மீட்டமைப்பு இணைப்பை அனுப்புக"
    },
    "resetPasswordEmailSent": {
        "en": "Password reset link sent to your email!", "bn": "আপনার ইমেইলে পাসওয়ার্ড রিসেট লিংক পাঠানো হয়েছে!", "ar": "تم إرسال رابط إعادة تعيين كلمة المرور إلى بريدك الإلكتروني!",
        "tr": "Şifre sıfırlama bağlantısı e-postanıza gönderildi!", "ur": "پاس ورڈ ری سیٹ کا لنک آپ کے ای میل پر بھیج دیا گیا ہے!", "fa": "پیوند بازنشانی رمز عبور به ایمیل شما ارسال شد!",
        "id": "Tautan reset kata sandi telah dikirim ke email Anda!", "ms": "Pautan set semula kata laluan telah dihantar ke e-mel anda!", "fr": "Lien de réinitialisation envoyé à votre e-mail !",
        "de": "Link zum Zurücksetzen des Passworts wurde an Ihre E-Mail gesendet!", "es": "¡Enlace de restablecimiento enviado a tu correo electrónico!", "ru": "Ссылка для сброса пароля отправлена на вашу почту!",
        "hi": "पासवर्ड रीसेट लिंक आपके ईमेल पर भेजा गया!", "pt": "Link de redefinição de senha enviado para seu e-mail!", "it": "Link per reimpostare la password inviato alla tua email!",
        "ja": "パスワード再設定リンクをメールに送信しました！", "ko": "비밀번호 재설정 링크가 이메일로 전송되었습니다!", "zh": "密码重置链接已发送到您的邮箱！", "vi": "Liên kết đặt lại mật khẩu đã được gửi đến email của bạn!",
        "sw": "Kiungo cha kuweka upya nenosiri kimetumwa kwa barua pepe yako!", "az": "Şifrə sıfırlama linki e-poçtunuza göndərildi!", "kk": "Құпия сөзді қалпына келтіру сілтемесі поштаңызға жіберілді!",
        "pa": "ਪਾਸਵਰਡ ਰੀਸੈਟ ਲਿੰਕ ਤੁਹਾਡੀ ਈਮੇਲ 'ਤੇ ਭੇਜਿਆ ਗਿਆ ਹੈ!", "ps": "د پټ نوم د بیا تنظیم لینک ستاسو بریښنالیک ته واستول شو!", "ta": "கடவுச்சொல் மீட்டமைப்பு இணைப்பு உங்கள் மின்னஞ்சலுக்கு அனுப்பப்பட்டது!"
    },
    "continueAsGuest": {
        "en": "Continue as Guest", "bn": "গেস্ট হিসেবে চালিয়ে যান", "ar": "المتابعة كضيف",
        "tr": "Misafir Olarak Devam Et", "ur": "بطور مہمان جاری رکھیں", "fa": "ادامه به عنوان مهمان",
        "id": "Lanjutkan sebagai Tamu", "ms": "Teruskan sebagai Tetamu", "fr": "Continuer en tant qu'invité",
        "de": "Als Gast fortfahren", "es": "Continuar como invitado", "ru": "Продолжить как гость",
        "hi": "अतिथि के रूप में जारी रखें", "pt": "Continuar como Convidado", "it": "Continua come Ospite",
        "ja": "ゲストとして続行", "ko": "게스트로 계속", "zh": "以访客身份继续", "vi": "Tiếp tục với tư cách Khách",
        "sw": "Endelea kama Mgeni", "az": "Qonaq kimi davam edin", "kk": "Қонақ ретінде жалғастыру",
        "pa": "ਮਹਿਮਾਨ ਵਜੋਂ ਜਾਰੀ ਰੱਖੋ", "ps": "د میلمه په توګه دوام ورکړئ", "ta": "விருந்தினராக தொடரவும்"
    },
    "alreadyHaveAccount": {
        "en": "Already have an account? Sign In", "bn": "ইতিমধ্যে অ্যাকাউন্ট আছে? সাইন ইন করুন", "ar": "هل لديك حساب بالفعل؟ تسجيل الدخول",
        "tr": "Zaten bir hesabınız var mı? Giriş Yap", "ur": "پہلے سے اکاؤنٹ ہے؟ سائن ان کریں", "fa": "از قبل حساب کاربری دارید؟ وارد شوید",
        "id": "Sudah punya akun? Masuk", "ms": "Sudah mempunyai akaun? Log Masuk", "fr": "Vous avez déjà un compte ? Se connecter",
        "de": "Bereits ein Konto? Anmelden", "es": "¿Ya tienes una cuenta? Iniciar sesión", "ru": "Уже есть аккаунт? Войти",
        "hi": "क्या पहले से एक खाता मौजूद है? साइन इन", "pt": "Já tem uma conta? Entrar", "it": "Hai già un account? Accedi",
        "ja": "既にアカウントをお持ちですか？サインイン", "ko": "이미 계정이 있으신가요? 로그인", "zh": "已有账户？登录", "vi": "Đã có tài khoản? Đăng nhập",
        "sw": "Tayari una akaunti? Ingia", "az": "Artıq hesabınız var? Daxil olun", "kk": "Тіркелгіңіз бар ма? Кіру",
        "pa": "ਕੀ ਪਹਿਲਾਂ ਹੀ ਖਾਤਾ ਹੈ? ਸਾਈਨ ਇਨ ਕਰੋ", "ps": "ایا له وړاندې حساب لرئ؟ ننوځئ", "ta": "ஏற்கனவே கணக்கு உள்ளதா? உள்நுழைக"
    },
    "dontHaveAccount": {
        "en": "Don't have an account? Sign Up", "bn": "অ্যাকাউন্ট নেই? তৈরি করুন", "ar": "ليس لديك حساب؟ إنشاء حساب",
        "tr": "Hesabınız yok mu? Kaydolun", "ur": "اکاؤنٹ نہیں ہے؟ سائن اپ کریں", "fa": "حساب کاربری ندارید؟ ثبت نام کنید",
        "id": "Belum punya akun? Daftar", "ms": "Belum mempunyai akaun? Daftar", "fr": "Vous n'avez pas de compte ? S'inscrire",
        "de": "Noch kein Konto? Registrieren", "es": "¿No tienes una cuenta? Regístrate", "ru": "Нет аккаунта? Зарегистрироваться",
        "hi": "अकाउंट नहीं है? साइन अप करें", "pt": "Não tem uma conta? Cadastre-se", "it": "Non hai un account? Registrati",
        "ja": "アカウントをお持ちでないですか？登録", "ko": "계정이 없으신가요? 가입하기", "zh": "还没有账户？注册", "vi": "Chưa có tài khoản? Đăng ký",
        "sw": "Huna akaunti? Jisajili", "az": "Hesabınız yoxdur? Qeydiyyatdan keçin", "kk": "Тіркелгіңіз жоқ па? Тіркелу",
        "pa": "ਕੀ ਖਾਤਾ ਨਹੀਂ ਹੈ? ਸਾਈਨ ਅੱਪ ਕਰੋ", "ps": "حساب نه لرئ؟ نوم لیکنه وکړئ", "ta": "கணக்கு இல்லையா? பதிவு செய்க"
    },
    "privacyPolicyNotice": {
        "en": "By continuing, you agree to our Terms of Service & Privacy Policy.", "bn": "এগিয়ে যাওয়ার মাধ্যমে, আপনি আমাদের সেবা শর্তাবলী এবং গোপনীয়তা নীতিতে সম্মতি দিচ্ছেন।", "ar": "بالمتابعة، فإنك توافق على شروط الخدمة وسياسة الخصوصية الخاصة بنا.",
        "tr": "Devam ederek Hizmet Şartlarımızı ve Gizlilik Politikamızı kabul etmiş olursunuz.", "ur": "جاری رکھ کر، آپ ہماری سروس کی شرائط اور رازداری کی پالیسی سے اتفاق کرتے ہیں۔", "fa": "با ادامه، شما با شرایط خدمات و خط مشی رازداری ما موافقت می‌کنید.",
        "id": "Dengan melanjutkan, Anda menyetujui Ketentuan Layanan & Kebijakan Privasi kami.", "ms": "Dengan meneruskan, anda bersetuju dengan Syarat Perkhidmatan & Dasar Privasi kami.", "fr": "En continuant, vous acceptez nos Conditions d'utilisation et notre Politique de confidentialité.",
        "de": "Indem Sie fortfahren, stimmen Sie unseren Nutzungsbedingungen und Datenschutzbestimmungen zu.", "es": "Al continuar, aceptas nuestros Términos de servicio y Política de privacidad.", "ru": "Продолжая, вы соглашаетесь с нашими Условиями обслуживания и Политикой конфиденциальности.",
        "hi": "जारी रखकर, आप हमारी सेवा की शर्तों और गोपनीयता नीति से सहमत होते हैं।", "pt": "Ao continuar, você concorda com nossos Termos de Serviço e Política de Privacidade.", "it": "Continuando, accetti i nostri Termini di servizio e l'Informativa sulla privacy.",
        "ja": "続行すると、利用規約とプライバシーポリシーに同意したことになります。", "ko": "계속 진행하면 서비스 약관 및 개인정보 보호정책에 동의하게 됩니다.", "zh": "继续操作即表示您同意我们的服务条款和隐私政策。", "vi": "Bằng cách tiếp tục, bạn đồng ý với Điều khoản dịch vụ & Chính sách quyền riêng tư của chúng tôi.",
        "sw": "Kwa kuendelea, unakubali Masharti yetu ya Huduma na Sera ya Faragha.", "az": "Davam etməklə Xidmət Şərtlərimiz və Məxfilik Siyasətimizlə razılaşırsınız.", "kk": "Жалғастыру арқылы сіз біздің Қызмет көрсету шарттарымыз бен Құпиялылық саясатымызға келісесіз.",
        "pa": "ਜਾਰੀ ਰੱਖ ਕੇ, ਤੁਸੀਂ ਸਾਡੀਆਂ ਸੇਵਾ ਦੀਆਂ ਸ਼ਰਤਾਂ ਅਤੇ ਗੋਪਨੀਯਤਾ ਨੀਤੀ ਨਾਲ ਸਹਿਮਤ ਹੁੰਦੇ ਹੋ।", "ps": "د دوام ورکولو سره، تاسو زموږ د خدماتو شرایطو او د محرمیت پالیسۍ سره موافق یاست.", "ta": "தொடர்வதன் மூலம், எங்கள் சேவை விதிமுறைகள் மற்றும் தனியுரிமைக் கொள்கையை ஏற்கிறீர்கள்."
    },
    "guestUser": {
        "en": "Guest User", "bn": "গেস্ট ব্যবহারকারী", "ar": "مستخدم ضيف",
        "tr": "Misafir Kullanıcı", "ur": "مہمان صارف", "fa": "کاربر مهمان",
        "id": "Pengguna Tamu", "ms": "Pengguna Tetamu", "fr": "Utilisateur invité",
        "de": "Gastbenutzer", "es": "Usuario invitado", "ru": "Гостевой пользователь",
        "hi": "अतिथि उपयोगकर्ता", "pt": "Usuário Convidado", "it": "Utente Ospite",
        "ja": "ゲストユーザー", "ko": "게스트 사용자", "zh": "访客用户", "vi": "Người dùng Khách",
        "sw": "Mtumiaji Mgeni", "az": "Qonaq İstifadəçi", "kk": "Қонақ пайдаланушы",
        "pa": "ਮਹਿਮਾਨ ਉਪਭੋਗਤਾ", "ps": "میلمه کاروونکی", "ta": "விருந்தினர் பயனர்"
    },
    "syncedCloudBackup": {
        "en": "Cloud Synchronization", "bn": "ক্লাউড সিঙ্ক্রোনাইজেশন", "ar": "المزامنة السحابية",
        "tr": "Bulut Senkronizasyonu", "ur": "کلاؤڈ ہم آہنگی", "fa": "همگام‌سازی ابری",
        "id": "Sinkronisasi Cloud", "ms": "Penyegerakan Awan", "fr": "Synchronisation Cloud",
        "de": "Cloud-Synchronisierung", "es": "Sincronización en la nube", "ru": "Облачная синхронизация",
        "hi": "क्लाउड सिंक्रोनाइज़ेशन", "pt": "Sincronização na Nuvem", "it": "Sincronizzazione Cloud",
        "ja": "クラウド同期", "ko": "클라우드 동기화", "zh": "云端同步", "vi": "Đồng bộ đám mây",
        "sw": "Usawazishaji wa Wingu", "az": "Bulud Sinxronizasiyası", "kk": "Бұлттық синхрондау",
        "pa": "ਕਲਾਉਡ ਸਿੰਕ੍ਰੋਨਾਈਜ਼ੇਸ਼ਨ", "ps": "کلاوډ همغږي", "ta": "கிளவுட் ஒத்திசைவு"
    },
    "syncedCloudBackupDesc": {
        "en": "Keep your notes, pins, and reading history synced across all your devices.",
        "bn": "আপনার সমস্ত ডিভাইসে আপনার নোট, পিন এবং পঠন ইতিহাস সুরক্ষিত ও সিঙ্ক রাখুন।",
        "ar": "حافظ على مزامنة ملاحظاتك وإشاراتك وسجل القراءة عبر جميع أجهزتك.",
        "tr": "Notlarınızı, yer imlerinizi ve okuma geçmişinizi tüm cihazlarınızda senkronize tutun.",
        "ur": "اپنے تمام آلات پر اپنے نوٹس، پن اور پڑھنے کی تاریخ کو مطابقت پذیر رکھیں۔",
        "fa": "یادداشت‌ها، سنجاق‌ها و تاریخچه خواندن خود را در همه دستگاه‌هایتان همگام نگه دارید.",
        "id": "Jaga agar catatan, pin, dan riwayat membaca Anda tetap tersinkronisasi di semua perangkat.",
        "ms": "Pastikan nota, pin, dan sejarah bacaan anda diselaraskan di semua peranti anda.",
        "fr": "Gardez vos notes, favoris et historique de lecture synchronisés sur tous vos appareils.",
        "de": "Halten Sie Ihre Notizen, Pins und Ihren Leseverlauf auf allen Ihren Geräten synchron.",
        "es": "Mantén tus notas, marcadores e historial de lectura sincronizados en todos tus dispositivos.",
        "ru": "Синхронизируйте заметки, закладки и историю чтения на всех ваших устройствах.",
        "hi": "अपने सभी उपकरणों पर अपने नोट्स, पिन और पढ़ने के इतिहास को सिंक रखें।",
        "pt": "Mantenha suas notas, pins e histórico de leitura sincronizados em todos os seus dispositivos.",
        "it": "Mantieni sincronizzate note, pin e cronologia di lettura su tutti i tuoi dispositivi.",
        "ja": "すべてのデバイス間でメモ、ピン、読書履歴を同期します。",
        "ko": "모든 기기에서 메모, 고정 항목 및 읽기 기록을 동기화 상태로 유지하세요.",
        "zh": "在所有设备上同步您的笔记、图钉和阅读历史记录。",
        "vi": "Giữ ghi chú, ghim và lịch sử đọc của bạn được đồng bộ hóa trên tất cả các thiết bị.",
        "sw": "Weka madokezo yako, pini, na historia ya usomaji ikiwa imesawazishwa kwenye vifaa vyako vyote.",
        "az": "Qeydlərinizi, sancaqlı ayələrinizi və oxu tarixçənizi bütün cihazlarınızda sinxron saxlayın.",
        "kk": "Жазбаларыңызды, бекітілген аяттарыңызды және оқу тарихыңызды барлық құрылғыларда синхрондаңыз.",
        "pa": "ਆਪਣੇ ਸਾਰੇ ਡਿਵਾਈਸਾਂ ਵਿੱਚ ਆਪਣੇ ਨੋਟਸ, ਪਿੰਨ ਅਤੇ ਪੜ੍ਹਨ ਦੇ ਇਤਿਹਾਸ ਨੂੰ ਸਿੰਕ ਰੱਖੋ।",
        "ps": "خپل نوټونه، پنونه او د لوستلو تاریخ په خپلو ټولو وسیلو کې همغږي وساتئ.",
        "ta": "உங்கள் குறிப்புகள், பின்கள் மற்றும் வாசிப்பு வரலாற்றை உங்கள் எல்லா சாதனங்களிலும் ஒத்திசைக்கவும்."
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