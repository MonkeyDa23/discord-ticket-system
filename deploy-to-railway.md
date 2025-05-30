# نشر المشروع على Railway مباشرة من Replit

## الطريقة السريعة:

### 1. اتصل بـ Railway من Replit
```bash
# في terminal Replit، نفذ هذا الأمر:
npx @railway/cli login
```

### 2. إنشاء مشروع Railway جديد
```bash
npx @railway/cli project create
```

### 3. نشر المشروع
```bash
npx @railway/cli up
```

### 4. إضافة قاعدة البيانات
```bash
npx @railway/cli add postgresql
```

### 5. إعداد المتغيرات
```bash
npx @railway/cli variables set NODE_ENV=production
npx @railway/cli variables set SESSION_SECRET=MySecretKey123456789012345678901234567890
```

## أو الطريقة اليدوية:

### خطوة 1: نسخ كود المشروع
1. حدد جميع الملفات في Replit
2. انسخ المحتوى
3. اذهب إلى GitHub.com
4. أنشئ repository جديد: `discord-ticket-system`
5. الصق الملفات

### خطوة 2: ربط Railway بـ GitHub
1. اذهب إلى railway.app
2. سجل دخول بـ GitHub
3. "New Project" > "Deploy from GitHub"
4. اختر المشروع

### الرابط النهائي سيكون:
```
https://discord-ticket-system-production.railway.app
```

## إعدادات Railway المطلوبة:

```env
NODE_ENV=production
SESSION_SECRET=أي_مفتاح_عشوائي_32_حرف_أو_أكثر
```

## المنافذ:
- Railway سيوجه تلقائياً للمنفذ 5000
- التطبيق سيعمل على HTTPS تلقائياً

سيكون لديك نظام كامل مع:
- لوحة تحكم عربية احترافية
- نظام تذاكر متكامل
- قاعدة بيانات PostgreSQL
- رابط دائم وآمن