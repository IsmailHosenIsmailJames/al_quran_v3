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
    },
    "searchAll": {
        "en": "All", "bn": "সব", "ar": "الكل",
        "tr": "Tümü", "ur": "سب", "fa": "همه",
        "id": "Semua", "ms": "Semua", "fr": "Tout",
        "de": "Alle", "es": "Todos", "ru": "Все",
        "hi": "सभी", "pt": "Todos", "it": "Tutti",
        "ja": "すべて", "ko": "전체", "zh": "全部", "vi": "Tất cả",
        "sw": "Yote", "az": "Hamısı", "kk": "Барлығы",
        "pa": "ਸਾਰੇ", "ps": "ټول", "ta": "அனைத்தும்"
    },
    "searchArabic": {
        "en": "Arabic", "bn": "আরবি", "ar": "العربية",
        "tr": "Arapça", "ur": "عربی", "fa": "عربی",
        "id": "Bahasa Arab", "ms": "Bahasa Arab", "fr": "Arabe",
        "de": "Arabisch", "es": "Árabe", "ru": "Арабский",
        "hi": "अरबी", "pt": "Árabe", "it": "Arabo",
        "ja": "アラビア語", "ko": "아랍어", "zh": "阿拉伯语", "vi": "Tiếng Ả Rập",
        "sw": "Kiarabu", "az": "Ərəbcə", "kk": "Арабша",
        "pa": "ਅਰਬੀ", "ps": "عربي", "ta": "அரபு"
    },
    "searchQuranHint": {
        "en": "Search Quran, Surah, 2:255, Translation...",
        "bn": "কুরআন, সূরা, ২:২৫৫, অনুবাদ খুঁজুন...",
        "ar": "ابحث في القرآن، السورة، ٢:٢٥٥، الترجمة...",
        "tr": "Kur'an, Sure, 2:255, Meal ara...",
        "ur": "قرآن، سورۃ، 2:255، ترجمہ تلاش کریں...",
        "id": "Cari Al-Quran, Surah, 2:255, Terjemahan...",
        "fr": "Rechercher Coran, Sourate, 2:255, Traduction...",
        "de": "Koran, Sure, 2:255, Übersetzung suchen...",
        "es": "Buscar Corán, Sura, 2:255, Traducción...",
        "ru": "Поиск в Коране, суре, 2:255, переводе..."
    },
    "searchFiltersAndOptions": {
        "en": "Search Filters & Options", "bn": "সার্চ ফিল্টার এবং অপশন", "ar": "خيارات وفلاتر البحث",
        "tr": "Arama Filtreleri ve Seçenekleri", "ur": "تلاش کے فلٹرز اور اختیارات", "fa": "فیلترها و گزینه‌های جستجو",
        "id": "Filter & Opsi Pencarian", "ms": "Penapis & Pilihan Carian", "fr": "Filtres et options de recherche",
        "de": "Suchfilter & Optionen", "es": "Filtros y opciones de búsqueda", "ru": "Фильтры и параметры поиска",
        "hi": "खोज फ़िल्टर और विकल्प", "pt": "Filtros e opções de pesquisa", "it": "Filtri e opzioni di ricerca",
        "ja": "検索フィルターとオプション", "ko": "검색 필터 및 옵션", "zh": "搜索过滤器与选项", "vi": "Bộ lọc & tùy chọn tìm kiếm"
    },
    "exactPhrase": {
        "en": "Exact Phrase", "bn": "হুবহু শব্দগুচ্ছ", "ar": "العبارة بالضبط",
        "tr": "Tam İfade", "ur": "عین جملہ", "fa": "عبارت دقیق",
        "id": "Frasa Tepat", "ms": "Frasa Tepat", "fr": "Phrase exacte",
        "de": "Exakte Phrase", "es": "Frase exacta", "ru": "Точная фраза",
        "hi": "सटीक वाक्यांश", "pt": "Frase exata", "it": "Frase esatta",
        "ja": "完全一致フレーズ", "ko": "정확한 구절", "zh": "精确短语", "vi": "Cụm từ chính xác",
        "sw": "Maneno Halisi", "az": "Dəqiq İfadə", "kk": "Дәл сөз тіркесі",
        "pa": "ਸਹੀ ਵਾਕੰਸ਼", "ps": "کټ مټ عبارت", "ta": "சரியான சொற்றொடர்"
    },
    "surahsFound": {
        "en": "{count, plural, =1{1 Surah found} other{{count} Surahs found}}",
        "bn": "{count, plural, =1{১ টি সূরা পাওয়া গেছে} other{{count} টি সূরা পাওয়া গেছে}}",
        "ar": "{count, plural, =1{تم العثور على سورة واحدة} =2{تم العثور على سورتين} few{تم العثور على {count} سور} many{تم العثور على {count} سورة} other{تم العثور على {count} سورة}}",
        "tr": "{count, plural, other{{count} Sure bulundu}}",
        "ur": "{count, plural, =1{1 سورت ملی} other{{count} سورتیں ملیں}}",
        "fa": "{count, plural, other{{count} سوره یافت شد}}",
        "id": "{count, plural, other{{count} Surah ditemukan}}",
        "ms": "{count, plural, other{{count} Surah dijumpai}}",
        "fr": "{count, plural, =1{1 sourate trouvée} other{{count} sourates trouvées}}",
        "de": "{count, plural, =1{1 Sure gefunden} other{{count} Suren gefunden}}",
        "es": "{count, plural, =1{1 sura encontrada} other{{count} suras encontradas}}",
        "ru": "{count, plural, one{{count} сура найдена} few{{count} суры найдены} other{{count} сур найдено}}",
        "hi": "{count, plural, =1{1 सूरह मिला} other{{count} सूरह मिले}}",
        "pt": "{count, plural, =1{1 surata encontrada} other{{count} suratas encontradas}}",
        "it": "{count, plural, =1{1 sura trovata} other{{count} sure trovate}}",
        "ja": "{count, plural, other{{count} 件の章が見つかりました}}",
        "ko": "{count, plural, other{{count}개의 장을 찾았습니다}}",
        "zh": "{count, plural, other{找到 {count} 个苏拉}}",
        "vi": "{count, plural, other{Tìm thấy {count} Surah}}",
        "sw": "{count, plural, =1{Sura 1 imepatikana} other{Sura {count} zimepatikana}}",
        "az": "{count, plural, other{{count} surə tapıldı}}",
        "kk": "{count, plural, other{{count} сүре табылды}}",
        "pa": "{count, plural, =1{1 ਸੂਰਤ ਮਿਲੀ} other{{count} ਸੂਰਤਾਂ ਮਿਲੀਆਂ}}",
        "ps": "{count, plural, =1{1 سورت وموندل شو} other{{count} سورتونه وموندل شول}}",
        "ta": "{count, plural, =1{1 அத்தியாயம் காணப்பட்டது} other{{count} அத்தியாயங்கள் காணப்பட்டன}}"
    },
    "ayahsFound": {
        "en": "{count, plural, =1{1 Ayah found} other{{count} Ayahs found}}",
        "bn": "{count, plural, =1{১ টি আয়াত পাওয়া গেছে} other{{count} টি আয়াত পাওয়া গেছে}}",
        "ar": "{count, plural, =1{تم العثور على آية واحدة} =2{تم العثور على آيتين} few{تم العثور على {count} آيات} many{تم العثور على {count} آية} other{تم العثور على {count} آية}}",
        "tr": "{count, plural, other{{count} Ayet bulundu}}",
        "ur": "{count, plural, =1{1 آیت ملی} other{{count} آیات ملیں}}",
        "fa": "{count, plural, other{{count} آیه یافت شد}}",
        "id": "{count, plural, other{{count} Ayat ditemukan}}",
        "ms": "{count, plural, other{{count} Ayat dijumpai}}",
        "fr": "{count, plural, =1{1 verset trouvé} other{{count} versets trouvés}}",
        "de": "{count, plural, =1{1 Vers gefunden} other{{count} Verse gefunden}}",
        "es": "{count, plural, =1{1 versículo encontrado} other{{count} versículos encontrados}}",
        "ru": "{count, plural, one{{count} аят найден} few{{count} аята найдено} other{{count} аятов найдено}}",
        "hi": "{count, plural, =1{1 आयत मिली} other{{count} आयतें मिलीं}}",
        "pt": "{count, plural, =1{1 versículo encontrado} other{{count} versículos encontrados}}",
        "it": "{count, plural, =1{1 versetto trovato} other{{count} versetti trovati}}",
        "ja": "{count, plural, other{{count} 件の節が見つかりました}}",
        "ko": "{count, plural, other{{count}개의 구절을 찾았습니다}}",
        "zh": "{count, plural, other{找到 {count} 条经文}}",
        "vi": "{count, plural, other{Tìm thấy {count} câu kinh}}",
        "sw": "{count, plural, =1{Aya 1 imepatikana} other{Aya {count} zimepatikana}}",
        "az": "{count, plural, other{{count} ayə tapıldı}}",
        "kk": "{count, plural, other{{count} аят табылды}}",
        "pa": "{count, plural, =1{1 ਆਇਤ ਮਿਲੀ} other{{count} ਆਇਤਾਂ ਮਿਲੀਆਂ}}",
        "ps": "{count, plural, =1{1 آیت وموندل شو} other{{count} آیاتونه وموندل شول}}",
        "ta": "{count, plural, =1{1 வசனம் காணப்பட்டது} other{{count} வசனங்கள் காணப்பட்டன}}"
    },
    "noMatchingSurahs": {
        "en": "No Surahs matching \"{query}\"",
        "bn": "\"{query}\" দিয়ে কোনো সূরা পাওয়া যায়নি",
        "ar": "لا توجد سور مطابقة لـ \"{query}\"",
        "tr": "\"{query}\" ile eşleşen sure bulunamadı",
        "ur": "\"{query}\" سے مماثل کوئی سورت نہیں ملی",
        "id": "Tidak ada Surah yang cocok dengan \"{query}\"",
        "fr": "Aucune sourate ne correspond à \"{query}\"",
        "de": "Keine Suren gefunden für \"{query}\"",
        "es": "No hay suras que coincidan con \"{query}\"",
        "ru": "Нет сур, соответствующих «{query}»"
    },
    "noResultsFound": {
        "en": "No results found", "bn": "কোনো ফলাফল পাওয়া যায়নি", "ar": "لم يتم العثور على نتائج",
        "tr": "Sonuç bulunamadı", "ur": "کوئی نتیجہ نہیں ملا", "fa": "نتیجه‌ای یافت نشد",
        "id": "Tidak ada hasil ditemukan", "ms": "Tiada hasil dijumpai", "fr": "Aucun résultat trouvé",
        "de": "Keine Ergebnisse gefunden", "es": "No se encontraron resultados", "ru": "Ничего не найдено",
        "hi": "कोई परिणाम नहीं मिला", "pt": "Nenhum resultado encontrado", "it": "Nessun risultato trovato",
        "ja": "結果が見つかりませんでした", "ko": "결과를 찾을 수 없습니다", "zh": "未找到结果", "vi": "Không tìm thấy kết quả"
    },
    "trySearchingFor": {
        "en": "Try searching for a Surah name, verse number (e.g. 2:255), or topics",
        "bn": "একটি সূরার নাম, আয়াত নম্বর (যেমন ২:২৫৫), বা বিষয় দিয়ে অনুসন্ধান করুন",
        "ar": "جرب البحث عن اسم سورة أو رقم آية (مثل ٢:٢٥٥) أو مواضيع",
        "tr": "Bir sure adı, ayet numarası (örn. 2:255) veya konuları aramayı deneyin",
        "ur": "سورۃ کا نام، آیت نمبر (مثلاً 2:255) یا موضوعات تلاش کرنے کی کوشش کریں",
        "id": "Coba cari nama Surah, nomor ayat (mis. 2:255), atau topik",
        "fr": "Essayez de rechercher un nom de sourate, un numéro de verset (ex. 2:255) ou des sujets",
        "de": "Versuchen Sie nach einem Sure-Namen, einer Versnummer (z. B. 2:255) oder Themen zu suchen",
        "es": "Intente buscar un nombre de sura, número de versículo (ej. 2:255) o temas",
        "ru": "Попробуйте поискать название суры, номер аята (например, 2:255) или темы"
    },
    "allSurahsCount": {
        "en": "All Surahs ({count})",
        "bn": "সকল সূরা ({count})",
        "ar": "جميع السور ({count})",
        "tr": "Tüm Sureler ({count})",
        "ur": "تمام سورتیں ({count})",
        "id": "Semua Surah ({count})",
        "fr": "Toutes les sourates ({count})",
        "de": "Alle Suren ({count})",
        "es": "Todas las suras ({count})",
        "ru": "Все суры ({count})"
    },
    "activeShortcutsCount": {
        "en": "Active Shortcuts ({count})",
        "bn": "সক্রিয় শর্টকাট ({count})",
        "ar": "الاختصارات النشطة ({count})",
        "tr": "Aktif Kısayollar ({count})",
        "ur": "فعال شارٹ کٹس ({count})",
        "id": "Pintasan Aktif ({count})",
        "fr": "Raccourcis actifs ({count})",
        "de": "Aktive Verknüpfungen ({count})",
        "es": "Accesos directos activos ({count})",
        "ru": "Активные ярлыки ({count})"
    },
    "noActiveShortcuts": {
        "en": "No active shortcuts found", "bn": "কোনো সক্রিয় শর্টকাট নেই", "ar": "لا توجد اختصارات نشطة",
        "tr": "Aktif kısayol bulunamadı", "ur": "کوئی فعال شارٹ کٹ نہیں ملا", "fa": "میانبر فعالی یافت نشد",
        "id": "Tidak ada pintasan aktif ditemukan", "ms": "Tiada pintasan aktif dijumpai", "fr": "Aucun raccourci actif trouvé",
        "de": "Keine aktiven Verknüpfungen gefunden", "es": "No se encontraron accesos directos activos", "ru": "Активные ярлыки не найдены",
        "hi": "कोई सक्रिय शॉर्टकट नहीं मिला", "pt": "Nenhum atalho ativo encontrado", "it": "Nessuna scorciatoia attiva trovata",
        "ja": "アクティブなショートカットが見つかりません", "ko": "활성 단축키를 찾을 수 없습니다", "zh": "未找到活动快捷方式", "vi": "Không tìm thấy phím tắt hoạt động"
    },
    "customize": {
        "en": "Customize", "bn": "কাস্টমাইজ", "ar": "تخصيص",
        "tr": "Özelleştir", "ur": "تخصیص", "fa": "شخصی‌سازی",
        "id": "Kustomisasi", "ms": "Penyesuaian", "fr": "Personnaliser",
        "de": "Anpassen", "es": "Personalizar", "ru": "Настроить",
        "hi": "अनुकूलित करें", "pt": "Personalizar", "it": "Personalizza",
        "ja": "カスタマイズ", "ko": "사용자 정의", "zh": "自定义", "vi": "Tùy chỉnh",
        "sw": "Binafsisha", "az": "Fərdiləşdir", "kk": "Баптау",
        "pa": "ਅਨੁਕੂਲਿਤ ਕਰੋ", "ps": "دودیز کړئ", "ta": "தனிப்பயனாக்கு"
    },
    "saveAndDownload": {
        "en": "Save & Download", "bn": "সেভ করুন এবং ডাউনলোড করুন", "ar": "حفظ وتنزيل",
        "tr": "Kaydet ve İndir", "ur": "محفوظ اور ڈاؤن لوڈ کریں", "fa": "ذخیره و دانلود",
        "id": "Simpan & Unduh", "ms": "Simpan & Muat Turun", "fr": "Enregistrer et télécharger",
        "de": "Speichern & Herunterladen", "es": "Guardar y Descargar", "ru": "Сохранить и скачать",
        "hi": "सहेजें और डाउनलोड करें", "pt": "Salvar e Baixar", "it": "Salva e Scarica",
        "ja": "保存してダウンロード", "ko": "저장 및 다운로드", "zh": "保存并下载", "vi": "Lưu & Tải xuống",
        "sw": "Hifadhi na Upakue", "az": "Yadda saxla və endir", "kk": "Сақтау және жүктеу",
        "pa": "ਸੁਰੱਖਿਅਤ ਕਰੋ ਅਤੇ ਡਾਊਨਲੋਡ ਕਰੋ", "ps": "خوندي او ډاونلوډ کړئ", "ta": "சேமித்து பதிவிறக்கவும்"
    },
    "bismillahPreview": {
        "en": "Bismillah Preview", "bn": "বিসমিল্লাহ প্রিভিউ", "ar": "معاينة البسملة",
        "tr": "Besmele Önizleme", "ur": "بسم اللہ پیش نظارہ", "fa": "پیش‌نمایش بسم الله",
        "id": "Pratinjau Bismillah", "ms": "Pratonton Bismillah", "fr": "Aperçu de la Bismillah",
        "de": "Bismillah-Vorschau", "es": "Vista previa de Bismillah", "ru": "Предпросмотр Бисмилля",
        "hi": "बिस्मिल्लाह पूर्वावलोकन", "pt": "Pré-visualização de Bismillah", "it": "Anteprima di Bismillah",
        "ja": "ビスミッラーのプレビュー", "ko": "비스밀라 미리보기", "zh": "太斯米预览", "vi": "Xem trước Bismillah",
        "sw": "Uhakiki wa Bismillah", "az": "Bismillah önizləməsi", "kk": "Бисмилля алдын ала қарау",
        "pa": "ਬਿਸਮਿੱਲਾ ਪੂਰਵਦਰਸ਼ਨ", "ps": "د بسم الله مخکتنه", "ta": "பிஸ்மில்லாஹ் முன்னோட்டம்"
    },
    "change": {
        "en": "Change", "bn": "পরিবর্তন", "ar": "تغيير",
        "tr": "Değiştir", "ur": "تبدیل کریں", "fa": "تغییر",
        "id": "Ubah", "ms": "Tukar", "fr": "Changer",
        "de": "Ändern", "es": "Cambiar", "ru": "Изменить",
        "hi": "बदलें", "pt": "Alterar", "it": "Modifica",
        "ja": "変更", "ko": "변경", "zh": "更改", "vi": "Thay đổi",
        "sw": "Badilisha", "az": "Dəyişdir", "kk": "Өзгерту",
        "pa": "ਬਦਲੋ", "ps": "بدلون", "ta": "மாற்று"
    },
    "tajweedRules": {
        "en": "Tajweed Rules", "bn": "তাজবীদ নিয়ম", "ar": "أحكام التجويد",
        "tr": "Tecvid Kuralları", "ur": "تجوید کے قواعد", "fa": "قواعد تجوید",
        "id": "Hukum Tajwid", "ms": "Hukum Tajwid", "fr": "Règles du Tajwid",
        "de": "Tadschwid-Regeln", "es": "Reglas de Tajweed", "ru": "Правила таджвида",
        "hi": "तजवीद के नियम", "pt": "Regras de Tajweed", "it": "Regole di Tajweed",
        "ja": "タジウィードの規則", "ko": "타지위드 규칙", "zh": "古兰经诵读规则", "vi": "Quy tắc Tajweed",
        "sw": "Kanuni za Tajweed", "az": "Təcvid qaydaları", "kk": "Тәжуид ережелері",
        "pa": "ਤਜਵੀਦ ਦੇ ਨਿਯਮ", "ps": "د تجوید قواعد", "ta": "தஜ்வீத் விதிகள்"
    },
    "exactPhraseMatch": {
        "en": "Exact Phrase Match", "bn": "হুবহু শব্দগুচ্ছ মিলান", "ar": "مطابقة العبارة بدقة",
        "tr": "Tam İfade Eşleşmesi", "ur": "عین جملے کا ملاپ", "fa": "تطبیق دقیق عبارت",
        "id": "Pencocokan Frasa Tepat", "ms": "Padanan Frasa Tepat", "fr": "Correspondance exacte de l'expression",
        "de": "Exakte Phrasenübereinstimmung", "es": "Coincidencia exacta de frase", "ru": "Точное совпадение фразы",
        "hi": "सटीक वाक्यांश मिलान", "pt": "Correspondência exata de frase", "it": "Corrispondenza esatta della frase",
        "ja": "完全一致検索", "ko": "정확한 구절 일치", "zh": "精确短语匹配", "vi": "Khớp cụm từ chính xác",
        "sw": "Ulinganifu Halisi wa Maneno", "az": "Dəqiq İfadə Uyğunluğu", "kk": "Дәл сөз тіркесін сәйкестендіру",
        "pa": "ਸਹੀ ਵਾਕੰਸ਼ ਮੇਲ", "ps": "د کټ مټ عبارت مطابقت", "ta": "சரியான சொற்றொடர் பொருத்தம்"
    },
    "matchExactWordsDesc": {
        "en": "Match exact words in continuous sequence", "bn": "ধারাবাহিক ক্রমানুসারে হুবহু শব্দগুলো মিলান", "ar": "مطابقة الكلمات بدقة في تسلسل متصل",
        "tr": "Kelimeleri ardışık sırada tam olarak eşleştir", "ur": "مسلسل ترتیب میں الفاظ کا درست ملاپ کریں", "fa": "تطبیق کلمات دقیق در یک دنباله پیوسته",
        "id": "Cocokkan kata-kata persis dalam urutan berurutan", "ms": "Padankan perkataan yang tepat dalam urutan berterusan", "fr": "Faire correspondre les mots exacts dans l'ordre continu",
        "de": "Exakte Wörter in fortlaufender Reihenfolge abgleichen", "es": "Coincidir palabras exactas en secuencia continua", "ru": "Сопоставлять точные слова в непрерывной последовательности",
        "hi": "लगातार क्रम में सटीक शब्दों का मिलान करें", "pt": "Corresponder palavras exatas em sequência contínua", "it": "Abbina le parole esatte in sequenza continua",
        "ja": "連続する順序で正確な単語を一致させます", "ko": "연속된 순서로 정확한 단어를 일치시킵니다", "zh": "按连续顺序匹配确切单词", "vi": "Khớp các từ chính xác theo trình tự liên tục",
        "sw": "Linganisha maneno halisi katika mlolongo unaoendelea", "az": "Ardıcıl ardıcıllıqla dəqiq sözləri uyğunlaşdırın", "kk": "Сөздерді үздіксіз ретпен дәл сәйкестендіріңіз",
        "pa": "ਲਗਾਤਾਰ ਕ੍ਰਮ ਵਿੱਚ ਸਹੀ ਸ਼ਬਦਾਂ ਦਾ ਮੇਲ ਕਰੋ", "ps": "په پرله پسې ترتیب کې دقیق ټکي مطابقت کړئ", "ta": "தொடர்ச்சியான வரிசையில் சரியான சொற்களைப் பொருத்துங்கள்"
    },
    "filterBySurah": {
        "en": "Filter by Surah", "bn": "সূরা অনুযায়ী ফিল্টার", "ar": "تصفية حسب السورة",
        "tr": "Sureye Göre Filtrele", "ur": "سورۃ کے لحاظ سے فلٹر کریں", "fa": "فیلتر بر اساس سوره",
        "id": "Filter berdasarkan Surah", "ms": "Tapis mengikut Surah", "fr": "Filtrer par sourate",
        "de": "Nach Sure filtern", "es": "Filtrar por sura", "ru": "Фильтр по суре",
        "hi": "सूरह द्वारा फ़िल्टर करें", "pt": "Filtrar por surata", "it": "Filtra per sura",
        "ja": "章（スーラ）でフィルター", "ko": "장(수라)별 필터", "zh": "按苏拉筛选", "vi": "Lọc theo Surah",
        "sw": "Chuja kwa Sura", "az": "Surəyə görə filtrləyin", "kk": "Сүре бойынша сүзгілеу",
        "pa": "ਸੂਰਤ ਅਨੁਸਾਰ ਫਿਲਟਰ ਕਰੋ", "ps": "د سورت له مخې فلټر کړئ", "ta": "அத்தியாயம் வாரியாக வடிகட்டவும்"
    },
    "all114SurahsEntireQuran": {
        "en": "All 114 Surahs (Entire Quran)", "bn": "সকল ১১৪টি সূরা (সম্পূর্ণ কুরআন)", "ar": "جميع السور الـ ١١٤ (القرآن كاملاً)",
        "tr": "Tüm 114 Sure (Tüm Kur'an)", "ur": "تمام 114 سورتیں (مکمل قرآن)", "fa": "همه ۱۱۴ سوره (کل قرآن)",
        "id": "Semua 114 Surah (Seluruh Al-Quran)", "ms": "Semua 114 Surah (Seluruh Al-Quran)", "fr": "Toutes les 114 sourates (Coran entier)",
        "de": "Alle 114 Suren (Gesamter Koran)", "es": "Las 114 suras (Corán completo)", "ru": "Все 114 сур (весь Коран)",
        "hi": "सभी 114 सूरह (संपूर्ण कुरान)", "pt": "Todas as 114 suratas (Alcorão completo)", "it": "Tutte le 114 sure (Intero Corano)",
        "ja": "全114章（クルアーン全体）", "ko": "전체 114개 장(쿠란 전체)", "zh": "全部 114 个苏拉（整本古兰经）", "vi": "Tất cả 114 Surah (Toàn bộ Kinh Quran)",
        "sw": "Sura zote 114 (Kurani nzima)", "az": "Bütün 114 surə (Bütün Quran)", "kk": "Барлық 114 сүре (Толық Құран)",
        "pa": "ਸਾਰੀਆਂ 114 ਸੂਰਤਾਂ (ਸਾਰਾ ਕੁਰਾਨ)", "ps": "ټول ۱۱۴ سورتونه (بشپړ قرآن)", "ta": "அனைத்து 114 அத்தியாயங்களும் (முழு குர்ஆன்)"
    },
    "revelationType": {
        "en": "Revelation Type", "bn": "নাযিলের স্থান", "ar": "نوع النزول",
        "tr": "İniş Yeri", "ur": "نزول کی قسم", "fa": "نوع نزول",
        "id": "Tempat Turunnya", "ms": "Tempat Penurunan", "fr": "Lieu de révélation",
        "de": "Offenbarungsort", "es": "Lugar de revelación", "ru": "Место ниспослания",
        "hi": "अवतरण का प्रकार", "pt": "Local de revelação", "it": "Luogo di rivelazione",
        "ja": "啓示の場所", "ko": "계시 장소", "zh": "降示地点", "vi": "Nơi mặc khải",
        "sw": "Aina ya Ufunuo", "az": "Nazil olma yeri", "kk": "Түсірілу түрі",
        "pa": "ਪ੍ਰਕਾਸ਼ ਦੀ ਕਿਸਮ", "ps": "د نزول ډول", "ta": "இறக்கப்பட்ட இடம்"
    },
    "searchInTranslations": {
        "en": "Search in Translations", "bn": "অনুবাদে অনুসন্ধান করুন", "ar": "البحث في الترجمات",
        "tr": "Meallerde Ara", "ur": "تراجم میں تلاش کریں", "fa": "جستجو در ترجمه‌ها",
        "id": "Cari dalam Terjemahan", "ms": "Cari dalam Terjemahan", "fr": "Rechercher dans les traductions",
        "de": "In Übersetzungen suchen", "es": "Buscar en traducciones", "ru": "Поиск в переводах",
        "hi": "अनुवादों में खोजें", "pt": "Pesquisar nas traduções", "it": "Cerca nelle traduzioni",
        "ja": "翻訳内で検索", "ko": "번역에서 검색", "zh": "在译文中搜索", "vi": "Tìm kiếm trong bản dịch",
        "sw": "Tafuta katika Tafsiri", "az": "Tərcümələrdə axtarın", "kk": "Аудармалардан іздеу",
        "pa": "ਅਨੁਵਾਦਾਂ ਵਿੱਚ ਖੋਜੋ", "ps": "په ژباړو کې لټون وکړئ", "ta": "மொழிபெயர்ப்புகளில் தேடவும்"
    },
    "searchInTafsirs": {
        "en": "Search in Tafsirs", "bn": "তাফসীরে অনুসন্ধান করুন", "ar": "البحث في التفاسير",
        "tr": "Tefsirlerde Ara", "ur": "تفاسیر میں تلاش کریں", "fa": "جستجو در تفاسیر",
        "id": "Cari dalam Tafsir", "ms": "Cari dalam Tafsir", "fr": "Rechercher dans les exégèses (tafsirs)",
        "de": "In Tafsiren suchen", "es": "Buscar en tafsires", "ru": "Поиск в тафсирах",
        "hi": "तफ़सीर में खोजें", "pt": "Pesquisar nos tafsirs", "it": "Cerca nei tafsir",
        "ja": "タフスィール（解釈）内で検索", "ko": "타프시르(주석)에서 검색", "zh": "在经注中搜索", "vi": "Tìm kiếm trong Tafsir",
        "sw": "Tafuta katika Tafsiri za Quran (Tafsir)", "az": "Təfsirlərdə axtarın", "kk": "Тәпсірлерден іздеу",
        "pa": "ਤਫ਼ਸੀਰ ਵਿੱਚ ਖੋਜੋ", "ps": "په تفاسیرو کې لټون وکړئ", "ta": "தஃப்சீரில் தேடவும்"
    },
    "activeCount": {
        "en": "{selected}/{total} active", "bn": "{selected}/{total} সক্রিয়", "ar": "{selected}/{total} نشط",
        "tr": "{selected}/{total} aktif", "ur": "{selected}/{total} فعال", "fa": "{selected}/{total} فعال",
        "id": "{selected}/{total} aktif", "ms": "{selected}/{total} aktif", "fr": "{selected}/{total} actif(s)",
        "de": "{selected}/{total} aktiv", "es": "{selected}/{total} activo(s)", "ru": "{selected}/{total} активно",
        "hi": "{selected}/{total} सक्रिय", "pt": "{selected}/{total} ativo(s)", "it": "{selected}/{total} attivo/i",
        "ja": "{selected}/{total} 件有効", "ko": "{selected}/{total}개 활성", "zh": "{selected}/{total} 项启用", "vi": "{selected}/{total} đang hoạt động",
        "sw": "{selected}/{total} amilifu", "az": "{selected}/{total} aktiv", "kk": "{selected}/{total} белсенді",
        "pa": "{selected}/{total} ਸਰਗਰਮ", "ps": "{selected}/{total} فعال", "ta": "{selected}/{total} செயலில் உள்ளது"
    },
    "recentSearches": {
        "en": "Recent Searches", "bn": "সাম্প্রতিক অনুসন্ধান", "ar": "عمليات البحث الأخيرة",
        "tr": "Son Aramalar", "ur": "حالیہ تلاشیں", "fa": "جستجوهای اخیر",
        "id": "Pencarian Terkini", "ms": "Carian Terkini", "fr": "Recherches récentes",
        "de": "Letzte Suchanfragen", "es": "Búsquedas recientes", "ru": "Недавние поиски",
        "hi": "हाल की खोजें", "pt": "Pesquisas recentes", "it": "Ricerche recenti",
        "ja": "最近の検索", "ko": "최근 검색", "zh": "最近搜索", "vi": "Tìm kiếm gần đây",
        "sw": "Utafutaji wa Hivi Karibuni", "az": "Son axtarışlar", "kk": "Соңғы іздеулер",
        "pa": "ਹਾਲੀਆ ਖੋਜਾਂ", "ps": "وروستي لټونونه", "ta": "சமீபத்திய தேடல்கள்"
    },
    "clearAll": {
        "en": "Clear All", "bn": "সব মুছুন", "ar": "مسح الكل",
        "tr": "Tümünü Temizle", "ur": "تمام صاف کریں", "fa": "پاک کردن همه",
        "id": "Hapus Semua", "ms": "Padam Semua", "fr": "Tout effacer",
        "de": "Alles löschen", "es": "Borrar todo", "ru": "Очистить всё",
        "hi": "सभी साफ़ करें", "pt": "Limpar tudo", "it": "Cancella tutto",
        "ja": "すべて消去", "ko": "모두 지우기", "zh": "清除全部", "vi": "Xóa tất cả",
        "sw": "Futa Yote", "az": "Hamısını təmizlə", "kk": "Барлығын тазалау",
        "pa": "ਸਭ ਸਾਫ਼ ਕਰੋ", "ps": "ټول پاک کړئ", "ta": "அனைத்தையும் அழி"
    },
    "searchGuideTitle": {
        "en": "Search the Holy Quran", "bn": "পবিত্র কুরআন অনুসন্ধান করুন", "ar": "ابحث في القرآن الكريم",
        "tr": "Kur'an-ı Kerim'de Ara", "ur": "قرآن مجید میں تلاش کریں", "fa": "جستجو در قرآن کریم",
        "id": "Cari di Al-Quran", "ms": "Cari dalam Al-Quran", "fr": "Rechercher dans le Saint Coran",
        "de": "Im Heiligen Koran suchen", "es": "Buscar en el Sagrado Corán", "ru": "Поиск в Священном Коране",
        "hi": "पवित्र कुरान में खोजें", "pt": "Pesquisar no Sagrado Alcorão", "it": "Cerca nel Sacro Corano",
        "ja": "クルアーンを検索", "ko": "성스러운 쿠란 검색", "zh": "搜索古兰经", "vi": "Tìm kiếm trong Kinh Quran",
        "sw": "Tafuta katika Kurani Tukufu", "az": "Müqəddəs Quranda axtarın", "kk": "Қасиетті Құраннан іздеу",
        "pa": "ਪਵਿੱਤਰ ਕੁਰਾਨ ਵਿੱਚ ਖੋਜੋ", "ps": "په سپېڅلي قرآن کې لټون وکړئ", "ta": "புனித குர்ஆனில் தேடுங்கள்"
    },
    "searchGuideDescription": {
        "en": "Search by Surah name, verse reference (e.g. 2:255), or words in translations and tafsir.",
        "bn": "সূরা নাম, আয়াত নম্বর (যেমন ২:২৫৫), অথবা অনুবাদ ও তাফসীরের শব্দ দিয়ে অনুসন্ধান করুন।",
        "ar": "ابحث باسم السورة أو رقم الآية (مثل 2:255) أو بالكلمات في الترجمات والتفاسير.",
        "tr": "Sure adı, ayet numarası (örn. 2:255) veya meal ve tefsirlerdeki kelimelerle arayın.",
        "ur": "سورۃ کے نام، آیت نمبر (مثلاً 2:255)، یا تراجم اور تفاسیر میں الفاظ کے ذریعے تلاش کریں۔",
        "fa": "بر اساس نام سوره، شماره آیه (مانند 2:255) یا کلمات در ترجمه‌ها و تفاسیر جستجو کنید.",
        "id": "Cari berdasarkan nama Surah, nomor ayat (mis. 2:255), atau kata dalam terjemahan dan tafsir.",
        "ms": "Cari mengikut nama Surah, rujukan ayat (cth. 2:255), atau perkataan dalam terjemahan dan tafsir.",
        "fr": "Recherchez par nom de sourate, référence de verset (ex. 2:255) ou mots dans les traductions et tafsirs.",
        "de": "Suchen Sie nach Sure-Namen, Versangabe (z. B. 2:255) oder Wörtern in Übersetzungen und Tafsir.",
        "es": "Busque por nombre de sura, referencia de versículo (ej. 2:255) o palabras en traducciones y tafsir.",
        "ru": "Ищите по названию суры, номеру аята (например, 2:255) или словам в переводах и тафсирах.",
        "hi": "सूरह नाम, आयत संदर्भ (उदा. 2:255), या अनुवाद और तफ़सीर के शब्दों द्वारा खोजें।",
        "pt": "Pesquise por nome de surata, referência de versículo (ex. 2:255) ou palavras em traduções e tafsir.",
        "it": "Cerca per nome della sura, riferimento del versetto (es. 2:255) o parole nelle traduzioni e nei tafsir.",
        "ja": "章名、節番号（例：2:255）、または翻訳やタフスィール内の単語で検索できます。",
        "ko": "장 이름, 구절 번호(예: 2:255) 또는 번역 및 타프시르의 단어로 검색하세요.",
        "zh": "通过苏拉名称、经文编号（例如 2:255）或译文及经注中的词语进行搜索。",
        "vi": "Tìm kiếm theo tên Surah, số câu (ví dụ 2:255) hoặc các từ trong bản dịch và tafsir.",
        "sw": "Tafuta kwa jina la Sura, nambari ya aya (mf. 2:255), au maneno katika tafsiri na tafsiri ya Quran.",
        "az": "Surə adı, ayə nömrəsi (məs. 2:255) və ya tərcümə və təfsirlərdəki sözlərlə axtarın.",
        "kk": "Сүре атауы, аят нөмірі (мыс. 2:255) немесе аудармалар мен тәпсірлердегі сөздер бойынша іздеңіз.",
        "pa": "ਸੂਰਤ ਦੇ ਨਾਮ, ਆਇਤ ਨੰਬਰ (ਜਿਵੇਂ 2:255), ਜਾਂ ਅਨੁਵਾਦਾਂ ਅਤੇ ਤਫ਼ਸੀਰ ਦੇ ਸ਼ਬਦਾਂ ਦੁਆਰਾ ਖੋਜੋ।",
        "ps": "د سورت نوم، د آیت شمېره (لکه 2:255)، یا په ژباړو او تفاسیرو کې د کلمو له مخې لټون وکړئ.",
        "ta": "அத்தியாயப் பெயர், வசன எண் (எ.கா. 2:255) அல்லது மொழிபெயர்ப்புகள் மற்றும் தஃப்சீரில் உள்ள சொற்கள் மூலம் தேடுங்கள்."
    },
    "madani15Line": {
        "en": "15-Line Madani", "bn": "১৫ লাইনের মাদানী", "ar": "مصحف المدينة ١٥ سطر",
        "tr": "15 Satır Medine", "ur": "15 سطری مدنی", "fa": "۱۵ خطی مدنی",
        "id": "15 Baris Madinah", "ms": "15 Baris Madinah", "fr": "15 Lignes Madani",
        "de": "15-Zeilen Madani", "es": "Madani de 15 líneas", "ru": "15-строчный Мединский",
        "hi": "15-पंक्ति मदनी", "pt": "Madani de 15 linhas", "it": "Madani a 15 righe",
        "ja": "15行マディーナ版", "ko": "15줄 메디나체", "zh": "15行麦地那版", "vi": "Madani 15 dòng",
        "sw": "Madani ya Mistari 15", "az": "15 Sətirli Mədinə", "kk": "15 жолдық Мәдина",
        "pa": "15-ਲਾਈਨ ਮਦਨੀ", "ps": "۱۵ کرښې مدني", "ta": "15-வரி மதனீ"
    },
    "totalPagesCount": {
        "en": "604 Pages", "bn": "৬০৪ পৃষ্ঠা", "ar": "٦٠٤ صفحة",
        "tr": "604 Sayfa", "ur": "604 صفحات", "fa": "۶۰۴ صفحه",
        "id": "604 Halaman", "ms": "604 Halaman", "fr": "604 Pages",
        "de": "604 Seiten", "es": "604 Páginas", "ru": "604 страницы",
        "hi": "604 पृष्ठ", "pt": "604 Páginas", "it": "604 Pagine",
        "ja": "604ページ", "ko": "604페이지", "zh": "604页", "vi": "604 Trang",
        "sw": "Kurasa 604", "az": "604 Səhifə", "kk": "604 бет",
        "pa": "604 ਪੰਨੇ", "ps": "۶۰۴ مخونه", "ta": "604 பக்கங்கள்"
    },
    "wordAudio": {
        "en": "Word Audio", "bn": "শব্দে অডিও", "ar": "صوت الكلمات",
        "tr": "Kelime Sesi", "ur": "لفظی آڈیو", "fa": "صوت کلمات",
        "id": "Audio Per Kata", "ms": "Audio Per Kata", "fr": "Audio mot à mot",
        "de": "Wort-Audio", "es": "Audio palabra por palabra", "ru": "Аудио по словам",
        "hi": "शब्द ऑडियो", "pt": "Áudio por palavra", "it": "Audio per parola",
        "ja": "単語ごとの音声", "ko": "단어별 오디오", "zh": "逐词音频", "vi": "Âm thanh từng từ",
        "sw": "Sauti ya Neno kwa Neno", "az": "Söz Səsi", "kk": "Сөздік аудио",
        "pa": "ਸ਼ਬਦ ਆਡੀਓ", "ps": "د ټکو غږ", "ta": "சொல் ஆடியோ"
    },
    "offlineReady": {
        "en": "Offline Ready", "bn": "অফলাইনে প্রস্তুত", "ar": "جاهز بدون إنترنت",
        "tr": "Çevrimdışı Hazır", "ur": "آف لائن دستیاب", "fa": "آماده به صورت آفلاین",
        "id": "Siap Offline", "ms": "Sedia Luar Talian", "fr": "Prêt hors ligne",
        "de": "Offline bereit", "es": "Listo sin conexión", "ru": "Доступно офлайн",
        "hi": "ऑफ़लाइन तैयार", "pt": "Pronto offline", "it": "Pronto offline",
        "ja": "オフライン対応", "ko": "오프라인 사용 가능", "zh": "支持离线", "vi": "Sẵn sàng ngoại tuyến",
        "sw": "Tayari Nje ya Mtandao", "az": "Oflayn Hazır", "kk": "Офлайн қолжетімді",
        "pa": "ਆਫ਼ਲਾਈਨ ਤਿਆਰ", "ps": "آفلاین چمتو", "ta": "ஆஃப்லைனில் தயார்"
    },
    "vectorFonts": {
        "en": "Vector Fonts", "bn": "ভেক্টর ফন্ট", "ar": "خطوط متجهة",
        "tr": "Vektör Yazı Tipleri", "ur": "ویکٹر فونٹس", "fa": "فونت‌های برداری",
        "id": "Font Vektor", "ms": "Fon Vektor", "fr": "Polices vectorielles",
        "de": "Vektorschriftarten", "es": "Fuentes vectoriales", "ru": "Векторные шрифты",
        "hi": "वेक्टर फ़ॉन्ट्स", "pt": "Fontes vetoriais", "it": "Font vettoriali",
        "ja": "ベクターフォント", "ko": "벡터 폰트", "zh": "矢量字体", "vi": "Phông chữ vector",
        "sw": "Fonti za Vekta", "az": "Vektor Şriftləri", "kk": "Векторлық қаріптер",
        "pa": "ਵੈਕਟਰ ਫੌਂਟ", "ps": "ویکتور فونټونه", "ta": "வெக்டர் எழுத்துருக்கள்"
    },
    "madaniMushafLayout": {
        "en": "Madani Mushaf Layout", "bn": "মাদানী মুসহাফ লেআউট", "ar": "تصميم مصحف المدينة",
        "tr": "Medine Mushaf Düzeni", "ur": "مدنی مصحف لے آؤٹ", "fa": "طرح مصحف مدنی",
        "id": "Tata Letak Mushaf Madinah", "ms": "Susun Atur Mushaf Madinah", "fr": "Disposition du Mushaf Madani",
        "de": "Madani-Mushaf-Layout", "es": "Diseño del Mushaf Madani", "ru": "Макет Мединского Мусхафа",
        "hi": "मदनी मुसहाफ लेआउट", "pt": "Layout do Mushaf Madani", "it": "Layout del Mushaf Madani",
        "ja": "マディーナ・ムスハフ・レイアウト", "ko": "메디나 무스하프 레이아웃", "zh": "麦地那穆斯哈夫布局", "vi": "Bố cục Mushaf Madani",
        "sw": "Muundo wa Mushaf wa Madani", "az": "Mədinə Müshəf Tərtibatı", "kk": "Мәдина Мұсхаф макеті",
        "pa": "ਮਦਨੀ ਮੁਸਹਫ਼ ਖਾਕਾ", "ps": "د مدني مصحف بڼه", "ta": "மதனீ முஸஹஃப் தளவமைப்பு"
    },
    "kfgqpcDescription": {
        "en": "King Fahd Quran Printing Complex (V4)", "bn": "বাদশাহ ফাহাদ কুরআন মুদ্রণ কমপ্লেক্স (V4)", "ar": "مجمع الملك فهد لطباعة المصحف الشريف (V4)",
        "tr": "Kral Fehd Kur'an Basım Kompleksi (V4)", "ur": "مجمع شاہ فہد برائے طباعت مصحف شریف (V4)", "fa": "مجتمع چاپ قرآن ملک فهد (V4)",
        "id": "Kompleks Percetakan Al-Quran Raja Fahd (V4)", "ms": "Kompleks Percetakan Al-Quran Raja Fahd (V4)", "fr": "Complexe du Roi Fahd pour l'impression du Coran (V4)",
        "de": "König-Fahd-Komplex zum Drucken des Korans (V4)", "es": "Complejo del Rey Fahd para la impresión del Corán (V4)", "ru": "Комплекс имени Короля Фахда (V4)",
        "hi": "शाह फहद कुरान प्रिंटिंग कॉम्प्लेक्स (V4)", "pt": "Complexo do Rei Fahd para Impressão do Alcorão (V4)", "it": "Complesso Re Fahd per la stampa del Corano (V4)",
        "ja": "ファハド国王クルアーン印刷複合体 (V4)", "ko": "파드 국왕 쿠란 인쇄 복합단지 (V4)", "zh": "法赫德国王古兰经印刷厂 (V4)", "vi": "Tổ hợp In ấn Kinh Quran Vua Fahd (V4)",
        "sw": "Kiwanda cha Uchapishaji cha Mfalme Fahd (V4)", "az": "Kral Fəhd Quran Çap Kompleksi (V4)", "kk": "Король Фаһд Құран басу кешені (V4)",
        "pa": "ਕਿੰਗ ਫ਼ਾਹਦ ਕੁਰਾਨ ਪ੍ਰਿੰਟਿੰਗ ਕੰਪਲੈਕਸ (V4)", "ps": "د پاچا فهد د قرآن چاپونې کمپلیکس (V4)", "ta": "மன்னர் ஃபஹத் குர்ஆன் அச்சிடும் வளாகம் (V4)"
    },
    "downloadingMushafPackage": {
        "en": "Downloading Mushaf Package...", "bn": "মুসহাফ প্যাকেজ ডাউনলোড হচ্ছে...", "ar": "جاري تنزيل حزمة المصحف...",
        "tr": "Mushaf Paketi İndiriliyor...", "ur": "مصحف پیکیج ڈاؤن لوڈ ہو رہا ہے...", "fa": "در حال دانلود بسته مصحف...",
        "id": "Mengunduh Paket Mushaf...", "ms": "Memuat Turun Pakej Mushaf...", "fr": "Téléchargement du pack Mushaf...",
        "de": "Mushaf-Paket wird heruntergeladen...", "es": "Descargando paquete de Mushaf...", "ru": "Загрузка пакета Мусхафа...",
        "hi": "मुसहाफ पैकेज डाउनलोड हो रहा है...", "pt": "Baixando pacote do Mushaf...", "it": "Download del pacchetto Mushaf...",
        "ja": "ムスハフパッケージをダウンロード中...", "ko": "무스하프 패키지 다운로드 중...", "zh": "正在下载穆斯哈夫数据包...", "vi": "Đang tải xuống gói Mushaf...",
        "sw": "Inapakua Kifurushi cha Mushaf...", "az": "Müshəf Paketi Endirilir...", "kk": "Мұсхаф топтамасы жүктелуде...",
        "pa": "ਮੁਸਹਫ਼ ਪੈਕੇਜ ਡਾਊਨਲੋਡ ਹੋ ਰਿਹਾ ਹੈ...", "ps": "د مصحف کڅوړه ډاونلوډ کیږي...", "ta": "முஸஹஃப் தொகுப்பு பதிவிறக்கப்படுகிறது..."
    },
    "extractingAndInstallingData": {
        "en": "Extracting & Installing Data...", "bn": "ডাটা এক্সট্র্যাক্ট ও ইনস্টল হচ্ছে...", "ar": "جاري استخراج وتثبيت البيانات...",
        "tr": "Veriler Çıkarılıyor ve Kuruluyor...", "ur": "ڈیٹا نکالا اور انسٹال کیا جا رہا ہے...", "fa": "در حال استخراج و نصب داده‌ها...",
        "id": "Mengekstrak & Memasang Data...", "ms": "Mengekstrak & Memasang Data...", "fr": "Extraction et installation des données...",
        "de": "Daten werden extrahiert und installiert...", "es": "Extrayendo e instalando datos...", "ru": "Извлечение и установка данных...",
        "hi": "डेटा निकाला और स्थापित किया जा रहा है...", "pt": "Extraindo e instalando dados...", "it": "Estrazione e installazione dei dati...",
        "ja": "データを抽出してインストール中...", "ko": "데이터 압축 해제 및 설치 중...", "zh": "正在解压并安装数据...", "vi": "Đang giải nén & cài đặt dữ liệu...",
        "sw": "Inafungua na Kusakinisha Data...", "az": "Məlumatlar Çıxarılır və Quraşdırılır...", "kk": "Деректер шығарылуда және орнатылуда...",
        "pa": "ਡੇਟਾ ਕੱਢਿਆ ਅਤੇ ਇੰਸਟਾਲ ਕੀਤਾ ਜਾ ਰਿਹਾ ਹੈ...", "ps": "ډاټا استخراج او انسټال کیږي...", "ta": "தரவு பிரித்தெடுக்கப்பட்டு நிறுவப்படுகிறது..."
    },
    "settingUpOfflinePages": {
        "en": "Setting up offline pages...", "bn": "অফলাইন পৃষ্ঠা প্রস্তুত হচ্ছে...", "ar": "جاري تجهيز الصفحات بدون اتصال...",
        "tr": "Çevrimdışı sayfalar ayarlanıyor...", "ur": "آف لائن صفحات ترتیب دیے جا رہے ہیں...", "fa": "در حال آماده‌سازی صفحات آفلاین...",
        "id": "Menyiapkan halaman offline...", "ms": "Menyediakan halaman luar talian...", "fr": "Configuration des pages hors ligne...",
        "de": "Offline-Seiten werden eingerichtet...", "es": "Configurando páginas sin conexión...", "ru": "Настройка офлайн-страниц...",
        "hi": "ऑफ़लाइन पृष्ठ तैयार किए जा रहे हैं...", "pt": "Configurando páginas offline...", "it": "Configurazione delle pagine offline...",
        "ja": "オフラインページを設定中...", "ko": "오프라인 페이지 설정 중...", "zh": "正在设置离线页面...", "vi": "Đang thiết lập các trang ngoại tuyến...",
        "sw": "Inatayarisha kurasa za nje ya mtandao...", "az": "Oflayn səhifələr qurulur...", "kk": "Офлайн беттер бапталуда...",
        "pa": "ਆਫ਼ਲਾਈਨ ਪੰਨੇ ਸੈੱਟ ਕੀਤੇ ਜਾ ਰਹੇ ਹਨ...", "ps": "آفلاین مخونه تنظیم کیږي...", "ta": "ஆஃப்லைன் பக்கங்கள் அமைக்கப்படுகின்றன..."
    },
    "fetchingLayoutArchive": {
        "en": "Fetching layout archive...", "bn": "লেআউট সংগ্রহ করা হচ্ছে...", "ar": "جاري جلب أرشيف التصميم...",
        "tr": "Düzen arşivi alınıyor...", "ur": "لے آؤٹ آرکائیو حاصل کی جا رہی ہے...", "fa": "در حال دریافت آرشیو طرح...",
        "id": "Mengambil arsip tata letak...", "ms": "Mengambil arkib susun atur...", "fr": "Récupération de l'archive de disposition...",
        "de": "Layout-Archiv wird abgerufen...", "es": "Obteniendo archivo de diseño...", "ru": "Получение архива макета...",
        "hi": "लेआउट संग्रह प्राप्त किया जा रहा है...", "pt": "Buscando arquivo de layout...", "it": "Recupero dell'archivio del layout...",
        "ja": "レイアウトアーカイブを取得中...", "ko": "레이아웃 아카이브를 가져오는 중...", "zh": "正在获取排版压缩包...", "vi": "Đang lấy kho lưu trữ bố cục...",
        "sw": "Inaleta kumbukumbu ya muundo...", "az": "Tərtibat arxivi əldə edilir...", "kk": "Макет архиві алынуда...",
        "pa": "ਖਾਕਾ ਪੁਰਾਲੇਖ ਪ੍ਰਾਪਤ ਕੀਤਾ ਜਾ ਰਿਹਾ ਹੈ...", "ps": "د بڼې آرشیف ترلاسه کیږي...", "ta": "தளவமைப்பு காப்பகம் பெறப்படுகிறது..."
    },
    "keepAppOpenDuringDownload": {
        "en": "Please keep the app open while download completes.",
        "bn": "ডাউনলোড সম্পন্ন হওয়া পর্যন্ত দয়া করে অ্যাপটি খোলা রাখুন।",
        "ar": "يرجى إبقاء التطبيق مفتوحاً حتى يكتمل التنزيل.",
        "tr": "Lütfen indirme tamamlanana kadar uygulamayı açık tutun.",
        "ur": "براہ کرم ڈاؤن لوڈ مکمل ہونے تک ایپ کھلی رکھیں۔",
        "fa": "لطفاً تا پایان دانلود، برنامه را باز نگه دارید.",
        "id": "Harap biarkan aplikasi tetap terbuka sampai unduhan selesai.",
        "ms": "Sila biarkan aplikasi terbuka sehingga muat turun selesai.",
        "fr": "Veuillez garder l'application ouverte jusqu'à la fin du téléchargement.",
        "de": "Bitte lassen Sie die App geöffnet, bis der Download abgeschlossen ist.",
        "es": "Por favor, mantenga la aplicación abierta mientras se completa la descarga.",
        "ru": "Пожалуйста, не закрывайте приложение до завершения загрузки.",
        "hi": "कृपया डाउनलोड पूरा होने तक ऐप को खुला रखें।",
        "pt": "Por favor, mantenha o aplicativo aberto até que o download seja concluído.",
        "it": "Si prega di mantenere l'app aperta fino al completamento del download.",
        "ja": "ダウンロードが完了するまでアプリを開いたままにしてください。",
        "ko": "다운로드가 완료될 때까지 앱을 열어두세요.",
        "zh": "下载完成前请保持应用处于打开状态。",
        "vi": "Vui lòng giữ ứng dụng mở cho đến khi tải xuống hoàn tất.",
        "sw": "Tafadhali weka programu wazi hadi upakuaji ukamilike.",
        "az": "Zəhmət olmasa, endirmə tamamlanana qədər tətbiqi açıq saxlayın.",
        "kk": "Жүктеу аяқталғанша қолданбаны ашық ұстаңыз.",
        "pa": "ਕਿਰਪਾ ਕਰਕੇ ਡਾਊਨਲੋਡ ਪੂਰਾ ਹੋਣ ਤੱਕ ਐਪ ਨੂੰ ਖੁੱਲ੍ਹਾ ਰੱਖੋ।",
        "ps": "مهرباني وکړئ د ډاونلوډ بشپړیدو پورې اپلیکیشن خلاص وساتئ.",
        "ta": "பதிவிறக்கம் முடியும் வரை பயன்பாட்டைத் திறந்து வைக்கவும்."
    },
    "downloadFailed": {
        "en": "Download Failed", "bn": "ডাউনলোড ব্যর্থ হয়েছে", "ar": "فشل التنزيل",
        "tr": "İndirme Başarısız", "ur": "ڈاؤن لوڈ ناکام ہو گیا", "fa": "دانلود ناموفق بود",
        "id": "Unduhan Gagal", "ms": "Muat Turun Gagal", "fr": "Échec du téléchargement",
        "de": "Download fehlgeschlagen", "es": "Error en la descarga", "ru": "Ошибка загрузки",
        "hi": "डाउनलोड विफल", "pt": "Falha no download", "it": "Download non riuscito",
        "ja": "ダウンロードに失敗しました", "ko": "다운로드 실패", "zh": "下载失败", "vi": "Tải xuống thất bại",
        "sw": "Upakuaji Umeshindwa", "az": "Endirmə Uğursuz Oldu", "kk": "Жүктеу сәтсіз аяқталды",
        "pa": "ਡਾਊਨਲੋਡ ਅਸਫਲ ਰਿਹਾ", "ps": "ډاونلوډ ناکام شو", "ta": "பதிவிறக்கம் தோல்வியடைந்தது"
    },
    "retryDownload": {
        "en": "Retry Download", "bn": "পুনরায় ডাউনলোড চেষ্টা করুন", "ar": "إعادة المحاولة",
        "tr": "İndirmeyi Tekrar Dene", "ur": "ڈاؤن لوڈ دوبارہ کریں", "fa": "تلاش مجدد برای دانلود",
        "id": "Coba Unduh Lagi", "ms": "Cuba Muat Turun Semula", "fr": "Réessayer le téléchargement",
        "de": "Download wiederholen", "es": "Reintentar descarga", "ru": "Повторить загрузку",
        "hi": "डाउनलोड पुनः प्रयास करें", "pt": "Tentar baixar novamente", "it": "Riprova il download",
        "ja": "再ダウンロード", "ko": "다운로드 다시 시도", "zh": "重试下载", "vi": "Thử tải lại",
        "sw": "Jaribu Kupakua Tena", "az": "Yenidən Endir", "kk": "Қайта жүктеу",
        "pa": "ਮੁੜ ਡਾਊਨਲੋਡ ਕਰੋ", "ps": "بیا ډاونلوډ هڅه وکړئ", "ta": "மீண்டும் பதிவிறக்கவும்"
    },
    "packageSize": {
        "en": "Package Size", "bn": "প্যাকেজের আকার", "ar": "حجم الحزمة",
        "tr": "Paket Boyutu", "ur": "پیکیج کا سائز", "fa": "حجم بسته",
        "id": "Ukuran Paket", "ms": "Saiz Pakej", "fr": "Taille du pack",
        "de": "Paketgröße", "es": "Tamaño del paquete", "ru": "Размер пакета",
        "hi": "पैकेज का आकार", "pt": "Tamanho do pacote", "it": "Dimensione del pacchetto",
        "ja": "パッケージサイズ", "ko": "패키지 크기", "zh": "数据包大小", "vi": "Kích thước gói",
        "sw": "Ukubwa wa Kifurushi", "az": "Paket Ölçüsü", "kk": "Топтама өлшемі",
        "pa": "ਪੈਕੇਜ ਦਾ ਆਕਾਰ", "ps": "د کڅوړې اندازه", "ta": "தொகுப்பு அளவு"
    },
    "loadingMushafPage": {
        "en": "Loading Mushaf Page...", "bn": "মুসহাফ পৃষ্ঠা লোড হচ্ছে...", "ar": "جاري تحميل صفحة المصحف...",
        "tr": "Mushaf Sayfası Yükleniyor...", "ur": "مصحف کا صفحہ لوڈ ہو رہا ہے...", "fa": "در حال بارگذاری صفحه مصحف...",
        "id": "Memuat Halaman Mushaf...", "ms": "Memuatkan Halaman Mushaf...", "fr": "Chargement de la page du Mushaf...",
        "de": "Mushaf-Seite wird geladen...", "es": "Cargando página del Mushaf...", "ru": "Загрузка страницы Мусхафа...",
        "hi": "मुसहाफ पृष्ठ लोड हो रहा है...", "pt": "Carregando página do Mushaf...", "it": "Caricamento della pagina del Mushaf...",
        "ja": "ムスハフページを読み込み中...", "ko": "무스하프 페이지 로딩 중...", "zh": "正在加载穆斯哈夫页面...", "vi": "Đang tải trang Mushaf...",
        "sw": "Inapakia Ukurasa wa Mushaf...", "az": "Müshəf Səhifəsi Yüklənir...", "kk": "Мұсхаф беті жүктелуде...",
        "pa": "ਮੁਸਹਫ਼ ਪੰਨਾ ਲੋਡ ਹੋ ਰਿਹਾ ਹੈ...", "ps": "د مصحف مخ بار کیږي...", "ta": "முஸஹஃப் பக்கம் ஏற்றப்படுகிறது..."
    },
    "quickPageJump": {
        "en": "Quick Page Jump", "bn": "দ্রুত পৃষ্ঠা পরিবর্তন", "ar": "انتقال سريع للصفحة",
        "tr": "Hızlı Sayfa Geçişi", "ur": "فوری صفحہ پر جائیں", "fa": "پرش سریع به صفحه",
        "id": "Lompat Halaman Cepat", "ms": "Lompat Halaman Pantas", "fr": "Accès rapide à la page",
        "de": "Schneller Seitensprung", "es": "Salto rápido de página", "ru": "Быстрый переход к странице",
        "hi": "त्वरित पृष्ठ कूद", "pt": "Salto rápido de página", "it": "Salto rapido di pagina",
        "ja": "クイックページ移動", "ko": "빠른 페이지 이동", "zh": "快速页面跳转", "vi": "Chuyển trang nhanh",
        "sw": "Kuruka Ukurasa Haraka", "az": "Sürətli Səhifə Keçidi", "kk": "Бетке жылдам өту",
        "pa": "ਤੁਰੰਤ ਪੰਨਾ ਛਾਲ", "ps": "ژر مخ ته تلل", "ta": "விரைவு பக்க தாவல்"
    },
    "searchSurahHint": {
        "en": "Search Surah by name or number...",
        "bn": "নাম বা নম্বর দিয়ে সূরা খুঁজুন...",
        "ar": "ابحث عن السورة بالاسم أو الرقم...",
        "tr": "Sureyi isim veya numara ile ara...",
        "ur": "نام یا نمبر سے سورت تلاش کریں...",
        "fa": "جستجوی سوره با نام یا شماره...",
        "id": "Cari Surah berdasarkan nama atau nomor...",
        "ms": "Cari Surah mengikut nama atau nombor...",
        "fr": "Rechercher une sourate par nom ou numéro...",
        "de": "Sure nach Name oder Nummer suchen...",
        "es": "Buscar sura por nombre o número...",
        "ru": "Поиск суры по названию или номеру...",
        "hi": "नाम या संख्या से सूरह खोजें...",
        "pt": "Pesquisar surata por nome ou número...",
        "it": "Cerca la sura per nome o numero...",
        "ja": "名前または番号でスーラを検索...",
        "ko": "이름이나 번호로 수라 검색...",
        "zh": "按名称或编号搜索苏拉...",
        "vi": "Tìm kiếm Surah theo tên hoặc số...",
        "sw": "Tafuta Sura kwa jina au nambari...",
        "az": "Surəni ad və ya nömrə ilə axtarın...",
        "kk": "Сүрені аты немесе нөмірі бойынша іздеу...",
        "pa": "ਨਾਮ ਜਾਂ ਨੰਬਰ ਦੁਆਰਾ ਸੂਰਤ ਖੋਜੋ...",
        "ps": "د نوم یا شمېرې له مخې سورت ولټوئ...",
        "ta": "பெயர் அல்லது எண் மூலம் அத்தியாயத்தைத் தேடுங்கள்..."
    },
    "fullscreen": {
        "en": "Fullscreen", "bn": "পূর্ণ পর্দা", "ar": "ملء الشاشة",
        "tr": "Tam Ekran", "ur": "فل اسکرین", "fa": "تمام صفحه",
        "id": "Layar Penuh", "ms": "Skrin Penuh", "fr": "Plein écran",
        "de": "Vollbild", "es": "Pantalla completa", "ru": "Полноэкранный режим",
        "hi": "पूर्ण स्क्रीन", "pt": "Tela cheia", "it": "Schermo intero",
        "ja": "全画面表示", "ko": "전체 화면", "zh": "全屏", "vi": "Toàn màn hình",
        "sw": "Skrini Kamili", "az": "Tam Ekran", "kk": "Толық экран",
        "pa": "ਪੂਰੀ ਸਕ੍ਰੀਨ", "ps": "بشپړ سکرین", "ta": "முழுத்திரை"
    },
    "back": {
        "en": "Back", "bn": "ফিরে যান", "ar": "رجوع",
        "tr": "Geri", "ur": "واپس", "fa": "بازگشت",
        "id": "Kembali", "ms": "Kembali", "fr": "Retour",
        "de": "Zurück", "es": "Atrás", "ru": "Назад",
        "hi": "पीछे", "pt": "Voltar", "it": "Indietro",
        "ja": "戻る", "ko": "뒤로", "zh": "返回", "vi": "Quay lại",
        "sw": "Nyuma", "az": "Geri", "kk": "Артқа",
        "pa": "ਵਾਪਸ", "ps": "شاته", "ta": "பின்செல்"
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