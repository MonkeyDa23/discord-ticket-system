# نظام إدارة تذاكر Discord الاحترافي

نظام شامل لإدارة تذاكر Discord مع لوحة تحكم ويب باللغة العربية، مبني بـ TypeScript و Express و React و PostgreSQL.

## المميزات الرئيسية

- **دعم متعدد السيرفرات**: إدارة التذاكر عبر عدة سيرفرات Discord
- **توجيه التذاكر المتقدم**: توجيه التذاكر لسيرفرات محددة حسب الفئة
- **لوحة تحكم ويب**: واجهة عربية شاملة لإدارة التذاكر
- **نظام المصادقة**: نظام موافقة المدراء مع تكامل Discord
- **حماية CAPTCHA**: حماية من السبام عند إنشاء التذاكر
- **مراقبة فورية**: تتبع محادثات التذاكر ونشاط النظام
- **نظام الصلاحيات**: تحكم بالوصول حسب الأدوار
- **تكامل قاعدة البيانات**: PostgreSQL لحفظ البيانات بشكل موثوق

## دليل النشر السريع على Railway

### الخطوة 1: تحضير GitHub
1. اذهب إلى github.com وسجل دخولك
2. انقر "New repository"
3. اسم المستودع: `discord-ticket-system`
4. اجعله Public
5. انقر "Create repository"

### الخطوة 2: رفع الملفات
1. حمل جميع ملفات المشروع من Replit
2. في GitHub، انقر "uploading an existing file"
3. اسحب جميع الملفات
4. انقر "Commit changes"

### الخطوة 3: النشر على Railway
1. اذهب إلى railway.app
2. سجل بـ GitHub
3. انقر "New Project"
4. اختر "Deploy from GitHub repo"
5. اختر `discord-ticket-system`
6. انتظر انتهاء النشر (3-5 دقائق)

### الخطوة 4: إضافة قاعدة البيانات
1. في نفس مشروع Railway
2. انقر "New Service"
3. اختر "Database" > "PostgreSQL"
4. Railway سينشئ قاعدة البيانات تلقائياً

### الخطوة 5: إعداد المتغيرات
1. انقر على خدمة التطبيق (ليس قاعدة البيانات)
2. اذهب لقسم "Variables"
3. أضف هذه المتغيرات:

```env
NODE_ENV=production
SESSION_SECRET=أي_نص_عشوائي_طويل_هنا_32_حرف_على_الأقل
```

### النتيجة النهائية
ستحصل على رابط مثل:
```
https://your-project-production-abc123.railway.app
```

## الدخول للنظام

### حساب المدير الافتراضي:
- اسم المستخدم: `admin`
- كلمة المرور: `admin123`

### الوصول للوحة التحكم:
```
https://your-railway-link.railway.app/
```

## إعداد Discord Bot (اختياري)

### إنشاء Discord Application:
1. اذهب إلى: https://discord.com/developers/applications
2. انقر "New Application"
3. أدخل اسم التطبيق
4. انقر "Create"

### إنشاء Bot:
1. من القائمة الجانبية، انقر "Bot"
2. انقر "Add Bot"
3. انسخ "Bot Token"
4. فعّل "MESSAGE CONTENT INTENT"

### دعوة البوت:
1. انتقل إلى "OAuth2" > "URL Generator"
2. في Scopes اختر "bot"
3. في Bot Permissions اختر:
   - Send Messages
   - Read Message History
   - Use Slash Commands
   - Manage Channels
4. انسخ الرابط وافتحه لدعوة البوت

### إضافة مفاتيح Discord في Railway:
```env
DISCORD_BOT_TOKEN=your_bot_token_here
DISCORD_CHANNEL_ID=your_channel_id_here
DISCORD_GUILD_ID=your_guild_id_here
```

## المميزات الأمنية

- مصادقة جلسات آمنة
- تشفير كلمات المرور
- حماية من CSRF
- التحقق من صحة المدخلات
- تحديد معدل الطلبات
- استعلامات قاعدة بيانات محمية

## أوامر Discord Bot

عند تفعيل تكامل Discord:

- `/setup` - تهيئة نظام التذاكر في قناة
- `/close` - إغلاق تذكرة
- `/stats` - عرض إحصائيات النظام
- أوامر المدراء مع ردود مخفية (أعلام `-r` و `-a`)

## API الرئيسية

### المصادقة
- `POST /api/auth/login` - تسجيل الدخول
- `POST /api/auth/register` - تسجيل جديد
- `POST /api/auth/logout` - تسجيل الخروج

### التذاكر
- `GET /api/tickets` - عرض جميع التذاكر
- `POST /api/tickets` - إنشاء تذكرة جديدة
- `GET /api/tickets/:id` - تفاصيل تذكرة
- `PUT /api/tickets/:id` - تحديث تذكرة
- `DELETE /api/tickets/:id` - حذف تذكرة

### الإدارة
- `GET /api/admin/stats` - إحصائيات النظام
- `GET /api/admin/users` - إدارة المستخدمين
- `POST /api/admin/settings` - تحديث الإعدادات

## بنية قاعدة البيانات

النظام يستخدم PostgreSQL مع الجداول الرئيسية:
- `users` - حسابات المستخدمين والمصادقة
- `tickets` - سجلات تذاكر الدعم
- `reviews` - تقييمات العملاء
- `bot_settings` - إعدادات التكوين
- `activities` - سجلات نشاط النظام

## المتطلبات التقنية

- Node.js 20+
- PostgreSQL
- Discord Bot Token (اختياري)
- SendGrid API Key (اختياري)

## الدعم التقني

للدعم والأسئلة، يرجى فتح تذكرة في المستودع.