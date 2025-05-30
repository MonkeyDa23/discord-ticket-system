# دليل النشر الخارجي لنظام إدارة التذاكر

## خيارات النشر المتاحة:

### 1. Railway (الأسرع والأسهل)
```bash
# خطوات النشر على Railway:
1. اذهب إلى railway.app
2. ربط GitHub repo
3. إضافة PostgreSQL database
4. تعيين متغيرات البيئة
```

### 2. DigitalOcean App Platform
```bash
# نشر آمن مع إعدادات متقدمة
1. إنشاء App في DigitalOcean
2. ربط المشروع من GitHub
3. إضافة Managed Database
4. تكوين Domain مخصص
```

### 3. Render
```bash
# استضافة مجانية مع قاعدة بيانات
1. ربط repo في render.com
2. إضافة PostgreSQL service
3. تعيين environment variables
```

## متغيرات البيئة المطلوبة:
```
DATABASE_URL=postgresql://...
DISCORD_BOT_TOKEN=your_bot_token
DISCORD_CHANNEL_ID=channel_id
DISCORD_GUILD_ID=guild_id
SENDGRID_API_KEY=sg_key (اختياري)
NODE_ENV=production
```

## أمان الرابط:
- كل الخدمات تعطي HTTPS تلقائياً
- يمكن إضافة custom domain
- متغيرات البيئة مشفرة
- لا يظهر اسم الخدمة في الرابط مع custom domain

## الخطوة التالية:
اختر الخدمة المفضلة وسأساعدك في الإعداد التفصيلي.