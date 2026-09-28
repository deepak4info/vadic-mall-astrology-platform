-- =============================================================================
-- Vadic Mall - SQLite Database Script (NOT for SQL Server)
-- =============================================================================
-- For SQL Server use: vadicmall-sqlserver.sql
--
-- Run (SQLite only):
--   cd VadicMall/src/VadicMall.Api
--   rm -f vadicmall.db
--   sqlite3 vadicmall.db < ../../database/vadicmall.sql
--
-- Demo passwords (BCrypt in Users table):
--   admin@vadicmall.com           -> Admin@123
--   customer@vadicmall.com        -> Customer@123
--   pandit.sharma@vadicmall.com   -> Astro@123
-- =============================================================================

PRAGMA foreign_keys = OFF;

DROP TABLE IF EXISTS ProductImages;
DROP TABLE IF EXISTS Products;
DROP TABLE IF EXISTS ProductCategories;
DROP TABLE IF EXISTS AstrologerProfiles;
DROP TABLE IF EXISTS PoojaServices;
DROP TABLE IF EXISTS SubscriptionPlans;
DROP TABLE IF EXISTS Coupons;
DROP TABLE IF EXISTS BlogPosts;
DROP TABLE IF EXISTS BlogCategories;
DROP TABLE IF EXISTS Faqs;
DROP TABLE IF EXISTS Settings;
DROP TABLE IF EXISTS Users;

PRAGMA foreign_keys = ON;

-- USERS
CREATE TABLE Users (
    Id TEXT NOT NULL PRIMARY KEY,
    Email TEXT NOT NULL UNIQUE,
    Phone TEXT,
    PasswordHash TEXT NOT NULL,
    FirstName TEXT NOT NULL,
    LastName TEXT NOT NULL,
    AvatarUrl TEXT,
    Role INTEGER NOT NULL,
    EmailVerified INTEGER NOT NULL DEFAULT 0,
    PhoneVerified INTEGER NOT NULL DEFAULT 0,
    LastLoginAt TEXT,
    RefreshToken TEXT,
    RefreshTokenExpiry TEXT,
    CreatedAt TEXT NOT NULL,
    UpdatedAt TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1
);

-- ASTROLOGER PROFILES
CREATE TABLE AstrologerProfiles (
    Id TEXT NOT NULL PRIMARY KEY,
    UserId TEXT NOT NULL UNIQUE,
    Specialization TEXT NOT NULL,
    Bio TEXT NOT NULL,
    ExperienceYears INTEGER NOT NULL,
    ConsultationFee TEXT NOT NULL,
    Rating TEXT NOT NULL,
    ReviewCount INTEGER NOT NULL,
    IsApproved INTEGER NOT NULL DEFAULT 0,
    IsFeatured INTEGER NOT NULL DEFAULT 0,
    Languages TEXT,
    Availability TEXT,
    CreatedAt TEXT NOT NULL,
    UpdatedAt TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (UserId) REFERENCES Users(Id) ON DELETE CASCADE
);

-- POOJA SERVICES
CREATE TABLE PoojaServices (
    Id TEXT NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL,
    Slug TEXT NOT NULL UNIQUE,
    Category TEXT NOT NULL,
    Description TEXT NOT NULL,
    Price TEXT NOT NULL,
    SalePrice TEXT,
    DurationMinutes INTEGER NOT NULL,
    ImageUrl TEXT,
    IsFeatured INTEGER NOT NULL DEFAULT 0,
    Rating TEXT NOT NULL,
    ReviewCount INTEGER NOT NULL,
    FestivalTag TEXT,
    CreatedAt TEXT NOT NULL,
    UpdatedAt TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1
);

-- PRODUCT CATEGORIES
CREATE TABLE ProductCategories (
    Id TEXT NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL,
    Slug TEXT NOT NULL UNIQUE,
    Description TEXT,
    ImageUrl TEXT,
    ParentId TEXT,
    CreatedAt TEXT NOT NULL,
    UpdatedAt TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1
);

-- PRODUCTS
CREATE TABLE Products (
    Id TEXT NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL,
    Slug TEXT NOT NULL UNIQUE,
    Description TEXT NOT NULL,
    CategoryId TEXT NOT NULL,
    Price TEXT NOT NULL,
    SalePrice TEXT,
    StockQuantity INTEGER NOT NULL,
    Sku TEXT,
    Rating TEXT NOT NULL,
    ReviewCount INTEGER NOT NULL,
    IsFeatured INTEGER NOT NULL DEFAULT 0,
    FestivalTag TEXT,
    CreatedAt TEXT NOT NULL,
    UpdatedAt TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (CategoryId) REFERENCES ProductCategories(Id) ON DELETE CASCADE
);

-- PRODUCT IMAGES
CREATE TABLE ProductImages (
    Id TEXT NOT NULL PRIMARY KEY,
    ProductId TEXT NOT NULL,
    ImageUrl TEXT NOT NULL,
    IsPrimary INTEGER NOT NULL DEFAULT 0,
    SortOrder INTEGER NOT NULL DEFAULT 0,
    CreatedAt TEXT NOT NULL,
    UpdatedAt TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (ProductId) REFERENCES Products(Id) ON DELETE CASCADE
);

-- SUBSCRIPTION PLANS
CREATE TABLE SubscriptionPlans (
    Id TEXT NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL,
    Slug TEXT NOT NULL UNIQUE,
    Description TEXT NOT NULL,
    Price TEXT NOT NULL,
    BillingCycle TEXT NOT NULL DEFAULT 'monthly',
    Features TEXT NOT NULL,
    IsPopular INTEGER NOT NULL DEFAULT 0,
    CreatedAt TEXT NOT NULL,
    UpdatedAt TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1
);

-- COUPONS
CREATE TABLE Coupons (
    Id TEXT NOT NULL PRIMARY KEY,
    Code TEXT NOT NULL UNIQUE,
    Description TEXT NOT NULL,
    Type INTEGER NOT NULL,
    Value TEXT NOT NULL,
    MinOrderValue TEXT,
    MaxDiscount TEXT,
    UsageLimit INTEGER NOT NULL,
    UsedCount INTEGER NOT NULL DEFAULT 0,
    ValidFrom TEXT NOT NULL,
    ValidTo TEXT NOT NULL,
    FestivalTag TEXT,
    CreatedAt TEXT NOT NULL,
    UpdatedAt TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1
);

-- BLOG
CREATE TABLE BlogCategories (
    Id TEXT NOT NULL PRIMARY KEY,
    Name TEXT NOT NULL,
    Slug TEXT NOT NULL UNIQUE,
    CreatedAt TEXT NOT NULL,
    UpdatedAt TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1
);

CREATE TABLE BlogPosts (
    Id TEXT NOT NULL PRIMARY KEY,
    Title TEXT NOT NULL,
    Slug TEXT NOT NULL UNIQUE,
    Excerpt TEXT NOT NULL,
    Content TEXT NOT NULL,
    ImageUrl TEXT,
    Author TEXT NOT NULL,
    CategoryId TEXT NOT NULL,
    ViewCount INTEGER NOT NULL DEFAULT 0,
    CreatedAt TEXT NOT NULL,
    UpdatedAt TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1,
    FOREIGN KEY (CategoryId) REFERENCES BlogCategories(Id) ON DELETE CASCADE
);

-- FAQS
CREATE TABLE Faqs (
    Id TEXT NOT NULL PRIMARY KEY,
    Question TEXT NOT NULL,
    Answer TEXT NOT NULL,
    Category TEXT NOT NULL,
    SortOrder INTEGER NOT NULL,
    CreatedAt TEXT NOT NULL,
    UpdatedAt TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1
);

-- SETTINGS
CREATE TABLE Settings (
    Id TEXT NOT NULL PRIMARY KEY,
    Key TEXT NOT NULL UNIQUE,
    Value TEXT NOT NULL,
    Description TEXT,
    CreatedAt TEXT NOT NULL,
    UpdatedAt TEXT,
    IsActive INTEGER NOT NULL DEFAULT 1
);

-- Catalog of skeleton-loader animation presets; whichever row has IsActive = 1 drives the
-- shimmer/pulse/wave/glow animation used by every loading skeleton across the site.
CREATE TABLE "Loading Skeleton" (
    Id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    Name TEXT NOT NULL,
    DisplayName TEXT NOT NULL,
    CssClass TEXT NOT NULL,
    DurationMs INTEGER NOT NULL,
    DelayMs INTEGER NOT NULL DEFAULT 0,
    Easing TEXT NOT NULL,
    ConfigJson TEXT,
    IsActive INTEGER NOT NULL DEFAULT 0,
    SortOrder INTEGER NOT NULL DEFAULT 0,
    CreatedAt TEXT NOT NULL,
    UpdatedAt TEXT
);

-- =============================================================================
-- SEED DATA
-- Role: 1=SuperAdmin, 2=Astrologer, 3=Customer | CouponType: 1=Percent, 2=Fixed
-- =============================================================================

INSERT INTO Users (Id, Email, Phone, PasswordHash, FirstName, LastName, Role, EmailVerified, PhoneVerified, CreatedAt, IsActive) VALUES
('a1000001-0000-0000-0000-000000000001', 'admin@vadicmall.com', NULL, '$2a$11$TVxfgC673/nIl9GU221EwOooamyFBI9.gpuGTIlAEitI3BHVlFqsK', 'Super', 'Admin', 1, 1, 0, datetime('now'), 1),
('a1000001-0000-0000-0000-000000000002', 'customer@vadicmall.com', '+91 9876543210', '$2a$11$GAfjZf3mb1eX7Rv4zEX1MuobAcbrWJ89hoZp4RvjEB/A4twI22u4.', 'Demo', 'Customer', 3, 1, 0, datetime('now'), 1),
('a1000001-0000-0000-0000-000000000003', 'pandit.sharma@vadicmall.com', NULL, '$2a$11$e9rLxmhi2NA7sS4BwJDhZuZluAK.hntzPNGJR1AwzVDw4f.nMAQve', 'Pandit', 'Sharma', 2, 1, 0, datetime('now'), 1),
('a1000001-0000-0000-0000-000000000004', 'dr.venkatesh@vadicmall.com', NULL, '$2a$11$e9rLxmhi2NA7sS4BwJDhZuZluAK.hntzPNGJR1AwzVDw4f.nMAQve', 'Dr.', 'Venkatesh', 2, 1, 0, datetime('now'), 1),
('a1000001-0000-0000-0000-000000000005', 'acharya.mishra@vadicmall.com', NULL, '$2a$11$e9rLxmhi2NA7sS4BwJDhZuZluAK.hntzPNGJR1AwzVDw4f.nMAQve', 'Acharya', 'Mishra', 2, 1, 0, datetime('now'), 1),
('a1000001-0000-0000-0000-000000000006', 'guru.anand@vadicmall.com', NULL, '$2a$11$e9rLxmhi2NA7sS4BwJDhZuZluAK.hntzPNGJR1AwzVDw4f.nMAQve', 'Guru', 'Anand', 2, 1, 0, datetime('now'), 1),
('a1000001-0000-0000-0000-000000000007', 'pandit.rao@vadicmall.com', NULL, '$2a$11$e9rLxmhi2NA7sS4BwJDhZuZluAK.hntzPNGJR1AwzVDw4f.nMAQve', 'Pandit', 'Rao', 2, 1, 0, datetime('now'), 1);

INSERT INTO AstrologerProfiles (Id, UserId, Specialization, Bio, ExperienceYears, ConsultationFee, Rating, ReviewCount, IsApproved, IsFeatured, Languages, CreatedAt, IsActive) VALUES
('b2000001-0000-0000-0000-000000000001', 'a1000001-0000-0000-0000-000000000003', 'Vedic Astrology', '25 years of experience in Vedic astrology and pooja rituals.', 25, '999', '4.9', 342, 1, 1, 'Hindi, English, Sanskrit', datetime('now'), 1),
('b2000001-0000-0000-0000-000000000002', 'a1000001-0000-0000-0000-000000000004', 'Marriage Astrology', 'Expert in marriage compatibility and relationship counseling.', 18, '799', '4.8', 256, 1, 1, 'Hindi, English, Sanskrit', datetime('now'), 1),
('b2000001-0000-0000-0000-000000000003', 'a1000001-0000-0000-0000-000000000005', 'Career Astrology', 'Specializes in career guidance through planetary analysis.', 15, '699', '4.7', 189, 1, 0, 'Hindi, English, Sanskrit', datetime('now'), 1),
('b2000001-0000-0000-0000-000000000004', 'a1000001-0000-0000-0000-000000000006', 'Nadi Astrology', 'Renowned Nadi astrologer with ancient palm leaf readings.', 30, '1499', '4.9', 412, 1, 1, 'Hindi, English, Sanskrit', datetime('now'), 1),
('b2000001-0000-0000-0000-000000000005', 'a1000001-0000-0000-0000-000000000007', 'Medical Astrology', 'Combines Ayurveda with astrological health remedies.', 20, '899', '4.6', 167, 1, 0, 'Hindi, English, Sanskrit', datetime('now'), 1);

INSERT INTO PoojaServices (Id, Name, Slug, Category, Description, Price, SalePrice, DurationMinutes, ImageUrl, IsFeatured, Rating, ReviewCount, FestivalTag, CreatedAt, IsActive) VALUES
('c3000001-0000-0000-0000-000000000001', 'Ganesh Puja', 'ganesh-puja', 'Ganesh Puja', 'Remove obstacles and invite prosperity with authentic Ganesh Puja.', '2100', '1800', 90, '/images/pooja/ganesh-puja.jpg', 1, '4.9', 120, 'Ganesh Chaturthi', datetime('now'), 1),
('c3000001-0000-0000-0000-000000000002', 'Satyanarayan Puja', 'satyanarayan-puja', 'Satyanarayan Puja', 'Sacred puja for peace, prosperity and fulfillment of wishes.', '3500', NULL, 120, '/images/pooja/satyanarayan-puja.jpg', 1, '4.5', 85, NULL, datetime('now'), 1),
('c3000001-0000-0000-0000-000000000003', 'Griha Pravesh', 'griha-pravesh', 'Griha Pravesh', 'House warming ceremony for positive energy in your new home.', '5100', '4590', 180, '/images/pooja/griha-pravesh.jpg', 1, '4.8', 95, NULL, datetime('now'), 1),
('c3000001-0000-0000-0000-000000000004', 'Navgraha Shanti', 'navgraha-shanti', 'Navgraha Shanti', 'Pacify all nine planets for harmony and success.', '7500', NULL, 240, '/images/pooja/navgraha-shanti.jpg', 0, '4.6', 70, 'Navratri', datetime('now'), 1),
('c3000001-0000-0000-0000-000000000005', 'Rudrabhishek', 'rudrabhishek', 'Rudrabhishek', 'Powerful Shiva worship for spiritual growth and protection.', '4100', '3280', 150, '/images/pooja/rudrabhishek.jpg', 1, '4.7', 110, 'Maha Shivratri', datetime('now'), 1),
('c3000001-0000-0000-0000-000000000006', 'Durga Puja', 'durga-puja', 'Durga Puja', 'Invoke Goddess Durga for strength and victory over obstacles.', '5500', '4125', 180, '/images/pooja/durga-puja.jpg', 1, '4.8', 130, 'Navratri', datetime('now'), 1),
('c3000001-0000-0000-0000-000000000007', 'Lakshmi Puja', 'lakshmi-puja', 'Lakshmi Puja', 'Attract wealth and abundance with sacred Lakshmi worship.', '3100', '2170', 120, '/images/pooja/lakshmi-puja.jpg', 1, '4.9', 150, 'Diwali', datetime('now'), 1),
('c3000001-0000-0000-0000-000000000008', 'Mundan Sanskar', 'mundan-sanskar', 'Mundan Sanskar', 'Traditional first haircut ceremony for children.', '2100', NULL, 60, '/images/pooja/mundan-sanskar.jpg', 0, '4.5', 60, NULL, datetime('now'), 1),
('c3000001-0000-0000-0000-000000000009', 'Vivah Puja', 'vivah-puja', 'Vivah Puja', 'Complete Vedic wedding ceremony with all rituals.', '15000', NULL, 360, '/images/pooja/vivah-puja.jpg', 1, '4.9', 45, NULL, datetime('now'), 1),
('c3000001-0000-0000-0000-000000000010', 'Yajna', 'yajna', 'Yajna', 'Sacred fire ritual for purification and divine blessings.', '8500', NULL, 300, '/images/pooja/yajna.jpg', 0, '4.6', 55, NULL, datetime('now'), 1);

INSERT INTO ProductCategories (Id, Name, Slug, Description, CreatedAt, IsActive) VALUES
('d4000001-0000-0000-0000-000000000001', 'Gemstones', 'gemstones', 'Authentic Gemstones for spiritual practice', datetime('now'), 1),
('d4000001-0000-0000-0000-000000000002', 'Malas', 'malas', 'Authentic Malas for spiritual practice', datetime('now'), 1),
('d4000001-0000-0000-0000-000000000003', 'Pooja Samagri', 'pooja-samagri', 'Authentic Pooja Samagri for spiritual practice', datetime('now'), 1),
('d4000001-0000-0000-0000-000000000004', 'Spiritual Books', 'spiritual-books', 'Authentic Spiritual Books for spiritual practice', datetime('now'), 1),
('d4000001-0000-0000-0000-000000000005', 'Idols & Images', 'idols', 'Authentic Idols & Images for spiritual practice', datetime('now'), 1),
('d4000001-0000-0000-0000-000000000006', 'Yantras', 'yantras', 'Authentic Yantras for spiritual practice', datetime('now'), 1),
('d4000001-0000-0000-0000-000000000007', 'Rudraksha', 'rudraksha', 'Authentic Rudraksha for spiritual practice', datetime('now'), 1),
('d4000001-0000-0000-0000-000000000008', 'Home Decor', 'home-decor', 'Authentic Home Decor for spiritual practice', datetime('now'), 1);

INSERT INTO Products (Id, Name, Slug, Description, CategoryId, Price, SalePrice, StockQuantity, Sku, Rating, ReviewCount, IsFeatured, FestivalTag, CreatedAt, IsActive) VALUES
('e5000001-0000-0000-0000-000000000001', 'Natural Ruby (Manik)', 'ruby-manik', 'Certified natural ruby for Sun planet remedies.', 'd4000001-0000-0000-0000-000000000001', '25000', '22500', 15, 'VM-RUBY-01', '4.5', 80, 1, 'Diwali', datetime('now'), 1),
('e5000001-0000-0000-0000-000000000002', 'Blue Sapphire (Neelam)', 'blue-sapphire', 'Premium Ceylon blue sapphire for Saturn.', 'd4000001-0000-0000-0000-000000000001', '45000', NULL, 8, 'VM-BLUE-01', '4.5', 45, 1, NULL, datetime('now'), 1),
('e5000001-0000-0000-0000-000000000003', '5 Mukhi Rudraksha Mala', 'rudraksha-mala-5', 'Authentic Nepali 5 Mukhi Rudraksha mala, 108 beads.', 'd4000001-0000-0000-0000-000000000002', '1200', '960', 50, 'VM-MALA-01', '4.5', 120, 1, 'Maha Shivratri', datetime('now'), 1),
('e5000001-0000-0000-0000-000000000004', 'Puja Thali Set (Brass)', 'puja-thali-brass', 'Complete brass puja thali with diya, bell, and kalash.', 'd4000001-0000-0000-0000-000000000003', '899', NULL, 100, 'VM-THALI-01', '4.4', 90, 0, NULL, datetime('now'), 1),
('e5000001-0000-0000-0000-000000000005', 'Bhagavad Gita (Hindi)', 'bhagavad-gita-hindi', 'Illustrated Bhagavad Gita with commentary.', 'd4000001-0000-0000-0000-000000000004', '350', '280', 200, 'VM-GITA-01', '4.8', 150, 1, NULL, datetime('now'), 1),
('e5000001-0000-0000-0000-000000000006', 'Brass Ganesha Idol', 'ganesha-idol-brass', 'Handcrafted brass Ganesha idol, 6 inches.', 'd4000001-0000-0000-0000-000000000005', '1499', '1199', 30, 'VM-GANESHA-01', '4.6', 75, 1, 'Ganesh Chaturthi', datetime('now'), 1),
('e5000001-0000-0000-0000-000000000007', 'Sri Yantra (Copper)', 'sri-yantra-copper', 'Energized Sri Yantra for prosperity and success.', 'd4000001-0000-0000-0000-000000000006', '2100', NULL, 25, 'VM-YANTRA-01', '4.7', 60, 1, 'Diwali', datetime('now'), 1),
('e5000001-0000-0000-0000-000000000008', '7 Mukhi Rudraksha', 'rudraksha-7-mukhi', 'Rare 7 Mukhi Rudraksha from Nepal.', 'd4000001-0000-0000-0000-000000000007', '3500', '2800', 12, 'VM-RUDRA-01', '4.5', 40, 0, NULL, datetime('now'), 1),
('e5000001-0000-0000-0000-000000000009', 'Incense Sticks Set', 'incense-sticks-set', 'Premium sandalwood and rose incense, 12 packs.', 'd4000001-0000-0000-0000-000000000003', '499', NULL, 150, 'VM-INCENSE-01', '4.3', 110, 0, NULL, datetime('now'), 1),
('e5000001-0000-0000-0000-000000000010', 'Krishna Wall Hanging', 'krishna-wall-hanging', 'Beautiful Krishna devotional wall art with frame.', 'd4000001-0000-0000-0000-000000000008', '799', '639', 40, 'VM-KRISHNA-01', '4.6', 55, 1, 'Krishna Janmashtami', datetime('now'), 1),
('e5000001-0000-0000-0000-000000000011', 'Yellow Sapphire (Pukhraj)', 'yellow-sapphire', 'Natural yellow sapphire for Jupiter blessings.', 'd4000001-0000-0000-0000-000000000001', '35000', '31500', 6, 'VM-PUKHRAJ-01', '4.8', 35, 1, NULL, datetime('now'), 1),
('e5000001-0000-0000-0000-000000000012', 'Tulsi Mala', 'tulsi-mala', 'Sacred Tulsi mala for chanting and meditation.', 'd4000001-0000-0000-0000-000000000002', '299', NULL, 80, 'VM-TULSI-01', '4.4', 95, 0, NULL, datetime('now'), 1);

INSERT INTO ProductImages (Id, ProductId, ImageUrl, IsPrimary, SortOrder, CreatedAt, IsActive) VALUES
('f6000001-0000-0000-0000-000000000001', 'e5000001-0000-0000-0000-000000000001', '/images/products/ruby-manik.jpg', 1, 0, datetime('now'), 1),
('f6000001-0000-0000-0000-000000000002', 'e5000001-0000-0000-0000-000000000002', '/images/products/blue-sapphire.jpg', 1, 0, datetime('now'), 1),
('f6000001-0000-0000-0000-000000000003', 'e5000001-0000-0000-0000-000000000003', '/images/products/rudraksha-mala-5.jpg', 1, 0, datetime('now'), 1),
('f6000001-0000-0000-0000-000000000004', 'e5000001-0000-0000-0000-000000000004', '/images/products/puja-thali-brass.jpg', 1, 0, datetime('now'), 1),
('f6000001-0000-0000-0000-000000000005', 'e5000001-0000-0000-0000-000000000005', '/images/products/bhagavad-gita-hindi.jpg', 1, 0, datetime('now'), 1),
('f6000001-0000-0000-0000-000000000006', 'e5000001-0000-0000-0000-000000000006', '/images/products/ganesha-idol-brass.jpg', 1, 0, datetime('now'), 1),
('f6000001-0000-0000-0000-000000000007', 'e5000001-0000-0000-0000-000000000007', '/images/products/sri-yantra-copper.jpg', 1, 0, datetime('now'), 1),
('f6000001-0000-0000-0000-000000000008', 'e5000001-0000-0000-0000-000000000008', '/images/products/rudraksha-7-mukhi.jpg', 1, 0, datetime('now'), 1),
('f6000001-0000-0000-0000-000000000009', 'e5000001-0000-0000-0000-000000000009', '/images/products/incense-sticks-set.jpg', 1, 0, datetime('now'), 1),
('f6000001-0000-0000-0000-000000000010', 'e5000001-0000-0000-0000-000000000010', '/images/products/krishna-wall-hanging.jpg', 1, 0, datetime('now'), 1),
('f6000001-0000-0000-0000-000000000011', 'e5000001-0000-0000-0000-000000000011', '/images/products/yellow-sapphire.jpg', 1, 0, datetime('now'), 1),
('f6000001-0000-0000-0000-000000000012', 'e5000001-0000-0000-0000-000000000012', '/images/products/tulsi-mala.jpg', 1, 0, datetime('now'), 1);

INSERT INTO SubscriptionPlans (Id, Name, Slug, Description, Price, BillingCycle, Features, IsPopular, CreatedAt, IsActive) VALUES
('g7000001-0000-0000-0000-000000000001', 'Basic', 'basic', 'Monthly horoscope and kundli checks', '199', 'monthly', '["Monthly Horoscope","2 Kundli Checks","Astrology Articles"]', 0, datetime('now'), 1),
('g7000001-0000-0000-0000-000000000002', 'Premium', 'premium', 'Weekly horoscope with pooja bookings', '499', 'monthly', '["Weekly Horoscope","5 Kundli Checks","2 Pooja Bookings","Chat Support"]', 1, datetime('now'), 1),
('g7000001-0000-0000-0000-000000000003', 'Elite', 'elite', 'Daily horoscope with unlimited kundli', '999', 'monthly', '["Daily Horoscope","Unlimited Kundli","10 Pooja Bookings","Astrologer Chat","Priority Support"]', 0, datetime('now'), 1),
('g7000001-0000-0000-0000-000000000004', 'Family', 'family', 'Elite features for 5 family members', '1999', 'monthly', '["5 Members","All Elite Features","Family Pooja","Group Consultations"]', 0, datetime('now'), 1),
('g7000001-0000-0000-0000-000000000005', 'Business', 'business', 'For professional astrologers', '4999', 'monthly', '["20+ Services","Priority Listing","Advanced Analytics","Dedicated Support"]', 0, datetime('now'), 1);

INSERT INTO Coupons (Id, Code, Description, Type, Value, MinOrderValue, MaxDiscount, UsageLimit, UsedCount, ValidFrom, ValidTo, FestivalTag, CreatedAt, IsActive) VALUES
('h8000001-0000-0000-0000-000000000001', 'DIWALI30', 'Diwali special 30% off', 1, '30', '500', '2000', 1000, 0, datetime('now','-30 days'), datetime('now','+60 days'), 'Diwali', datetime('now'), 1),
('h8000001-0000-0000-0000-000000000002', 'WELCOME100', 'Welcome discount for new users', 2, '100', '999', NULL, 5000, 0, datetime('now','-90 days'), datetime('now','+365 days'), NULL, datetime('now'), 1),
('h8000001-0000-0000-0000-000000000003', 'NAVRATRI25', 'Navratri festival discount', 1, '25', '1000', '1500', 500, 0, datetime('now','-10 days'), datetime('now','+30 days'), 'Navratri', datetime('now'), 1);

INSERT INTO BlogCategories (Id, Name, Slug, CreatedAt, IsActive) VALUES
('i9000001-0000-0000-0000-000000000001', 'Astrology Tips', 'astrology-tips', datetime('now'), 1);

INSERT INTO BlogPosts (Id, Title, Slug, Excerpt, Content, ImageUrl, Author, CategoryId, ViewCount, CreatedAt, IsActive) VALUES
('j1000001-0000-0000-0000-000000000001', 'Understanding Your Birth Chart', 'understanding-birth-chart', 'Learn the basics of Vedic birth chart interpretation.', 'Your birth chart, or Kundli, is a cosmic snapshot of the sky at the moment of your birth. It reveals planetary positions, houses, and nakshatras that influence your life path.', '/images/blog/birth-chart.jpg', 'Pandit Sharma', 'i9000001-0000-0000-0000-000000000001', 1250, datetime('now'), 1),
('j1000001-0000-0000-0000-000000000002', 'Diwali Puja Guide 2026', 'diwali-puja-guide', 'Complete guide to performing Lakshmi Puja this Diwali.', 'Diwali, the festival of lights, is the perfect time for Lakshmi Puja. Prepare your altar with diyas, flowers, and sacred offerings for Goddess Lakshmi.', '/images/blog/diwali-guide.jpg', 'Acharya Mishra', 'i9000001-0000-0000-0000-000000000001', 890, datetime('now'), 1),
('j1000001-0000-0000-0000-000000000003', 'Gemstones and Planetary Remedies', 'gemstones-planetary-remedies', 'How to choose the right gemstone for your planetary dosha.', 'In Vedic astrology, gemstones are powerful tools for balancing planetary energies. Ruby for Sun, Pearl for Moon, and Blue Sapphire for Saturn are among the most prescribed.', '/images/blog/gemstones.jpg', 'Dr. Venkatesh', 'i9000001-0000-0000-0000-000000000001', 654, datetime('now'), 1);

INSERT INTO Faqs (Id, Question, Answer, Category, SortOrder, CreatedAt, IsActive) VALUES
('k1100001-0000-0000-0000-000000000001', 'How do I book a pooja service?', 'Browse our pooja catalog, select a service, choose date and time, and complete payment. Our pandits will perform the ritual and send prasad.', 'Pooja', 1, datetime('now'), 1),
('k1100001-0000-0000-0000-000000000002', 'Are gemstones certified?', 'Yes, all our gemstones come with authenticity certificates from recognized gemological laboratories.', 'Products', 2, datetime('now'), 1),
('k1100001-0000-0000-0000-000000000003', 'How long does kundli analysis take?', 'Standard kundli analysis is delivered within 24-48 hours. Premium analysis may take up to 72 hours.', 'Kundli', 3, datetime('now'), 1),
('k1100001-0000-0000-0000-000000000004', 'What payment methods are accepted?', 'We accept UPI, credit/debit cards, net banking, wallets, and Cash on Delivery for eligible orders.', 'Payment', 4, datetime('now'), 1),
('k1100001-0000-0000-0000-000000000005', 'Can I cancel a pooja booking?', 'Yes, cancellations made 48 hours before the scheduled date receive a full refund.', 'Pooja', 5, datetime('now'), 1);

INSERT INTO Settings (Id, Key, Value, Description, CreatedAt, IsActive) VALUES
('l1200001-0000-0000-0000-000000000001', 'site_name', 'Vadic Mall', 'Application name', datetime('now'), 1),
('l1200001-0000-0000-0000-000000000002', 'support_email', 'info@vadicmall.com', 'Support email', datetime('now'), 1),
('l1200001-0000-0000-0000-000000000003', 'support_phone', '+91 98765 43210', 'Support phone', datetime('now'), 1),
('l1200001-0000-0000-0000-000000000004', 'free_shipping_threshold', '999', 'Free shipping above this amount', datetime('now'), 1);

INSERT INTO "Loading Skeleton" (Name, DisplayName, CssClass, DurationMs, DelayMs, Easing, ConfigJson, IsActive, SortOrder, CreatedAt) VALUES
('shimmer', 'Shimmer Sweep', 'skeleton-shimmer', 1600, 0, 'ease-in-out', NULL, 1, 1, datetime('now')),
('pulse', 'Soft Pulse', 'skeleton-pulse', 1400, 0, 'ease-in-out', NULL, 0, 2, datetime('now')),
('wave', 'Wave Sweep', 'skeleton-wave', 1800, 0, 'linear', NULL, 0, 3, datetime('now')),
('glow', 'Saffron Glow', 'skeleton-glow', 2000, 0, 'ease-in-out', NULL, 0, 4, datetime('now'));
