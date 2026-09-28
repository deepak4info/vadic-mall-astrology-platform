using VadicMall.Domain.Common;
using VadicMall.Domain.Enums;

namespace VadicMall.Domain.Entities;

public class User : BaseEntity
{
    public string Email { get; set; } = string.Empty;
    public string? Phone { get; set; }
    public string PasswordHash { get; set; } = string.Empty;
    public string FirstName { get; set; } = string.Empty;
    public string LastName { get; set; } = string.Empty;
    public string? AvatarUrl { get; set; }
    public UserRole Role { get; set; } = UserRole.Customer;
    public bool EmailVerified { get; set; }
    public bool PhoneVerified { get; set; }
    public DateTime? LastLoginAt { get; set; }
    public string? RefreshToken { get; set; }
    public DateTime? RefreshTokenExpiry { get; set; }
    public bool IsStaffApproved { get; set; }

    public AstrologerProfile? AstrologerProfile { get; set; }
    public ICollection<Address> Addresses { get; set; } = [];
    public ICollection<PoojaBooking> PoojaBookings { get; set; } = [];
    public ICollection<Order> Orders { get; set; } = [];
    public ICollection<CartItem> CartItems { get; set; } = [];
    public ICollection<WishlistItem> WishlistItems { get; set; } = [];
    public ICollection<KundliRequest> KundliRequests { get; set; } = [];
    public ICollection<Review> Reviews { get; set; } = [];
    public ICollection<Notification> Notifications { get; set; } = [];
    public ICollection<UserSubscription> UserSubscriptions { get; set; } = [];
    public ICollection<UserPermission> UserPermissions { get; set; } = [];
}

public class UserPermission
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public StaffPermission Permission { get; set; }
}

public class AstrologerProfile : BaseEntity
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public string Specialization { get; set; } = string.Empty;
    public string Bio { get; set; } = string.Empty;
    public int ExperienceYears { get; set; }
    public decimal ConsultationFee { get; set; }
    public decimal Rating { get; set; }
    public int ReviewCount { get; set; }
    public bool IsApproved { get; set; }
    public bool IsFeatured { get; set; }
    public string? Languages { get; set; }
    public string? Availability { get; set; }

    public ICollection<AstrologerReview> AstrologerReviews { get; set; } = [];
}

public class PoojaService : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public decimal? SalePrice { get; set; }
    public int DurationMinutes { get; set; }
    public string? ImageUrl { get; set; }
    public bool IsFeatured { get; set; }
    public decimal Rating { get; set; }
    public int ReviewCount { get; set; }
    public string? FestivalTag { get; set; }

    public ICollection<PoojaBooking> Bookings { get; set; } = [];
}

public class PoojaBooking : BaseEntity
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public Guid PoojaServiceId { get; set; }
    public PoojaService PoojaService { get; set; } = null!;
    public Guid? AstrologerId { get; set; }
    public User? Astrologer { get; set; }
    public DateTime ScheduledDate { get; set; }
    public string? ScheduledTime { get; set; }
    public BookingStatus Status { get; set; } = BookingStatus.Pending;
    public decimal Amount { get; set; }
    public string? SpecialInstructions { get; set; }
    public string? Notes { get; set; }
}

public class ProductCategory : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string? Description { get; set; }
    public string? ImageUrl { get; set; }
    public Guid? ParentId { get; set; }
    public ProductCategory? Parent { get; set; }
    public ICollection<ProductCategory> Children { get; set; } = [];
    public ICollection<Product> Products { get; set; } = [];
}

public class Product : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public Guid CategoryId { get; set; }
    public ProductCategory Category { get; set; } = null!;
    public decimal Price { get; set; }
    public decimal? SalePrice { get; set; }
    public int StockQuantity { get; set; }
    public string? Sku { get; set; }
    public decimal Rating { get; set; }
    public int ReviewCount { get; set; }
    public bool IsFeatured { get; set; }
    public string? FestivalTag { get; set; }

    public ICollection<ProductImage> Images { get; set; } = [];
    public ICollection<Review> Reviews { get; set; } = [];
    public ICollection<OrderItem> OrderItems { get; set; } = [];
}

public class ProductImage : BaseEntity
{
    public Guid ProductId { get; set; }
    public Product Product { get; set; } = null!;
    public string ImageUrl { get; set; } = string.Empty;
    public bool IsPrimary { get; set; }
    public int SortOrder { get; set; }
}

public class Coupon : BaseEntity
{
    public string Code { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public CouponType Type { get; set; }
    public decimal Value { get; set; }
    public decimal? MinOrderValue { get; set; }
    public decimal? MaxDiscount { get; set; }
    public int UsageLimit { get; set; }
    public int UsedCount { get; set; }
    public DateTime ValidFrom { get; set; }
    public DateTime ValidTo { get; set; }
    public string? FestivalTag { get; set; }

    public ICollection<CouponUsage> Usages { get; set; } = [];
}

public class CouponUsage : BaseEntity
{
    public Guid CouponId { get; set; }
    public Coupon Coupon { get; set; } = null!;
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public Guid? OrderId { get; set; }
    public decimal DiscountAmount { get; set; }
}

public class Order : BaseEntity
{
    public string OrderNumber { get; set; } = string.Empty;
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public OrderStatus Status { get; set; } = OrderStatus.Pending;
    public decimal SubTotal { get; set; }
    public decimal Discount { get; set; }
    public decimal ShippingFee { get; set; }
    public decimal Total { get; set; }
    public string? CouponCode { get; set; }
    public Guid? ShippingAddressId { get; set; }
    public Address? ShippingAddress { get; set; }
    public string? TrackingNumber { get; set; }

    public ICollection<OrderItem> Items { get; set; } = [];
    public ICollection<OrderTracking> TrackingHistory { get; set; } = [];
    public Payment? Payment { get; set; }
}

public class OrderItem : BaseEntity
{
    public Guid OrderId { get; set; }
    public Order Order { get; set; } = null!;
    public Guid ProductId { get; set; }
    public Product Product { get; set; } = null!;
    public int Quantity { get; set; }
    public decimal UnitPrice { get; set; }
    public decimal TotalPrice { get; set; }
}

public class OrderTracking : BaseEntity
{
    public Guid OrderId { get; set; }
    public Order Order { get; set; } = null!;
    public OrderStatus Status { get; set; }
    public string? Notes { get; set; }
    public string? Location { get; set; }
}

public class KundliRequest : BaseEntity
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public string Name { get; set; } = string.Empty;
    public DateTime DateOfBirth { get; set; }
    public string TimeOfBirth { get; set; } = string.Empty;
    public string PlaceOfBirth { get; set; } = string.Empty;
    public string Gender { get; set; } = string.Empty;
    public KundliStatus Status { get; set; } = KundliStatus.Pending;
    public decimal Amount { get; set; }
    public string? ReportUrl { get; set; }
    public Guid? AssignedAstrologerId { get; set; }
}

public class Payment : BaseEntity
{
    public Guid OrderId { get; set; }
    public Order Order { get; set; } = null!;
    public decimal Amount { get; set; }
    public PaymentStatus Status { get; set; } = PaymentStatus.Pending;
    public string PaymentMethod { get; set; } = string.Empty;
    public string? TransactionId { get; set; }
    public string? GatewayResponse { get; set; }
}

public class Address : BaseEntity
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public string FullName { get; set; } = string.Empty;
    public string Phone { get; set; } = string.Empty;
    public string AddressLine1 { get; set; } = string.Empty;
    public string? AddressLine2 { get; set; }
    public string City { get; set; } = string.Empty;
    public string State { get; set; } = string.Empty;
    public string Pincode { get; set; } = string.Empty;
    public string Country { get; set; } = "India";
    public bool IsDefault { get; set; }
}

public class CartItem : BaseEntity
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public Guid ProductId { get; set; }
    public Product Product { get; set; } = null!;
    public int Quantity { get; set; }
}

public class WishlistItem : BaseEntity
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public Guid ProductId { get; set; }
    public Product Product { get; set; } = null!;
}

public class Review : BaseEntity
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public Guid ProductId { get; set; }
    public Product Product { get; set; } = null!;
    public int Rating { get; set; }
    public string Comment { get; set; } = string.Empty;
}

public class AstrologerReview : BaseEntity
{
    public Guid UserId { get; set; }
    public Guid AstrologerProfileId { get; set; }
    public AstrologerProfile AstrologerProfile { get; set; } = null!;
    public int Rating { get; set; }
    public string Comment { get; set; } = string.Empty;
}

public class Notification : BaseEntity
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public string Title { get; set; } = string.Empty;
    public string Message { get; set; } = string.Empty;
    public string Type { get; set; } = "info";
    public bool IsRead { get; set; }
    public string? Link { get; set; }
}

public class GiftCard : BaseEntity
{
    public string Code { get; set; } = string.Empty;
    public string Type { get; set; } = string.Empty;
    public decimal Amount { get; set; }
    public decimal Balance { get; set; }
    public Guid? PurchasedByUserId { get; set; }
    public Guid? RedeemedByUserId { get; set; }
    public DateTime? ExpiryDate { get; set; }
    public string Status { get; set; } = "active";
}

public class SubscriptionPlan : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string Description { get; set; } = string.Empty;
    public decimal Price { get; set; }
    public string BillingCycle { get; set; } = "monthly";
    public string Features { get; set; } = "[]";
    public bool IsPopular { get; set; }

    public ICollection<UserSubscription> UserSubscriptions { get; set; } = [];
}

public class UserSubscription : BaseEntity
{
    public Guid UserId { get; set; }
    public User User { get; set; } = null!;
    public Guid SubscriptionPlanId { get; set; }
    public SubscriptionPlan Plan { get; set; } = null!;
    public DateTime StartDate { get; set; }
    public DateTime EndDate { get; set; }
    public bool AutoRenew { get; set; } = true;
    public string Status { get; set; } = "active";
}

public class BlogCategory : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public ICollection<BlogPost> Posts { get; set; } = [];
}

public class BlogPost : BaseEntity
{
    public string Title { get; set; } = string.Empty;
    public string Slug { get; set; } = string.Empty;
    public string Excerpt { get; set; } = string.Empty;
    public string Content { get; set; } = string.Empty;
    public string? ImageUrl { get; set; }
    public string Author { get; set; } = string.Empty;
    public Guid CategoryId { get; set; }
    public BlogCategory Category { get; set; } = null!;
    public int ViewCount { get; set; }
}

public class Faq : BaseEntity
{
    public string Question { get; set; } = string.Empty;
    public string Answer { get; set; } = string.Empty;
    public string Category { get; set; } = string.Empty;
    public int SortOrder { get; set; }
}

public class ContactQuery : BaseEntity
{
    public string Name { get; set; } = string.Empty;
    public string Email { get; set; } = string.Empty;
    public string Phone { get; set; } = string.Empty;
    public string Subject { get; set; } = string.Empty;
    public string Message { get; set; } = string.Empty;
    public bool IsResolved { get; set; }
}

public class NewsletterSubscriber : BaseEntity
{
    public string Email { get; set; } = string.Empty;
    public bool IsConfirmed { get; set; }
}

public class LoginLog : BaseEntity
{
    public Guid? UserId { get; set; }
    public string Email { get; set; } = string.Empty;
    public bool Success { get; set; }
    public string? IpAddress { get; set; }
    public string? UserAgent { get; set; }
    public string? FailureReason { get; set; }
}

public class AuditLog : BaseEntity
{
    public Guid? UserId { get; set; }
    public string Action { get; set; } = string.Empty;
    public string EntityType { get; set; } = string.Empty;
    public string? EntityId { get; set; }
    public string? BeforeState { get; set; }
    public string? AfterState { get; set; }
    public string? IpAddress { get; set; }
}

public class ErrorLog : BaseEntity
{
    public string Message { get; set; } = string.Empty;
    public string? StackTrace { get; set; }
    public string? Source { get; set; }
    public string? RequestPath { get; set; }
    public Guid? UserId { get; set; }
}

public class Setting : BaseEntity
{
    public string Key { get; set; } = string.Empty;
    public string Value { get; set; } = string.Empty;
    public string? Description { get; set; }
}

// Maps to the pre-existing "Loading Skeleton" table (int identity key, not a Guid-keyed
// BaseEntity like the rest of the domain) — a catalog of skeleton-loader animation presets
// the admin can pick from; whichever row has IsActive=true drives the shimmer/pulse/wave
// animation used by every skeleton loader across the site.
public class LoadingSkeleton
{
    public int Id { get; set; }
    public string Name { get; set; } = string.Empty;
    public string DisplayName { get; set; } = string.Empty;
    public string CssClass { get; set; } = string.Empty;
    public int DurationMs { get; set; }
    public int DelayMs { get; set; }
    public string Easing { get; set; } = string.Empty;
    public string? ConfigJson { get; set; }
    public bool IsActive { get; set; }
    public int SortOrder { get; set; }
    public DateTime CreatedAt { get; set; } = DateTime.UtcNow;
    public DateTime? UpdatedAt { get; set; }
}
