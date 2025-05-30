# Dockerfile لنشر نظام إدارة التذاكر
FROM node:20-alpine

WORKDIR /app

# نسخ ملفات المشروع
COPY package*.json ./
RUN npm install

COPY . .

# بناء المشروع
RUN npm run build

# تعريف المنفذ
EXPOSE 5000

# تشغيل الخادم
CMD ["npm", "start"]