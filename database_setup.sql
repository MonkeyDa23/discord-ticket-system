-- إنشاء قاعدة بيانات نظام التذاكر المتكامل
CREATE DATABASE IF NOT EXISTS ticket_system CHARACTER SET utf8mb4 COLLATE utf8mb4_unicode_ci;
USE ticket_system;

-- جدول المستخدمين والحسابات مع نظام الموافقة
CREATE TABLE users (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    discord_id VARCHAR(50),
    phone VARCHAR(20),
    reason_for_access TEXT NOT NULL,
    account_status ENUM('pending', 'approved', 'rejected', 'suspended') DEFAULT 'pending',
    user_role ENUM('admin', 'user') DEFAULT 'user',
    approved_by VARCHAR(50),
    approved_at TIMESTAMP NULL,
    rejection_reason TEXT,
    last_login TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- جدول طلبات إنشاء الحسابات
CREATE TABLE account_requests (
    id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255) NOT NULL,
    full_name VARCHAR(100) NOT NULL,
    discord_id VARCHAR(50),
    phone VARCHAR(20),
    reason_for_access TEXT NOT NULL,
    requested_role ENUM('admin', 'user') DEFAULT 'user',
    request_status ENUM('pending', 'approved', 'rejected') DEFAULT 'pending',
    discord_message_id VARCHAR(50),
    admin_notes TEXT,
    processed_by VARCHAR(50),
    processed_at TIMESTAMP NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- جدول التذاكر المتقدم
CREATE TABLE tickets (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id VARCHAR(20) NOT NULL UNIQUE,
    user_id VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL,
    email VARCHAR(255),
    subject VARCHAR(255) NOT NULL,
    description TEXT NOT NULL,
    status ENUM('open', 'in_progress', 'waiting', 'closed') DEFAULT 'open',
    priority ENUM('low', 'medium', 'high', 'urgent') DEFAULT 'medium',
    assigned_to VARCHAR(50),
    category_id INT,
    server_id VARCHAR(50),
    channel_id VARCHAR(50),
    dm_channel_id VARCHAR(50),
    user_roles JSON,
    user_message_count INT DEFAULT 0,
    captcha_verified BOOLEAN DEFAULT FALSE,
    captcha_code VARCHAR(10),
    image_url TEXT,
    tags JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP,
    closed_at TIMESTAMP NULL
);

-- جدول رسائل التذاكر (للمحادثات والأرشيف)
CREATE TABLE ticket_messages (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id VARCHAR(20) NOT NULL,
    user_id VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL,
    content TEXT NOT NULL,
    is_admin_message BOOLEAN DEFAULT FALSE,
    is_hidden BOOLEAN DEFAULT FALSE,
    attachments JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    INDEX idx_ticket_id (ticket_id),
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id) ON DELETE CASCADE
);

-- جدول إعداد التذاكر (الأزرار والقوائم المنسدلة)
CREATE TABLE ticket_setup (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type ENUM('button', 'dropdown') NOT NULL,
    name VARCHAR(100) NOT NULL,
    emoji VARCHAR(10),
    description TEXT,
    image_url TEXT,
    allowed_roles JSON,
    category_id VARCHAR(50) NOT NULL,
    server_id VARCHAR(50) NOT NULL,
    user_message TEXT,
    review_channel_id VARCHAR(50),
    archive_channel_id VARCHAR(50),
    is_active BOOLEAN DEFAULT TRUE,
    order_number INT DEFAULT 0,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- جدول صلاحيات الأوامر
CREATE TABLE command_permissions (
    id INT AUTO_INCREMENT PRIMARY KEY,
    command_name VARCHAR(50) NOT NULL,
    prefix VARCHAR(5) DEFAULT '-',
    allowed_roles JSON,
    is_enabled BOOLEAN DEFAULT TRUE,
    description TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- جدول فئات التذاكر
CREATE TABLE ticket_categories (
    id INT AUTO_INCREMENT PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    emoji VARCHAR(10),
    description TEXT,
    image_url TEXT,
    allowed_roles JSON,
    category_id VARCHAR(50) NOT NULL,
    server_id VARCHAR(50) NOT NULL,
    is_active BOOLEAN DEFAULT TRUE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- جدول التقييمات
CREATE TABLE reviews (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id VARCHAR(20) NOT NULL,
    user_id VARCHAR(50) NOT NULL,
    username VARCHAR(50) NOT NULL,
    rating INT NOT NULL CHECK (rating >= 1 AND rating <= 5),
    comment TEXT,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id) ON DELETE CASCADE
);

-- جدول إعدادات البوت
CREATE TABLE bot_settings (
    id INT AUTO_INCREMENT PRIMARY KEY,
    setting_key VARCHAR(100) NOT NULL UNIQUE,
    setting_value TEXT NOT NULL,
    description TEXT,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- جدول الأنشطة
CREATE TABLE activities (
    id INT AUTO_INCREMENT PRIMARY KEY,
    type VARCHAR(50) NOT NULL,
    description TEXT NOT NULL,
    user_id VARCHAR(50),
    metadata JSON,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
);

-- جدول التحقق من الكاباتشا
CREATE TABLE captcha_verifications (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ticket_id VARCHAR(20) NOT NULL,
    code VARCHAR(10) NOT NULL,
    is_verified BOOLEAN DEFAULT FALSE,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    expires_at TIMESTAMP NOT NULL,
    FOREIGN KEY (ticket_id) REFERENCES tickets(ticket_id) ON DELETE CASCADE
);

-- إدراج البيانات الافتراضية
INSERT INTO bot_settings (setting_key, setting_value, description) VALUES
('global_prefix', '-', 'البريفكس العام لجميع الأوامر'),
('welcome_message', 'مرحباً بك في نظام التذاكر! تم إنشاء تذكرتك بنجاح.', 'رسالة الترحيب للمستخدمين'),
('close_message', 'شكراً لك! تم إغلاق تذكرتك. نتطلع لخدمتك مرة أخرى.', 'رسالة إغلاق التذكرة'),
('captcha_message', 'للمتابعة، يرجى إدخال رمز التحقق المرسل لك.', 'رسالة الكاباتشا');

INSERT INTO command_permissions (command_name, description, allowed_roles) VALUES
('r', 'الرد على التذكرة (للإداريين العاديين)', JSON_ARRAY()),
('a', 'الرد المخفي (للإداريين المخفيين)', JSON_ARRAY()),
('close', 'إغلاق التذكرة', JSON_ARRAY()),
('archive', 'أرشفة التذكرة', JSON_ARRAY()),
('captcha', 'إنشاء كود كاباتشا جديد', JSON_ARRAY()),
('ban', 'حظر المستخدم من إنشاء تذاكر', JSON_ARRAY()),
('closeall', 'إغلاق جميع التذاكر', JSON_ARRAY()),
('monitor', 'مراقبة التذكرة', JSON_ARRAY());

-- إنشاء الفهارس لتحسين الأداء
CREATE INDEX idx_tickets_status ON tickets(status);
CREATE INDEX idx_tickets_user_id ON tickets(user_id);
CREATE INDEX idx_tickets_created_at ON tickets(created_at);
CREATE INDEX idx_ticket_messages_ticket_id ON ticket_messages(ticket_id);
CREATE INDEX idx_activities_created_at ON activities(created_at);
CREATE INDEX idx_reviews_rating ON reviews(rating);

-- إنشاء مشاهدات للإحصائيات السريعة
CREATE VIEW ticket_stats AS
SELECT 
    COUNT(*) as total_tickets,
    SUM(CASE WHEN status IN ('open', 'in_progress', 'waiting') THEN 1 ELSE 0 END) as active_tickets,
    SUM(CASE WHEN status = 'closed' THEN 1 ELSE 0 END) as closed_tickets,
    AVG(CASE WHEN status = 'closed' AND closed_at IS NOT NULL 
        THEN TIMESTAMPDIFF(HOUR, created_at, closed_at) END) as avg_resolution_hours
FROM tickets;

CREATE VIEW review_stats AS
SELECT 
    COUNT(*) as total_reviews,
    AVG(rating) as average_rating,
    SUM(CASE WHEN rating = 5 THEN 1 ELSE 0 END) as five_star,
    SUM(CASE WHEN rating = 4 THEN 1 ELSE 0 END) as four_star,
    SUM(CASE WHEN rating = 3 THEN 1 ELSE 0 END) as three_star,
    SUM(CASE WHEN rating = 2 THEN 1 ELSE 0 END) as two_star,
    SUM(CASE WHEN rating = 1 THEN 1 ELSE 0 END) as one_star
FROM reviews;