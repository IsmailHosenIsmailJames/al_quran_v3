import json
import os

languages = [
    "en", "ar", "az", "bn", "de", "es", "fa", "fr", "hi", "id", "it", "ja", 
    "kk", "ko", "ms", "pa", "ps", "pt", "ru", "sw", "ta", "tr", "ur", "vi", "zh"
]

translations = {
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
    "reminderRingtone": {
        "en": "Reminder Sound", "ar": "صوت التذكير", "az": "Xatırlatma səsi",
        "bn": "রিমাইন্ডার রিংটোন", "de": "Erinnerungston", "es": "Sonido de recordatorio",
        "fa": "صدای یادآور", "fr": "Son de rappel", "hi": "स्मरण ध्वनि",
        "id": "Suara Pengingat", "it": "Suono del promemoria", "ja": "リマインダー音",
        "kk": "Еске салу дыбысы", "ko": "알림음", "ms": "Bunyi Peringatan",
        "pa": "ਯਾਦ-ਦਹਾਨੀ ਧੁਨੀ", "ps": "د یادونې غږ", "pt": "Som de lembrete",
        "ru": "Звук напоминания", "sw": "Sauti ya Kikumbusho", "ta": "நினைவூட்டல் ஒலி",
        "tr": "Hatırlatıcı Sesi", "ur": "یاد دہانی کی آواز", "vi": "Âm thanh nhắc nhở",
        "zh": "提醒声音"
    },
    "chooseRingtone": {
        "en": "Choose Ringtone", "ar": "اختيار النغمة", "az": "Zəng melodiyası seçin",
        "bn": "রিংটোন নির্বাচন করুন", "de": "Klingelton wählen", "es": "Elegir tono",
        "fa": "انتخاب زنگ", "fr": "Choisir la sonnerie", "hi": "रिंगटोन चुनें",
        "id": "Pilih Nada Dering", "it": "Scegli suoneria", "ja": "着信音を選択",
        "kk": "Қоңырау үнін таңдаңыз", "ko": "벨소리 선택", "ms": "Pilih Nada Dering",
        "pa": "ਰਿੰਗਟੋਨ ਚੁਣੋ", "ps": "د زنګ غږ غوره کړئ", "pt": "Escolher toque",
        "ru": "Выбрать мелодию", "sw": "Chagua Mlio", "ta": "ரிங்டோனைத் தேர்ந்தெடுக்கவும்",
        "tr": "Zil Sesi Seç", "ur": "رنگ ٹون منتخب کریں", "vi": "Chọn nhạc chuông",
        "zh": "选择铃声"
    },
    "chooseRingtoneDescription": {
        "en": "Choose from system sounds or device audio",
        "ar": "اختر من أصوات النظام أو ملفات الصوت بالجهاز",
        "az": "Sistem səslərindən və ya cihaz audio fayllarından seçin",
        "bn": "সিস্টেম সাউন্ড বা ডিভাইসের অডিও থেকে বেছে নিন",
        "de": "Wählen Sie aus Systemtönen oder Gerätedateien",
        "es": "Elija entre sonidos del sistema o audio del dispositivo",
        "fa": "از صداهای سیستم یا فایل‌های صوتی دستگاه انتخاب کنید",
        "fr": "Choisissez parmi les sons du système ou l'audio de l'appareil",
        "hi": "सिस्टम ध्वनियों या डिवाइस ऑडियो से चुनें",
        "id": "Pilih dari suara sistem atau audio perangkat",
        "it": "Scegli tra i suoni di sistema o l'audio del dispositivo",
        "ja": "システム音またはデバイスの音声から選択",
        "kk": "Жүйелік дыбыстардан немесе құрылғы аудиосынан таңдаңыз",
        "ko": "시스템 소리 또는 기기 오디오에서 선택",
        "ms": "Pilih daripada bunyi sistem atau audio peranti",
        "pa": "ਸਿਸਟਮ ਧੁਨੀਆਂ ਜਾਂ ਡਿਵਾਈਸ ਆਡੀਓ ਵਿੱਚੋਂ ਚੁਣੋ",
        "ps": "د سیسټم غږونو یا د وسیلې له آډیو څخه غوره کړئ",
        "pt": "Escolha entre sons do sistema ou áudio do dispositivo",
        "ru": "Выберите из системных звуков или аудио устройства",
        "sw": "Chagua kutoka kwa sauti za mfumo au faili za sauti za kifaa",
        "ta": "கணினி ஒலிகள் அல்லது சாதன ஆடியோவிலிருந்து தேர்ந்தெடுக்கவும்",
        "tr": "Sistem seslerinden veya cihaz seslerinden seçin",
        "ur": "سسٹم کی آوازوں یا ڈیوائس کے آڈیو سے منتخب کریں",
        "vi": "Chọn từ âm thanh hệ thống hoặc âm thanh thiết bị",
        "zh": "从系统声音或设备音频中选择"
    },
    "defaultSound": {
        "en": "App Default (notification_sound.wav)",
        "ar": "افتراضي التطبيق (notification_sound.wav)",
        "az": "Tətbiq standartı (notification_sound.wav)",
        "bn": "অ্যাপ ডিফল্ট (notification_sound.wav)",
        "de": "App-Standard (notification_sound.wav)",
        "es": "Predeterminado de la app (notification_sound.wav)",
        "fa": "پیش‌فرض برنامه (notification_sound.wav)",
        "fr": "Par défaut de l'application (notification_sound.wav)",
        "hi": "ऐप डिफ़ॉल्ट (notification_sound.wav)",
        "id": "Bawaan Aplikasi (notification_sound.wav)",
        "it": "Predefinito dell'app (notification_sound.wav)",
        "ja": "アプリデフォルト (notification_sound.wav)",
        "kk": "Қолданбаның әдепкі үні (notification_sound.wav)",
        "ko": "앱 기본값 (notification_sound.wav)",
        "ms": "Lalai Aplikasi (notification_sound.wav)",
        "pa": "ਐਪ ਡਿਫੌਲਟ (notification_sound.wav)",
        "ps": "د اپلیکیشن ډیفالټ (notification_sound.wav)",
        "pt": "Padrão do aplicativo (notification_sound.wav)",
        "ru": "По умолчанию приложения (notification_sound.wav)",
        "sw": "Chaguo-msingi la Programu (notification_sound.wav)",
        "ta": "செயலி இயல்புநிலை (notification_sound.wav)",
        "tr": "Uygulama Varsayılanı (notification_sound.wav)",
        "ur": "ایپ کا ڈیفالٹ (notification_sound.wav)",
        "vi": "Mặc định ứng dụng (notification_sound.wav)",
        "zh": "应用默认 (notification_sound.wav)"
    },
    "systemNotification": {
        "en": "System Default Notification",
        "ar": "إشعار النظام الافتراضي",
        "az": "Sistem standart bildirişi",
        "bn": "সিস্টেম ডিফল্ট নোটিফিকেশন",
        "de": "Systemstandard-Benachrichtigung",
        "es": "Notificación predeterminada del sistema",
        "fa": "اعلان پیش‌فرض سیستم",
        "fr": "Notification par défaut du système",
        "hi": "सिस्टम डिफ़ॉल्ट सूचना",
        "id": "Notifikasi Bawaan Sistem",
        "it": "Notifica predefinita di sistema",
        "ja": "システム標準の通知音",
        "kk": "Жүйенің әдепкі хабарландыруы",
        "ko": "시스템 기본 알림",
        "ms": "Pemberitahuan Lalai Sistem",
        "pa": "ਸਿਸਟਮ ਡਿਫੌਲਟ ਸੂਚਨਾ",
        "ps": "د سیسټم ډیفالټ خبرتیا",
        "pt": "Notificação padrão do sistema",
        "ru": "Системное уведомление по умолчанию",
        "sw": "Taarifa Chaguomsingi ya Mfumo",
        "ta": "கணினி இயல்புநிலை அறிவிப்பு",
        "tr": "Sistem Varsayılan Bildirimi",
        "ur": "سسٹم کا ڈیفالٹ نوٹیفکیشن",
        "vi": "Thông báo mặc định của hệ thống",
        "zh": "系统默认通知"
    },
    "systemAlarm": {
        "en": "System Default Alarm",
        "ar": "منبه النظام الافتراضي",
        "az": "Sistem standart zəngli saatı",
        "bn": "সিস্টেম ডিফল্ট অ্যালার্ম",
        "de": "Systemstandard-Alarm",
        "es": "Alarma predeterminada del sistema",
        "fa": "هشدار پیش‌فرض سیستم",
        "fr": "Alarme par défaut du système",
        "hi": "सिस्टम डिफ़ॉल्ट अलार्म",
        "id": "Alarm Bawaan Sistem",
        "it": "Sveglia predefinita di sistema",
        "ja": "システム標準のアラーム音",
        "kk": "Жүйенің әдепкі оятар үні",
        "ko": "시스템 기본 알람",
        "ms": "Penggera Lalai Sistem",
        "pa": "ਸਿਸਟਮ ਡਿਫੌਲਟ ਅਲਾਰਮ",
        "ps": "د سیسټم ډیفالټ الارم",
        "pt": "Alarme padrão do sistema",
        "ru": "Системный будильник по умолчанию",
        "sw": "Kengele Chaguomsingi ya Mfumo",
        "ta": "கணினி இயல்புநிலை அலாரம்",
        "tr": "Sistem Varsayılan Alarmı",
        "ur": "سسٹم کا ڈیفالٹ الارم",
        "vi": "Báo thức mặc định của hệ thống",
        "zh": "系统默认闹钟"
    },
    "systemRingtone": {
        "en": "System Phone Ringtone",
        "ar": "نغمة الهاتف الافتراضية",
        "az": "Sistem telefon zəngi",
        "bn": "সিস্টেম ফোন রিংটোন",
        "de": "System-Telefonklingelton",
        "es": "Tono de llamada del sistema",
        "fa": "زنگ تماس سیستم",
        "fr": "Sonnerie de téléphone du système",
        "hi": "सिस्टम फ़ोन रिंगटोन",
        "id": "Nada Dering Telepon Sistem",
        "it": "Suoneria del telefono di sistema",
        "ja": "システムの着信音",
        "kk": "Жүйенің телефон қоңырауы",
        "ko": "시스템 전화 벨소리",
        "ms": "Nada Dering Telefon Sistem",
        "pa": "ਸਿਸਟਮ ਫ਼ੋਨ ਰਿੰਗਟੋਨ",
        "ps": "د سیسټم د ټیلیفون زنګ",
        "pt": "Toque de telefone do sistema",
        "ru": "Системный звонок телефона",
        "sw": "Mlio wa Simu wa Mfumo",
        "ta": "கணினி தொலைபேசி ரிங்டோன்",
        "tr": "Sistem Telefon Zil Sesi",
        "ur": "سسٹم کی فون رنگ ٹون",
        "vi": "Nhạc chuông điện thoại của hệ thống",
        "zh": "系统电话铃声"
    },
    "previewSound": {
        "en": "Preview Sound",
        "ar": "معاينة الصوت",
        "az": "Səsə qabaqcadan baxış",
        "bn": "শব্দ শুনুন",
        "de": "Ton anhören",
        "es": "Vista previa del sonido",
        "fa": "پیش‌شنیدن صدا",
        "fr": "Écouter le son",
        "hi": "ध्वनि पूर्वावलोकन",
        "id": "Pratinjau Suara",
        "it": "Ascolta anteprima",
        "ja": "サウンドを試聴",
        "kk": "Дыбысты тыңдау",
        "ko": "소리 미리듣기",
        "ms": "Pratonton Bunyi",
        "pa": "ਧੁਨੀ ਦੀ ਝਲਕ",
        "ps": "د غږ مخکتنه",
        "pt": "Ouvir prévia",
        "ru": "Прослушать звук",
        "sw": "Sikiliza Sauti",
        "ta": "ஒலியை முன்னோட்டமிடு",
        "tr": "Sesi Önizle",
        "ur": "آواز سنیں",
        "vi": "Nghe thử âm thanh",
        "zh": "试听声音"
    },
    "stopPreview": {
        "en": "Stop Preview",
        "ar": "إيقاف المعاينة",
        "az": "Önizləməni dayandırın",
        "bn": "প্লে বন্ধ করুন",
        "de": "Wiedergabe stoppen",
        "es": "Detener reproducción",
        "fa": "توقف پخش",
        "fr": "Arrêter l'écoute",
        "hi": "पूर्वावलोकन रोकें",
        "id": "Hentikan Pratinjau",
        "it": "Ferma anteprima",
        "ja": "試聴を停止",
        "kk": "Тыңдауды тоқтату",
        "ko": "미리듣기 중지",
        "ms": "Hentikan Pratonton",
        "pa": "ਝਲਕ ਰੋਕੋ",
        "ps": "مخکتنه بنده کړئ",
        "pt": "Parar prévia",
        "ru": "Остановить",
        "sw": "Acha Kusikiliza",
        "ta": "முன்னோட்டத்தை நிறுத்து",
        "tr": "Önizlemeyi Durdur",
        "ur": "بند کریں",
        "vi": "Dừng nghe thử",
        "zh": "停止试听"
    },
    "testNotification": {
        "en": "Send Test Notification",
        "ar": "إرسال إشعار تجريبي",
        "az": "Test bildirişi göndərin",
        "bn": "টেস্ট নোটিফিকেশন পাঠান",
        "de": "Testbenachrichtigung senden",
        "es": "Enviar notificación de prueba",
        "fa": "ارسال اعلان آزمایشی",
        "fr": "Envoyer une notification de test",
        "hi": "परीक्षण सूचना भेजें",
        "id": "Kirim Notifikasi Uji Coba",
        "it": "Invia notifica di prova",
        "ja": "テスト通知を送信",
        "kk": "Сынақ хабарландыруын жіберу",
        "ko": "테스트 알림 보내기",
        "ms": "Hantar Pemberitahuan Ujian",
        "pa": "ਟੈਸਟ ਸੂਚਨਾ ਭੇਜੋ",
        "ps": "ازمایښتي خبرتیا واستوئ",
        "pt": "Enviar notificação de teste",
        "ru": "Отправить тестовое уведомление",
        "sw": "Tuma Taarifa ya Jaribio",
        "ta": "சோதனை அறிவிப்பை அனுப்பவும்",
        "tr": "Test Bildirimi Gönder",
        "ur": "ٹیسٹ نوٹیفکیشن بھیجیں",
        "vi": "Gửi thông báo thử nghiệm",
        "zh": "发送测试通知"
    },
    "testNotificationSent": {
        "en": "Test notification sent! Check your notifications.",
        "ar": "تم إرسال الإشعار التجريبي! تحقق من إشعاراتك.",
        "az": "Test bildirişi göndərildi! Bildirişlərinizi yoxlayın.",
        "bn": "টেস্ট নোটিফিকেশন পাঠানো হয়েছে! আপনার নোটিফিকেশন চেক করুন।",
        "de": "Testbenachrichtigung gesendet! Überprüfen Sie Ihre Benachrichtigungen.",
        "es": "¡Notificación de prueba enviada! Revisa tus notificaciones.",
        "fa": "اعلان آزمایشی ارسال شد! اعلان‌های خود را بررسی کنید.",
        "fr": "Notification de test envoyée ! Vérifiez vos notifications.",
        "hi": "परीक्षण सूचना भेजी गई! अपनी सूचनाएं जांचें।",
        "id": "Notifikasi uji coba terkirim! Periksa notifikasi Anda.",
        "it": "Notifica di prova inviata! Controlla le tue notifiche.",
        "ja": "テスト通知を送信しました！通知を確認してください。",
        "kk": "Сынақ хабарландыруы жіберілді! Хабарландыруларыңызды тексеріңіз.",
        "ko": "테스트 알림이 전송되었습니다! 알림을 확인하세요.",
        "ms": "Pemberitahuan ujian dihantar! Semak pemberitahuan anda.",
        "pa": "ਟੈਸਟ ਸੂਚਨਾ ਭੇਜੀ ਗਈ! ਆਪਣੀਆਂ ਸੂਚਨਾਵਾਂ ਦੀ ਜਾਂਚ ਕਰੋ।",
        "ps": "ازمایښتي خبرتیا واستول شوه! خپلې خبرتیاوې وګورئ.",
        "pt": "Notificação de teste enviada! Verifique suas notificações.",
        "ru": "Тестовое уведомление отправлено! Проверьте панель уведомлений.",
        "sw": "Taarifa ya jaribio imetumwa! Angalia taarifa zako.",
        "ta": "சோதனை அறிவிப்பு அனுப்பப்பட்டது! உங்கள் அறிவிப்புகளைச் சரிபார்க்கவும்.",
        "tr": "Test bildirimi gönderildi! Bildirimlerinizi kontrol edin.",
        "ur": "ٹیسٹ نوٹیفکیشن بھیج دیا گیا! اپنے نوٹیفکیشنز چیک کریں۔",
        "vi": "Đã gửi thông báo thử nghiệm! Kiểm tra thông báo của bạn.",
        "zh": "测试通知已发送！请查看您的通知。"
    },
    "quickPresets": {
        "en": "Quick Presets",
        "ar": "خيارات سريعة",
        "az": "Sürətli seçimlər",
        "bn": "কুইক প্রিসেট",
        "de": "Schnellauswahl",
        "es": "Ajustes rápidos",
        "fa": "گزینه‌های سریع",
        "fr": "Sélection rapide",
        "hi": "त्वरित प्रीसेट",
        "id": "Pilihan Cepat",
        "it": "Preimpostazioni rapide",
        "ja": "クイックプリセット",
        "kk": "Жылдам таңдаулар",
        "ko": "빠른 사전 설정",
        "ms": "Pratetap Pantas",
        "pa": "ਤੁਰੰਤ ਪ੍ਰੀਸੈਟਸ",
        "ps": "ګړندي اختیارونه",
        "pt": "Predefinições rápidas",
        "ru": "Быстрый выбор",
        "sw": "Chaguo za Haraka",
        "ta": "விரைவு முன்னமைவுகள்",
        "tr": "Hızlı Önayarlar",
        "ur": "فوری ترتیبات",
        "vi": "Cài đặt nhanh",
        "zh": "快速预设"
    },
    "reminderModeOff": {
        "en": "Off", "ar": "إيقاف", "az": "Bağlı", "bn": "বন্ধ",
        "de": "Aus", "es": "Desactivado", "fa": "خاموش", "fr": "Désactivé",
        "hi": "बंद", "id": "Mati", "it": "Disattivato", "ja": "オフ",
        "kk": "Өшірулі", "ko": "꺼짐", "ms": "Mati", "pa": "ਬੰਦ",
        "ps": "بند", "pt": "Desligado", "ru": "Выкл", "sw": "Zima",
        "ta": "முடக்கு", "tr": "Kapalı", "ur": "بند", "vi": "Tắt", "zh": "关闭"
    },
    "reminderModeNotification": {
        "en": "Notification", "ar": "إشعار", "az": "Bildiriş", "bn": "নোটিফিকেশন",
        "de": "Benachrichtigung", "es": "Notificación", "fa": "اعلان", "fr": "Notification",
        "hi": "अधिसूचना", "id": "Notifikasi", "it": "Notifica", "ja": "通知",
        "kk": "Хабарландыру", "ko": "알림", "ms": "Pemberitahuan", "pa": "ਸੂਚਨਾ",
        "ps": "خبرتیا", "pt": "Notificação", "ru": "Уведомление", "sw": "Arifa",
        "ta": "அறிவிப்பு", "tr": "Bildirim", "ur": "اطلاع", "vi": "Thông báo", "zh": "通知"
    },
    "reminderModeAlarm": {
        "en": "Alarm", "ar": "منبه", "az": "Zəngli saat", "bn": "অ্যালার্ম",
        "de": "Wecker", "es": "Alarma", "fa": "هشدار", "fr": "Alarme",
        "hi": "अलार्म", "id": "Alarm", "it": "Sveglia", "ja": "アラーム",
        "kk": "Оятқыш", "ko": "알람", "ms": "Penggera", "pa": "ਅਲਾਰਮ",
        "ps": "الارم", "pt": "Alarme", "ru": "Будильник", "sw": "Kengele",
        "ta": "அலாரம்", "tr": "Alarm", "ur": "الارم", "vi": "Báo thức", "zh": "闹钟"
    },
    "testAlarm": {
        "en": "Test Alarm", "ar": "تجربة المنبه", "az": "Zəngli saatı sına", "bn": "অ্যালার্ম পরীক্ষা করুন",
        "de": "Wecker testen", "es": "Probar alarma", "fa": "آزمایش هشدار", "fr": "Tester l'alarme",
        "hi": "अलार्म परीक्षण", "id": "Uji Alarm", "it": "Testa sveglia", "ja": "アラームテスト",
        "kk": "Оятқышты тексеру", "ko": "알람 테스트", "ms": "Uji Penggera", "pa": "ਅਲਾਰਮ ਪਰਖੋ",
        "ps": "الارم وازموئئ", "pt": "Testar alarme", "ru": "Тест будильника", "sw": "Jaribu Kengele",
        "ta": "அலாரத்தை சோதிக்கவும்", "tr": "Alarmı Test Et", "ur": "الارم آزمائیں", "vi": "Kiểm tra báo thức", "zh": "测试闹钟"
    },
    "testAlarmSent": {
        "en": "Full-screen alarm test sent", "ar": "تم إرسال تجربة المنبه بملء الشاشة", "az": "Tam ekran zəngli saat testi göndərildi", "bn": "ফুল-স্ক্রিন অ্যালার্ম টেস্ট পাঠানো হয়েছে",
        "de": "Vollbild-Alarmtest gesendet", "es": "Prueba de alarma de pantalla completa enviada", "fa": "آزمایش هشدار تمام صفحه ارسال شد", "fr": "Test d'alarme plein écran envoyé",
        "hi": "फुल-स्क्रीन अलार्म टेस्ट भेजा गया", "id": "Uji alarm layar penuh terkirim", "it": "Test sveglia a schermo intero inviato", "ja": "全画面アラームテストを送信しました",
        "kk": "Толық экранды оятқыш сынағы жіберілді", "ko": "전체 화면 알람 테스트 전송됨", "ms": "Ujian penggera skrin penuh dihantar", "pa": "ਫੁੱਲ-ਸਕ੍ਰੀਨ ਅਲਾਰਮ ਟੈਸਟ ਭੇਜਿਆ ਗਿਆ",
        "ps": "د بشپړ سکرین د الارم ازموینه واستول شوه", "pt": "Teste de alarme em tela cheia enviado", "ru": "Тест полноэкранного будильника отправлен", "sw": "Jaribio la kengele ya skrini nzima limetumwa",
        "ta": "முழுத் திரை அலார சோதனை அனுப்பப்பட்டது", "tr": "Tam ekran alarm testi gönderildi", "ur": "مکمل اسکرین الارم ٹیسٹ بھیج دیا گیا", "vi": "Đã gửi kiểm tra báo thức toàn màn hình", "zh": "已发送全屏闹钟测试"
    },
    "stopAlarm": {
        "en": "Stop Alarm", "ar": "إيقاف المنبه", "az": "Zəngli saatı saxla", "bn": "অ্যালার্ম বন্ধ করুন",
        "de": "Wecker stoppen", "es": "Detener alarma", "fa": "توقف هشدار", "fr": "Arrêter l'alarme",
        "hi": "अलार्म बंद करें", "id": "Hentikan Alarm", "it": "Ferma sveglia", "ja": "アラーム停止",
        "kk": "Оятқышты тоқтату", "ko": "알람 중지", "ms": "Hentikan Penggera", "pa": "ਅਲਾਰਮ ਰੋਕੋ",
        "ps": "الارم بند کړئ", "pt": "Parar alarme", "ru": "Остановить будильник", "sw": "Simamisha Kengele",
        "ta": "அலாரத்தை நிறுத்து", "tr": "Alarmı Durdur", "ur": "الارم بند کریں", "vi": "Dừng báo thức", "zh": "停止闹钟"
    },
    "snooze": {
        "en": "Snooze", "ar": "غفوة", "az": "Təxirə sal", "bn": "স্নুজ",
        "de": "Schlummern", "es": "Posponer", "fa": "تعویق", "fr": "Répéter",
        "hi": "स्नूज़", "id": "Tunda", "it": "Posponi", "ja": "スヌーズ",
        "kk": "Кейінге қалдыру", "ko": "스누즈", "ms": "Tunda", "pa": "ਸਨੂਜ਼",
        "ps": "ځنډول", "pt": "Soneca", "ru": "Отложить", "sw": "Ahirisha",
        "ta": "ஸ்னூஸ்", "tr": "Ertele", "ur": "اسنوز", "vi": "Báo lại", "zh": "稍后提醒"
    },
    "snoozed10Min": {
        "en": "Snoozed for 10 minutes", "ar": "تم التفعيل لـ 10 دقائق", "az": "10 dəqiqə təxirə salındı", "bn": "১০ মিনিটের জন্য স্নুজ করা হয়েছে",
        "de": "Für 10 Minuten geschlummert", "es": "Pospuesto por 10 minutos", "fa": "برای ۱۰ دقیقه به تعویق افتاد", "fr": "Répété pour 10 minutes",
        "hi": "10 मिनट के लिए स्नूज़ किया गया", "id": "Ditunda selama 10 menit", "it": "Posposto per 10 minuti", "ja": "10分間スヌーズしました",
        "kk": "10 минутқа кейінге қалдырылды", "ko": "10분 동안 스누즈됨", "ms": "Ditunda selama 10 minit", "pa": "10 ਮਿੰਟਾਂ ਲਈ ਸਨੂਜ਼ ਕੀਤਾ ਗਿਆ",
        "ps": "د ۱۰ دقیقو لپاره وځنډول شو", "pt": "Adiado por 10 minutos", "ru": "Отложено на 10 минут", "sw": "Imeahirishwa kwa dakika 10",
        "ta": "10 நிமிடங்களுக்கு ஒத்திவைக்கப்பட்டது", "tr": "10 dakika ertelendi", "ur": "10 منٹ کے لیے اسنوز کیا گیا", "vi": "Đã báo lại trong 10 phút", "zh": "已稍后提醒10分钟"
    },
    "fullScreenAlarmPermission": {
        "en": "Full-Screen Alarm Permission", "ar": "إذن المنبه بملء الشاشة", "az": "Tam ekran zəngli saat icazəsi", "bn": "ফুল-স্ক্রিন অ্যালার্ম অনুমতি",
        "de": "Vollbild-Alarm-Berechtigung", "es": "Permiso de alarma de pantalla completa", "fa": "مجوز هشدار تمام صفحه", "fr": "Autorisation d'alarme plein écran",
        "hi": "फुल-स्क्रीन अलार्म अनुमति", "id": "Izin Alarm Layar Penuh", "it": "Autorizzazione sveglia a schermo intero", "ja": "全画面アラーム権限",
        "kk": "Толық экранды оятқыш рұқсаты", "ko": "전체 화면 알람 권한", "ms": "Kebenaran Penggera Skrin Penuh", "pa": "ਫੁੱਲ-ਸਕ੍ਰੀਨ ਅਲਾਰਮ ਆਗਿਆ",
        "ps": "د بشپړ سکرین د الارم اجازه", "pt": "Permissão de alarme em tela cheia", "ru": "Разрешение на полноэкранный будильник", "sw": "Ruhusa ya Kengele ya Skrini Nzima",
        "ta": "முழுத் திரை அலார அனுமதி", "tr": "Tam Ekran Alarm İzni", "ur": "فل اسکرین الارم کی اجازت", "vi": "Quyền báo thức toàn màn hình", "zh": "全屏闹钟权限"
    },
    "fullScreenAlarmPermissionDesc": {
        "en": "Allow alarms to wake up the screen when your phone is locked", "ar": "السماح للمنبه بإيقاظ الشاشة عندما يكون الهاتف مقفلاً", "az": "Telefon kilitli olduqda zəngli saatın ekranı oyatmasına icazə verin", "bn": "ফোন লক থাকা অবস্থায় অ্যালার্মকে স্ক্রিন জাগানোর অনুমতি দিন",
        "de": "Erlauben Sie dem Wecker, den Bildschirm bei gesperrtem Telefon zu aktivieren", "es": "Permitir que las alarmas activen la pantalla cuando el teléfono está bloqueado", "fa": "اجازه دهید هشدارها هنگام قفل بودن گوشی صفحه را روشن کنند", "fr": "Autoriser les alarmes à réveiller l'écran lorsque le téléphone est verrouillé",
        "hi": "फ़ोन लॉक होने पर अलार्म को स्क्रीन जगाने की अनुमति दें", "id": "Izinkan alarm mengaktifkan layar saat ponsel terkunci", "it": "Consenti alle sveglie di riattivare lo schermo quando il telefono è bloccato", "ja": "端末がロックされている時にアラームが画面を起動することを許可",
        "kk": "Телефон құлыптаулы болғанда оятқышқа экранды оятуға рұқсат етіңіз", "ko": "휴대폰이 잠겨 있을 때 알람이 화면을 켜도록 허용", "ms": "Benarkan penggera menghidupkan skrin apabila telefon dikunci", "pa": "ਫੋਨ ਲੌਕ ਹੋਣ 'ਤੇ ਅਲਾਰਮ ਨੂੰ ਸਕ੍ਰੀਨ ਜਗਾਉਣ ਦੀ ਆਗਿਆ ਦਿਓ",
        "ps": "الارم ته اجازه ورکړئ کله چې ټلیفون قفل وي سکرین فعال کړي", "pt": "Permitir que os alarmes ativem a tela quando o telefone estiver bloqueado", "ru": "Разрешить будильникам включать экран при заблокированном телефоне", "sw": "Ruhusu kengele kuamsha skrini wakati simu imefungwa",
        "ta": "தொலைபேசி பூட்டப்பட்டிருக்கும் போது அலாரங்கள் திரையை எழுப்ப அனுமதிக்கவும்", "tr": "Telefon kilitliyken alarmların ekranı uyandırmasına izin verin", "ur": "فون لاک ہونے پر الارم کو اسکرین آن کرنے کی اجازت دیں", "vi": "Cho phép báo thức đánh thức màn hình khi điện thoại bị khóa", "zh": "允许闹钟在手机锁定时唤醒屏幕"
    },
    "grantPermission": {
        "en": "Grant Permission", "ar": "منح الإذن", "az": "İcazə verin", "bn": "অনুমতি দিন",
        "de": "Berechtigung erteilen", "es": "Conceder permiso", "fa": "اعطای مجوز", "fr": "Accorder l'autorisation",
        "hi": "अनुमति दें", "id": "Beri Izin", "it": "Concedi autorizzazione", "ja": "権限を許可",
        "kk": "Рұқсат беру", "ko": "권한 허용", "ms": "Beri Kebenaran", "pa": "ਆਗਿਆ ਦਿਓ",
        "ps": "اجازه ورکړئ", "pt": "Conceder permissão", "ru": "Предоставить разрешение", "sw": "Toa Ruhusa",
        "ta": "அனுமதி கொடுங்கள்", "tr": "İzin Ver", "ur": "اجازت دیں", "vi": "Cấp quyền", "zh": "授予权限"
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