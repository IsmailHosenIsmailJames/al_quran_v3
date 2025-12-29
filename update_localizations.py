import json
import os

translations = {
    "optimizingQuranScript": {
        "am": "የቁርኣን ስክሪፕት ማመቻቸት",
        "ar": "تحسين نص القرآن",
        "az": "Quran Mətninin Optimallaşdırılması",
        "bn": "কুরআনের স্ক্রিপ্ট অপ্টিমাইজ করা হচ্ছে",
        "de": "Optimierung des Koranskripts",
        "es": "Optimizando el guion del Corán",
        "fa": "بهینه سازی اسکریپت قرآن",
        "fr": "Optimisation du script du Coran",
        "ha": "Ingantaccen Rubutun Alqur'ani",
        "hi": "कुरान स्क्रिप्ट का अनुकूलन",
        "id": "Mengoptimalkan Skrip Quran",
        "it": "Ottimizzazione dello script del Corano",
        "ja": "コーランのスクリプトを最適化しています",
        "kk": "Құран сценарийін оңтайландыру",
        "ko": "쿠란 스크립트 최적화",
        "ku": "Optimîzekirina skrîpta Quranê",
        "ms": "Mengoptimumkan Skrip Quran",
        "pa": "ਕੁਰਾਨ ਸਕਰਿਪਟ ਨੂੰ ਅਨੁਕੂਲ ਬਣਾ ਰਿਹਾ ਹੈ",
        "ps": "د قرآن سکریپټ اصلاح کول",
        "pt": "Otimizando o Roteiro do Alcorão",
        "ru": "Оптимизация сценария Корана",
        "so": "Hagaajinta Qoraalka Qur'aanka",
        "sw": "Inaboresha Hati ya Kurani",
        "ta": "குர்ஆன் ஸ்கிரிப்டை மேம்படுத்துகிறது",
        "tr": "Kuran Metnini Optimize Etme",
        "ug": "قۇرئان قوليازمىسىنى ئەلالاشتۇرۇش",
        "ur": "قرآن اسکرپٹ کو بہتر بنانا",
        "vi": "Tối ưu hóa kịch bản Kinh Qur'an",
        "yo": "Iṣapejuwe Iwe afọwọkọ Al-Qur’an",
        "zh": "优化古兰经脚本"
    },
    "noon": {
        "am": "ቀትር", "ar": "الظهر", "az": "Günorta", "bn": "দুপুর", "de": "Mittag", "es": "Mediodía", "fa": "ظهر", "fr": "Midi", "ha": "Rana", "hi": "दोपहर", "id": "Siang", "it": "Mezzogiorno", "ja": "正午", "kk": "Тал түс", "ko": "정오", "ku": "Nîvro", "ms": "Tengah hari", "pa": "ਦੁਪਹਿਰ", "ps": "ماسپښین", "pt": "Meio-dia", "ru": "Полдень", "so": "Duhur", "sw": "Adhuhuri", "ta": "நண்பகல்", "tr": "Öğle", "ug": "چۈش", "ur": "دوپہر", "vi": "Trưa", "yo": "Ọsán", "zh": "中午"
    },
    "sunset": {
        "am": "የፀሐይat መጥለቅ", "ar": "الغروب", "az": "Gün batımı", "bn": "সূর্যাস্ত", "de": "Sonnenuntergang", "es": "Atardecer", "fa": "غروب", "fr": "Coucher du soleil", "ha": "Faɗuwar rana", "hi": "सूर्यास्त", "id": "Terbenam Matahari", "it": "Tramonto", "ja": "日没", "kk": "Күн батуы", "ko": "일몰", "ku": "Roava", "ms": "Matahari terbenam", "pa": "ਸੂਰਜ ਡੁੱਬਣਾ", "ps": "لمر لوېدل", "pt": "Pôr do sol", "ru": "Закат", "so": "Qorrax dhaca", "sw": "Machweo", "ta": "சூரிய அஸ்தமனம்", "tr": "Gün batımı", "ug": "كۈن پېتىش", "ur": "غروب آفتاب", "vi": "Hoàng hôn", "yo": "Ìwọ̀ Oòrùn", "zh": "日落"
    },
    "forbiddenSalatTimes": {
        "am": "የተከለከሉ የሶላት ጊዜያት", "ar": "أوقات الصلاة المنهي عنها", "az": "Qadağan olunmuş namaz vaxtları", "bn": "নিষিদ্ধ নামাজের সময়", "de": "Verbotene Gebetszeiten", "es": "Horarios de oración prohibidos", "fa": "اوقات مکروه نماز", "fr": "Heures de prière interdites", "ha": "Lokutan Sallah da aka haramta", "hi": "वर्जित नमाज का समय", "id": "Waktu Shalat Terlarang", "it": "Orari di preghiera proibiti", "ja": "禁止された祈りの時間", "kk": "Тыйым салынған намаз уақыттары", "ko": "금지된 기도 시간", "ku": "Demên nimêjê yên qedexe", "ms": "Waktu Solat Dilarang", "pa": "ਮਨਾਹੀ ਵਾਲੇ ਨਮਾਜ਼ ਦੇ ਸਮੇਂ", "ps": "د لمونځ منع شوي وختونه", "pt": "Horários de oração proibidos", "ru": "Запрещенные времена намаза", "so": "Waqtiyada Salaadda La Mamnuucay", "sw": "Nyakati za Sala Zilizokatazwa", "ta": "தடைசெய்யப்பட்ட தொழுகை நேரங்கள்", "tr": "Kerahat Vakitleri", "ug": "چەكلەنگەن ناماز ۋاقىتلىرى", "ur": "ممنوعہ نماز کے اوقات", "vi": "Thời gian cầu nguyện bị cấm", "yo": "Awọn akoko Adura ti a ka leewọ", "zh": "禁止祈祷的时间"
    },
    "prayerTimes": {
        "am": "የሶላት ጊዜያት", "ar": "أوقات الصلاة", "az": "Namaz vaxtları", "bn": "নামাজের সময়সূচী", "de": "Gebetszeiten", "es": "Horarios de oración", "fa": "اوقات شرعی", "fr": "Horaires des prières", "ha": "Lokutan Sallah", "hi": "नमाज का समय", "id": "Waktu Shalat", "it": "Orari di preghiera", "ja": "祈りの時間", "kk": "Намаз уақыттары", "ko": "기도 시간", "ku": "Demên nimêjê", "ms": "Waktu Solat", "pa": "ਨਮਾਜ਼ ਦੇ ਸਮੇਂ", "ps": "د لمونځ وختونه", "pt": "Horários de oração", "ru": "Времена намаза", "so": "Waqtiyada Salaadda", "sw": "Nyakati za Sala", "ta": "தொழுகை நேரங்கள்", "tr": "Namaz Vakitleri", "ug": "ناماز ۋاقىتلىرى", "ur": "نماز کے اوقات", "vi": "Thời gian cầu nguyện", "yo": "Awọn akoko Adura", "zh": "祈祷时间"
    },
    "hanafi": {
        "am": "ሐናፊ", "ar": "حنفى", "az": "Hənəfi", "bn": "হানাফী", "de": "Hanafi", "es": "Hanafi", "fa": "حنفی", "fr": "Hanafi", "ha": "Hanafi", "hi": "हनफी", "id": "Hanafi", "it": "Hanafi", "ja": "ハナフィー", "kk": "Ханали", "ko": "하나피", "ku": "Hanafî", "ms": "Hanafi", "pa": "ਹਨਫੀ", "ps": "حنفي", "pt": "Hanafi", "ru": "Ханифитский", "so": "Xanafi", "sw": "Hanafi", "ta": "ஹனஃபி", "tr": "Hanefi", "ug": "ھەنەفىي", "ur": "حنفی", "vi": "Hanafi", "yo": "Hanafi", "zh": "哈纳菲"
    },
    "shafie": {
        "am": "ሻፊኢ", "ar": "شافعى", "az": "Şafii", "bn": "শাফেয়ী", "de": "Shafi'i", "es": "Shafi'i", "fa": "شافعی", "fr": "Shafi'i", "ha": "Shafi'i", "hi": "शफी", "id": "Syafi'i", "it": "Shafi'i", "ja": "シャーフィイー", "kk": "Шафиғи", "ko": "샤피이", "ku": "Şafiî", "ms": "Syafi'i", "pa": "ਸ਼ਫਈ", "ps": "شافعي", "pt": "Shafi'i", "ru": "Шафиитский", "so": "Shaafici", "sw": "Shafi'i", "ta": "ஷாஃபி", "tr": "Şafii", "ug": "شافىئىي", "ur": "شافعی", "vi": "Shafi'i", "yo": "Shafi'i", "zh": "沙斐仪"
    },
    "suhurEnd": {
        "am": "የሱሁር መጨረሻ", "ar": "نهاية السحور", "az": "Səhər yeməyinin bitməsi", "bn": "সেহরির শেষ", "de": "Suhur Ende", "es": "Fin de Suhur", "fa": "پایان سحری", "fr": "Fin du Suhur", "ha": "Karshen Sahur", "hi": "सुहुर समाप्ति", "id": "Akhir Sahur", "it": "Fine Suhur", "ja": "スフールの終わり", "kk": "Сәресінің аяқталуы", "ko": "수후르 종료", "ku": "Dawiya Paşîvê", "ms": "Tamat Sahur", "pa": "ਸੁਹੁਰ ਸਮਾਪਤੀ", "ps": "د سحری پای", "pt": "Fim do Suhur", "ru": "Конец Сухура", "so": "Dhamaadka Saxuurta", "sw": "Mwisho wa Suhur", "ta": "சஹர் முடிவு", "tr": "Sahur Bitişi", "ug": "سەھەرلىك ئاخىرلىشىشى", "ur": "سحری کا اختتام", "vi": "Kết thúc Suhur", "yo": "Ipari Suhur", "zh": "封斋时间"
    },
    "iftarStart": {
        "am": "የኢፍጣር መጀመሪያ", "ar": "بداية الإفطار", "az": "İftar başlanğıcı", "bn": "ইফতার শুরু", "de": "Iftar Start", "es": "Inicio de Iftar", "fa": "آغاز افطار", "fr": "Début de l'Iftar", "ha": "Farkon Bude Baki", "hi": "इफ्तार शुरू", "id": "Mulai Iftar", "it": "Inizio Iftar", "ja": "イフタールの始まり", "kk": "Ауызашардың басталуы", "ko": "이프타르 시작", "ku": "Destpêka Fitara", "ms": "Mula Iftar", "pa": "ਇਫਤਾਰ ਸ਼ੁਰੂ", "ps": "د افطار پیل", "pt": "Início do Iftar", "ru": "Начало Ифтара", "so": "Bilaabidda Afurka", "sw": "Mwanzo wa Iftar", "ta": "இப்தார் ஆரம்பம்", "tr": "İftar Vakti", "ug": "ئىپتار باشلىنىشى", "ur": "افطار کا وقت", "vi": "Bắt đầu Iftar", "yo": "Ibẹrẹ Iftar", "zh": "开斋时间"
    },
    "tahajjudStart": {
        "am": "የተሃጁድ መጀመሪያ", "ar": "بداية التهجد", "az": "Təhəccüd başlanğıcı", "bn": "তাহাজ্জুদ শুরু", "de": "Tahajjud Start", "es": "Inicio de Tahajjud", "fa": "آغاز تهجد", "fr": "Début du Tahajjud", "ha": "Farkon Tahajjud", "hi": "तहज्जुद शुरू", "id": "Mulai Tahajjud", "it": "Inizio Tahajjud", "ja": "タハッジュドの始まり", "kk": "Тәһәжүдтің басталуы", "ko": "타하주드 시작", "ku": "Destpêka Teheccûdê", "ms": "Mula Tahajjud", "pa": "ਤਹਜੁਦ ਸ਼ੁਰੂ", "ps": "د تهجد پیل", "pt": "Início do Tahajjud", "ru": "Начало Тахаджуда", "so": "Bilaabidda Tahajjudka", "sw": "Mwanzo wa Tahajjud", "ta": "தஹஜ்ஜுத் ஆரம்பம்", "tr": "Teheccüd Başlangıcı", "ug": "تەھەججۇد باشلىنىشى", "ur": "تہجد کی شروعات", "vi": "Bắt đầu Tahajjud", "yo": "Ibẹrẹ Tahajjud", "zh": "夜间祷告开始"
    },
    "tahajjud": {
        "am": "ተሃጁድ", "ar": "التهجد", "az": "Təhəccüd", "bn": "তাহাজ্জুদ", "de": "Tahajjud", "es": "Tahajjud", "fa": "تهجد", "fr": "Tahajjud", "ha": "Tahajjud", "hi": "तहज्जुद", "id": "Tahajjud", "it": "Tahajjud", "ja": "タハッジュド", "kk": "Тәһәжүд", "ko": "타하주드", "ku": "Teheccûd", "ms": "Tahajjud", "pa": "ਤਹਜੁਦ", "ps": "تهجد", "pt": "Tahajjud", "ru": "Тахаджуд", "so": "Tahajjud", "sw": "Tahajjud", "ta": "தஹஜ்ஜுத்", "tr": "Teheccüd", "ug": "تەھەججۇد", "ur": "تہجد", "vi": "Tahajjud", "yo": "Tahajjud", "zh": "夜间祷告"
    },
    "dhuha": {
        "am": "ዱሃ", "ar": "الضحى", "az": "Duha", "bn": "চাশত", "de": "Dhuha", "es": "Dhuha", "fa": "ضحی", "fr": "Dhuha", "ha": "Walaha", "hi": "दुहा", "id": "Dhuha", "it": "Dhuha", "ja": "ドゥハー", "kk": "Духа", "ko": "두하", "ku": "Duha", "ms": "Dhuha", "pa": "ਚਾਸ਼ਤ", "ps": "ضحى", "pt": "Dhuha", "ru": "Духа", "so": "Barqo", "sw": "Dhuha", "ta": "லுஹா", "tr": "Kuşluk", "ug": "دۇھا", "ur": "چاشت", "vi": "Dhuha", "yo": "Dhuha", "zh": "杜哈"
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
                        print(f"Key already exists in {file_path}")

print("Localization update complete.")