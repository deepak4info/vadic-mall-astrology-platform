using Microsoft.EntityFrameworkCore;
using VadicMall.Domain.Entities;

namespace VadicMall.Infrastructure.Data;

public class VadicMallDbContext(DbContextOptions<VadicMallDbContext> options) : DbContext(options)
{
    public DbSet<User> Users => Set<User>();
    public DbSet<AstrologerProfile> AstrologerProfiles => Set<AstrologerProfile>();
    public DbSet<PoojaService> PoojaServices => Set<PoojaService>();
    public DbSet<PoojaBooking> PoojaBookings => Set<PoojaBooking>();
    public DbSet<ProductCategory> ProductCategories => Set<ProductCategory>();
    public DbSet<Product> Products => Set<Product>();
    public DbSet<ProductImage> ProductImages => Set<ProductImage>();
    public DbSet<Coupon> Coupons => Set<Coupon>();
    public DbSet<CouponUsage> CouponUsages => Set<CouponUsage>();
    public DbSet<Order> Orders => Set<Order>();
    public DbSet<OrderItem> OrderItems => Set<OrderItem>();
    public DbSet<OrderTracking> OrderTracking => Set<OrderTracking>();
    public DbSet<KundliRequest> KundliRequests => Set<KundliRequest>();
    public DbSet<Payment> Payments => Set<Payment>();
    public DbSet<Address> Addresses => Set<Address>();
    public DbSet<CartItem> CartItems => Set<CartItem>();
    public DbSet<WishlistItem> WishlistItems => Set<WishlistItem>();
    public DbSet<Review> Reviews => Set<Review>();
    public DbSet<AstrologerReview> AstrologerReviews => Set<AstrologerReview>();
    public DbSet<Notification> Notifications => Set<Notification>();
    public DbSet<GiftCard> GiftCards => Set<GiftCard>();
    public DbSet<SubscriptionPlan> SubscriptionPlans => Set<SubscriptionPlan>();
    public DbSet<UserSubscription> UserSubscriptions => Set<UserSubscription>();
    public DbSet<BlogCategory> BlogCategories => Set<BlogCategory>();
    public DbSet<BlogPost> BlogPosts => Set<BlogPost>();
    public DbSet<Faq> Faqs => Set<Faq>();
    public DbSet<ContactQuery> ContactQueries => Set<ContactQuery>();
    public DbSet<NewsletterSubscriber> NewsletterSubscribers => Set<NewsletterSubscriber>();
    public DbSet<LoginLog> LoginLogs => Set<LoginLog>();
    public DbSet<AuditLog> AuditLogs => Set<AuditLog>();
    public DbSet<ErrorLog> ErrorLogs => Set<ErrorLog>();
    public DbSet<Setting> Settings => Set<Setting>();
    public DbSet<LoadingSkeleton> LoadingSkeletons => Set<LoadingSkeleton>();
    public DbSet<UserPermission> UserPermissions => Set<UserPermission>();

    protected override void OnModelCreating(ModelBuilder modelBuilder)
    {
        modelBuilder.Entity<User>(e =>
        {
            e.HasIndex(u => u.Email).IsUnique();
            e.HasOne(u => u.AstrologerProfile).WithOne(a => a.User).HasForeignKey<AstrologerProfile>(a => a.UserId);
        });

        modelBuilder.Entity<PoojaService>(e => e.HasIndex(p => p.Slug).IsUnique());
        modelBuilder.Entity<Product>(e => e.HasIndex(p => p.Slug).IsUnique());
        modelBuilder.Entity<ProductCategory>(e => e.HasIndex(c => c.Slug).IsUnique());
        modelBuilder.Entity<Coupon>(e => e.HasIndex(c => c.Code).IsUnique());
        modelBuilder.Entity<Order>(e => e.HasIndex(o => o.OrderNumber).IsUnique());
        modelBuilder.Entity<BlogPost>(e => e.HasIndex(b => b.Slug).IsUnique());
        modelBuilder.Entity<GiftCard>(e => e.HasIndex(g => g.Code).IsUnique());
        modelBuilder.Entity<SubscriptionPlan>(e => e.HasIndex(s => s.Slug).IsUnique());
        modelBuilder.Entity<Setting>(e => e.HasIndex(s => s.Key).IsUnique());

        modelBuilder.Entity<PoojaBooking>(e =>
        {
            e.HasOne(b => b.User).WithMany(u => u.PoojaBookings).HasForeignKey(b => b.UserId).OnDelete(DeleteBehavior.Restrict);
            e.HasOne(b => b.Astrologer).WithMany().HasForeignKey(b => b.AstrologerId).OnDelete(DeleteBehavior.SetNull);
        });

        modelBuilder.Entity<Order>()
            .HasOne(o => o.Payment)
            .WithOne(p => p.Order)
            .HasForeignKey<Payment>(p => p.OrderId);

        modelBuilder.Entity<CartItem>()
            .HasIndex(c => new { c.UserId, c.ProductId }).IsUnique();

        modelBuilder.Entity<WishlistItem>()
            .HasIndex(w => new { w.UserId, w.ProductId }).IsUnique();

        modelBuilder.Entity<UserPermission>(e =>
        {
            e.HasKey(p => new { p.UserId, p.Permission });
            e.HasOne(p => p.User).WithMany(u => u.UserPermissions).HasForeignKey(p => p.UserId).OnDelete(DeleteBehavior.Cascade);
        });

        // Pre-existing table with a space in its name and an int (not Guid) primary key.
        modelBuilder.Entity<LoadingSkeleton>().ToTable("Loading Skeleton");
    }
}
