using VadicMall.Application.DTOs.Customer;

namespace VadicMall.Application.DTOs.Admin;

public record DashboardStatsDto(
    int TotalUsers,
    int TotalAstrologers,
    int TotalOrders,
    int TotalBookings,
    decimal TotalRevenue,
    int PendingOrders,
    int PendingBookings,
    int LowStockProducts);

public record RevenueChartDto(string Label, decimal Revenue);
public record RecentOrderDto(Guid Id, string OrderNumber, string CustomerName, decimal Total, string Status, DateTime CreatedAt);

public record AdminUserDto(Guid Id, string Email, string FirstName, string LastName, string Role, bool IsActive, DateTime CreatedAt, bool? IsAstrologerApproved = null, bool IsStaffApproved = false, List<string>? Permissions = null);
public record AdminProductDto(Guid Id, string Name, string Category, decimal Price, decimal? SalePrice, int StockQuantity, bool IsFeatured, bool IsActive, string? ImageUrl = null);
public record AdminPoojaDto(Guid Id, string Name, string Category, decimal Price, bool IsFeatured, bool IsActive, string? ImageUrl = null);
public record AdminOrderDto(Guid Id, string OrderNumber, string CustomerName, decimal Total, string Status, DateTime CreatedAt);
public record AdminCategoryDto(Guid Id, string Name, string Slug);
public record CreateProductRequest(string Name, string Description, Guid CategoryId, decimal Price, decimal? SalePrice, int StockQuantity, bool IsFeatured, string? FestivalTag, List<string> ImageUrls);
public record AdminProductDetailDto(Guid Id, string Name, string Description, Guid CategoryId, decimal Price, decimal? SalePrice, int StockQuantity, bool IsFeatured, bool IsActive, string? FestivalTag, List<string> Images);
public record UpdateProductRequest(string Name, string Description, Guid CategoryId, decimal Price, decimal? SalePrice, int StockQuantity, bool IsFeatured, bool IsActive, string? FestivalTag, List<string> ImageUrls);
public record UpdateStockRequest(bool InStock);
public record UpdateUserStatusRequest(bool IsActive);
public record AdminPoojaDetailDto(Guid Id, string Name, string Category, string Description, decimal Price, decimal? SalePrice, int DurationMinutes, bool IsFeatured, bool IsActive, string? ImageUrl = null);
public record UpdatePoojaRequest(string Name, string Category, string Description, decimal Price, decimal? SalePrice, int DurationMinutes, bool IsFeatured, bool IsActive, string? ImageUrl = null);
public record AdminOrderDetailDto(Guid Id, string OrderNumber, string CustomerName, string CustomerEmail, decimal SubTotal, decimal Discount, decimal ShippingFee, decimal Total, string Status, DateTime CreatedAt, List<OrderItemDto> Items, List<OrderTrackingDto> Tracking);
public record UpdateOrderStatusRequest(string Status, string? Notes, string? Location);
public record UpdateAstrologerApprovalRequest(bool Approved);
public record BulkDeleteRequest(List<Guid> Ids);
public record BulkDeleteResultDto(int DeletedCount, List<string> SkippedProductNames);
public record AdminBookingDto(Guid Id, string ServiceName, string CustomerName, DateTime ScheduledDate, string? ScheduledTime, string Status, decimal Amount, string? ImageUrl);
public record UpdateStaffApprovalRequest(bool IsApproved);
public record UpdateUserPermissionsRequest(List<string> Permissions);
public record AdminCouponDto(Guid Id, string Code, string Description, string Type, decimal Value, decimal? MinOrderValue, decimal? MaxDiscount, int UsageLimit, int UsedCount, DateTime ValidFrom, DateTime ValidTo, string? FestivalTag, bool IsActive);
public record CreateCouponRequest(string Code, string Description, string Type, decimal Value, decimal? MinOrderValue, decimal? MaxDiscount, int UsageLimit, DateTime ValidFrom, DateTime ValidTo, string? FestivalTag);
public record UpdateCouponRequest(string Description, string Type, decimal Value, decimal? MinOrderValue, decimal? MaxDiscount, int UsageLimit, DateTime ValidFrom, DateTime ValidTo, string? FestivalTag, bool IsActive);
