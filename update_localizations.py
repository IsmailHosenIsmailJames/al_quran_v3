import json
import os

translations = {
    "sunRising": {
        "ar": "شروق الشمس", "az": "Günəşin çıxması", "bn": "সূর্যোদয়", "de": "Sonnenaufgang", "es": "Salida del sol", "fa": "طلوع خورشید", "fr": "Lever du soleil", "hi": "सूर्योदय", "id": "Matahari Terbit", "it": "Sorgere del sole", "ja": "日の出", "kk": "Күннің шығуы", "ko": "일출", "ms": "Matahari Terbit", "pa": "ਸੂਰਜ ਚੜ੍ਹਨਾ", "ps": "لمر ختل", "pt": "Nascer do sol", "ru": "Восход солнца", "sw": "Kuchomoza kwa Jua", "ta": "சூரியோதயம்", "tr": "Güneşin Doğuşu", "ur": "طلوع آفتاب", "vi": "Mặt trời mọc", "zh": "日出"
    },
    "sunSetting": {
        "ar": "غروب الشمس", "az": "Günəşin batması", "bn": "সূর্যাস্ত", "de": "Sonnenuntergang", "es": "Puesta del sol", "fa": "غروب خورشید", "fr": "Coucher du soleil", "hi": "सूर्यास्त", "id": "Matahari Terbenam", "it": "Tramonto", "ja": "日の入り", "kk": "Күннің батуы", "ko": "일몰", "ms": "Matahari Terbenam", "pa": "ਸੂਰਜ ਡੁੱਬਣਾ", "ps": "لمر لوېدل", "pt": "Pôr do sol", "ru": "Закат солнца", "sw": "Kuzama kwa Jua", "ta": "சூரிய அஸ்தமனம்", "tr": "Güneşin Batışı", "ur": "غروب آفتاب", "vi": "Mặt trời lặn", "zh": "日落"
    },
    "sunTopOfTheHead": {
        "ar": "وقت الزوال (الشمس في كبد السماء)", "az": "Günəşin Təpədə Olması", "bn": "সূর্য মাথার উপরে", "de": "Sonne im Zenit", "es": "Sol en el cenit", "fa": "خورشید در وسط آسمان", "fr": "Soleil au zénith", "hi": "सूरज सिर के ऊपर", "id": "Matahari di Atas Kepala", "it": "Sole allo zenit", "ja": "太陽が真上", "kk": "Күннің тас төбеде болуы", "ko": "태양이 머리 위에 있음", "ms": "Matahari di Atas Kepala", "pa": "ਸੂਰਜ ਸਿਰ ਦੇ ਉੱਪਰ", "ps": "لمر د سر په سر", "pt": "Sol no zênite", "ru": "Солнце в зените", "sw": "Jua Utosini", "ta": "சூரியன் உச்சி", "tr": "Güneşin Tepede Olması", "ur": "سورج سر کے اوپر", "vi": "Mặt trời trên đỉnh đầu", "zh": "太阳当头"
    },
    "salatTime": {
        "ar": "وقت الصلاة", "az": "Namaz Vaxtı", "bn": "নামাজের সময়", "de": "Gebetszeit", "es": "Tiempo de Oración", "fa": "وقت نماز", "fr": "Heure de la prière", "hi": "प्रार्थना का समय", "id": "Waktu Salat", "it": "Tempo di preghiera", "ja": "礼拝の時間", "kk": "Намаз уақыты", "ko": "기도 시간", "ms": "Waktu Solat", "pa": "ਪ੍ਰਾਰਥਨਾ ਦਾ ਸਮਾਂ", "ps": "د لمانځه وخت", "pt": "Tempo de Oração", "ru": "Время молитвы", "sw": "Wakati wa Swala", "ta": "தொழுகை நேரம்", "tr": "Namaz Vakti", "ur": "نماز کا وقت", "vi": "Thời gian cầu nguyện", "zh": "礼拜时间"
    },
    "forbiddenSalatTime": {
        "ar": "وقت كراهة الصلاة", "az": "Məkruh Namaz Vaxtı", "bn": "নামাজের নিষিদ্ধ সময়", "de": "Verbotene Gebetszeit", "es": "Tiempo de oración prohibido", "fa": "وقت ممنوعه نماز", "fr": "Heure de prière interdite", "hi": "वर्जित प्रार्थना का समय", "id": "Waktu Salat Terlarang", "it": "Tempo di preghiera proibito", "ja": "礼拝禁止時間", "kk": "Намаз оқуға тыйым салынған уақыт", "ko": "금지된 기도 시간", "ms": "Waktu Solat Dilarang", "pa": "ਵਰਜਿਤ ਪ੍ਰਾਰਥਨਾ ਦਾ ਸਮਾਂ", "ps": "د لمانځه منع شوی وخت", "pt": "Tempo de oração proibido", "ru": "Запрещенное время молитвы", "sw": "Wakati Uliokatazwa wa Swala", "ta": "தடைசெய்யப்பட்ட தொழுகை நேரம்", "tr": "Kerahat Vakti", "ur": "ممنوعہ نماز کا وقت", "vi": "Thời gian cầu nguyện bị cấm", "zh": "被禁止的礼拜时间"
    },
    "profile": {
        "ar": "الملف الشخصي", "az": "Profil", "bn": "প্রোফাইল", "de": "Profil", "es": "Perfil", "fa": "پروفایل", "fr": "Profil", "hi": "प्रोफ़ाइल", "id": "Profil", "it": "Profilo", "ja": "プロフィール", "kk": "Профиль", "ko": "프로필", "ms": "Profil", "pa": "ਪ੍ਰੋਫਾਈਲ", "ps": "پېژندڅېره", "pt": "Perfil", "ru": "Профиль", "sw": "Profaili", "ta": "சுயவிவரம்", "tr": "Profil", "ur": "پروفائل", "vi": "Hồ sơ", "zh": "个人资料"
    },
    "pleaseLoginToSearch": {
        "ar": "يرجى تسجيل الدخول لاستخدام ميزة البحث.", "az": "Axtarış funksiyasından istifadə etmək üçün daxil olun.", "bn": "অনুগ্রহ করে অনুসন্ধান সুবিধা ব্যবহার করতে লগইন করুন।", "de": "Bitte melden Sie sich an, um die Suchfunktion zu nutzen.", "es": "Inicie sesión para utilizar la función de búsqueda.", "fa": "لطفاً برای استفاده از قابلیت جستجو وارد شوید.", "fr": "Veuillez vous connecter pour utiliser la fonction de recherche.", "hi": "खोज सुविधा का उपयोग करने के लिए कृपया लॉगिन करें।", "id": "Silakan masuk untuk menggunakan fitur pencarian.", "it": "Accedi per utilizzare la funzione di ricerca.", "ja": "検索機能を使用するにはログインしてください。", "kk": "Іздеу мүмкіндігін пайдалану үшін жүйеге кіріңіз.", "ko": "검색 기능을 사용하려면 로그인하세요.", "ms": "Sila log masuk untuk menggunakan ciri carian.", "pa": "ਖੋਜ ਵਿਸ਼ੇਸ਼ਤਾ ਦੀ ਵਰਤੋਂ ਕਰਨ ਲਈ ਕਿਰਪਾ ਕਰਕੇ ਲੌਗਇਨ ਕਰੋ।", "ps": "مهرباني وکړئ د لټون اسانتیا کارولو لپاره ننوځئ.", "pt": "Por favor, faça login para usar o recurso de busca.", "ru": "Пожалуйста, войдите, чтобы использовать функцию поиска.", "sw": "Tafadhali ingia ili utumie huduma ya kutafuta.", "ta": "தேடல் அம்சத்தைப் பயன்படுத்த தயவுசெய்து உள்நுழையவும்.", "tr": "Arama özelliğini kullanmak için lütfen giriş yapın.", "ur": "سرچ فیچر استعمال کرنے کے لیے براہ کرم لاگ ان کریں۔", "vi": "Vui lòng đăng nhập to sử dụng tính năng tìm kiếm.", "zh": "请登录以使用搜索功能。"
    },
    "searchHint": {
        "ar": "البحث عن الآيات، السور...", "az": "Ayələr, surələr axtarın...", "bn": "আয়াত, সূরা অনুসন্ধান করুন...", "de": "Suche nach Versen, Suren...", "es": "Buscar versículos, suras...", "fa": "جستجو برای آیات، سوره‌ها...", "fr": "Rechercher des versets, sourates...", "hi": "आयतें, सूरह खोजें...", "id": "Cari ayat, surah...", "it": "Cerca versetti, sure...", "ja": "句、章（スーラ）を検索...", "kk": "Аяттарды, сүрелерді іздеу...", "ko": "구절, 수라 검색...", "ms": "Cari ayat, surah...", "pa": "ਆਇਤਾਂ, ਸੂਰਾ ਖੋਜੋ...", "ps": "د آیتونو، سورتونو لټون...", "pt": "Buscar versículos, suras...", "ru": "Поиск стихов, сур...", "sw": "Tafuta aya, sura...", "ta": "வசனங்கள், சூராக்களைத் தேடுங்கள்...", "tr": "Ayet, sure ara...", "ur": "آیات، سورتیں تلاش کریں...", "vi": "Tìm kiếm câu thơ, surah...", "zh": "搜索诗节、苏拉..."
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