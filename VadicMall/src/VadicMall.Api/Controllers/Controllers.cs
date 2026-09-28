using System.Security.Claims;
using Microsoft.AspNetCore.Authorization;
using Microsoft.AspNetCore.Hosting;
using Microsoft.AspNetCore.Mvc;
using VadicMall.Application.DTOs.Admin;
using VadicMall.Application.DTOs.Astrologer;
using VadicMall.Application.DTOs.Auth;
using VadicMall.Application.DTOs.Catalog;
using VadicMall.Application.DTOs.Customer;
using VadicMall.Application.Interfaces;

namespace VadicMall.Api.Controllers;

[ApiController]
[Route("api/auth")]
public class AuthController(IAuthService authService) : ControllerBase
{
    [HttpPost("register")]
    public async Task<ActionResult<AuthResponse>> Register([FromBody] RegisterRequest request)
    {
        try { return Ok(await authService.RegisterAsync(request)); }
        catch (InvalidOperationException ex) { return BadRequest(new { message = ex.Message }); }
    }

    [HttpPost("register-astrologer")]
    public async Task<ActionResult<AuthResponse>> RegisterAstrologer([FromBody] RegisterAstrologerRequest request)
    {
        try { return Ok(await authService.RegisterAstrologerAsync(request)); }
        catch (InvalidOperationException ex) { return BadRequest(new { message = ex.Message }); }
    }

    [HttpPost("login")]
    public async Task<ActionResult<AuthResponse>> Login([FromBody] LoginRequest request)
    {
        try
        {
            return Ok(await authService.LoginAsync(request,
                HttpContext.Connection.RemoteIpAddress?.ToString(),
                Request.Headers.UserAgent.ToString()));
        }
        catch (UnauthorizedAccessException ex) { return Unauthorized(new { message = ex.Message }); }
    }

    [HttpPost("refresh-token")]
    public async Task<ActionResult<AuthResponse>> RefreshToken([FromBody] RefreshTokenRequest request)
    {
        try { return Ok(await authService.RefreshTokenAsync(request)); }
        catch (UnauthorizedAccessException ex) { return Unauthorized(new { message = ex.Message }); }
    }

    [Authorize]
    [HttpGet("me")]
    public async Task<ActionResult<UserDto>> Me()
    {
        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        var user = await authService.GetCurrentUserAsync(userId);
        return user == null ? NotFound() : Ok(user);
    }

    [Authorize]
    [HttpPost("change-password")]
    public async Task<IActionResult> ChangePassword([FromBody] ChangePasswordRequest request)
    {
        var userId = Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);
        try
        {
            await authService.ChangePasswordAsync(userId, request);
            return Ok(new { message = "Password changed successfully" });
        }
        catch (UnauthorizedAccessException ex) { return Unauthorized(new { message = ex.Message }); }
    }
}

[ApiController]
[Route("api/catalog")]
public class CatalogController(ICatalogService catalogService) : ControllerBase
{
    [HttpGet("pooja-services")]
    public async Task<ActionResult<IEnumerable<PoojaServiceDto>>> GetPoojaServices(
        [FromQuery] string? category, [FromQuery] string? search, [FromQuery] bool? featured) =>
        Ok(await catalogService.GetPoojaServicesAsync(category, search, featured));

    [HttpGet("pooja-services/{id:guid}")]
    public async Task<ActionResult<PoojaServiceDto>> GetPoojaService(Guid id)
    {
        var result = await catalogService.GetPoojaServiceByIdAsync(id);
        return result == null ? NotFound() : Ok(result);
    }

    [HttpGet("products")]
    public async Task<ActionResult<IEnumerable<ProductDto>>> GetProducts(
        [FromQuery] string? category, [FromQuery] string? search,
        [FromQuery] decimal? minPrice, [FromQuery] decimal? maxPrice, [FromQuery] bool? featured) =>
        Ok(await catalogService.GetProductsAsync(category, search, minPrice, maxPrice, featured));

    [HttpGet("products/{id:guid}")]
    public async Task<ActionResult<ProductDetailDto>> GetProduct(Guid id)
    {
        var result = await catalogService.GetProductByIdAsync(id);
        return result == null ? NotFound() : Ok(result);
    }

    [HttpGet("astrologers")]
    public async Task<ActionResult<IEnumerable<AstrologerDto>>> GetAstrologers(
        [FromQuery] string? specialization, [FromQuery] string? search) =>
        Ok(await catalogService.GetAstrologersAsync(specialization, search));

    [HttpGet("astrologers/{id:guid}")]
    public async Task<ActionResult<AstrologerDto>> GetAstrologer(Guid id)
    {
        var result = await catalogService.GetAstrologerByIdAsync(id);
        return result == null ? NotFound() : Ok(result);
    }

    [HttpGet("festival-offers")]
    public async Task<ActionResult<IEnumerable<FestivalOfferDto>>> GetFestivalOffers() =>
        Ok(await catalogService.GetFestivalOffersAsync());

    [HttpGet("subscription-plans")]
    public async Task<ActionResult<IEnumerable<SubscriptionPlanDto>>> GetSubscriptionPlans() =>
        Ok(await catalogService.GetSubscriptionPlansAsync());

    [HttpGet("gift-cards")]
    public async Task<ActionResult<IEnumerable<GiftCardTypeDto>>> GetGiftCards() =>
        Ok(await catalogService.GetGiftCardTypesAsync());

    [HttpGet("blog")]
    public async Task<ActionResult<IEnumerable<BlogPostDto>>> GetBlog([FromQuery] string? category) =>
        Ok(await catalogService.GetBlogPostsAsync(category));

    [HttpGet("blog/{slug}")]
    public async Task<ActionResult<BlogPostDetailDto>> GetBlogPost(string slug)
    {
        var result = await catalogService.GetBlogPostBySlugAsync(slug);
        return result == null ? NotFound() : Ok(result);
    }

    [HttpGet("faqs")]
    public async Task<ActionResult<IEnumerable<FaqDto>>> GetFaqs([FromQuery] string? category) =>
        Ok(await catalogService.GetFaqsAsync(category));

    [HttpGet("testimonials")]
    public async Task<ActionResult<IEnumerable<TestimonialDto>>> GetTestimonials() =>
        Ok(await catalogService.GetTestimonialsAsync());

    [HttpPost("contact")]
    public async Task<IActionResult> Contact([FromBody] ContactRequest request)
    {
        await catalogService.SubmitContactAsync(request);
        return Ok(new { message = "Thank you for contacting us. We will respond shortly." });
    }

    [HttpPost("newsletter")]
    public async Task<IActionResult> Newsletter([FromBody] NewsletterRequest request)
    {
        await catalogService.SubscribeNewsletterAsync(request);
        return Ok(new { message = "Successfully subscribed to newsletter" });
    }

    [HttpPost("coupons/validate")]
    public async Task<ActionResult<CouponValidationResponse>> ValidateCoupon([FromBody] CouponValidationRequest request) =>
        Ok(await catalogService.ValidateCouponAsync(request));

    [HttpPost("gift-cards/validate")]
    public async Task<ActionResult<GiftCardValidationResponse>> ValidateGiftCard([FromBody] GiftCardValidationRequest request) =>
        Ok(await catalogService.ValidateGiftCardAsync(request));

    [HttpGet("search")]
    public async Task<IActionResult> Search([FromQuery] string q) =>
        Ok(await catalogService.SearchAsync(q));

    [HttpGet("settings/{key}")]
    public async Task<ActionResult<SettingDto>> GetSetting(string key)
    {
        var result = await catalogService.GetSettingAsync(key);
        return result == null ? NotFound() : Ok(result);
    }

    [HttpGet("loading-skeleton")]
    public async Task<ActionResult<LoadingSkeletonDto>> GetActiveLoadingSkeleton()
    {
        var result = await catalogService.GetActiveLoadingSkeletonAsync();
        return result == null ? NotFound() : Ok(result);
    }
}

[ApiController]
[Route("api/customer")]
[Authorize(Policy = "CustomerOnly")]
public class CustomerController(ICustomerService customerService) : ControllerBase
{
    private Guid UserId => Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

    [HttpGet("cart")]
    public async Task<ActionResult<CartDto>> GetCart() => Ok(await customerService.GetCartAsync(UserId));

    [HttpPost("cart")]
    public async Task<IActionResult> AddToCart([FromBody] AddToCartRequest request)
    {
        await customerService.AddToCartAsync(UserId, request);
        return Ok(new { message = "Added to cart" });
    }

    [HttpPut("cart/{productId:guid}")]
    public async Task<IActionResult> UpdateCart(Guid productId, [FromBody] UpdateCartRequest request)
    {
        await customerService.UpdateCartItemAsync(UserId, productId, request);
        return Ok(new { message = "Cart updated" });
    }

    [HttpDelete("cart/{productId:guid}")]
    public async Task<IActionResult> RemoveFromCart(Guid productId)
    {
        await customerService.RemoveFromCartAsync(UserId, productId);
        return Ok(new { message = "Removed from cart" });
    }

    [HttpDelete("cart/clear")]
    public async Task<IActionResult> ClearCart()
    {
        await customerService.ClearCartAsync(UserId);
        return Ok(new { message = "Cart cleared" });
    }

    [HttpGet("orders")]
    public async Task<ActionResult<IEnumerable<OrderDto>>> GetOrders() =>
        Ok(await customerService.GetOrdersAsync(UserId));

    [HttpGet("orders/{id:guid}")]
    public async Task<ActionResult<OrderDto>> GetOrder(Guid id)
    {
        var order = await customerService.GetOrderByIdAsync(UserId, id);
        return order == null ? NotFound() : Ok(order);
    }

    [HttpPost("orders")]
    public async Task<ActionResult<OrderDto>> CreateOrder([FromBody] CreateOrderRequest request) =>
        Ok(await customerService.CreateOrderAsync(UserId, request));

    [HttpGet("orders/{id:guid}/tracking")]
    public async Task<ActionResult<IEnumerable<OrderTrackingDto>>> GetTracking(Guid id) =>
        Ok(await customerService.GetOrderTrackingAsync(UserId, id));

    [HttpGet("pooja-bookings")]
    public async Task<ActionResult<IEnumerable<PoojaBookingDto>>> GetBookings() =>
        Ok(await customerService.GetPoojaBookingsAsync(UserId));

    [HttpPost("pooja-bookings")]
    public async Task<ActionResult<PoojaBookingDto>> CreateBooking([FromBody] PoojaBookingRequest request) =>
        Ok(await customerService.CreatePoojaBookingAsync(UserId, request));

    [HttpGet("kundli-requests")]
    public async Task<ActionResult<IEnumerable<KundliResponseDto>>> GetKundliRequests() =>
        Ok(await customerService.GetKundliRequestsAsync(UserId));

    [HttpPost("kundli-requests")]
    public async Task<ActionResult<KundliResponseDto>> CreateKundliRequest([FromBody] KundliRequestDto request) =>
        Ok(await customerService.CreateKundliRequestAsync(UserId, request));

    [HttpPost("subscriptions")]
    public async Task<ActionResult<UserSubscriptionDto>> Subscribe([FromBody] SubscribeRequest request) =>
        Ok(await customerService.SubscribeAsync(UserId, request));

    [HttpGet("subscriptions")]
    public async Task<ActionResult<IEnumerable<UserSubscriptionDto>>> GetSubscriptions() =>
        Ok(await customerService.GetSubscriptionsAsync(UserId));

    [HttpPost("gift-cards/purchase")]
    public async Task<ActionResult<GiftCardPurchaseDto>> PurchaseGiftCard([FromBody] PurchaseGiftCardRequest request) =>
        Ok(await customerService.PurchaseGiftCardAsync(UserId, request));

    [HttpGet("addresses")]
    public async Task<ActionResult<IEnumerable<AddressDto>>> GetAddresses() =>
        Ok(await customerService.GetAddressesAsync(UserId));

    [HttpPost("addresses")]
    public async Task<ActionResult<AddressDto>> CreateAddress([FromBody] CreateAddressRequest request) =>
        Ok(await customerService.CreateAddressAsync(UserId, request));

    [HttpGet("wishlist")]
    public async Task<ActionResult<IEnumerable<WishlistItemDto>>> GetWishlist() =>
        Ok(await customerService.GetWishlistAsync(UserId));

    [HttpPost("wishlist")]
    public async Task<IActionResult> AddToWishlist([FromBody] AddToWishlistRequest request)
    {
        await customerService.AddToWishlistAsync(UserId, request);
        return Ok(new { message = "Added to wishlist" });
    }

    [HttpDelete("wishlist/{productId:guid}")]
    public async Task<IActionResult> RemoveFromWishlist(Guid productId)
    {
        await customerService.RemoveFromWishlistAsync(UserId, productId);
        return Ok(new { message = "Removed from wishlist" });
    }

}

[ApiController]
[Route("api/astrologer")]
[Authorize(Policy = "AstrologerOnly")]
public class AstrologerController(IAstrologerService astrologerService) : ControllerBase
{
    private Guid UserId => Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

    [HttpGet("profile")]
    public async Task<ActionResult<AstrologerProfileDto>> GetProfile()
    {
        var result = await astrologerService.GetMyProfileAsync(UserId);
        return result == null ? NotFound() : Ok(result);
    }

    [HttpGet("bookings")]
    public async Task<ActionResult<IEnumerable<AstrologerBookingDto>>> GetBookings() =>
        Ok(await astrologerService.GetMyBookingsAsync(UserId));
}

[ApiController]
[Route("api/notifications")]
[Authorize]
public class NotificationsController(ICustomerService customerService) : ControllerBase
{
    private Guid UserId => Guid.Parse(User.FindFirstValue(ClaimTypes.NameIdentifier)!);

    [HttpGet]
    public async Task<ActionResult<IEnumerable<NotificationDto>>> Get() =>
        Ok(await customerService.GetNotificationsAsync(UserId));

    [HttpPost("{id:guid}/read")]
    public async Task<IActionResult> MarkRead(Guid id)
    {
        await customerService.MarkNotificationReadAsync(UserId, id);
        return Ok(new { message = "Marked as read" });
    }

    [HttpPost("read-all")]
    public async Task<IActionResult> MarkAllRead()
    {
        await customerService.MarkAllNotificationsReadAsync(UserId);
        return Ok(new { message = "All marked as read" });
    }
}

[ApiController]
[Route("api/admin")]
[Authorize]
public class AdminController(IAdminService adminService, IWebHostEnvironment env) : ControllerBase
{
    [Authorize(Policy = "AdminOnly")]
    [HttpGet("dashboard")]
    public async Task<ActionResult<DashboardStatsDto>> Dashboard() =>
        Ok(await adminService.GetDashboardStatsAsync());

    [Authorize(Policy = "AdminOnly")]
    [HttpGet("dashboard/charts/revenue")]
    public async Task<ActionResult<IEnumerable<RevenueChartDto>>> RevenueChart([FromQuery] int months = 6) =>
        Ok(await adminService.GetRevenueChartAsync(months));

    [Authorize(Policy = "AdminOnly")]
    [HttpGet("dashboard/recent-orders")]
    public async Task<ActionResult<IEnumerable<RecentOrderDto>>> RecentOrders([FromQuery] int count = 10) =>
        Ok(await adminService.GetRecentOrdersAsync(count));

    [Authorize(Policy = "AdminOnly")]
    [HttpGet("users")]
    public async Task<ActionResult<IEnumerable<AdminUserDto>>> Users() =>
        Ok(await adminService.GetUsersAsync());

    [Authorize(Policy = "ManageProducts")]
    [HttpGet("products")]
    public async Task<ActionResult<IEnumerable<AdminProductDto>>> Products() =>
        Ok(await adminService.GetProductsAsync());

    [Authorize(Policy = "ManagePoojaServices")]
    [HttpGet("pooja-services")]
    public async Task<ActionResult<IEnumerable<AdminPoojaDto>>> PoojaServices() =>
        Ok(await adminService.GetPoojaServicesAsync());

    [Authorize(Policy = "ManageOrders")]
    [HttpGet("orders")]
    public async Task<ActionResult<IEnumerable<AdminOrderDto>>> Orders() =>
        Ok(await adminService.GetOrdersAsync());

    [Authorize(Policy = "ManageBookings")]
    [HttpGet("bookings")]
    public async Task<ActionResult<IEnumerable<AdminBookingDto>>> Bookings() =>
        Ok(await adminService.GetBookingsAsync());

    [Authorize(Policy = "ManageProducts")]
    [HttpGet("categories")]
    public async Task<ActionResult<IEnumerable<AdminCategoryDto>>> Categories() =>
        Ok(await adminService.GetCategoriesAsync());

    [Authorize(Policy = "ManageOffers")]
    [HttpGet("coupons")]
    public async Task<ActionResult<IEnumerable<AdminCouponDto>>> Coupons() =>
        Ok(await adminService.GetCouponsAsync());

    [Authorize(Policy = "ManageOffers")]
    [HttpPost("coupons")]
    public async Task<ActionResult<AdminCouponDto>> CreateCoupon([FromBody] CreateCouponRequest request)
    {
        try { return Ok(await adminService.CreateCouponAsync(request)); }
        catch (InvalidOperationException ex) { return BadRequest(new { message = ex.Message }); }
    }

    [Authorize(Policy = "ManageOffers")]
    [HttpPut("coupons/{id:guid}")]
    public async Task<ActionResult<AdminCouponDto>> UpdateCoupon(Guid id, [FromBody] UpdateCouponRequest request)
    {
        try { return Ok(await adminService.UpdateCouponAsync(id, request)); }
        catch (KeyNotFoundException ex) { return NotFound(new { message = ex.Message }); }
        catch (InvalidOperationException ex) { return BadRequest(new { message = ex.Message }); }
    }

    [Authorize(Policy = "ManageOffers")]
    [HttpDelete("coupons/{id:guid}")]
    public async Task<IActionResult> DeleteCoupon(Guid id)
    {
        try
        {
            await adminService.DeleteCouponAsync(id);
            return Ok(new { message = "Coupon deleted" });
        }
        catch (KeyNotFoundException ex) { return NotFound(new { message = ex.Message }); }
        catch (InvalidOperationException ex) { return BadRequest(new { message = ex.Message }); }
    }

    [Authorize(Policy = "AdminOnly")]
    [HttpPatch("users/{id:guid}/staff-approval")]
    public async Task<ActionResult<AdminUserDto>> UpdateStaffApproval(Guid id, [FromBody] UpdateStaffApprovalRequest request)
    {
        try { return Ok(await adminService.UpdateStaffApprovalAsync(id, request)); }
        catch (KeyNotFoundException ex) { return NotFound(new { message = ex.Message }); }
    }

    [Authorize(Policy = "AdminOnly")]
    [HttpPut("users/{id:guid}/permissions")]
    public async Task<ActionResult<AdminUserDto>> UpdateUserPermissions(Guid id, [FromBody] UpdateUserPermissionsRequest request)
    {
        try { return Ok(await adminService.UpdateUserPermissionsAsync(id, request)); }
        catch (KeyNotFoundException ex) { return NotFound(new { message = ex.Message }); }
        catch (InvalidOperationException ex) { return BadRequest(new { message = ex.Message }); }
    }

    [Authorize(Policy = "ManageProducts")]
    [HttpPost("products")]
    [Consumes("multipart/form-data")]
    public async Task<ActionResult<AdminProductDto>> CreateProduct(
        [FromForm] string name, [FromForm] string description, [FromForm] Guid categoryId,
        [FromForm] decimal price, [FromForm] decimal? salePrice, [FromForm] int stockQuantity,
        [FromForm] bool isFeatured, [FromForm] string? festivalTag,
        List<IFormFile> images)
    {
        var imageUrls = new List<string>();
        foreach (var image in images)
        {
            var url = await SaveImageAsync(image);
            if (url != null) imageUrls.Add(url);
        }
        try
        {
            var result = await adminService.CreateProductAsync(new CreateProductRequest(
                name, description, categoryId, price, salePrice, stockQuantity, isFeatured, festivalTag, imageUrls));
            return Ok(result);
        }
        catch (KeyNotFoundException ex) { return BadRequest(new { message = ex.Message }); }
    }

    [Authorize(Policy = "ManageProducts")]
    [HttpGet("products/{id:guid}")]
    public async Task<ActionResult<AdminProductDetailDto>> GetProduct(Guid id)
    {
        var result = await adminService.GetProductByIdAsync(id);
        return result == null ? NotFound() : Ok(result);
    }

    [Authorize(Policy = "ManageProducts")]
    [HttpPut("products/{id:guid}")]
    [Consumes("multipart/form-data")]
    public async Task<ActionResult<AdminProductDto>> UpdateProduct(Guid id,
        [FromForm] string name, [FromForm] string description, [FromForm] Guid categoryId,
        [FromForm] decimal price, [FromForm] decimal? salePrice, [FromForm] int stockQuantity,
        [FromForm] bool isFeatured, [FromForm] bool isActive, [FromForm] string? festivalTag,
        List<IFormFile> images, [FromForm] List<string> imageOrder)
    {
        // imageOrder has one entry per image slot, in display order: either the literal
        // "NEW" (consume the next file from `images`, in upload order) or an existing
        // image's URL to keep as-is. This lets the admin add, remove, or reorder as many
        // images as they want and have every one of them persisted, not just a fixed count.
        var imageUrls = new List<string>();
        var nextNewImage = 0;
        foreach (var slot in imageOrder)
        {
            if (slot == "NEW")
            {
                if (nextNewImage >= images.Count) continue;
                var uploaded = await SaveImageAsync(images[nextNewImage]);
                nextNewImage++;
                if (uploaded != null) imageUrls.Add(uploaded);
            }
            else if (!string.IsNullOrWhiteSpace(slot))
            {
                imageUrls.Add(slot);
            }
        }
        try
        {
            var result = await adminService.UpdateProductAsync(id, new UpdateProductRequest(
                name, description, categoryId, price, salePrice, stockQuantity, isFeatured, isActive, festivalTag, imageUrls));
            return Ok(result);
        }
        catch (KeyNotFoundException ex) { return BadRequest(new { message = ex.Message }); }
    }

    [Authorize(Policy = "ManageProducts")]
    [HttpPatch("products/{id:guid}/stock")]
    public async Task<ActionResult<AdminProductDto>> UpdateProductStock(Guid id, [FromBody] UpdateStockRequest request)
    {
        try { return Ok(await adminService.UpdateProductStockAsync(id, request)); }
        catch (KeyNotFoundException ex) { return NotFound(new { message = ex.Message }); }
    }

    [Authorize(Policy = "ManageProducts")]
    [HttpDelete("products/{id:guid}")]
    public async Task<IActionResult> DeleteProduct(Guid id)
    {
        try
        {
            await adminService.DeleteProductAsync(id);
            return Ok(new { message = "Product deleted" });
        }
        catch (KeyNotFoundException ex) { return NotFound(new { message = ex.Message }); }
        catch (InvalidOperationException ex) { return BadRequest(new { message = ex.Message }); }
    }

    [Authorize(Policy = "ManageProducts")]
    [HttpPost("products/bulk-delete")]
    public async Task<ActionResult<BulkDeleteResultDto>> BulkDeleteProducts([FromBody] BulkDeleteRequest request) =>
        Ok(await adminService.DeleteProductsAsync(request.Ids));

    [Authorize(Policy = "AdminOnly")]
    [HttpPatch("users/{id:guid}/status")]
    public async Task<ActionResult<AdminUserDto>> UpdateUserStatus(Guid id, [FromBody] UpdateUserStatusRequest request)
    {
        try { return Ok(await adminService.UpdateUserStatusAsync(id, request)); }
        catch (KeyNotFoundException ex) { return NotFound(new { message = ex.Message }); }
    }

    [Authorize(Policy = "AdminOnly")]
    [HttpPatch("users/{id:guid}/astrologer-approval")]
    public async Task<ActionResult<AdminUserDto>> UpdateAstrologerApproval(Guid id, [FromBody] UpdateAstrologerApprovalRequest request)
    {
        try { return Ok(await adminService.UpdateAstrologerApprovalAsync(id, request)); }
        catch (KeyNotFoundException ex) { return NotFound(new { message = ex.Message }); }
    }

    [Authorize(Policy = "ManagePoojaServices")]
    [HttpGet("pooja-services/{id:guid}")]
    public async Task<ActionResult<AdminPoojaDetailDto>> GetPoojaService(Guid id)
    {
        var result = await adminService.GetPoojaServiceByIdAsync(id);
        return result == null ? NotFound() : Ok(result);
    }

    [Authorize(Policy = "ManagePoojaServices")]
    [HttpPut("pooja-services/{id:guid}")]
    [Consumes("multipart/form-data")]
    public async Task<ActionResult<AdminPoojaDto>> UpdatePoojaService(Guid id,
        [FromForm] string name, [FromForm] string category, [FromForm] string description,
        [FromForm] decimal price, [FromForm] decimal? salePrice, [FromForm] int durationMinutes,
        [FromForm] bool isFeatured, [FromForm] bool isActive, IFormFile? image)
    {
        var imageUrl = await SaveImageAsync(image, "pooja");
        try
        {
            var request = new UpdatePoojaRequest(name, category, description, price, salePrice, durationMinutes, isFeatured, isActive, imageUrl);
            return Ok(await adminService.UpdatePoojaServiceAsync(id, request));
        }
        catch (KeyNotFoundException ex) { return NotFound(new { message = ex.Message }); }
    }

    [Authorize(Policy = "ManageOrders")]
    [HttpGet("orders/{id:guid}")]
    public async Task<ActionResult<AdminOrderDetailDto>> GetOrder(Guid id)
    {
        var result = await adminService.GetOrderByIdAsync(id);
        return result == null ? NotFound() : Ok(result);
    }

    [Authorize(Policy = "ManageOrders")]
    [HttpPut("orders/{id:guid}/status")]
    public async Task<ActionResult<AdminOrderDto>> UpdateOrderStatus(Guid id, [FromBody] UpdateOrderStatusRequest request)
    {
        try { return Ok(await adminService.UpdateOrderStatusAsync(id, request)); }
        catch (KeyNotFoundException ex) { return NotFound(new { message = ex.Message }); }
        catch (ArgumentException ex) { return BadRequest(new { message = ex.Message }); }
    }

    [Authorize(Policy = "AdminOnly")]
    [HttpPut("settings/{key}")]
    [Consumes("multipart/form-data")]
    public async Task<ActionResult<SettingDto>> UpdateSettingImage(string key, IFormFile? image)
    {
        var imageUrl = await SaveImageAsync(image, "settings");
        if (imageUrl == null) return BadRequest(new { message = "Image is required" });
        return Ok(await adminService.UpdateSettingImageAsync(key, imageUrl));
    }

    [Authorize(Policy = "AdminOnly")]
    [HttpGet("loading-skeletons")]
    public async Task<ActionResult<IEnumerable<LoadingSkeletonDto>>> GetLoadingSkeletons() =>
        Ok(await adminService.GetLoadingSkeletonsAsync());

    [Authorize(Policy = "AdminOnly")]
    [HttpPatch("loading-skeletons/{id:int}/activate")]
    public async Task<ActionResult<LoadingSkeletonDto>> ActivateLoadingSkeleton(int id)
    {
        try { return Ok(await adminService.SetActiveLoadingSkeletonAsync(id)); }
        catch (KeyNotFoundException ex) { return NotFound(new { message = ex.Message }); }
    }

    private async Task<string?> SaveImageAsync(IFormFile? image, string subfolder = "products")
    {
        if (image is not { Length: > 0 }) return null;

        var ext = Path.GetExtension(image.FileName);
        var fileName = $"{Guid.NewGuid()}{ext}";
        var webRoot = env.WebRootPath ?? Path.Combine(env.ContentRootPath, "wwwroot");
        var dir = Path.Combine(webRoot, "images", subfolder);
        Directory.CreateDirectory(dir);
        await using var stream = new FileStream(Path.Combine(dir, fileName), FileMode.Create);
        await image.CopyToAsync(stream);
        return $"/images/{subfolder}/{fileName}";
    }
}

[ApiController]
[Route("api/[controller]")]
public class HealthController : ControllerBase
{
    [HttpGet]
    public IActionResult Get() => Ok(new { status = "healthy", service = "VadicMall API", timestamp = DateTime.UtcNow });
}
