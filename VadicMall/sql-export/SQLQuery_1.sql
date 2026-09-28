-- ============================================================
-- VADIC MALL - SEED DATA FOR ROLES, USERS & ROLEPERMISSIONS
-- FIXED: Role column uses int (not string), RoleId uses uniqueidentifier
-- ============================================================

-- ============================================================
-- 1. SEED ROLES TABLE (with specific IDs for reference)
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM [dbo].[Roles] WHERE [Code] = 'SuperAdmin')
BEGIN
    INSERT INTO [dbo].[Roles] ([Id], [Name], [Code], [Description], [IsSystem], [CreatedAt], [UpdatedAt], [IsActive]) VALUES
    (N'11111111-1111-1111-1111-111111111111', 'Super Admin', 'SuperAdmin', 'Full access - can view and manage everything including users, roles, permissions, billing, payments, orders, products, pooja services', 1, GETDATE(), NULL, 1),
    (N'22222222-2222-2222-2222-222222222222', 'Astrologer', 'Astrologer', 'Can see assigned pooja bookings, manage booking status, view customer details, manage payment status for assigned bookings', 1, GETDATE(), NULL, 1),
    (N'33333333-3333-3333-3333-333333333333', 'Customer', 'Customer', 'Can order products, book pooja, get kundli, view own bookings, orders, product status, pooja status, assigned astrologer details', 1, GETDATE(), NULL, 1);
    PRINT '✅ Roles seeded successfully';
END
ELSE
    PRINT 'ℹ️ Roles already exist, skipping...';

-- ============================================================
-- 2. GET ROLE IDs FOR REFERENCE
-- ============================================================
DECLARE @SuperAdminRoleId UNIQUEIDENTIFIER = (SELECT TOP 1 [Id] FROM [dbo].[Roles] WHERE [Code] = 'SuperAdmin');
DECLARE @AstrologerRoleId UNIQUEIDENTIFIER = (SELECT TOP 1 [Id] FROM [dbo].[Roles] WHERE [Code] = 'Astrologer');
DECLARE @CustomerRoleId UNIQUEIDENTIFIER = (SELECT TOP 1 [Id] FROM [dbo].[Roles] WHERE [Code] = 'Customer');

-- ============================================================
-- 3. SEED SUPERADMIN USER
-- ============================================================
-- Role column uses INT: 1 = SuperAdmin, 2 = Astrologer, 3 = Customer
IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [Email] = 'admin@vedicastro.com')
BEGIN
    INSERT INTO [dbo].[Users] (
        [Id], [Email], [Phone], [PasswordHash], [FirstName], [LastName], 
        [AvatarUrl], [Role], [RoleId], [EmailVerified], [PhoneVerified], 
        [LastLoginAt], [RefreshToken], [RefreshTokenExpiry], [CreatedAt], [UpdatedAt], [IsActive]
    ) VALUES (
        N'AAAAAAAA-AAAA-AAAA-AAAA-AAAAAAAAAAAA',
        'admin@vedicastro.com',
        '9999999999',
        'Admin@123',  -- Will be hashed by API on first login
        'Super',
        'Admin',
        NULL,
        1,  -- INT: 1 = SuperAdmin
        @SuperAdminRoleId,  -- GUID reference
        1,
        1,
        NULL,
        NULL,
        NULL,
        GETDATE(),
        NULL,
        1
    );
    PRINT '✅ SuperAdmin user created (Role: 1)';
END
ELSE
    PRINT 'ℹ️ SuperAdmin user already exists';

-- ============================================================
-- 4. SEED ASTROLOGER USER
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [Email] = 'astrologer@vedicastro.com')
BEGIN
    INSERT INTO [dbo].[Users] (
        [Id], [Email], [Phone], [PasswordHash], [FirstName], [LastName], 
        [AvatarUrl], [Role], [RoleId], [EmailVerified], [PhoneVerified], 
        [LastLoginAt], [RefreshToken], [RefreshTokenExpiry], [CreatedAt], [UpdatedAt], [IsActive]
    ) VALUES (
        N'BBBBBBBB-BBBB-BBBB-BBBB-BBBBBBBBBBBB',
        'astrologer@vedicastro.com',
        '8888888888',
        'Astro@123',  -- Will be hashed by API on first login
        'Raj',
        'Sharma',
        NULL,
        2,  -- INT: 2 = Astrologer
        @AstrologerRoleId,  -- GUID reference
        1,
        1,
        NULL,
        NULL,
        NULL,
        GETDATE(),
        NULL,
        1
    );
    PRINT '✅ Astrologer user created (Role: 2)';
END
ELSE
    PRINT 'ℹ️ Astrologer user already exists';

-- ============================================================
-- 5. SEED CUSTOMER USER
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM [dbo].[Users] WHERE [Email] = 'customer@vedicastro.com')
BEGIN
    INSERT INTO [dbo].[Users] (
        [Id], [Email], [Phone], [PasswordHash], [FirstName], [LastName], 
        [AvatarUrl], [Role], [RoleId], [EmailVerified], [PhoneVerified], 
        [LastLoginAt], [RefreshToken], [RefreshTokenExpiry], [CreatedAt], [UpdatedAt], [IsActive]
    ) VALUES (
        N'CCCCCCCC-CCCC-CCCC-CCCC-CCCCCCCCCCCC',
        'customer@vedicastro.com',
        '7777777777',
        'Customer@123',  -- Will be hashed by API on first login
        'Priya',
        'Patel',
        NULL,
        3,  -- INT: 3 = Customer
        @CustomerRoleId,  -- GUID reference
        1,
        1,
        NULL,
        NULL,
        NULL,
        GETDATE(),
        NULL,
        1
    );
    PRINT '✅ Customer user created (Role: 3)';
END
ELSE
    PRINT 'ℹ️ Customer user already exists';

-- ============================================================
-- 6. SEED PERMISSIONS (needed for RolePermissions)
-- ============================================================
IF NOT EXISTS (SELECT 1 FROM [dbo].[Permissions] WHERE [Code] = 'user.manage.all')
BEGIN
    INSERT INTO [dbo].[Permissions] ([Id], [Name], [Code], [Module], [Description], [CreatedAt], [UpdatedAt], [IsActive]) VALUES
    (NEWID(), 'User - Manage All', 'user.manage.all', 'User', 'Create/update/delete/view any user', GETDATE(), NULL, 1),
    (NEWID(), 'Role - Manage', 'role.manage', 'User', 'Manage roles and permission mapping', GETDATE(), NULL, 1),
    (NEWID(), 'Pooja Service - Manage', 'pooja.service.manage', 'Pooja', 'Create/update/delete pooja service catalog', GETDATE(), NULL, 1),
    (NEWID(), 'Pooja Booking - View All', 'pooja.booking.view.all', 'Pooja', 'View all pooja bookings', GETDATE(), NULL, 1),
    (NEWID(), 'Pooja Booking - Manage Own', 'pooja.booking.manage.own', 'Pooja', 'Astrologer manages own assigned pooja bookings', GETDATE(), NULL, 1),
    (NEWID(), 'Pooja Booking - Create', 'pooja.booking.create', 'Pooja', 'Customer creates a pooja booking', GETDATE(), NULL, 1),
    (NEWID(), 'Pooja Booking - View Own', 'pooja.booking.view.own', 'Pooja', 'Customer views own bookings', GETDATE(), NULL, 1),
    (NEWID(), 'Product - Manage', 'product.manage', 'Product', 'Create/update/delete products', GETDATE(), NULL, 1),
    (NEWID(), 'Product - View', 'product.view', 'Product', 'View product catalog', GETDATE(), NULL, 1),
    (NEWID(), 'Category - Manage', 'category.manage', 'Product', 'Create/update/delete product categories', GETDATE(), NULL, 1),
    (NEWID(), 'Stock - View All', 'stock.view.all', 'Product', 'View product stock movement history', GETDATE(), NULL, 1),
    (NEWID(), 'Order - View All', 'order.view.all', 'Order', 'View all orders', GETDATE(), NULL, 1),
    (NEWID(), 'Order - Create', 'order.create', 'Order', 'Customer places an order', GETDATE(), NULL, 1),
    (NEWID(), 'Order - View Own', 'order.view.own', 'Order', 'Customer views own orders', GETDATE(), NULL, 1),
    (NEWID(), 'Order - Cancel', 'order.cancel', 'Order', 'Customer cancels own orders', GETDATE(), NULL, 1),
    (NEWID(), 'Kundli - Create', 'kundli.request.create', 'Kundli', 'Customer requests a kundli', GETDATE(), NULL, 1),
    (NEWID(), 'Kundli - View Own', 'kundli.request.view.own', 'Kundli', 'Customer views own kundli requests', GETDATE(), NULL, 1),
    (NEWID(), 'Kundli - Manage Own', 'kundli.request.manage.own', 'Kundli', 'Astrologer manages assigned kundli requests', GETDATE(), NULL, 1),
    (NEWID(), 'Kundli - View All', 'kundli.request.view.all', 'Kundli', 'View all kundli requests', GETDATE(), NULL, 1),
    (NEWID(), 'Dashboard - View All', 'dashboard.view.all', 'Dashboard', 'View full admin dashboard/stats', GETDATE(), NULL, 1),
    (NEWID(), 'Address - Manage Own', 'address.manage.own', 'Address', 'Customer manages own addresses', GETDATE(), NULL, 1),
    (NEWID(), 'Payment - Create', 'payment.create', 'Payment', 'Customer initiates a payment', GETDATE(), NULL, 1),
    (NEWID(), 'Payment - View Own', 'payment.view.own', 'Payment', 'Customer views own payment history', GETDATE(), NULL, 1),
    (NEWID(), 'Payment - View All', 'payment.view.all', 'Payment', 'View all payments (admin)', GETDATE(), NULL, 1),
    (NEWID(), 'Logs - View All', 'logs.view.all', 'System', 'View all system logs', GETDATE(), NULL, 1),
    (NEWID(), 'Astrologer - Approve', 'astrologer.approve', 'User', 'Approve/reject astrologer self-registration', GETDATE(), NULL, 1),
    (NEWID(), 'Coupon - Manage', 'coupon.manage', 'Coupon', 'Create/update/delete coupons', GETDATE(), NULL, 1),
    (NEWID(), 'Gift Card - Manage', 'gift.card.manage', 'GiftCard', 'Manage gift cards', GETDATE(), NULL, 1),
    (NEWID(), 'Subscription - Manage', 'subscription.manage', 'Subscription', 'Manage subscriptions', GETDATE(), NULL, 1);
    PRINT '✅ Permissions seeded successfully';
END
ELSE
    PRINT 'ℹ️ Permissions already exist, skipping...';

-- ============================================================
-- 7. SEED ROLE PERMISSIONS
-- ============================================================
-- SuperAdmin gets ALL permissions
IF NOT EXISTS (SELECT 1 FROM [dbo].[RolePermissions] WHERE [RoleId] = @SuperAdminRoleId)
BEGIN
    INSERT INTO [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive])
    SELECT NEWID(), @SuperAdminRoleId, [Id], GETDATE(), NULL, 1
    FROM [dbo].[Permissions];
    PRINT '✅ SuperAdmin permissions mapped (All permissions)';
END

-- Astrologer permissions
IF NOT EXISTS (SELECT 1 FROM [dbo].[RolePermissions] WHERE [RoleId] = @AstrologerRoleId)
BEGIN
    INSERT INTO [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive])
    SELECT NEWID(), @AstrologerRoleId, [Id], GETDATE(), NULL, 1
    FROM [dbo].[Permissions]
    WHERE [Code] IN (
        'pooja.booking.manage.own',
        'kundli.request.manage.own',
        'product.view',
        'order.view.own',
        'payment.view.own'
    );
    PRINT '✅ Astrologer permissions mapped';
END

-- Customer permissions
IF NOT EXISTS (SELECT 1 FROM [dbo].[RolePermissions] WHERE [RoleId] = @CustomerRoleId)
BEGIN
    INSERT INTO [dbo].[RolePermissions] ([Id], [RoleId], [PermissionId], [CreatedAt], [UpdatedAt], [IsActive])
    SELECT NEWID(), @CustomerRoleId, [Id], GETDATE(), NULL, 1
    FROM [dbo].[Permissions]
    WHERE [Code] IN (
        'pooja.booking.create',
        'pooja.booking.view.own',
        'product.view',
        'order.create',
        'order.view.own',
        'order.cancel',
        'kundli.request.create',
        'kundli.request.view.own',
        'address.manage.own',
        'payment.create',
        'payment.view.own'
    );
    PRINT '✅ Customer permissions mapped';
END

-- ============================================================
-- 8. VERIFY SEED DATA
-- ============================================================
PRINT '';
PRINT '============================================';
PRINT '✅ VADIC MALL - SEED DATA COMPLETED!';
PRINT '============================================';
PRINT '';

PRINT '📊 ROLES:';
SELECT [Id], [Name], [Code], [Description] FROM [dbo].[Roles];
PRINT '';

PRINT '📊 USERS:';
SELECT [Id], [Email], [FirstName], [LastName], [Role], [RoleId], [IsActive] FROM [dbo].[Users];
PRINT '';

PRINT '📊 ROLE PERMISSIONS SUMMARY:';
SELECT 
    r.[Name] AS RoleName,
    COUNT(rp.[PermissionId]) AS PermissionCount
FROM [dbo].[Roles] r
LEFT JOIN [dbo].[RolePermissions] rp ON r.[Id] = rp.[RoleId]
WHERE r.[Code] IN ('SuperAdmin', 'Astrologer', 'Customer')
GROUP BY r.[Name];
PRINT '';

PRINT '🔑 DEFAULT LOGINS:';
PRINT '   🟢 SuperAdmin (Role: 1): admin@vedicastro.com / Admin@123';
PRINT '   🟢 Astrologer (Role: 2): astrologer@vedicastro.com / Astro@123';
PRINT '   🟢 Customer (Role: 3): customer@vedicastro.com / Customer@123';
PRINT '';

PRINT '📋 ROLE CAPABILITIES:';
PRINT '   🟣 SuperAdmin (Role: 1): Full access to everything';
PRINT '   🟠 Astrologer (Role: 2): Assigned bookings, kundli, payment status';
PRINT '   🟢 Customer (Role: 3): Order products, book pooja, kundli, view own data';
PRINT '';
PRINT '============================================';
PRINT '✅ SEED SCRIPT COMPLETE!';
PRINT '============================================';