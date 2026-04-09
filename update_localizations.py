import json
import os

translations = {
    "indopakFont": {
        "ar": "الخط الهندوسي الباكستاني", "az": "İndopak Şrifti", "bn": "ইন্দোপাক ফন্ট", "de": "Indopak-Schriftart", "es": "Fuente Indopak", "fa": "قلم هندپاک", "fr": "Police Indopak", "hi": "इंडोपाक फ़ॉन्ट", "id": "Font Indopak", "it": "Carattere Indopak", "ja": "インドパック・フォント", "kk": "Индопак шрифті", "ko": "인도팩 글꼴", "ms": "Fon Indopak", "pa": "ਇੰਡੋਪਾਕ ਫੋਂਟ", "ps": "هندپاک فونټ", "pt": "Fonte Indopak", "ru": "Шрифт Индопак", "sw": "Fonti ya Indopak", "ta": "இந்தோபாக் எழுத்துரு", "tr": "İndopak Yazı Tipi", "ur": "انڈو پاک فونٹ", "vi": "Phông chữ Indopak", "zh": "印巴字体"
    },
    "uthmaniFont": {
        "ar": "الخط العثماني", "az": "Osmani Şrifti", "bn": "উসমানী ফন্ট", "de": "Uthmani-Schriftart", "es": "Fuente Uzmaní", "fa": "قلم عثمانی", "fr": "Police Uthmani", "hi": "उस्मानी फ़ॉन्ट", "id": "Font Utsmani", "it": "Carattere Uthmani", "ja": "ウスマニ・フォント", "kk": "Осман шрифті", "ko": "우스마니 글꼴", "ms": "Fon Uthmani", "pa": "ਉਸਮਾਨੀ ਫੋਂਟ", "ps": "عثماني فونټ", "pt": "Fonte Uthmani", "ru": "Шрифт Усмани", "sw": "Fonti ya Uthmani", "ta": "உஸ்மானி எழுத்துரு", "tr": "Osmani Yazı Tipi", "ur": "عثمانی فونٹ", "vi": "Phông chữ Uthmani", "zh": "奥斯曼字体"
    },
    "close": {
        "ar": "إغلاق", "az": "Bağla", "bn": "বন্ধ করুন", "de": "Schließen", "es": "Cerrar", "fa": "بستن", "fr": "Fermer", "hi": "बंद करें", "id": "Tutup", "it": "Chiudi", "ja": "閉じる", "kk": "Жабу", "ko": "닫기", "ms": "Tutup", "pa": "ਬੰਦ ਕਰੋ", "ps": "بندول", "pt": "Fechar", "ru": "Закрыть", "sw": "Funga", "ta": "மூடு", "tr": "Kapat", "ur": "بند کریں", "vi": "Đóng", "zh": "关闭"
    },
    "goToSettings": {
        "ar": "اذهب إلى الإعدادات", "az": "Ayarlara get", "bn": "সেটিংসে যান", "de": "Zu den Einstellungen", "es": "Ir a ajustes", "fa": "رفتن به تنظیمات", "fr": "Aller aux paramètres", "hi": "सेटिंग्स में जाएं", "id": "Buka Pengaturan", "it": "Vai alle impostazioni", "ja": "設定へ移動", "kk": "Параметрлерге өту", "ko": "설정으로 이동", "ms": "Pergi ke Tetapan", "pa": "ਸੈਟਿੰਗਾਂ 'ਤੇ ਜਾਓ", "ps": "تنظیماتو ته لاړ شئ", "pt": "Ir para configurações", "ru": "Перейти в настройки", "sw": "Nenda kwenye Mipangilio", "ta": "அமைப்புகளுக்குச் செல்லவும்", "tr": "Ayarlara Git", "ur": "ترتیبات پر جائیں", "vi": "Đi tới cài đặt", "zh": "前往设置"
    },
    "scriptSettingsUpdated": {
        "ar": "تم تحديث إعدادات الخط", "az": "Mətn ayarları yeniləndi", "bn": "স্ক্রিপ্ট সেটিংস আপডেট করা হয়েছে", "de": "Skript-Einstellungen aktualisiert", "es": "Ajustes de script actualizados", "fa": "تنظیمات رسم‌الخط به‌روز شد", "fr": "Paramètres du script mis à jour", "hi": "लिपि सेटिंग्स अपडेट की गईं", "id": "Pengaturan Skrip Diperbarui", "it": "Impostazioni dello script aggiornate", "ja": "スクリプト設定が更新されました", "kk": "Мәтін параметрлері жаңартылды", "ko": "스크립트 설정이 업데이트되었습니다", "ms": "Tetapan Skrip Dikemas Kini", "pa": "ਸਕ੍ਰਿਪਟ ਸੈਟਿੰਗਾਂ ਅਪਡੇਟ ਕੀਤੀਆਂ ਗਈਆਂ", "ps": "د ليکني تنظیمات تازه شول", "pt": "Configurações de script atualizadas", "ru": "Настройки скрипта обновлены", "sw": "Mipangilio ya Maandishi Imesasishwa", "ta": "ஸ்கிரிப்ட் அமைப்புகள் புதுப்பிக்கப்பட்டன", "tr": "Yazı Ayarları Güncellendi", "ur": "رسم الخط کی ترتیبات اپ ڈیٹ ہو گئیں", "vi": "Đã cập nhật cài đặt tập lệnh", "zh": "脚本设置已更新"
    },
    "scriptSettingsUpdatedDescription": {
        "ar": "لقد قمنا بتبسيط خيارات الخط وأضفنا المزيد من الخطوط.", "az": "Mətn seçimlərimizi sadələşdirdik və daha çox şrift əlavə etdik.", "bn": "আমরা আমাদের স্ক্রিপ্ট অপশনগুলো সহজ করেছি এবং আরও ফন্ট যোগ করেছি।", "de": "Wir haben unsere Skriptoptionen vereinfacht und weitere Schriftarten hinzugefügt.", "es": "Hemos simplificado nuestras opciones de script y añadido más fuentes.", "fa": "ما گزینه‌های رسم‌الخط را ساده‌تر کرده و قلم‌های بیشتری اضافه کرده‌ایم.", "fr": "Nous avons simplifié nos options de script et ajouté plus de polices.", "hi": "हमने अपनी लिपि विकल्पों को सरल बना दिया है और अधिक फ़ॉन्ट जोड़े हैं।", "id": "Kami telah menyederhanakan opsi skrip dan menambahkan lebih banyak font.", "it": "Abbiamo semplificato le nostre opzioni di script e aggiunto altri caratteri.", "ja": "スクリプトのオプションを簡素化し、さらにフォントを追加しました。", "kk": "Мәтін опцияларын жеңілдетіп, көбірек шрифт қостық.", "ko": "스크립트 옵션을 단순화하고 더 많은 글꼴을 추가했습니다.", "ms": "Kami telah memudahkan pilihan skrip kami dan menambah lebih banyak fon.", "pa": "ਅਸੀਂ ਆਪਣੇ ਸਕ੍ਰਿਪਟ ਵਿਕਲਪਾਂ ਨੂੰ ਸਰਲ ਬਣਾਇਆ ਹੈ ਅਤੇ ਹੋਰ ਫੋਂਟ ਸ਼ਾਮਲ ਕੀਤੇ ਹਨ।", "ps": "موږ د ليکني انتخابونه ساده کړي او نور فونټونه مو اضافه کړي دي.", "pt": "Simplificamos nossas opções de script e adicionamos mais fontes.", "ru": "Мы упростили параметры скрипта и добавили новые шрифты.", "sw": "Tumerahisisha chaguzi zetu za maandishi na kuongeza fonti zaidi.", "ta": "நாங்கள் ஸ்கிரிப்ட் விருப்பங்களை எளிதாக்கியுள்ளோம் மற்றும் கூடுதல் எழுத்துருக்களைச் சேர்த்துள்ளோம்.", "tr": "Yazı seçeneklerimizi basitleştirdik ve daha fazla yazı tipi ekledik.", "ur": "ہم نے اپنے رسم الخط کے اختیارات کو سادہ بنا دیا ہے اور مزید فونٹس شامل کیے ہیں۔", "vi": "Chúng tôi đã đơn giản hóa các tùy chọn tập lệnh và thêm nhiều phông chữ hơn.", "zh": "我们简化了脚本选项并添加了更多字体。"
    },
    "enterPageNumber": {
        "ar": "أدخل رقم الصفحة بين 1 و 604", "az": "1 ilə 604 arasında bir səhifə nömrəsi daxil edin", "bn": "১ থেকে ৬০৪ এর মধ্যে একটি পৃষ্ঠা নম্বর লিখুন", "de": "Geben Sie eine Seitenzahl zwischen 1 und 604 ein", "es": "Introduce un número de página entre 1 y 604", "fa": "شماره صفحه‌ای بین ۱ تا ۶۰۴ وارد کنید", "fr": "Entrez un numéro de page entre 1 et 604", "hi": "1 से 604 के बीच एक पृष्ठ संख्या दर्ज करें", "id": "Masukkan nomor halaman antara 1 dan 604", "it": "Inserisci un numero di pagina tra 1 e 604", "ja": "1から604までのページ番号を入力してください", "kk": "1 мен 604 арасындағы бет нөмірін енгізіңіз", "ko": "1에서 604 사이의 페이지 번호를 입력하세요", "ms": "Masukkan nombor halaman antara 1 hingga 604", "pa": "1 ਤੋਂ 604 ਦੇ ਵਿਚਕਾਰ ਇੱਕ ਪੰਨਾ ਨੰਬਰ ਦਰਜ ਕਰੋ", "ps": "د ۱ او ۶۰۴ ترمنځ د پاڼې شمېره داخله کړئ", "pt": "Insira um número de página entre 1 e 604", "ru": "Введите номер страницы от 1 до 604", "sw": "Ingiza namba ya ukurasa kati ya 1 na 604", "ta": "1 முதல் 604 வரையிலான பக்க எண்ணை உள்ளிடவும்", "tr": "1 ile 604 arasında bir sayfa numarası girin", "ur": "1 سے 604 کے درمیان صفحہ نمبر درج کریں", "vi": "Nhập số trang từ 1 đến 604", "zh": "输入 1 到 604 之间的页码"
    },
    "deleteMushafData": {
        "ar": "حذف بيانات المصحف", "az": "Müshaf məlumatlarını sil", "bn": "মুসহাফ ডাটা মুছে ফেলুন", "de": "Mushaf-Daten löschen", "es": "Eliminar datos del Mushaf", "fa": "حذف داده‌های مصحف", "fr": "Supprimer les données du Mushaf", "hi": "मुसहाफ डेटा हटाएं", "id": "Hapus Data Mushaf", "it": "Elimina dati Mushaf", "ja": "ムスハフのデータを削除する", "kk": "Мұсхаф деректерін жою", "ko": "무사프 데이터 삭제", "ms": "Padam Data Mushaf", "pa": "ਮੁਸਹਾਫ ਡੇਟਾ ਮਿਟਾਓ", "ps": "د مصحف ډیټا حذف کړئ", "pt": "Excluir dados do Mushaf", "ru": "Удалить данные Мусхафа", "sw": "Futa Data ya Mushaf", "ta": "முஸ்ஹாஃப் தரவை நீக்கு", "tr": "Mushaf Verilerini Sil", "ur": "مصحف کا ڈیٹا حذف کریں", "vi": "Xóa dữ liệu Mushaf", "zh": "删除 Mushaf 数据"
    },
    "deleteMushafDataDescription": {
        "ar": "هل أنت متأكد أنك تريد حذف جميع بيانات المصحف؟", "az": "Bütün Müshaf məlumatlarını silmək istədiyinizə əminsiniz?", "bn": "আপনি কি নিশ্চিত যে আপনি সমস্ত মুসহাফ ডাটা মুছে ফেলতে চান?", "de": "Sind Sie sicher, dass Sie alle Mushaf-Daten löschen möchten?", "es": "¿Estás seguro de que quieres eliminar todos los datos del Mushaf?", "fa": "آیا مطمئن هستید که می‌خواهید تمام داده‌های مصحف را حذف کنید؟", "fr": "Êtes-vous sûr de vouloir supprimer toutes les données du Mushaf ?", "hi": "क्या आप वाकई सभी मुसहाफ डेटा को हटाना चाहते हैं?", "id": "Apakah Anda yakin ingin menghapus semua data Mushaf?", "it": "Sei sicuro di voler eliminare tutti i dati del Mushaf?", "ja": "ムスハフの全データを削除してもよろしいですか？", "kk": "Барлық Мұсхаф деректерін жоюды қалайтыныңызға сенімдісіз бе?", "ko": "모든 무사프 데이터를 삭제하시겠습니까?", "ms": "Adakah anda pasti mahu memadam semua data Mushaf?", "pa": "ਕੀ ਤੁਸੀਂ ਯਕੀਨੀ ਤੌਰ 'ਤੇ ਸਾਰਾ ਮੁਸਹਾਫ ਡੇਟਾ ਮਿਟਾਉਣਾ ਚਾਹੁੰਦੇ ਹੋ?", "ps": "ایا تاسو ډاډه یاست چې غواړئ د مصحف ټول معلومات حذف کړئ؟", "pt": "Tem certeza de que deseja excluir todos os dados do Mushaf?", "ru": "Вы уверены, что хотите удалить все данные Мусхафа?", "sw": "Una uhakika unataka kufuta data zote za Mushaf?", "ta": "அனைத்து முஸ்ஹாஃப் தரவையும் நீக்க விரும்புகிறீர்களா?", "tr": "Tüm Mushaf verilerini silmek istediğinizden emin misiniz?", "ur": "کیا آپ واقعی مصحف کا تمام ڈیٹا حذف کرنا چاہتے ہیں؟", "vi": "Bạn có chắc chắn muốn xóa tất cả dữ liệu Mushaf không?", "zh": "您确定要删除所有 Mushaf 数据吗？"
    },
    "invalidPage": {
        "ar": "صفحة غير صالحة (1-604)", "az": "Yanlış səhifə (1-604)", "bn": "অকার্যকর পৃষ্ঠা (১-৬০৪)", "de": "Ungültige Seite (1-604)", "es": "Página no válida (1-604)", "fa": "صفحه نامعتبر (۱-۶۰۴)", "fr": "Page invalide (1-604)", "hi": "अमान्य पृष्ठ (1-604)", "id": "Halaman tidak valid (1-604)", "it": "Pagina non valida (1-604)", "ja": "無効なページ（1-604）", "kk": "Бет қате (1-604)", "ko": "잘못된 페이지 (1-604)", "ms": "Halaman tidak sah (1-604)", "pa": "ਅਵੈਧ ਪੰਨਾ (1-604)", "ps": "نامعتبره پاڼه (۱-۶۰۴)", "pt": "Página inválida (1-604)", "ru": "Неверная страница (1-604)", "sw": "Ukurasa batili (1-604)", "ta": "தவறான பக்கம் (1-604)", "tr": "Geçersiz sayfa (1-604)", "ur": "غلط صفحہ (1-604)", "vi": "Trang không hợp lệ (1-604)", "zh": "无效页码 (1-604)"
    },
    "goToPage": {
        "ar": "ذهاب إلى الصفحة", "az": "Səhifəyə get", "bn": "পৃষ্ঠায় যান", "de": "Gehe zu Seite", "es": "Ir a la página", "fa": "رفتن به صفحه", "fr": "Aller à la page", "hi": "पृष्ठ पर जाएं", "id": "Buka Halaman", "it": "Vai alla pagina", "ja": "ページへ移動", "kk": "Бетке өту", "ko": "페이지로 이동", "ms": "Pergi ke Halaman", "pa": "ਪੰਨੇ 'ਤੇ ਜਾਓ", "ps": "پاڼې ته لاړ شئ", "pt": "Ir para a página", "ru": "Перейти на страницу", "sw": "Nenda kwenye Ukurasa", "ta": "பக்கத்திற்குச் செல்லவும்", "tr": "Sayfaya Git", "ur": "صفحہ پر جائیں", "vi": "Đi tới trang", "zh": "前往页面"
    },
    "resources": {
        "ar": "الموارد", "az": "Resurslar", "bn": "রিসোর্স", "de": "Ressourcen", "es": "Recursos", "fa": "منابع", "fr": "Ressources", "hi": "संसाधन", "id": "Sumber Daya", "it": "Risorse", "ja": "リソース", "kk": "Ресурстар", "ko": "리소스", "ms": "Sumber", "pa": "ਸਰੋਤ", "ps": "سرچینې", "pt": "Recursos", "ru": "Ресурсы", "sw": "Rasilimali", "ta": "ஆதாரங்கள்", "tr": "Kaynaklar", "ur": "وسائل", "vi": "Tài nguyên", "zh": "资源"
    },
    "mushaf": {
        "ar": "مصحف", "az": "Müshaf", "bn": "মুসহাফ", "de": "Mushaf", "es": "Mushaf", "fa": "مصحف", "fr": "Mushaf", "hi": "मुसहाफ", "id": "Mushaf", "it": "Mushaf", "ja": "ムスハフ", "kk": "Мұсхаф", "ko": "무사프", "ms": "Mushaf", "pa": "ਮੁਸਹਾਫ", "ps": "مصحف", "pt": "Mushaf", "ru": "Мусхаф", "sw": "Mushaf", "ta": "முஸ்ஹாஃப்", "tr": "Mushaf", "ur": "مصحف", "vi": "Mushaf", "zh": "麦斯哈夫"
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