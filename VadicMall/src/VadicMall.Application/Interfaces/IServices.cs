using VadicMall.Application.DTOs.Admin;
using VadicMall.Application.DTOs.Astrologer;
using VadicMall.Application.DTOs.Auth;
using VadicMall.Application.DTOs.Catalog;
using VadicMall.Application.DTOs.Customer;

namespace VadicMall.Application.Interfaces;

public interface IAuthService
{
    Task<AuthResponse> RegisterAsync(RegisterRequest request);
    Task<AuthResponse> RegisterAstrologerAsync(RegisterAstrologerRequest request);
    Task<AuthResponse> LoginAsync(LoginRequest request, string? ipAddress, string? userAgent);
    Task<AuthResponse> RefreshTokenAsync(RefreshTokenRequest request);
    Task<UserDto?> GetCurrentUserAsync(Guid userId);
    Task ChangePasswordAsync(Guid userId, ChangePasswordRequest request);
}

public interface ICatalogService
{
    Task<IEnumerable<PoojaServiceDto>> GetPoojaServicesAsync(string? category = null, string? search = null, bool? featured = null);
    Task<PoojaServiceDto?> GetPoojaServiceByIdAsync(Guid id);
    Task<IEnumerable<ProductDto>> GetProductsAsync(string? category = null, string? search = null, decimal? minPrice = null, decimal? maxPrice = null, bool? featured = null);
    Task<ProductDetailDto?> GetProductByIdAsync(Guid id);
    Task<IEnumerable<AstrologerDto>> GetAstrologersAsync(string? specialization = null, string? search = null);
    Task<AstrologerDto?> GetAstrologerByIdAsync(Guid id);
    Task<IEnumerable<SubscriptionPlanDto>> GetSubscriptionPlansAsync();
    Task<IEnumerable<GiftCardTypeDto>> GetGiftCardTypesAsync();
    Task<IEnumerable<FestivalOfferDto>> GetFestivalOffersAsync();
    Task<IEnumerable<BlogPostDto>> GetBlogPostsAsync(string? category = null);
    Task<BlogPostDetailDto?> GetBlogPostBySlugAsync(string slug);
    Task<IEnumerable<FaqDto>> GetFaqsAsync(string? category = null);
    Task<IEnumerable<TestimonialDto>> GetTestimonialsAsync();
    Task SubmitContactAsync(ContactRequest request);
    Task SubscribeNewsletterAsync(NewsletterRequest request);
    Task<CouponValidationResponse> ValidateCouponAsync(CouponValidationRequest request);
    Task<GiftCardValidationResponse> ValidateGiftCardAsync(GiftCardValidationRequest request);
    Task<object> SearchAsync(string query);
    Task<SettingDto?> GetSettingAsync(string key);
    Task<LoadingSkeletonDto?> GetActiveLoadingSkeletonAsync();
}

public interface ICustomerService
{
    Task<CartDto> GetCartAsync(Guid userId);
    Task AddToCartAsync(Guid userId, AddToCartRequest request);
    Task UpdateCartItemAsync(Guid userId, Guid productId, UpdateCartRequest request);
    Task RemoveFromCartAsync(Guid userId, Guid productId);
    Task ClearCartAsync(Guid userId);
    Task<OrderDto> CreateOrderAsync(Guid userId, CreateOrderRequest request);
    Task<IEnumerable<OrderDto>> GetOrdersAsync(Guid userId);
    Task<OrderDto?> GetOrderByIdAsync(Guid userId, Guid orderId);
    Task<IEnumerable<OrderTrackingDto>> GetOrderTrackingAsync(Guid userId, Guid orderId);
    Task<PoojaBookingDto> CreatePoojaBookingAsync(Guid userId, PoojaBookingRequest request);
    Task<IEnumerable<PoojaBookingDto>> GetPoojaBookingsAsync(Guid userId);
    Task<KundliResponseDto> CreateKundliRequestAsync(Guid userId, KundliRequestDto request);
    Task<IEnumerable<KundliResponseDto>> GetKundliRequestsAsync(Guid userId);
    Task<UserSubscriptionDto> SubscribeAsync(Guid userId, SubscribeRequest request);
    Task<IEnumerable<UserSubscriptionDto>> GetSubscriptionsAsync(Guid userId);
    Task<GiftCardPurchaseDto> PurchaseGiftCardAsync(Guid userId, PurchaseGiftCardRequest request);
    Task<IEnumerable<AddressDto>> GetAddressesAsync(Guid userId);
    Task<AddressDto> CreateAddressAsync(Guid userId, CreateAddressRequest request);
    Task<IEnumerable<WishlistItemDto>> GetWishlistAsync(Guid userId);
    Task AddToWishlistAsync(Guid userId, AddToWishlistRequest request);
    Task RemoveFromWishlistAsync(Guid userId, Guid productId);
    Task<IEnumerable<NotificationDto>> GetNotificationsAsync(Guid userId);
    Task MarkNotificationReadAsync(Guid userId, Guid id);
    Task MarkAllNotificationsReadAsync(Guid userId);
}

public interface IAdminService
{
    Task<DashboardStatsDto> GetDashboardStatsAsync();
    Task<IEnumerable<RevenueChartDto>> GetRevenueChartAsync(int months = 6);
    Task<IEnumerable<RecentOrderDto>> GetRecentOrdersAsync(int count = 10);
    Task<IEnumerable<AdminUserDto>> GetUsersAsync();
    Task<IEnumerable<AdminProductDto>> GetProductsAsync();
    Task<IEnumerable<AdminPoojaDto>> GetPoojaServicesAsync();
    Task<IEnumerable<AdminOrderDto>> GetOrdersAsync();
    Task<IEnumerable<AdminCategoryDto>> GetCategoriesAsync();
    Task<AdminProductDto> CreateProductAsync(CreateProductRequest request);
    Task<AdminProductDetailDto?> GetProductByIdAsync(Guid id);
    Task<AdminProductDto> UpdateProductAsync(Guid id, UpdateProductRequest request);
    Task<AdminProductDto> UpdateProductStockAsync(Guid id, UpdateStockRequest request);
    Task<AdminUserDto> UpdateUserStatusAsync(Guid id, UpdateUserStatusRequest request);
    Task<AdminPoojaDetailDto?> GetPoojaServiceByIdAsync(Guid id);
    Task<AdminPoojaDto> UpdatePoojaServiceAsync(Guid id, UpdatePoojaRequest request);
    Task<AdminOrderDetailDto?> GetOrderByIdAsync(Guid id);
    Task<AdminOrderDto> UpdateOrderStatusAsync(Guid id, UpdateOrderStatusRequest request);
    Task<AdminUserDto> UpdateAstrologerApprovalAsync(Guid userId, UpdateAstrologerApprovalRequest request);
    Task DeleteProductAsync(Guid id);
    Task<BulkDeleteResultDto> DeleteProductsAsync(List<Guid> ids);
    Task<IEnumerable<AdminBookingDto>> GetBookingsAsync();
    Task<AdminUserDto> UpdateStaffApprovalAsync(Guid userId, UpdateStaffApprovalRequest request);
    Task<AdminUserDto> UpdateUserPermissionsAsync(Guid userId, UpdateUserPermissionsRequest request);
    Task<IEnumerable<AdminCouponDto>> GetCouponsAsync();
    Task<AdminCouponDto> CreateCouponAsync(CreateCouponRequest request);
    Task<AdminCouponDto> UpdateCouponAsync(Guid id, UpdateCouponRequest request);
    Task DeleteCouponAsync(Guid id);
    Task<SettingDto> UpdateSettingImageAsync(string key, string imageUrl);
    Task<IEnumerable<LoadingSkeletonDto>> GetLoadingSkeletonsAsync();
    Task<LoadingSkeletonDto> SetActiveLoadingSkeletonAsync(int id);
}

public interface IAstrologerService
{
    Task<AstrologerProfileDto?> GetMyProfileAsync(Guid userId);
    Task<IEnumerable<AstrologerBookingDto>> GetMyBookingsAsync(Guid userId);
}

public interface ITokenService
{
    string GenerateAccessToken(Guid userId, string email, string role);
    string GenerateRefreshToken();
    Guid? ValidateToken(string token);
}
