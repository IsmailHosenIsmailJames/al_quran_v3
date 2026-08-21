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