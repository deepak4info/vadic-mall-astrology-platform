using VadicMall.Domain.Enums;

namespace VadicMall.Application.DTOs.Customer;

public record CartItemDto(Guid Id, Guid ProductId, string ProductName, decimal Price, decimal? SalePrice, string? ImageUrl, int Quantity, decimal LineTotal);
public record CartDto(List<CartItemDto> Items, decimal SubTotal, int ItemCount);
public record AddToCartRequest(Guid ProductId, int Quantity);
public record UpdateCartRequest(int Quantity);
public record CreateOrderRequest(Guid? ShippingAddressId, string? CouponCode, string PaymentMethod, string? GiftCardCode = null);
public record OrderDto(Guid Id, string OrderNumber, OrderStatus Status, decimal Total, DateTime CreatedAt, List<OrderItemDto> Items);
public record OrderItemDto(Guid ProductId, string ProductName, int Quantity, decimal UnitPrice, decimal TotalPrice, string? ImageUrl = null);
public record OrderTrackingDto(OrderStatus Status, string? Notes, string? Location, DateTime CreatedAt);
public record PoojaBookingRequest(Guid PoojaServiceId, DateTime ScheduledDate, string? ScheduledTime, string? SpecialInstructions);
public record PoojaBookingDto(Guid Id, string ServiceName, DateTime ScheduledDate, string? ScheduledTime, BookingStatus Status, decimal Amount, DateTime CreatedAt);
public record KundliRequestDto(string Name, DateTime DateOfBirth, string TimeOfBirth, string PlaceOfBirth, string Gender, decimal? Amount);
public record KundliResponseDto(Guid Id, string Name, KundliStatus Status, decimal Amount, DateTime CreatedAt, string? ReportUrl);
public record SubscribeRequest(Guid SubscriptionPlanId, string PaymentMethod);
public record UserSubscriptionDto(Guid Id, string PlanName, decimal Price, DateTime StartDate, DateTime EndDate, string Status);
public record PurchaseGiftCardRequest(string Type, decimal Amount, string PaymentMethod);
public record GiftCardPurchaseDto(Guid Id, string Code, decimal Amount, decimal Balance, string Status);
public record AddressDto(Guid Id, string FullName, string Phone, string AddressLine1, string? AddressLine2, string City, string State, string Pincode, string Country, bool IsDefault);
public record CreateAddressRequest(string FullName, string Phone, string AddressLine1, string? AddressLine2, string City, string State, string Pincode, string Country, bool IsDefault);
public record WishlistItemDto(Guid ProductId, string ProductName, decimal Price, decimal? SalePrice, string? ImageUrl, decimal Rating, int StockQuantity);
public record AddToWishlistRequest(Guid ProductId);
public record NotificationDto(Guid Id, string Title, string Message, string Type, bool IsRead, string? Link, DateTime CreatedAt);
