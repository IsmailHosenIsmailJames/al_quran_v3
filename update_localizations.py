import json
import os

translations = {
    "hijri": {
        "ar": "هجري", "az": "Hicri", "bn": "হিজরি", "de": "Hidschri", "es": "Hégira", "fa": "هجری", "fr": "Hégirien", "hi": "हिजरी", "id": "Hijriah", "it": "Egira", "ja": "ヒジュラ暦", "kk": "Хижра", "ko": "히즈라", "ms": "Hijrah", "pa": "ਹਿਜਰੀ", "ps": "هجري", "pt": "Hégira", "ru": "Хиджра", "sw": "Hijria", "ta": "ஹிஜ்ரி", "tr": "Hicri", "ur": "ہجری", "vi": "Hijri", "zh": "回历"
    },
    "gregorian": {
        "ar": "ميلادي", "az": "Qriqorian", "bn": "গ্রেগরিয়ান", "de": "Gregorianisch", "es": "Gregoriano", "fa": "میلادی", "fr": "Grégorien", "hi": "ग्रेगोरियन", "id": "Masehi", "it": "Gregoriano", "ja": "グレゴリオ暦", "kk": "Григориан", "ko": "그레고리력", "ms": "Masihi", "pa": "ਗ੍ਰੈਗੋਰੀਅਨ", "ps": "ګریګورین", "pt": "Gregoriano", "ru": "Григорианский", "sw": "Gregori", "ta": "கிரிகோரியன்", "tr": "Miladi", "ur": "عیسوی", "vi": "Dương lịch", "zh": "公历"
    },
    "prayerTimesCalender": {
        "ar": "تقويم أوقات الصلاة", "az": "Namaz Vaxtları Təqvimi", "bn": "নামাজের সময়সূচী ক্যালেন্ডার", "de": "Gebetszeitenkalender", "es": "Calendario de Tiempos de Oración", "fa": "تقویم اوقات شرعی", "fr": "Calendrier des heures de prière", "hi": "प्रार्थना के समय का कैलेंडर", "id": "Kalender Waktu Salat", "it": "Calendario dei tempi di preghiera", "ja": "礼拝時間カレンダー", "kk": "Намаз уақыттарының күнтізбесі", "ko": "기도 시간 달력", "ms": "Kalendar Waktu Solat", "pa": "ਪ੍ਰਾਰਥਨਾ ਦੇ ਸਮੇਂ ਦਾ ਕੈਲੰਡਰ", "ps": "د لمانځه وختونو کیلنڈر", "pt": "Calendário de Horários de Oração", "ru": "Календарь времени молитв", "sw": "Kalenda ya Nyakati za Swala", "ta": "தொழுகை நேரங்கள் நாட்காட்டி", "tr": "Namaz Vakitleri Takvimi", "ur": "نماز کے اوقات کا کیلنڈر", "vi": "Lịch Thời gian Cầu nguyện", "zh": "祈祷时间日历"
    },
    "allowLocation": {
        "ar": "السماح بالموقع", "az": "Məkanı icazə ver", "bn": "অবস্থান অনুমতি দিন", "de": "Standort zulassen", "es": "Permitir ubicación", "fa": "اجازه مکان", "fr": "Autoriser l'emplacement", "hi": "स्थान की अनुमति दें", "id": "Izinkan Lokasi", "it": "Consenti posizione", "ja": "位置情報を許可", "kk": "Орналасуға рұқсат беру", "ko": "위치 허용", "ms": "Benarkan Lokasi", "pa": "ਟਿਕਾਣੇ ਦੀ ਇਜਾਜ਼ਤ ਦਿਓ", "ps": "موقعیت ته اجازه ورکړئ", "pt": "Permitir localização", "ru": "Разрешить местоположение", "sw": "Ruhusu Mahali", "ta": "இருப்பிடத்தை அனுமதி", "tr": "Konuma İzin Ver", "ur": "مقام کی اجازت دیں", "vi": "Cho phép vị trí", "zh": "允许位置"
    },
    "allowLocationDescription": {
        "ar": "تحديث أوقات الصلاة تلقائيًا.", "az": "Namaz vaxtlarını avtomatik yeniləyir.", "bn": "স্বয়ংক্রিয়ভাবে নামাজের সময় আপডেট করে।", "de": "Aktualisiert Gebetszeiten automatisch.", "es": "Actualiza automáticamente los tiempos de oración.", "fa": "اوقات شرعی را به طور خودکار به روز می کند.", "fr": "Met à jour automatiquement les heures de prière.", "hi": "प्रार्थना का समय स्वचालित रूप से अपडेट करता है।", "id": "Secara otomatis memperbarui waktu salat.", "it": "Aggiorna automaticamente i tempi di preghiera.", "ja": "礼拝時間を自動的に更新します。", "kk": "Намаз уақыттарын автоматты түрде жаңартады.", "ko": "기도 시간을 자동으로 업데이트합니다.", "ms": "Kemas kini waktu solat secara automatik.", "pa": "ਪ੍ਰਾਰਥਨਾ ਦੇ ਸਮੇਂ ਨੂੰ ਆਪਣੇ ਆਪ ਅਪਡੇਟ ਕਰਦਾ ਹੈ।", "ps": "د لمانځه وختونه په اوتومات ډول تازه کوي.", "pt": "Atualiza automaticamente os horários de oração.", "ru": "Автоматически обновляет время молитв.", "sw": "Husasisha kiotomatiki nyakati za swala.", "ta": "தொழுகை நேரங்களை தானாகவே புதுப்பிக்கிறது.", "tr": "Namaz vakitlerini otomatik günceller.", "ur": "نماز کے اوقات خود بخود اپ ڈیٹ کرتا ہے۔", "vi": "Tự động cập nhật thời gian cầu nguyện.", "zh": "自动更新祈祷时间。"
    },
    "manualLocation": {
        "ar": "موقع يدوي", "az": "Əl ilə məkan", "bn": "ম্যানুয়াল অবস্থান", "de": "Manueller Standort", "es": "Ubicación manual", "fa": "مکان دستی", "fr": "Emplacement manuel", "hi": "मैनुअल स्थान", "id": "Lokasi Manual", "it": "Posizione manuale", "ja": "手動で位置情報を設定", "kk": "Қолмен орналасу", "ko": "수동 위치", "ms": "Lokasi Manual", "pa": "ਮੈਨੁਅਲ ਟਿਕਾਣਾ", "ps": "لاسي موقعیت", "pt": "Localização manual", "ru": "Ручное местоположение", "sw": "Eneo la Mwongozo", "ta": "கையேடு இருப்பிடம்", "tr": "Manuel Konum", "ur": "دستی مقام", "vi": "Vị trí thủ công", "zh": "手动位置"
    },
    "manualLocationDescription": {
        "ar": "اختر البلد والمدينة يدويًا. ستحتاج إلى تحديث الموقع إذا قمت بتغيير المدينة.", "az": "Ölkəni və şəhəri əl ilə seçin. Şəhəri dəyişsəniz, məkanı yeniləməlisiniz.", "bn": "ম্যানুয়ালি দেশ এবং শহর নির্বাচন করুন। আপনি শহর পরিবর্তন করলে আপনাকে অবস্থান আপডেট করতে হবে।", "de": "Wählen Sie das Land und die Stadt manuell aus. Sie müssen den Standort aktualisieren, wenn Sie die Stadt wechseln.", "es": "Seleccione manualmente el país y la ciudad. Necesita actualizar la ubicación si cambia de ciudad.", "fa": "کشور و شهر را به صورت دستی انتخاب کنید. در صورت تغییر شهر باید مکان را به روز کنید.", "fr": "Sélectionnez manuellement le pays et la ville. Vous devez mettre à jour l'emplacement si vous changez de ville.", "hi": "मैन्युअल रूप से देश और शहर का चयन करें। यदि आप शहर बदलते हैं तो आपको स्थान अपडेट करने की आवश्यकता है।", "id": "Pilih negara dan kota secara manual. Anda perlu memperbarui lokasi jika Anda mengubah kota.", "it": "Seleziona manualmente il paese e la città. Devi aggiornare la posizione se cambi città.", "ja": "国と都市を手動で選択します。都市を変更した場合は、位置情報を更新する必要があります。", "kk": "Ел мен қаланы қолмен таңдаңыз. Қаланы өзгертсеңіз, орналасуды жаңартуыңыз керек.", "ko": "국가와 도시를 수동으로 선택합니다. 도시를 변경하면 위치를 업데이트해야 합니다.", "ms": "Pilih negara dan bandar secara manual. Anda perlu mengemas kini lokasi jika anda menukar bandar.", "pa": "ਮੈਨੁਅਲ ਤੌਰ 'ਤੇ ਦੇਸ਼ ਅਤੇ ਸ਼ਹਿਰ ਦੀ ਚੋਣ ਕਰੋ। ਜੇਕਰ ਤੁਸੀਂ ਸ਼ਹਿਰ ਬਦਲਦੇ ਹੋ ਤਾਂ ਤੁਹਾਨੂੰ ਟਿਕਾਣਾ ਅਪਡੇਟ ਕਰਨ ਦੀ ਲੋੜ ਹੈ।", "ps": "په لاسي ډول هیواد او ښار وټاکئ. که تاسو ښار بدل کړئ نو تاسو اړتیا لرئ موقعیت تازه کړئ.", "pt": "Selecione manualmente o país e a cidade. Você precisa atualizar a localização se mudar de cidade.", "ru": "Выберите страну и город вручную. Вам нужно будет обновить местоположение, если вы смените город.", "sw": "Chagua nchi na jiji kwa mikono. Unahitaji kusasisha eneo ikiwa utabadilisha jiji.", "ta": "நாட்டையும் நகரத்தையும் கைமுறையாகத் தேர்ந்தெடுக்கவும். நீங்கள் நகரத்தை மாற்றினால் இருப்பிடத்தைப் புதுப்பிக்க வேண்டும்.", "tr": "Ülke ve şehri manuel seçin. Şehir değiştirirseniz konumu güncellemeniz gerekir.", "ur": "دستی طور پر ملک اور شہر کا انتخاب کریں۔ اگر آپ شہر تبدیل کرتے ہیں تو آپ کو مقام کو اپ ڈیٹ کرنے کی ضرورت ہے۔", "vi": "Chọn quốc gia và thành phố theo cách thủ công. Bạn cần cập nhật vị trí nếu bạn thay đổi thành phố.", "zh": "手动选择国家和城市。如果您更改城市，则需要更新位置。"
    },
    "selectLocation": {
        "ar": "اختر الموقع", "az": "Məkanı seçin", "bn": "অবস্থান নির্বাচন করুন", "de": "Standort auswählen", "es": "Seleccionar ubicación", "fa": "انتخاب مکان", "fr": "Sélectionner l'emplacement", "hi": "स्थान चुनें", "id": "Pilih Lokasi", "it": "Seleziona posizione", "ja": "位置情報を選択", "kk": "Орналасуды таңдаңыз", "ko": "위치 선택", "ms": "Pilih Lokasi", "pa": "ਟਿਕਾਣਾ ਚੁਣੋ", "ps": "موقعیت وټاکئ", "pt": "Selecionar localização", "ru": "Выберите местоположение", "sw": "Chagua Mahali", "ta": "இருப்பிடத்தைத் தேர்ந்தெடுக்கவும்", "tr": "Konum Seçin", "ur": "مقام منتخب کریں", "vi": "Chọn vị trí", "zh": "选择位置"
    },
    "selectCountry": {
        "ar": "اختر البلد", "az": "Ölkəni seçin", "bn": "দেশ নির্বাচন করুন", "de": "Land auswählen", "es": "Seleccionar país", "fa": "انتخاب کشور", "fr": "Sélectionner le pays", "hi": "देश चुनें", "id": "Pilih Negara", "it": "Seleziona paese", "ja": "国を選択", "kk": "Елді таңдаңыз", "ko": "국가 선택", "ms": "Pilih Negara", "pa": "ਦੇਸ਼ ਚੁਣੋ", "ps": "هیواد وټاکئ", "pt": "Selecionar país", "ru": "Выберите страну", "sw": "Chagua Nchi", "ta": "நாட்டைத் தேர்ந்தெடுக்கவும்", "tr": "Ülke Seçin", "ur": "ملک منتخب کریں", "vi": "Chọn quốc gia", "zh": "选择国家"
    },
    "selectCity": {
        "ar": "اختر المدينة", "az": "Şəhəri seçin", "bn": "শহর নির্বাচন করুন", "de": "Stadt auswählen", "es": "Seleccionar ciudad", "fa": "انتخاب شهر", "fr": "Sélectionner la ville", "hi": "शहर चुनें", "id": "Pilih Kota", "it": "Seleziona città", "ja": "都市を選択", "kk": "Қаланы таңдаңыз", "ko": "도시 선택", "ms": "Pilih Bandar", "pa": "ਸ਼ਹਿਰ ਚੁਣੋ", "ps": "ښار وټاکئ", "pt": "Selecionar cidade", "ru": "Выберите город", "sw": "Chagua Jiji", "ta": "நகரத்தைத் தேர்ந்தெடுக்கவும்", "tr": "Şehir Seçin", "ur": "شہر منتخب کریں", "vi": "Chọn thành phố", "zh": "选择城市"
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