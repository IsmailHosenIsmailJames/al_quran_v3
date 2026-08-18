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