-- =============================================================================
-- Vadic Mall - Complete SQL Server Database Script (T-SQL)
-- =============================================================================
-- 35+ tables: catalog, orders, payments, order tracking, RBAC (roles/permissions),
-- login/audit/error logs, bookings, subscriptions, kundli, notifications.
--
-- Run in SSMS or Azure Data Studio -> Execute (F5)
-- Test connection first: vadicmall-sqlserver-test.sql
-- =============================================================================

USE [master];
GO

IF DB_ID(N'VadicMall') IS NULL
BEGIN
    CREATE DATABASE [VadicMall];
END
GO

USE [VadicMall];
GO

SET NOCOUNT ON;
SET ANSI_NULLS ON;
SET QUOTED_IDENTIFIER ON;
SET XACT_ABORT ON;
GO

DECLARE @sql NVARCHAR(MAX) = N'';
SELECT @sql = @sql + N'ALTER TABLE ' + QUOTENAME(OBJECT_SCHEMA_NAME(parent_object_id)) + N'.' + QUOTENAME(OBJECT_NAME(parent_object_id)) + N' DROP CONSTRAINT ' + QUOTENAME(name) + N';' + CHAR(13) FROM sys.foreign_keys;
IF LEN(@sql) > 0 EXEC sys.sp_executesql @sql;
SET @sql = N'';
SELECT @sql = @sql + N'IF OBJECT_ID(N''' + SCHEMA_NAME(schema_id) + N'.' + name + N''', N''U'') IS NOT NULL DROP TABLE ' + QUOTENAME(SCHEMA_NAME(schema_id)) + N'.' + QUOTENAME(name) + N';' + CHAR(13) FROM sys.tables WHERE schema_id = SCHEMA_ID(N'dbo');
IF LEN(@sql) > 0 EXEC sys.sp_executesql @sql;
GO


-- ===================== RBAC =====================
CREATE TABLE dbo.[Roles] (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL UNIQUE,
    Code NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(500) NULL,
    IsSystem BIT NOT NULL CONSTRAINT DF_Roles_IsSystem DEFAULT 1,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Roles_IsActive DEFAULT 1
);
GO

CREATE TABLE dbo.[Permissions] (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Code NVARCHAR(100) NOT NULL UNIQUE,
    Name NVARCHAR(200) NOT NULL,
    Module NVARCHAR(100) NOT NULL,
    Description NVARCHAR(500) NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Permissions_IsActive DEFAULT 1
);
GO

CREATE TABLE dbo.RolePermissions (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    RoleId UNIQUEIDENTIFIER NOT NULL,
    PermissionId UNIQUEIDENTIFIER NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_RolePermissions_IsActive DEFAULT 1,
    CONSTRAINT UQ_RolePermissions UNIQUE (RoleId, PermissionId),
    CONSTRAINT FK_RolePermissions_Roles FOREIGN KEY (RoleId) REFERENCES dbo.[Roles](Id) ON DELETE CASCADE,
    CONSTRAINT FK_RolePermissions_Permissions FOREIGN KEY (PermissionId) REFERENCES dbo.[Permissions](Id) ON DELETE CASCADE
);
GO

-- ===================== USERS =====================
CREATE TABLE dbo.[Users] (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Email NVARCHAR(256) NOT NULL UNIQUE,
    Phone NVARCHAR(20) NULL,
    PasswordHash NVARCHAR(500) NOT NULL,
    FirstName NVARCHAR(100) NOT NULL,
    LastName NVARCHAR(100) NOT NULL,
    AvatarUrl NVARCHAR(500) NULL,
    [Role] INT NOT NULL,
    RoleId UNIQUEIDENTIFIER NULL,
    EmailVerified BIT NOT NULL CONSTRAINT DF_Users_EmailVerified DEFAULT 0,
    PhoneVerified BIT NOT NULL CONSTRAINT DF_Users_PhoneVerified DEFAULT 0,
    LastLoginAt DATETIME2 NULL,
    RefreshToken NVARCHAR(500) NULL,
    RefreshTokenExpiry DATETIME2 NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Users_IsActive DEFAULT 1,
    CONSTRAINT FK_Users_Roles FOREIGN KEY (RoleId) REFERENCES dbo.[Roles](Id) ON DELETE SET NULL
);
GO

CREATE TABLE dbo.AstrologerProfiles (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    UserId UNIQUEIDENTIFIER NOT NULL UNIQUE,
    Specialization NVARCHAR(200) NOT NULL,
    Bio NVARCHAR(MAX) NOT NULL,
    ExperienceYears INT NOT NULL,
    ConsultationFee DECIMAL(18,2) NOT NULL,
    Rating DECIMAL(3,1) NOT NULL,
    ReviewCount INT NOT NULL,
    IsApproved BIT NOT NULL CONSTRAINT DF_AstrologerProfiles_IsApproved DEFAULT 0,
    IsFeatured BIT NOT NULL CONSTRAINT DF_AstrologerProfiles_IsFeatured DEFAULT 0,
    Languages NVARCHAR(200) NULL,
    Availability NVARCHAR(500) NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_AstrologerProfiles_IsActive DEFAULT 1,
    CONSTRAINT FK_AstrologerProfiles_Users FOREIGN KEY (UserId) REFERENCES dbo.[Users](Id) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.Addresses (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    UserId UNIQUEIDENTIFIER NOT NULL,
    FullName NVARCHAR(200) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    AddressLine1 NVARCHAR(300) NOT NULL,
    AddressLine2 NVARCHAR(300) NULL,
    City NVARCHAR(100) NOT NULL,
    State NVARCHAR(100) NOT NULL,
    Pincode NVARCHAR(20) NOT NULL,
    Country NVARCHAR(100) NOT NULL CONSTRAINT DF_Addresses_Country DEFAULT N'India',
    IsDefault BIT NOT NULL CONSTRAINT DF_Addresses_IsDefault DEFAULT 0,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Addresses_IsActive DEFAULT 1,
    CONSTRAINT FK_Addresses_Users FOREIGN KEY (UserId) REFERENCES dbo.[Users](Id) ON DELETE CASCADE
);
GO

-- ===================== CATALOG =====================
CREATE TABLE dbo.ProductCategories (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Slug NVARCHAR(200) NOT NULL UNIQUE,
    Description NVARCHAR(500) NULL,
    ImageUrl NVARCHAR(500) NULL,
    ParentId UNIQUEIDENTIFIER NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_ProductCategories_IsActive DEFAULT 1
);
GO

CREATE TABLE dbo.Products (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Slug NVARCHAR(200) NOT NULL UNIQUE,
    Description NVARCHAR(MAX) NOT NULL,
    CategoryId UNIQUEIDENTIFIER NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    SalePrice DECIMAL(18,2) NULL,
    StockQuantity INT NOT NULL,
    Sku NVARCHAR(50) NULL,
    Rating DECIMAL(3,1) NOT NULL,
    ReviewCount INT NOT NULL,
    IsFeatured BIT NOT NULL CONSTRAINT DF_Products_IsFeatured DEFAULT 0,
    FestivalTag NVARCHAR(100) NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Products_IsActive DEFAULT 1,
    CONSTRAINT FK_Products_ProductCategories FOREIGN KEY (CategoryId) REFERENCES dbo.ProductCategories(Id) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.ProductImages (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    ProductId UNIQUEIDENTIFIER NOT NULL,
    ImageUrl NVARCHAR(500) NOT NULL,
    IsPrimary BIT NOT NULL CONSTRAINT DF_ProductImages_IsPrimary DEFAULT 0,
    SortOrder INT NOT NULL CONSTRAINT DF_ProductImages_SortOrder DEFAULT 0,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_ProductImages_IsActive DEFAULT 1,
    CONSTRAINT FK_ProductImages_Products FOREIGN KEY (ProductId) REFERENCES dbo.Products(Id) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.PoojaServices (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Slug NVARCHAR(200) NOT NULL UNIQUE,
    Category NVARCHAR(100) NOT NULL,
    Description NVARCHAR(MAX) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    SalePrice DECIMAL(18,2) NULL,
    DurationMinutes INT NOT NULL,
    ImageUrl NVARCHAR(500) NULL,
    IsFeatured BIT NOT NULL CONSTRAINT DF_PoojaServices_IsFeatured DEFAULT 0,
    Rating DECIMAL(3,1) NOT NULL,
    ReviewCount INT NOT NULL,
    FestivalTag NVARCHAR(100) NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_PoojaServices_IsActive DEFAULT 1
);
GO

CREATE TABLE dbo.Coupons (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Code NVARCHAR(50) NOT NULL UNIQUE,
    Description NVARCHAR(500) NOT NULL,
    [Type] INT NOT NULL,
    [Value] DECIMAL(18,2) NOT NULL,
    MinOrderValue DECIMAL(18,2) NULL,
    MaxDiscount DECIMAL(18,2) NULL,
    UsageLimit INT NOT NULL,
    UsedCount INT NOT NULL CONSTRAINT DF_Coupons_UsedCount DEFAULT 0,
    ValidFrom DATETIME2 NOT NULL,
    ValidTo DATETIME2 NOT NULL,
    FestivalTag NVARCHAR(100) NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Coupons_IsActive DEFAULT 1
);
GO

CREATE TABLE dbo.SubscriptionPlans (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Name NVARCHAR(100) NOT NULL,
    Slug NVARCHAR(100) NOT NULL UNIQUE,
    Description NVARCHAR(500) NOT NULL,
    Price DECIMAL(18,2) NOT NULL,
    BillingCycle NVARCHAR(20) NOT NULL CONSTRAINT DF_SubscriptionPlans_BillingCycle DEFAULT N'monthly',
    Features NVARCHAR(MAX) NOT NULL,
    IsPopular BIT NOT NULL CONSTRAINT DF_SubscriptionPlans_IsPopular DEFAULT 0,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_SubscriptionPlans_IsActive DEFAULT 1
);
GO

CREATE TABLE dbo.GiftCards (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Code NVARCHAR(50) NOT NULL UNIQUE,
    [Type] NVARCHAR(50) NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    Balance DECIMAL(18,2) NOT NULL,
    PurchasedByUserId UNIQUEIDENTIFIER NULL,
    RedeemedByUserId UNIQUEIDENTIFIER NULL,
    ExpiryDate DATETIME2 NULL,
    Status NVARCHAR(50) NOT NULL CONSTRAINT DF_GiftCards_Status DEFAULT N'active',
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_GiftCards_IsActive DEFAULT 1
);
GO

CREATE TABLE dbo.BlogCategories (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Slug NVARCHAR(200) NOT NULL UNIQUE,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_BlogCategories_IsActive DEFAULT 1
);
GO

CREATE TABLE dbo.BlogPosts (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Title NVARCHAR(300) NOT NULL,
    Slug NVARCHAR(300) NOT NULL UNIQUE,
    Excerpt NVARCHAR(1000) NOT NULL,
    Content NVARCHAR(MAX) NOT NULL,
    ImageUrl NVARCHAR(500) NULL,
    Author NVARCHAR(200) NOT NULL,
    CategoryId UNIQUEIDENTIFIER NOT NULL,
    ViewCount INT NOT NULL CONSTRAINT DF_BlogPosts_ViewCount DEFAULT 0,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_BlogPosts_IsActive DEFAULT 1,
    CONSTRAINT FK_BlogPosts_BlogCategories FOREIGN KEY (CategoryId) REFERENCES dbo.BlogCategories(Id) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.Faqs (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Question NVARCHAR(500) NOT NULL,
    Answer NVARCHAR(MAX) NOT NULL,
    Category NVARCHAR(100) NOT NULL,
    SortOrder INT NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Faqs_IsActive DEFAULT 1
);
GO

CREATE TABLE dbo.Settings (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    [Key] NVARCHAR(100) NOT NULL UNIQUE,
    [Value] NVARCHAR(MAX) NOT NULL,
    Description NVARCHAR(500) NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Settings_IsActive DEFAULT 1
);
GO

-- ===================== ORDERS & PAYMENTS =====================
CREATE TABLE dbo.Orders (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    OrderNumber NVARCHAR(50) NOT NULL UNIQUE,
    UserId UNIQUEIDENTIFIER NOT NULL,
    Status INT NOT NULL CONSTRAINT DF_Orders_Status DEFAULT 1,
    SubTotal DECIMAL(18,2) NOT NULL,
    Discount DECIMAL(18,2) NOT NULL CONSTRAINT DF_Orders_Discount DEFAULT 0,
    ShippingFee DECIMAL(18,2) NOT NULL CONSTRAINT DF_Orders_ShippingFee DEFAULT 0,
    Total DECIMAL(18,2) NOT NULL,
    CouponCode NVARCHAR(50) NULL,
    ShippingAddressId UNIQUEIDENTIFIER NULL,
    TrackingNumber NVARCHAR(100) NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Orders_IsActive DEFAULT 1,
    CONSTRAINT FK_Orders_Users FOREIGN KEY (UserId) REFERENCES dbo.[Users](Id) ON DELETE NO ACTION,
    CONSTRAINT FK_Orders_Addresses FOREIGN KEY (ShippingAddressId) REFERENCES dbo.Addresses(Id) ON DELETE SET NULL
);
GO

CREATE TABLE dbo.OrderItems (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    OrderId UNIQUEIDENTIFIER NOT NULL,
    ProductId UNIQUEIDENTIFIER NOT NULL,
    Quantity INT NOT NULL,
    UnitPrice DECIMAL(18,2) NOT NULL,
    TotalPrice DECIMAL(18,2) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_OrderItems_IsActive DEFAULT 1,
    CONSTRAINT FK_OrderItems_Orders FOREIGN KEY (OrderId) REFERENCES dbo.Orders(Id) ON DELETE CASCADE,
    CONSTRAINT FK_OrderItems_Products FOREIGN KEY (ProductId) REFERENCES dbo.Products(Id) ON DELETE NO ACTION
);
GO

CREATE TABLE dbo.OrderTracking (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    OrderId UNIQUEIDENTIFIER NOT NULL,
    Status INT NOT NULL,
    Notes NVARCHAR(500) NULL,
    Location NVARCHAR(200) NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_OrderTracking_IsActive DEFAULT 1,
    CONSTRAINT FK_OrderTracking_Orders FOREIGN KEY (OrderId) REFERENCES dbo.Orders(Id) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.Payments (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    OrderId UNIQUEIDENTIFIER NOT NULL UNIQUE,
    Amount DECIMAL(18,2) NOT NULL,
    Status INT NOT NULL CONSTRAINT DF_Payments_Status DEFAULT 1,
    PaymentMethod NVARCHAR(50) NOT NULL,
    TransactionId NVARCHAR(200) NULL,
    GatewayResponse NVARCHAR(MAX) NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Payments_IsActive DEFAULT 1,
    CONSTRAINT FK_Payments_Orders FOREIGN KEY (OrderId) REFERENCES dbo.Orders(Id) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.PaymentTransactions (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    UserId UNIQUEIDENTIFIER NOT NULL,
    PaymentType NVARCHAR(50) NOT NULL,
    ReferenceId UNIQUEIDENTIFIER NOT NULL,
    Amount DECIMAL(18,2) NOT NULL,
    Status INT NOT NULL CONSTRAINT DF_PaymentTransactions_Status DEFAULT 1,
    PaymentMethod NVARCHAR(50) NOT NULL,
    TransactionId NVARCHAR(200) NULL,
    GatewayResponse NVARCHAR(MAX) NULL,
    Notes NVARCHAR(500) NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_PaymentTransactions_IsActive DEFAULT 1,
    CONSTRAINT FK_PaymentTransactions_Users FOREIGN KEY (UserId) REFERENCES dbo.[Users](Id) ON DELETE NO ACTION
);
GO

CREATE TABLE dbo.CouponUsages (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    CouponId UNIQUEIDENTIFIER NOT NULL,
    UserId UNIQUEIDENTIFIER NOT NULL,
    OrderId UNIQUEIDENTIFIER NULL,
    DiscountAmount DECIMAL(18,2) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_CouponUsages_IsActive DEFAULT 1,
    CONSTRAINT FK_CouponUsages_Coupons FOREIGN KEY (CouponId) REFERENCES dbo.Coupons(Id) ON DELETE NO ACTION,
    CONSTRAINT FK_CouponUsages_Users FOREIGN KEY (UserId) REFERENCES dbo.[Users](Id) ON DELETE NO ACTION,
    CONSTRAINT FK_CouponUsages_Orders FOREIGN KEY (OrderId) REFERENCES dbo.Orders(Id) ON DELETE SET NULL
);
GO

-- ===================== BOOKINGS & SUBSCRIPTIONS =====================
CREATE TABLE dbo.PoojaBookings (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    UserId UNIQUEIDENTIFIER NOT NULL,
    PoojaServiceId UNIQUEIDENTIFIER NOT NULL,
    AstrologerId UNIQUEIDENTIFIER NULL,
    ScheduledDate DATETIME2 NOT NULL,
    ScheduledTime NVARCHAR(20) NULL,
    Status INT NOT NULL CONSTRAINT DF_PoojaBookings_Status DEFAULT 1,
    Amount DECIMAL(18,2) NOT NULL,
    SpecialInstructions NVARCHAR(1000) NULL,
    Notes NVARCHAR(1000) NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_PoojaBookings_IsActive DEFAULT 1,
    CONSTRAINT FK_PoojaBookings_Users FOREIGN KEY (UserId) REFERENCES dbo.[Users](Id) ON DELETE NO ACTION,
    CONSTRAINT FK_PoojaBookings_PoojaServices FOREIGN KEY (PoojaServiceId) REFERENCES dbo.PoojaServices(Id) ON DELETE NO ACTION,
    CONSTRAINT FK_PoojaBookings_Astrologers FOREIGN KEY (AstrologerId) REFERENCES dbo.[Users](Id) ON DELETE SET NULL
);
GO

CREATE TABLE dbo.KundliRequests (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    UserId UNIQUEIDENTIFIER NOT NULL,
    Name NVARCHAR(200) NOT NULL,
    DateOfBirth DATETIME2 NOT NULL,
    TimeOfBirth NVARCHAR(20) NOT NULL,
    PlaceOfBirth NVARCHAR(200) NOT NULL,
    Gender NVARCHAR(20) NOT NULL,
    Status INT NOT NULL CONSTRAINT DF_KundliRequests_Status DEFAULT 1,
    Amount DECIMAL(18,2) NOT NULL,
    ReportUrl NVARCHAR(500) NULL,
    AssignedAstrologerId UNIQUEIDENTIFIER NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_KundliRequests_IsActive DEFAULT 1,
    CONSTRAINT FK_KundliRequests_Users FOREIGN KEY (UserId) REFERENCES dbo.[Users](Id) ON DELETE NO ACTION
);
GO

CREATE TABLE dbo.UserSubscriptions (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    UserId UNIQUEIDENTIFIER NOT NULL,
    SubscriptionPlanId UNIQUEIDENTIFIER NOT NULL,
    StartDate DATETIME2 NOT NULL,
    EndDate DATETIME2 NOT NULL,
    AutoRenew BIT NOT NULL CONSTRAINT DF_UserSubscriptions_AutoRenew DEFAULT 1,
    Status NVARCHAR(50) NOT NULL CONSTRAINT DF_UserSubscriptions_Status DEFAULT N'active',
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_UserSubscriptions_IsActive DEFAULT 1,
    CONSTRAINT FK_UserSubscriptions_Users FOREIGN KEY (UserId) REFERENCES dbo.[Users](Id) ON DELETE CASCADE,
    CONSTRAINT FK_UserSubscriptions_Plans FOREIGN KEY (SubscriptionPlanId) REFERENCES dbo.SubscriptionPlans(Id) ON DELETE NO ACTION
);
GO

-- ===================== USER ACTIVITY =====================
CREATE TABLE dbo.CartItems (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    UserId UNIQUEIDENTIFIER NOT NULL,
    ProductId UNIQUEIDENTIFIER NOT NULL,
    Quantity INT NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_CartItems_IsActive DEFAULT 1,
    CONSTRAINT FK_CartItems_Users FOREIGN KEY (UserId) REFERENCES dbo.[Users](Id) ON DELETE CASCADE,
    CONSTRAINT FK_CartItems_Products FOREIGN KEY (ProductId) REFERENCES dbo.Products(Id) ON DELETE CASCADE,
    CONSTRAINT UQ_CartItems_UserProduct UNIQUE (UserId, ProductId)
);
GO

CREATE TABLE dbo.WishlistItems (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    UserId UNIQUEIDENTIFIER NOT NULL,
    ProductId UNIQUEIDENTIFIER NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_WishlistItems_IsActive DEFAULT 1,
    CONSTRAINT FK_WishlistItems_Users FOREIGN KEY (UserId) REFERENCES dbo.[Users](Id) ON DELETE CASCADE,
    CONSTRAINT FK_WishlistItems_Products FOREIGN KEY (ProductId) REFERENCES dbo.Products(Id) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.Reviews (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    UserId UNIQUEIDENTIFIER NOT NULL,
    ProductId UNIQUEIDENTIFIER NOT NULL,
    Rating INT NOT NULL,
    Comment NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Reviews_IsActive DEFAULT 1,
    CONSTRAINT FK_Reviews_Users FOREIGN KEY (UserId) REFERENCES dbo.[Users](Id) ON DELETE CASCADE,
    CONSTRAINT FK_Reviews_Products FOREIGN KEY (ProductId) REFERENCES dbo.Products(Id) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.AstrologerReviews (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    UserId UNIQUEIDENTIFIER NOT NULL,
    AstrologerProfileId UNIQUEIDENTIFIER NOT NULL,
    Rating INT NOT NULL,
    Comment NVARCHAR(MAX) NOT NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_AstrologerReviews_IsActive DEFAULT 1,
    CONSTRAINT FK_AstrologerReviews_Users FOREIGN KEY (UserId) REFERENCES dbo.[Users](Id) ON DELETE CASCADE,
    CONSTRAINT FK_AstrologerReviews_Profiles FOREIGN KEY (AstrologerProfileId) REFERENCES dbo.AstrologerProfiles(Id) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.Notifications (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    UserId UNIQUEIDENTIFIER NOT NULL,
    Title NVARCHAR(200) NOT NULL,
    Message NVARCHAR(MAX) NOT NULL,
    [Type] NVARCHAR(50) NOT NULL CONSTRAINT DF_Notifications_Type DEFAULT N'info',
    IsRead BIT NOT NULL CONSTRAINT DF_Notifications_IsRead DEFAULT 0,
    Link NVARCHAR(500) NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_Notifications_IsActive DEFAULT 1,
    CONSTRAINT FK_Notifications_Users FOREIGN KEY (UserId) REFERENCES dbo.[Users](Id) ON DELETE CASCADE
);
GO

CREATE TABLE dbo.ContactQueries (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Name NVARCHAR(200) NOT NULL,
    Email NVARCHAR(256) NOT NULL,
    Phone NVARCHAR(20) NOT NULL,
    Subject NVARCHAR(300) NOT NULL,
    Message NVARCHAR(MAX) NOT NULL,
    IsResolved BIT NOT NULL CONSTRAINT DF_ContactQueries_IsResolved DEFAULT 0,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_ContactQueries_IsActive DEFAULT 1
);
GO

CREATE TABLE dbo.NewsletterSubscribers (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Email NVARCHAR(256) NOT NULL UNIQUE,
    IsConfirmed BIT NOT NULL CONSTRAINT DF_NewsletterSubscribers_IsConfirmed DEFAULT 0,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_NewsletterSubscribers_IsActive DEFAULT 1
);
GO

-- ===================== APPLICATION LOGS =====================
CREATE TABLE dbo.LoginLogs (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    UserId UNIQUEIDENTIFIER NULL,
    Email NVARCHAR(256) NOT NULL,
    Success BIT NOT NULL,
    IpAddress NVARCHAR(50) NULL,
    UserAgent NVARCHAR(500) NULL,
    FailureReason NVARCHAR(500) NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_LoginLogs_IsActive DEFAULT 1
);
GO

CREATE TABLE dbo.AuditLogs (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    UserId UNIQUEIDENTIFIER NULL,
    Action NVARCHAR(200) NOT NULL,
    EntityType NVARCHAR(100) NOT NULL,
    EntityId NVARCHAR(100) NULL,
    BeforeState NVARCHAR(MAX) NULL,
    AfterState NVARCHAR(MAX) NULL,
    IpAddress NVARCHAR(50) NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_AuditLogs_IsActive DEFAULT 1
);
GO

CREATE TABLE dbo.ErrorLogs (
    Id UNIQUEIDENTIFIER NOT NULL PRIMARY KEY,
    Message NVARCHAR(MAX) NOT NULL,
    StackTrace NVARCHAR(MAX) NULL,
    Source NVARCHAR(200) NULL,
    RequestPath NVARCHAR(500) NULL,
    UserId UNIQUEIDENTIFIER NULL,
    CreatedAt DATETIME2 NOT NULL,
    UpdatedAt DATETIME2 NULL,
    IsActive BIT NOT NULL CONSTRAINT DF_ErrorLogs_IsActive DEFAULT 1
);
GO

-- =============================================================================
-- SEED DATA
-- Enums: UserRole 1=SuperAdmin 2=Astrologer 3=Customer
--        OrderStatus 1=Pending 2=Confirmed 3=Processing 4=Shipped 5=OutForDelivery 6=Delivered
--        PaymentStatus 1=Pending 2=Success 3=Failed 4=Refunded
--        BookingStatus 1=Pending 2=Confirmed 3=InProgress 4=Completed 5=Cancelled
-- =============================================================================

-- ROLES
INSERT INTO dbo.[Roles] (Id, Name, Code, Description, IsSystem, CreatedAt, IsActive) VALUES
('r1000001-0000-0000-0000-000000000001', N'Super Admin', N'super-admin', N'Full platform access - manages users, orders, payments, logs', 1, GETUTCDATE(), 1),
('r1000001-0000-0000-0000-000000000002', N'Astrologer', N'astrologer', N'Manages consultations, pooja bookings, kundli reports', 1, GETUTCDATE(), 1),
('r1000001-0000-0000-0000-000000000003', N'Customer', N'customer', N'Shops, books poojas, requests kundli', 1, GETUTCDATE(), 1);
GO

-- PERMISSIONS
INSERT INTO dbo.[Permissions] (Id, Code, Name, Module, Description, CreatedAt, IsActive) VALUES
('p1000001-0000-0000-0000-000000000001', N'users.view', N'View Users', N'Users', N'View all user accounts', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000002', N'users.manage', N'Manage Users', N'Users', N'Create, edit, deactivate users', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000003', N'orders.view', N'View Orders', N'Orders', N'View all product orders', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000004', N'orders.manage', N'Manage Orders', N'Orders', N'Update order status and tracking', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000005', N'payments.view', N'View Payments', N'Payments', N'View all payment transactions', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000006', N'payments.refund', N'Refund Payments', N'Payments', N'Process payment refunds', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000007', N'pooja.view', N'View Pooja Bookings', N'Pooja', N'View all pooja bookings', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000008', N'pooja.manage', N'Manage Pooja Bookings', N'Pooja', N'Assign astrologers, update booking status', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000009', N'astrologers.view', N'View Astrologers', N'Astrologers', N'View astrologer profiles', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000010', N'astrologers.approve', N'Approve Astrologers', N'Astrologers', N'Approve or reject astrologer applications', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000011', N'products.manage', N'Manage Products', N'Catalog', N'Manage products and categories', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000012', N'reports.view', N'View Reports', N'Reports', N'View sales and analytics reports', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000013', N'settings.manage', N'Manage Settings', N'Settings', N'Update site configuration', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000014', N'logs.view', N'View Application Logs', N'Logs', N'View login, audit, and error logs', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000015', N'roles.manage', N'Manage Roles', N'RBAC', N'Manage roles and permissions', GETUTCDATE(), 1),
('p1000001-0000-0000-0000-000000000016', N'kundli.manage', N'Manage Kundli Requests', N'Kundli', N'Assign and complete kundli reports', GETUTCDATE(), 1);
GO

-- SUPER ADMIN: all permissions
INSERT INTO dbo.RolePermissions (Id, RoleId, PermissionId, CreatedAt, IsActive)
SELECT NEWID(), 'r1000001-0000-0000-0000-000000000001', Id, GETUTCDATE(), 1 FROM dbo.[Permissions];
GO

-- ASTROLOGER permissions
INSERT INTO dbo.RolePermissions (Id, RoleId, PermissionId, CreatedAt, IsActive) VALUES
(NEWID(), 'r1000001-0000-0000-0000-000000000002', 'p1000001-0000-0000-0000-000000000007', GETUTCDATE(), 1),
(NEWID(), 'r1000001-0000-0000-0000-000000000002', 'p1000001-0000-0000-0000-000000000008', GETUTCDATE(), 1),
(NEWID(), 'r1000001-0000-0000-0000-000000000002', 'p1000001-0000-0000-0000-000000000016', GETUTCDATE(), 1);
GO

-- USERS
INSERT INTO dbo.[Users] (Id, Email, Phone, PasswordHash, FirstName, LastName, [Role], RoleId, EmailVerified, PhoneVerified, CreatedAt, IsActive) VALUES
('a1000001-0000-0000-0000-000000000001', N'admin@vadicmall.com', NULL, N'$2a$11$TVxfgC673/nIl9GU221EwOooamyFBI9.gpuGTIlAEitI3BHVlFqsK', N'Super', N'Admin', 1, 'r1000001-0000-0000-0000-000000000001', 1, 0, GETUTCDATE(), 1),
('a1000001-0000-0000-0000-000000000002', N'customer@vadicmall.com', N'+91 9876543210', N'$2a$11$GAfjZf3mb1eX7Rv4zEX1MuobAcbrWJ89hoZp4RvjEB/A4twI22u4.', N'Demo', N'Customer', 3, 'r1000001-0000-0000-0000-000000000003', 1, 0, GETUTCDATE(), 1),
('a1000001-0000-0000-0000-000000000003', N'pandit.sharma@vadicmall.com', NULL, N'$2a$11$e9rLxmhi2NA7sS4BwJDhZuZluAK.hntzPNGJR1AwzVDw4f.nMAQve', N'Pandit', N'Sharma', 2, 'r1000001-0000-0000-0000-000000000002', 1, 0, GETUTCDATE(), 1),
('a1000001-0000-0000-0000-000000000004', N'dr.venkatesh@vadicmall.com', NULL, N'$2a$11$e9rLxmhi2NA7sS4BwJDhZuZluAK.hntzPNGJR1AwzVDw4f.nMAQve', N'Dr.', N'Venkatesh', 2, 'r1000001-0000-0000-0000-000000000002', 1, 0, GETUTCDATE(), 1),
('a1000001-0000-0000-0000-000000000005', N'acharya.mishra@vadicmall.com', NULL, N'$2a$11$e9rLxmhi2NA7sS4BwJDhZuZluAK.hntzPNGJR1AwzVDw4f.nMAQve', N'Acharya', N'Mishra', 2, 'r1000001-0000-0000-0000-000000000002', 1, 0, GETUTCDATE(), 1),
('a1000001-0000-0000-0000-000000000006', N'guru.anand@vadicmall.com', NULL, N'$2a$11$e9rLxmhi2NA7sS4BwJDhZuZluAK.hntzPNGJR1AwzVDw4f.nMAQve', N'Guru', N'Anand', 2, 'r1000001-0000-0000-0000-000000000002', 1, 0, GETUTCDATE(), 1),
('a1000001-0000-0000-0000-000000000007', N'pandit.rao@vadicmall.com', NULL, N'$2a$11$e9rLxmhi2NA7sS4BwJDhZuZluAK.hntzPNGJR1AwzVDw4f.nMAQve', N'Pandit', N'Rao', 2, 'r1000001-0000-0000-0000-000000000002', 1, 0, GETUTCDATE(), 1);
GO

INSERT INTO dbo.AstrologerProfiles (Id, UserId, Specialization, Bio, ExperienceYears, ConsultationFee, Rating, ReviewCount, IsApproved, IsFeatured, Languages, CreatedAt, IsActive) VALUES
('b2000001-0000-0000-0000-000000000001', 'a1000001-0000-0000-0000-000000000003', N'Vedic Astrology', N'25 years of experience in Vedic astrology and pooja rituals.', 25, 999.00, 4.9, 342, 1, 1, N'Hindi, English, Sanskrit', GETUTCDATE(), 1),
('b2000001-0000-0000-0000-000000000002', 'a1000001-0000-0000-0000-000000000004', N'Marriage Astrology', N'Expert in marriage compatibility and relationship counseling.', 18, 799.00, 4.8, 256, 1, 1, N'Hindi, English, Sanskrit', GETUTCDATE(), 1),
('b2000001-0000-0000-0000-000000000003', 'a1000001-0000-0000-0000-000000000005', N'Career Astrology', N'Specializes in career guidance through planetary analysis.', 15, 699.00, 4.7, 189, 1, 0, N'Hindi, English, Sanskrit', GETUTCDATE(), 1),
('b2000001-0000-0000-0000-000000000004', 'a1000001-0000-0000-0000-000000000006', N'Nadi Astrology', N'Renowned Nadi astrologer with ancient palm leaf readings.', 30, 1499.00, 4.9, 412, 1, 1, N'Hindi, English, Sanskrit', GETUTCDATE(), 1),
('b2000001-0000-0000-0000-000000000005', 'a1000001-0000-0000-0000-000000000007', N'Medical Astrology', N'Combines Ayurveda with astrological health remedies.', 20, 899.00, 4.6, 167, 1, 0, N'Hindi, English, Sanskrit', GETUTCDATE(), 1);
GO

INSERT INTO dbo.PoojaServices (Id, Name, Slug, Category, Description, Price, SalePrice, DurationMinutes, ImageUrl, IsFeatured, Rating, ReviewCount, FestivalTag, CreatedAt, IsActive) VALUES
('c3000001-0000-0000-0000-000000000001', N'Ganesh Puja', N'ganesh-puja', N'Ganesh Puja', N'Remove obstacles and invite prosperity with authentic Ganesh Puja.', 2100.00, 1800.00, 90, N'/images/pooja/ganesh-puja.jpg', 1, 4.9, 120, N'Ganesh Chaturthi', GETUTCDATE(), 1),
('c3000001-0000-0000-0000-000000000002', N'Satyanarayan Puja', N'satyanarayan-puja', N'Satyanarayan Puja', N'Sacred puja for peace, prosperity and fulfillment of wishes.', 3500.00, NULL, 120, N'/images/pooja/satyanarayan-puja.jpg', 1, 4.5, 85, NULL, GETUTCDATE(), 1),
('c3000001-0000-0000-0000-000000000003', N'Griha Pravesh', N'griha-pravesh', N'Griha Pravesh', N'House warming ceremony for positive energy in your new home.', 5100.00, 4590.00, 180, N'/images/pooja/griha-pravesh.jpg', 1, 4.8, 95, NULL, GETUTCDATE(), 1),
('c3000001-0000-0000-0000-000000000004', N'Navgraha Shanti', N'navgraha-shanti', N'Navgraha Shanti', N'Pacify all nine planets for harmony and success.', 7500.00, NULL, 240, N'/images/pooja/navgraha-shanti.jpg', 0, 4.6, 70, N'Navratri', GETUTCDATE(), 1),
('c3000001-0000-0000-0000-000000000005', N'Rudrabhishek', N'rudrabhishek', N'Rudrabhishek', N'Powerful Shiva worship for spiritual growth and protection.', 4100.00, 3280.00, 150, N'/images/pooja/rudrabhishek.jpg', 1, 4.7, 110, N'Maha Shivratri', GETUTCDATE(), 1),
('c3000001-0000-0000-0000-000000000006', N'Durga Puja', N'durga-puja', N'Durga Puja', N'Invoke Goddess Durga for strength and victory over obstacles.', 5500.00, 4125.00, 180, N'/images/pooja/durga-puja.jpg', 1, 4.8, 130, N'Navratri', GETUTCDATE(), 1),
('c3000001-0000-0000-0000-000000000007', N'Lakshmi Puja', N'lakshmi-puja', N'Lakshmi Puja', N'Attract wealth and abundance with sacred Lakshmi worship.', 3100.00, 2170.00, 120, N'/images/pooja/lakshmi-puja.jpg', 1, 4.9, 150, N'Diwali', GETUTCDATE(), 1),
('c3000001-0000-0000-0000-000000000008', N'Mundan Sanskar', N'mundan-sanskar', N'Mundan Sanskar', N'Traditional first haircut ceremony for children.', 2100.00, NULL, 60, N'/images/pooja/mundan-sanskar.jpg', 0, 4.5, 60, NULL, GETUTCDATE(), 1),
('c3000001-0000-0000-0000-000000000009', N'Vivah Puja', N'vivah-puja', N'Vivah Puja', N'Complete Vedic wedding ceremony with all rituals.', 15000.00, NULL, 360, N'/images/pooja/vivah-puja.jpg', 1, 4.9, 45, NULL, GETUTCDATE(), 1),
('c3000001-0000-0000-0000-000000000010', N'Yajna', N'yajna', N'Yajna', N'Sacred fire ritual for purification and divine blessings.', 8500.00, NULL, 300, N'/images/pooja/yajna.jpg', 0, 4.6, 55, NULL, GETUTCDATE(), 1);
GO

INSERT INTO dbo.ProductCategories (Id, Name, Slug, Description, CreatedAt, IsActive) VALUES
('d4000001-0000-0000-0000-000000000001', N'Gemstones', N'gemstones', N'Authentic Gemstones for spiritual practice', GETUTCDATE(), 1),
('d4000001-0000-0000-0000-000000000002', N'Malas', N'malas', N'Authentic Malas for spiritual practice', GETUTCDATE(), 1),
('d4000001-0000-0000-0000-000000000003', N'Pooja Samagri', N'pooja-samagri', N'Authentic Pooja Samagri for spiritual practice', GETUTCDATE(), 1),
('d4000001-0000-0000-0000-000000000004', N'Spiritual Books', N'spiritual-books', N'Authentic Spiritual Books for spiritual practice', GETUTCDATE(), 1),
('d4000001-0000-0000-0000-000000000005', N'Idols & Images', N'idols', N'Authentic Idols & Images for spiritual practice', GETUTCDATE(), 1),
('d4000001-0000-0000-0000-000000000006', N'Yantras', N'yantras', N'Authentic Yantras for spiritual practice', GETUTCDATE(), 1),
('d4000001-0000-0000-0000-000000000007', N'Rudraksha', N'rudraksha', N'Authentic Rudraksha for spiritual practice', GETUTCDATE(), 1),
('d4000001-0000-0000-0000-000000000008', N'Home Decor', N'home-decor', N'Authentic Home Decor for spiritual practice', GETUTCDATE(), 1);
GO

INSERT INTO dbo.Products (Id, Name, Slug, Description, CategoryId, Price, SalePrice, StockQuantity, Sku, Rating, ReviewCount, IsFeatured, FestivalTag, CreatedAt, IsActive) VALUES
('e5000001-0000-0000-0000-000000000001', N'Natural Ruby (Manik)', N'ruby-manik', N'Certified natural ruby for Sun planet remedies.', 'd4000001-0000-0000-0000-000000000001', 25000.00, 22500.00, 15, N'VM-RUBY-01', 4.5, 80, 1, N'Diwali', GETUTCDATE(), 1),
('e5000001-0000-0000-0000-000000000002', N'Blue Sapphire (Neelam)', N'blue-sapphire', N'Premium Ceylon blue sapphire for Saturn.', 'd4000001-0000-0000-0000-000000000001', 45000.00, NULL, 8, N'VM-BLUE-01', 4.5, 45, 1, NULL, GETUTCDATE(), 1),
('e5000001-0000-0000-0000-000000000003', N'5 Mukhi Rudraksha Mala', N'rudraksha-mala-5', N'Authentic Nepali 5 Mukhi Rudraksha mala, 108 beads.', 'd4000001-0000-0000-0000-000000000002', 1200.00, 960.00, 50, N'VM-MALA-01', 4.5, 120, 1, N'Maha Shivratri', GETUTCDATE(), 1),
('e5000001-0000-0000-0000-000000000004', N'Puja Thali Set (Brass)', N'puja-thali-brass', N'Complete brass puja thali with diya, bell, and kalash.', 'd4000001-0000-0000-0000-000000000003', 899.00, NULL, 100, N'VM-THALI-01', 4.4, 90, 0, NULL, GETUTCDATE(), 1),
('e5000001-0000-0000-0000-000000000005', N'Bhagavad Gita (Hindi)', N'bhagavad-gita-hindi', N'Illustrated Bhagavad Gita with commentary.', 'd4000001-0000-0000-0000-000000000004', 350.00, 280.00, 200, N'VM-GITA-01', 4.8, 150, 1, NULL, GETUTCDATE(), 1),
('e5000001-0000-0000-0000-000000000006', N'Brass Ganesha Idol', N'ganesha-idol-brass', N'Handcrafted brass Ganesha idol, 6 inches.', 'd4000001-0000-0000-0000-000000000005', 1499.00, 1199.00, 30, N'VM-GANESHA-01', 4.6, 75, 1, N'Ganesh Chaturthi', GETUTCDATE(), 1),
('e5000001-0000-0000-0000-000000000007', N'Sri Yantra (Copper)', N'sri-yantra-copper', N'Energized Sri Yantra for prosperity and success.', 'd4000001-0000-0000-0000-000000000006', 2100.00, NULL, 25, N'VM-YANTRA-01', 4.7, 60, 1, N'Diwali', GETUTCDATE(), 1),
('e5000001-0000-0000-0000-000000000008', N'7 Mukhi Rudraksha', N'rudraksha-7-mukhi', N'Rare 7 Mukhi Rudraksha from Nepal.', 'd4000001-0000-0000-0000-000000000007', 3500.00, 2800.00, 12, N'VM-RUDRA-01', 4.5, 40, 0, NULL, GETUTCDATE(), 1),
('e5000001-0000-0000-0000-000000000009', N'Incense Sticks Set', N'incense-sticks-set', N'Premium sandalwood and rose incense, 12 packs.', 'd4000001-0000-0000-0000-000000000003', 499.00, NULL, 150, N'VM-INCENSE-01', 4.3, 110, 0, NULL, GETUTCDATE(), 1),
('e5000001-0000-0000-0000-000000000010', N'Krishna Wall Hanging', N'krishna-wall-hanging', N'Beautiful Krishna devotional wall art with frame.', 'd4000001-0000-0000-0000-000000000008', 799.00, 639.00, 40, N'VM-KRISHNA-01', 4.6, 55, 1, N'Krishna Janmashtami', GETUTCDATE(), 1),
('e5000001-0000-0000-0000-000000000011', N'Yellow Sapphire (Pukhraj)', N'yellow-sapphire', N'Natural yellow sapphire for Jupiter blessings.', 'd4000001-0000-0000-0000-000000000001', 35000.00, 31500.00, 6, N'VM-PUKHRAJ-01', 4.8, 35, 1, NULL, GETUTCDATE(), 1),
('e5000001-0000-0000-0000-000000000012', N'Tulsi Mala', N'tulsi-mala', N'Sacred Tulsi mala for chanting and meditation.', 'd4000001-0000-0000-0000-000000000002', 299.00, NULL, 80, N'VM-TULSI-01', 4.4, 95, 0, NULL, GETUTCDATE(), 1);
GO

INSERT INTO dbo.ProductImages (Id, ProductId, ImageUrl, IsPrimary, SortOrder, CreatedAt, IsActive) VALUES
('f6000001-0000-0000-0000-000000000001', 'e5000001-0000-0000-0000-000000000001', N'/images/products/ruby-manik.jpg', 1, 0, GETUTCDATE(), 1),
('f6000001-0000-0000-0000-000000000002', 'e5000001-0000-0000-0000-000000000002', N'/images/products/blue-sapphire.jpg', 1, 0, GETUTCDATE(), 1),
('f6000001-0000-0000-0000-000000000003', 'e5000001-0000-0000-0000-000000000003', N'/images/products/rudraksha-mala-5.jpg', 1, 0, GETUTCDATE(), 1),
('f6000001-0000-0000-0000-000000000004', 'e5000001-0000-0000-0000-000000000004', N'/images/products/puja-thali-brass.jpg', 1, 0, GETUTCDATE(), 1),
('f6000001-0000-0000-0000-000000000005', 'e5000001-0000-0000-0000-000000000005', N'/images/products/bhagavad-gita-hindi.jpg', 1, 0, GETUTCDATE(), 1),
('f6000001-0000-0000-0000-000000000006', 'e5000001-0000-0000-0000-000000000006', N'/images/products/ganesha-idol-brass.jpg', 1, 0, GETUTCDATE(), 1),
('f6000001-0000-0000-0000-000000000007', 'e5000001-0000-0000-0000-000000000007', N'/images/products/sri-yantra-copper.jpg', 1, 0, GETUTCDATE(), 1),
('f6000001-0000-0000-0000-000000000008', 'e5000001-0000-0000-0000-000000000008', N'/images/products/rudraksha-7-mukhi.jpg', 1, 0, GETUTCDATE(), 1),
('f6000001-0000-0000-0000-000000000009', 'e5000001-0000-0000-0000-000000000009', N'/images/products/incense-sticks-set.jpg', 1, 0, GETUTCDATE(), 1),
('f6000001-0000-0000-0000-000000000010', 'e5000001-0000-0000-0000-000000000010', N'/images/products/krishna-wall-hanging.jpg', 1, 0, GETUTCDATE(), 1),
('f6000001-0000-0000-0000-000000000011', 'e5000001-0000-0000-0000-000000000011', N'/images/products/yellow-sapphire.jpg', 1, 0, GETUTCDATE(), 1),
('f6000001-0000-0000-0000-000000000012', 'e5000001-0000-0000-0000-000000000012', N'/images/products/tulsi-mala.jpg', 1, 0, GETUTCDATE(), 1);
GO

INSERT INTO dbo.SubscriptionPlans (Id, Name, Slug, Description, Price, BillingCycle, Features, IsPopular, CreatedAt, IsActive) VALUES
('g7000001-0000-0000-0000-000000000001', N'Basic', N'basic', N'Monthly horoscope and kundli checks', 199.00, N'monthly', N'["Monthly Horoscope","2 Kundli Checks","Astrology Articles"]', 0, GETUTCDATE(), 1),
('g7000001-0000-0000-0000-000000000002', N'Premium', N'premium', N'Weekly horoscope with pooja bookings', 499.00, N'monthly', N'["Weekly Horoscope","5 Kundli Checks","2 Pooja Bookings","Chat Support"]', 1, GETUTCDATE(), 1),
('g7000001-0000-0000-0000-000000000003', N'Elite', N'elite', N'Daily horoscope with unlimited kundli', 999.00, N'monthly', N'["Daily Horoscope","Unlimited Kundli","10 Pooja Bookings","Astrologer Chat","Priority Support"]', 0, GETUTCDATE(), 1),
('g7000001-0000-0000-0000-000000000004', N'Family', N'family', N'Elite features for 5 family members', 1999.00, N'monthly', N'["5 Members","All Elite Features","Family Pooja","Group Consultations"]', 0, GETUTCDATE(), 1),
('g7000001-0000-0000-0000-000000000005', N'Business', N'business', N'For professional astrologers', 4999.00, N'monthly', N'["20+ Services","Priority Listing","Advanced Analytics","Dedicated Support"]', 0, GETUTCDATE(), 1);
GO

INSERT INTO dbo.Coupons (Id, Code, Description, [Type], [Value], MinOrderValue, MaxDiscount, UsageLimit, UsedCount, ValidFrom, ValidTo, FestivalTag, CreatedAt, IsActive) VALUES
('h8000001-0000-0000-0000-000000000001', N'DIWALI30', N'Diwali special 30% off', 1, 30.00, 500.00, 2000.00, 1000, 0, DATEADD(DAY, -30, GETUTCDATE()), DATEADD(DAY, 60, GETUTCDATE()), N'Diwali', GETUTCDATE(), 1),
('h8000001-0000-0000-0000-000000000002', N'WELCOME100', N'Welcome discount for new users', 2, 100.00, 999.00, NULL, 5000, 0, DATEADD(DAY, -90, GETUTCDATE()), DATEADD(DAY, 365, GETUTCDATE()), NULL, GETUTCDATE(), 1),
('h8000001-0000-0000-0000-000000000003', N'NAVRATRI25', N'Navratri festival discount', 1, 25.00, 1000.00, 1500.00, 500, 0, DATEADD(DAY, -10, GETUTCDATE()), DATEADD(DAY, 30, GETUTCDATE()), N'Navratri', GETUTCDATE(), 1);
GO

INSERT INTO dbo.BlogCategories (Id, Name, Slug, CreatedAt, IsActive) VALUES
('i9000001-0000-0000-0000-000000000001', N'Astrology Tips', N'astrology-tips', GETUTCDATE(), 1);
GO

INSERT INTO dbo.BlogPosts (Id, Title, Slug, Excerpt, Content, ImageUrl, Author, CategoryId, ViewCount, CreatedAt, IsActive) VALUES
('j1000001-0000-0000-0000-000000000001', N'Understanding Your Birth Chart', N'understanding-birth-chart', N'Learn the basics of Vedic birth chart interpretation.', N'Your birth chart, or Kundli, is a cosmic snapshot of the sky at the moment of your birth.', N'/images/blog/birth-chart.jpg', N'Pandit Sharma', 'i9000001-0000-0000-0000-000000000001', 1250, GETUTCDATE(), 1),
('j1000001-0000-0000-0000-000000000002', N'Diwali Puja Guide 2026', N'diwali-puja-guide', N'Complete guide to performing Lakshmi Puja this Diwali.', N'Diwali, the festival of lights, is the perfect time for Lakshmi Puja.', N'/images/blog/diwali-guide.jpg', N'Acharya Mishra', 'i9000001-0000-0000-0000-000000000001', 890, GETUTCDATE(), 1),
('j1000001-0000-0000-0000-000000000003', N'Gemstones and Planetary Remedies', N'gemstones-planetary-remedies', N'How to choose the right gemstone for your planetary dosha.', N'In Vedic astrology, gemstones are powerful tools for balancing planetary energies.', N'/images/blog/gemstones.jpg', N'Dr. Venkatesh', 'i9000001-0000-0000-0000-000000000001', 654, GETUTCDATE(), 1);
GO

INSERT INTO dbo.Faqs (Id, Question, Answer, Category, SortOrder, CreatedAt, IsActive) VALUES
('k1100001-0000-0000-0000-000000000001', N'How do I book a pooja service?', N'Browse our pooja catalog, select a service, choose date and time, and complete payment.', N'Pooja', 1, GETUTCDATE(), 1),
('k1100001-0000-0000-0000-000000000002', N'Are gemstones certified?', N'Yes, all our gemstones come with authenticity certificates.', N'Products', 2, GETUTCDATE(), 1),
('k1100001-0000-0000-0000-000000000003', N'How long does kundli analysis take?', N'Standard kundli analysis is delivered within 24-48 hours.', N'Kundli', 3, GETUTCDATE(), 1),
('k1100001-0000-0000-0000-000000000004', N'What payment methods are accepted?', N'We accept UPI, cards, net banking, wallets, and COD.', N'Payment', 4, GETUTCDATE(), 1),
('k1100001-0000-0000-0000-000000000005', N'Can I cancel a pooja booking?', N'Yes, cancellations 48 hours before receive a full refund.', N'Pooja', 5, GETUTCDATE(), 1);
GO

INSERT INTO dbo.Settings (Id, [Key], [Value], Description, CreatedAt, IsActive) VALUES
('l1200001-0000-0000-0000-000000000001', N'site_name', N'Vadic Mall', N'Application name', GETUTCDATE(), 1),
('l1200001-0000-0000-0000-000000000002', N'support_email', N'info@vadicmall.com', N'Support email', GETUTCDATE(), 1),
('l1200001-0000-0000-0000-000000000003', N'support_phone', N'+91 98765 43210', N'Support phone', GETUTCDATE(), 1),
('l1200001-0000-0000-0000-000000000004', N'free_shipping_threshold', N'999', N'Free shipping above this amount', GETUTCDATE(), 1);
GO

-- SAMPLE: customer address, order, tracking, payment
INSERT INTO dbo.Addresses (Id, UserId, FullName, Phone, AddressLine1, City, State, Pincode, Country, IsDefault, CreatedAt, IsActive) VALUES
('m1000001-0000-0000-0000-000000000001', 'a1000001-0000-0000-0000-000000000002', N'Demo Customer', N'+91 9876543210', N'123 Temple Road', N'Varanasi', N'Uttar Pradesh', N'221001', N'India', 1, GETUTCDATE(), 1);
GO

INSERT INTO dbo.Orders (Id, OrderNumber, UserId, Status, SubTotal, Discount, ShippingFee, Total, CouponCode, ShippingAddressId, TrackingNumber, CreatedAt, IsActive) VALUES
('n1000001-0000-0000-0000-000000000001', N'VM-2026-00001', 'a1000001-0000-0000-0000-000000000002', 4, 22500.00, 2500.00, 0.00, 20000.00, N'DIWALI30', 'm1000001-0000-0000-0000-000000000001', N'VMTRK123456789', GETUTCDATE(), 1);
GO

INSERT INTO dbo.OrderItems (Id, OrderId, ProductId, Quantity, UnitPrice, TotalPrice, CreatedAt, IsActive) VALUES
('o1000001-0000-0000-0000-000000000001', 'n1000001-0000-0000-0000-000000000001', 'e5000001-0000-0000-0000-000000000001', 1, 22500.00, 22500.00, GETUTCDATE(), 1);
GO

INSERT INTO dbo.OrderTracking (Id, OrderId, Status, Notes, Location, CreatedAt, IsActive) VALUES
('t1000001-0000-0000-0000-000000000001', 'n1000001-0000-0000-0000-000000000001', 2, N'Order confirmed by admin', N'Varanasi Warehouse', DATEADD(HOUR, -48, GETUTCDATE()), 1),
('t1000001-0000-0000-0000-000000000002', 'n1000001-0000-0000-0000-000000000001', 3, N'Order packed and ready', N'Varanasi Warehouse', DATEADD(HOUR, -24, GETUTCDATE()), 1),
('t1000001-0000-0000-0000-000000000003', 'n1000001-0000-0000-0000-000000000001', 4, N'Shipped via BlueDart', N'In Transit', DATEADD(HOUR, -12, GETUTCDATE()), 1);
GO

INSERT INTO dbo.Payments (Id, OrderId, Amount, Status, PaymentMethod, TransactionId, GatewayResponse, CreatedAt, IsActive) VALUES
('p1100001-0000-0000-0000-000000000001', 'n1000001-0000-0000-0000-000000000001', 20000.00, 2, N'UPI', N'pay_VM202600001', N'{"status":"captured","gateway":"razorpay"}', GETUTCDATE(), 1);
GO

INSERT INTO dbo.PaymentTransactions (Id, UserId, PaymentType, ReferenceId, Amount, Status, PaymentMethod, TransactionId, Notes, CreatedAt, IsActive) VALUES
('p1100001-0000-0000-0000-000000000002', 'a1000001-0000-0000-0000-000000000002', N'Order', 'n1000001-0000-0000-0000-000000000001', 20000.00, 2, N'UPI', N'pay_VM202600001', N'Product order payment', GETUTCDATE(), 1);
GO

INSERT INTO dbo.PoojaBookings (Id, UserId, PoojaServiceId, AstrologerId, ScheduledDate, ScheduledTime, Status, Amount, SpecialInstructions, CreatedAt, IsActive) VALUES
('q1000001-0000-0000-0000-000000000001', 'a1000001-0000-0000-0000-000000000002', 'c3000001-0000-0000-0000-000000000001', 'a1000001-0000-0000-0000-000000000003', DATEADD(DAY, 7, GETUTCDATE()), N'09:00 AM', 2, 1800.00, N'Please perform at home altar', GETUTCDATE(), 1);
GO

INSERT INTO dbo.PaymentTransactions (Id, UserId, PaymentType, ReferenceId, Amount, Status, PaymentMethod, TransactionId, Notes, CreatedAt, IsActive) VALUES
('p1100001-0000-0000-0000-000000000003', 'a1000001-0000-0000-0000-000000000002', N'PoojaBooking', 'q1000001-0000-0000-0000-000000000001', 1800.00, 2, N'Card', N'pay_POOJA001', N'Ganesh Puja booking payment', GETUTCDATE(), 1);
GO

INSERT INTO dbo.KundliRequests (Id, UserId, Name, DateOfBirth, TimeOfBirth, PlaceOfBirth, Gender, Status, Amount, AssignedAstrologerId, CreatedAt, IsActive) VALUES
('k1100001-0000-0000-0000-000000000001', 'a1000001-0000-0000-0000-000000000002', N'Demo Customer', '1990-05-15', N'06:30 AM', N'Varanasi, India', N'Male', 2, 499.00, 'a1000001-0000-0000-0000-000000000003', GETUTCDATE(), 1);
GO

INSERT INTO dbo.PaymentTransactions (Id, UserId, PaymentType, ReferenceId, Amount, Status, PaymentMethod, TransactionId, Notes, CreatedAt, IsActive) VALUES
('p1100001-0000-0000-0000-000000000004', 'a1000001-0000-0000-0000-000000000002', N'Kundli', 'k1100001-0000-0000-0000-000000000001', 499.00, 2, N'UPI', N'pay_KUNDLI001', N'Kundli analysis payment', GETUTCDATE(), 1);
GO

-- APPLICATION LOGS
INSERT INTO dbo.LoginLogs (Id, UserId, Email, Success, IpAddress, UserAgent, CreatedAt, IsActive) VALUES
('l1100001-0000-0000-0000-000000000001', 'a1000001-0000-0000-0000-000000000001', N'admin@vadicmall.com', 1, N'192.168.1.1', N'Mozilla/5.0 SSMS Admin', GETUTCDATE(), 1),
('l1100001-0000-0000-0000-000000000002', 'a1000001-0000-0000-0000-000000000002', N'customer@vadicmall.com', 1, N'192.168.1.50', N'Mozilla/5.0 Chrome', GETUTCDATE(), 1),
('l1100001-0000-0000-0000-000000000003', NULL, N'hacker@example.com', 0, N'10.0.0.99', N'curl/7.68', GETUTCDATE(), 1);
GO

UPDATE dbo.LoginLogs SET FailureReason = N'Invalid credentials' WHERE Id = 'l1100001-0000-0000-0000-000000000003';
GO

INSERT INTO dbo.AuditLogs (Id, UserId, Action, EntityType, EntityId, BeforeState, AfterState, IpAddress, CreatedAt, IsActive) VALUES
('a1100001-0000-0000-0000-000000000001', 'a1000001-0000-0000-0000-000000000001', N'OrderStatusUpdated', N'Order', N'n1000001-0000-0000-0000-000000000001', N'{"status":2}', N'{"status":4}', N'192.168.1.1', GETUTCDATE(), 1),
('a1100001-0000-0000-0000-000000000002', 'a1000001-0000-0000-0000-000000000001', N'AstrologerApproved', N'AstrologerProfile', N'b2000001-0000-0000-0000-000000000001', N'{"IsApproved":false}', N'{"IsApproved":true}', N'192.168.1.1', GETUTCDATE(), 1);
GO

INSERT INTO dbo.ErrorLogs (Id, Message, StackTrace, Source, RequestPath, UserId, CreatedAt, IsActive) VALUES
('e1100001-0000-0000-0000-000000000001', N'Payment gateway timeout', N'at PaymentService.ChargeAsync line 42', N'VadicMall.Api', N'/api/payments/charge', 'a1000001-0000-0000-0000-000000000002', GETUTCDATE(), 1);
GO

PRINT N'Vadic Mall complete database created: 36 tables, RBAC, orders, payments, tracking, logs.';
GO

SELECT t.name AS TableName FROM sys.tables t WHERE t.schema_id = SCHEMA_ID(N'dbo') ORDER BY t.name;
GO
