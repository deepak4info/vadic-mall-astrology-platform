using System.Text.Json;
using Microsoft.EntityFrameworkCore;
using VadicMall.Application.DTOs.Admin;
using VadicMall.Application.DTOs.Catalog;
using VadicMall.Application.DTOs.Customer;
using VadicMall.Application.Interfaces;
using VadicMall.Domain.Entities;
using VadicMall.Domain.Enums;
using VadicMall.Infrastructure.Data;

namespace VadicMall.Infrastructure.Services;

public class CatalogService(VadicMallDbContext db) : ICatalogService
{
    public async Task<IEnumerable<PoojaServiceDto>> GetPoojaServicesAsync(string? category = null, string? search = null, bool? featured = null)
    {
        var query = db.PoojaServices.AsNoTracking().Where(p => p.IsActive);

        if (!string.IsNullOrWhiteSpace(category))
            query = query.Where(p => p.Category == category);
        if (!string.IsNullOrWhiteSpace(search))
            query = query.Where(p => p.Name.Contains(search) || p.Description.Contains(search));
        if (featured == true)
            query = query.Where(p => p.IsFeatured);

        return await query.OrderByDescending(p => p.IsFeatured).ThenBy(p => p.Name)
            .Select(p => MapPooja(p)).ToListAsync();
    }

    public async Task<PoojaServiceDto?> GetPoojaServiceByIdAsync(Guid id)
    {
        var p = await db.PoojaServices.AsNoTracking().FirstOrDefaultAsync(x => x.Id == id && x.IsActive);
        return p == null ? null : MapPooja(p);
    }

    public async Task<IEnumerable<ProductDto>> GetProductsAsync(string? category = null, string? search = null, decimal? minPrice = null, decimal? maxPrice = null, bool? featured = null)
    {
        var query = db.Products.AsNoTracking().Include(p => p.Category).Include(p => p.Images)
            .Where(p => p.IsActive);

        if (!string.IsNullOrWhiteSpace(category))
            query = query.Where(p => p.Category.Slug == category || p.Category.Name == category);
        if (!string.IsNullOrWhiteSpace(search))
            query = query.Where(p => p.Name.Contains(search) || p.Description.Contains(search));
        if (minPrice.HasValue)
            query = query.Where(p => (p.SalePrice ?? p.Price) >= minPrice.Value);
        if (maxPrice.HasValue)
            query = query.Where(p => (p.SalePrice ?? p.Price) <= maxPrice.Value);
        if (featured == true)
            query = query.Where(p => p.IsFeatured);

        return await query.OrderByDescending(p => p.IsFeatured).ThenBy(p => p.Name)
            .Select(p => new ProductDto(
                p.Id, p.Name, p.Slug, p.Description, p.Category.Name,
                p.Price, p.SalePrice, p.StockQuantity, p.Rating, p.ReviewCount,
                p.IsFeatured,
                p.Images.OrderBy(i => i.SortOrder).Select(i => i.ImageUrl).FirstOrDefault(),
                p.FestivalTag)).ToListAsync();
    }

    public async Task<ProductDetailDto?> GetProductByIdAsync(Guid id)
    {
        var p = await db.Products.AsNoTracking()
            .Include(x => x.Category)
            .Include(x => x.Images)
            .Include(x => x.Reviews).ThenInclude(r => r.User)
            .FirstOrDefaultAsync(x => x.Id == id && x.IsActive);

        if (p == null) return null;

        return new ProductDetailDto(
            p.Id, p.Name, p.Slug, p.Description, p.Category.Name,
            p.Price, p.SalePrice, p.StockQuantity, p.Rating, p.ReviewCount, p.IsFeatured,
            p.Images.OrderBy(i => i.SortOrder).Select(i => i.ImageUrl).ToList(),
            p.Reviews.Select(r => new ReviewDto(r.Id, $"{r.User.FirstName} {r.User.LastName[0]}.", r.Rating, r.Comment, r.CreatedAt)).ToList(),
            p.FestivalTag);
    }

    public async Task<IEnumerable<AstrologerDto>> GetAstrologersAsync(string? specialization = null, string? search = null)
    {
        var query = db.AstrologerProfiles.AsNoTracking()
            .Include(a => a.User)
            .Where(a => a.IsActive && a.IsApproved);

        if (!string.IsNullOrWhiteSpace(specialization))
            query = query.Where(a => a.Specialization.Contains(specialization));
        if (!string.IsNullOrWhiteSpace(search))
            query = query.Where(a => a.User.FirstName.Contains(search) || a.User.LastName.Contains(search) || a.Specialization.Contains(search));

        return await query.OrderByDescending(a => a.IsFeatured).ThenByDescending(a => a.Rating)
            .Select(a => new AstrologerDto(
                a.UserId,
                $"{a.User.FirstName} {a.User.LastName}",
                a.Specialization, a.Bio, a.ExperienceYears, a.ConsultationFee,
                a.Rating, a.ReviewCount, a.IsFeatured, a.User.AvatarUrl, a.Languages))
            .ToListAsync();
    }

    public async Task<AstrologerDto?> GetAstrologerByIdAsync(Guid id)
    {
        var a = await db.AstrologerProfiles.AsNoTracking()
            .Include(x => x.User)
            .FirstOrDefaultAsync(x => x.UserId == id && x.IsActive && x.IsApproved);

        if (a == null) return null;

        return new AstrologerDto(a.UserId, $"{a.User.FirstName} {a.User.LastName}",
            a.Specialization, a.Bio, a.ExperienceYears, a.ConsultationFee,
            a.Rating, a.ReviewCount, a.IsFeatured, a.User.AvatarUrl, a.Languages);
    }

    public async Task<IEnumerable<SubscriptionPlanDto>> GetSubscriptionPlansAsync()
    {
        var plans = await db.SubscriptionPlans.AsNoTracking().Where(p => p.IsActive).OrderBy(p => p.Price).ToListAsync();
        return plans.Select(p => new SubscriptionPlanDto(
            p.Id, p.Name, p.Slug, p.Description, p.Price, p.BillingCycle,
            JsonSerializer.Deserialize<List<string>>(p.Features) ?? [],
            p.IsPopular));
    }

    public Task<IEnumerable<GiftCardTypeDto>> GetGiftCardTypesAsync() =>
        Task.FromResult<IEnumerable<GiftCardTypeDto>>([
            new("Pooja Gift Card", [500, 1000, 2500, 5000, 10000]),
            new("Product Gift Card", [500, 1000, 2500, 5000, 10000]),
            new("Consultation Gift Card", [1000, 2500, 5000, 10000]),
            new("Complete Gift Card", [1000, 2500, 5000, 10000, 25000])
        ]);

    public async Task<IEnumerable<FestivalOfferDto>> GetFestivalOffersAsync()
    {
        var festivals = new[] { "Diwali", "Navratri", "Maha Shivratri", "Ganesh Chaturthi", "Krishna Janmashtami" };
        var offers = new List<FestivalOfferDto>();

        foreach (var festival in festivals)
        {
            var services = await db.PoojaServices.AsNoTracking()
                .Where(p => p.FestivalTag == festival && p.IsActive).Take(3)
                .Select(p => MapPooja(p)).ToListAsync();

            var products = await db.Products.AsNoTracking()
                .Include(p => p.Category).Include(p => p.Images)
                .Where(p => p.FestivalTag == festival && p.IsActive).Take(4)
                .Select(p => new ProductDto(p.Id, p.Name, p.Slug, p.Description, p.Category.Name,
                    p.Price, p.SalePrice, p.StockQuantity, p.Rating, p.ReviewCount, p.IsFeatured,
                    p.Images.OrderBy(i => i.SortOrder).Select(i => i.ImageUrl).FirstOrDefault(),
                    p.FestivalTag)).ToListAsync();

            if (services.Count > 0 || products.Count > 0)
            {
                offers.Add(new FestivalOfferDto(festival,
                    $"Special {festival} offers on poojas and spiritual products",
                    festival switch { "Diwali" => 30, "Navratri" => 25, _ => 20 },
                    null, services, products));
            }
        }

        return offers;
    }

    public async Task<IEnumerable<BlogPostDto>> GetBlogPostsAsync(string? category = null)
    {
        var query = db.BlogPosts.AsNoTracking().Include(b => b.Category).Where(b => b.IsActive);
        if (!string.IsNullOrWhiteSpace(category))
            query = query.Where(b => b.Category.Slug == category);

        return await query.OrderByDescending(b => b.CreatedAt)
            .Select(b => new BlogPostDto(b.Id, b.Title, b.Slug, b.Excerpt, b.ImageUrl,
                b.Author, b.Category.Name, b.CreatedAt, b.ViewCount)).ToListAsync();
    }

    public async Task<BlogPostDetailDto?> GetBlogPostBySlugAsync(string slug)
    {
        var b = await db.BlogPosts.AsNoTracking().Include(x => x.Category)
            .FirstOrDefaultAsync(x => x.Slug == slug && x.IsActive);
        if (b == null) return null;

        return new BlogPostDetailDto(b.Id, b.Title, b.Slug, b.Excerpt, b.Content,
            b.ImageUrl, b.Author, b.Category.Name, b.CreatedAt, b.ViewCount);
    }

    public async Task<IEnumerable<FaqDto>> GetFaqsAsync(string? category = null)
    {
        var query = db.Faqs.AsNoTracking().Where(f => f.IsActive);
        if (!string.IsNullOrWhiteSpace(category))
            query = query.Where(f => f.Category == category);

        return await query.OrderBy(f => f.SortOrder)
            .Select(f => new FaqDto(f.Id, f.Question, f.Answer, f.Category)).ToListAsync();
    }

    public Task<IEnumerable<TestimonialDto>> GetTestimonialsAsync() =>
        Task.FromResult<IEnumerable<TestimonialDto>>([
            new("Priya Sharma", "Mumbai", "The Ganesh Puja booking was seamless. Received prasad on time. Highly recommended!", 5, null),
            new("Rajesh Kumar", "Delhi", "Authentic gemstones with certification. Vadic Mall is my trusted spiritual marketplace.", 5, null),
            new("Anita Desai", "Bangalore", "Kundli analysis was detailed and accurate. The astrologer was very knowledgeable.", 5, null),
            new("Vikram Singh", "Jaipur", "Diwali special offers saved me 30%. Beautiful pooja samagri collection.", 5, null)
        ]);

    public async Task SubmitContactAsync(ContactRequest request)
    {
        db.ContactQueries.Add(new ContactQuery
        {
            Name = request.Name,
            Email = request.Email,
            Phone = request.Phone,
            Subject = request.Subject,
            Message = request.Message
        });
        await db.SaveChangesAsync();
    }

    public async Task SubscribeNewsletterAsync(NewsletterRequest request)
    {
        if (!await db.NewsletterSubscribers.AnyAsync(n => n.Email == request.Email))
        {
            db.NewsletterSubscribers.Add(new NewsletterSubscriber { Email = request.Email });
            await db.SaveChangesAsync();
        }
    }

    public async Task<CouponValidationResponse> ValidateCouponAsync(CouponValidationRequest request)
    {
        var coupon = await db.Coupons.FirstOrDefaultAsync(c =>
            c.Code == request.Code.ToUpperInvariant() && c.IsActive &&
            c.ValidFrom <= DateTime.UtcNow && c.ValidTo >= DateTime.UtcNow);

        if (coupon == null)
            return new CouponValidationResponse(false, "Invalid or expired coupon", 0, null);

        if (coupon.UsedCount >= coupon.UsageLimit)
            return new CouponValidationResponse(false, "Coupon usage limit reached", 0, null);

        if (coupon.MinOrderValue.HasValue && request.OrderTotal < coupon.MinOrderValue.Value)
            return new CouponValidationResponse(false, $"Minimum order value is ₹{coupon.MinOrderValue}", 0, null);

        var discount = coupon.Type switch
        {
            CouponType.Percentage => request.OrderTotal * coupon.Value / 100,
            CouponType.FixedAmount => coupon.Value,
            _ => 0
        };

        if (coupon.MaxDiscount.HasValue)
            discount = Math.Min(discount, coupon.MaxDiscount.Value);

        return new CouponValidationResponse(true, "Coupon applied successfully", discount, coupon.Code);
    }

    public async Task<GiftCardValidationResponse> ValidateGiftCardAsync(GiftCardValidationRequest request)
    {
        var giftCard = await db.GiftCards.AsNoTracking()
            .FirstOrDefaultAsync(g => g.Code == request.Code.ToUpperInvariant());

        if (giftCard == null)
            return new GiftCardValidationResponse(false, "Invalid gift card code", 0, null);

        if (giftCard.Status != "active")
            return new GiftCardValidationResponse(false, "This gift card has already been fully redeemed", 0, null);

        if (giftCard.ExpiryDate.HasValue && giftCard.ExpiryDate.Value < DateTime.UtcNow)
            return new GiftCardValidationResponse(false, "This gift card has expired", 0, null);

        if (giftCard.Balance <= 0)
            return new GiftCardValidationResponse(false, "This gift card has no remaining balance", 0, null);

        return new GiftCardValidationResponse(true, $"Gift card valid — ₹{giftCard.Balance:N0} available", giftCard.Balance, giftCard.Code);
    }

    public async Task<object> SearchAsync(string query)
    {
        var poojas = await GetPoojaServicesAsync(search: query);
        var products = await GetProductsAsync(search: query);
        var astrologers = await GetAstrologersAsync(search: query);
        return new { poojas, products, astrologers };
    }

    public async Task<SettingDto?> GetSettingAsync(string key)
    {
        var setting = await db.Settings.AsNoTracking().FirstOrDefaultAsync(s => s.Key == key && s.IsActive);
        return setting == null ? null : new SettingDto(setting.Key, setting.Value);
    }

    public async Task<LoadingSkeletonDto?> GetActiveLoadingSkeletonAsync()
    {
        var preset = await db.LoadingSkeletons.AsNoTracking()
            .Where(s => s.IsActive).OrderBy(s => s.SortOrder).FirstOrDefaultAsync();
        return preset == null ? null : new LoadingSkeletonDto(preset.Id, preset.Name, preset.DisplayName,
            preset.CssClass, preset.DurationMs, preset.DelayMs, preset.Easing, preset.ConfigJson, preset.IsActive, preset.SortOrder);
    }

    private static PoojaServiceDto MapPooja(PoojaService p) =>
        new(p.Id, p.Name, p.Slug, p.Category, p.Description, p.Price, p.SalePrice,
            p.DurationMinutes, p.ImageUrl, p.IsFeatured, p.Rating, p.ReviewCount, p.FestivalTag);
}

public class CustomerService(VadicMallDbContext db) : ICustomerService
{
    public async Task<CartDto> GetCartAsync(Guid userId)
    {
        var items = await db.CartItems.AsNoTracking()
            .Include(c => c.Product).ThenInclude(p => p.Images)
            .Where(c => c.UserId == userId && c.IsActive)
            .ToListAsync();

        var dtos = items.Select(c =>
        {
            var price = c.Product.SalePrice ?? c.Product.Price;
            return new CartItemDto(c.Id, c.ProductId, c.Product.Name, c.Product.Price,
                c.Product.SalePrice,
                c.Product.Images.OrderBy(i => i.SortOrder).Select(i => i.ImageUrl).FirstOrDefault(),
                c.Quantity, price * c.Quantity);
        }).ToList();

        return new CartDto(dtos, dtos.Sum(i => i.LineTotal), dtos.Sum(i => i.Quantity));
    }

    public async Task AddToCartAsync(Guid userId, AddToCartRequest request)
    {
        var existing = await db.CartItems.FirstOrDefaultAsync(c =>
            c.UserId == userId && c.ProductId == request.ProductId && c.IsActive);

        if (existing != null)
        {
            existing.Quantity += request.Quantity;
            existing.UpdatedAt = DateTime.UtcNow;
        }
        else
        {
            db.CartItems.Add(new CartItem { UserId = userId, ProductId = request.ProductId, Quantity = request.Quantity });
        }

        await db.SaveChangesAsync();
    }

    public async Task UpdateCartItemAsync(Guid userId, Guid productId, UpdateCartRequest request)
    {
        var item = await db.CartItems.FirstOrDefaultAsync(c =>
            c.UserId == userId && c.ProductId == productId && c.IsActive)
            ?? throw new KeyNotFoundException("Cart item not found");

        if (request.Quantity <= 0)
            db.CartItems.Remove(item);
        else
        {
            item.Quantity = request.Quantity;
            item.UpdatedAt = DateTime.UtcNow;
        }

        await db.SaveChangesAsync();
    }

    public async Task RemoveFromCartAsync(Guid userId, Guid productId)
    {
        var item = await db.CartItems.FirstOrDefaultAsync(c =>
            c.UserId == userId && c.ProductId == productId && c.IsActive);
        if (item != null)
        {
            db.CartItems.Remove(item);
            await db.SaveChangesAsync();
        }
    }

    public async Task ClearCartAsync(Guid userId)
    {
        var items = await db.CartItems.Where(c => c.UserId == userId).ToListAsync();
        db.CartItems.RemoveRange(items);
        await db.SaveChangesAsync();
    }

    public async Task<OrderDto> CreateOrderAsync(Guid userId, CreateOrderRequest request)
    {
        var cart = await GetCartAsync(userId);
        if (cart.Items.Count == 0)
            throw new InvalidOperationException("Cart is empty");

        var discount = 0m;
        if (!string.IsNullOrWhiteSpace(request.CouponCode))
        {
            var validation = await new CatalogService(db).ValidateCouponAsync(
                new CouponValidationRequest(request.CouponCode, cart.SubTotal));
            if (validation.IsValid)
                discount = validation.DiscountAmount;
        }

        var shippingFee = cart.SubTotal >= 999 ? 0 : 99;
        var totalBeforeGiftCard = Math.Max(cart.SubTotal - discount + shippingFee, 0);

        GiftCard? giftCard = null;
        var giftCardApplied = 0m;
        if (!string.IsNullOrWhiteSpace(request.GiftCardCode))
        {
            giftCard = await db.GiftCards.FirstOrDefaultAsync(g => g.Code == request.GiftCardCode.ToUpperInvariant());
            var giftCardUsable = giftCard != null && giftCard.Status == "active" && giftCard.Balance > 0
                && (!giftCard.ExpiryDate.HasValue || giftCard.ExpiryDate.Value >= DateTime.UtcNow);
            if (giftCardUsable)
                giftCardApplied = Math.Min(giftCard!.Balance, totalBeforeGiftCard);
        }

        var order = new Order
        {
            OrderNumber = $"VM{DateTime.UtcNow:yyyyMMdd}{Random.Shared.Next(1000, 9999)}",
            UserId = userId,
            Status = OrderStatus.Confirmed,
            SubTotal = cart.SubTotal,
            Discount = discount + giftCardApplied,
            ShippingFee = shippingFee,
            Total = totalBeforeGiftCard - giftCardApplied,
            CouponCode = request.CouponCode,
            ShippingAddressId = request.ShippingAddressId
        };

        if (giftCard != null && giftCardApplied > 0)
        {
            giftCard.Balance -= giftCardApplied;
            giftCard.RedeemedByUserId = userId;
            if (giftCard.Balance <= 0) giftCard.Status = "redeemed";
        }

        foreach (var item in cart.Items)
        {
            var product = await db.Products.Include(p => p.Images).FirstOrDefaultAsync(p => p.Id == item.ProductId)
                ?? throw new KeyNotFoundException("Product not found");
            var unitPrice = product.SalePrice ?? product.Price;

            order.Items.Add(new OrderItem
            {
                ProductId = item.ProductId,
                Quantity = item.Quantity,
                UnitPrice = unitPrice,
                TotalPrice = unitPrice * item.Quantity
            });

            product.StockQuantity -= item.Quantity;
        }

        order.TrackingHistory.Add(new OrderTracking
        {
            Status = OrderStatus.Confirmed,
            Notes = "Order confirmed and payment received"
        });

        order.Payment = new Payment
        {
            Amount = order.Total,
            Status = PaymentStatus.Success,
            PaymentMethod = request.PaymentMethod,
            TransactionId = $"TXN{Guid.NewGuid():N}"[..16].ToUpperInvariant()
        };

        db.Orders.Add(order);
        db.Notifications.Add(new Notification
        {
            UserId = userId,
            Title = "Order Placed",
            Message = $"Your order {order.OrderNumber} has been confirmed.",
            Type = "order",
            Link = $"/customer/orders/{order.Id}"
        });
        await ClearCartAsync(userId);
        await db.SaveChangesAsync();

        return MapOrder(order);
    }

    public async Task<IEnumerable<OrderDto>> GetOrdersAsync(Guid userId) =>
        (await db.Orders.AsNoTracking().Include(o => o.Items).ThenInclude(i => i.Product).ThenInclude(p => p.Images)
            .Where(o => o.UserId == userId).OrderByDescending(o => o.CreatedAt).ToListAsync())
            .Select(MapOrder);

    public async Task<OrderDto?> GetOrderByIdAsync(Guid userId, Guid orderId)
    {
        var order = await db.Orders.AsNoTracking().Include(o => o.Items).ThenInclude(i => i.Product).ThenInclude(p => p.Images)
            .FirstOrDefaultAsync(o => o.Id == orderId && o.UserId == userId);
        return order == null ? null : MapOrder(order);
    }

    public async Task<IEnumerable<OrderTrackingDto>> GetOrderTrackingAsync(Guid userId, Guid orderId) =>
        await db.OrderTracking.AsNoTracking()
            .Where(t => t.Order.UserId == userId && t.OrderId == orderId)
            .OrderBy(t => t.CreatedAt)
            .Select(t => new OrderTrackingDto(t.Status, t.Notes, t.Location, t.CreatedAt))
            .ToListAsync();

    public async Task<PoojaBookingDto> CreatePoojaBookingAsync(Guid userId, PoojaBookingRequest request)
    {
        var service = await db.PoojaServices.FindAsync(request.PoojaServiceId)
            ?? throw new KeyNotFoundException("Pooja service not found");

        var booking = new PoojaBooking
        {
            UserId = userId,
            PoojaServiceId = request.PoojaServiceId,
            ScheduledDate = request.ScheduledDate,
            ScheduledTime = request.ScheduledTime,
            SpecialInstructions = request.SpecialInstructions,
            Amount = service.SalePrice ?? service.Price,
            Status = BookingStatus.Pending
        };

        db.PoojaBookings.Add(booking);
        db.Notifications.Add(new Notification
        {
            UserId = userId,
            Title = "Pooja Booking Received",
            Message = $"Your booking for {service.Name} on {booking.ScheduledDate:d MMM yyyy} has been received.",
            Type = "booking",
            Link = "/customer"
        });
        await db.SaveChangesAsync();

        return new PoojaBookingDto(booking.Id, service.Name, booking.ScheduledDate,
            booking.ScheduledTime, booking.Status, booking.Amount, booking.CreatedAt);
    }

    public async Task<IEnumerable<PoojaBookingDto>> GetPoojaBookingsAsync(Guid userId) =>
        await db.PoojaBookings.AsNoTracking().Include(b => b.PoojaService)
            .Where(b => b.UserId == userId).OrderByDescending(b => b.CreatedAt)
            .Select(b => new PoojaBookingDto(b.Id, b.PoojaService.Name, b.ScheduledDate,
                b.ScheduledTime, b.Status, b.Amount, b.CreatedAt)).ToListAsync();

    public async Task<KundliResponseDto> CreateKundliRequestAsync(Guid userId, KundliRequestDto request)
    {
        var kundli = new KundliRequest
        {
            UserId = userId,
            Name = request.Name,
            DateOfBirth = request.DateOfBirth,
            TimeOfBirth = request.TimeOfBirth,
            PlaceOfBirth = request.PlaceOfBirth,
            Gender = request.Gender,
            Amount = request.Amount ?? 499,
            Status = KundliStatus.Pending
        };

        db.KundliRequests.Add(kundli);
        await db.SaveChangesAsync();

        return new KundliResponseDto(kundli.Id, kundli.Name, kundli.Status, kundli.Amount, kundli.CreatedAt, null);
    }

    public async Task<IEnumerable<KundliResponseDto>> GetKundliRequestsAsync(Guid userId) =>
        await db.KundliRequests.AsNoTracking().Where(k => k.UserId == userId)
            .OrderByDescending(k => k.CreatedAt)
            .Select(k => new KundliResponseDto(k.Id, k.Name, k.Status, k.Amount, k.CreatedAt, k.ReportUrl))
            .ToListAsync();

    public async Task<UserSubscriptionDto> SubscribeAsync(Guid userId, SubscribeRequest request)
    {
        var plan = await db.SubscriptionPlans.FindAsync(request.SubscriptionPlanId)
            ?? throw new KeyNotFoundException("Subscription plan not found");

        var subscription = new UserSubscription
        {
            UserId = userId,
            SubscriptionPlanId = plan.Id,
            StartDate = DateTime.UtcNow,
            EndDate = DateTime.UtcNow.AddMonths(1),
            Status = "active"
        };

        db.UserSubscriptions.Add(subscription);
        await db.SaveChangesAsync();

        return new UserSubscriptionDto(subscription.Id, plan.Name, plan.Price,
            subscription.StartDate, subscription.EndDate, subscription.Status);
    }

    public async Task<IEnumerable<UserSubscriptionDto>> GetSubscriptionsAsync(Guid userId) =>
        await db.UserSubscriptions.AsNoTracking().Include(s => s.Plan)
            .Where(s => s.UserId == userId)
            .OrderByDescending(s => s.CreatedAt)
            .Select(s => new UserSubscriptionDto(s.Id, s.Plan.Name, s.Plan.Price, s.StartDate, s.EndDate, s.Status))
            .ToListAsync();

    public async Task<GiftCardPurchaseDto> PurchaseGiftCardAsync(Guid userId, PurchaseGiftCardRequest request)
    {
        var code = $"VMGC{Guid.NewGuid():N}"[..12].ToUpperInvariant();
        var giftCard = new GiftCard
        {
            Code = code,
            Type = request.Type,
            Amount = request.Amount,
            Balance = request.Amount,
            PurchasedByUserId = userId,
            Status = "active",
            ExpiryDate = DateTime.UtcNow.AddYears(1)
        };

        db.GiftCards.Add(giftCard);
        db.Notifications.Add(new Notification
        {
            UserId = userId,
            Title = "Gift Card Purchased",
            Message = $"Your {request.Type} worth ₹{request.Amount:N0} is ready. Code: {code}",
            Type = "giftcard",
            Link = "/gift-cards"
        });
        await db.SaveChangesAsync();

        return new GiftCardPurchaseDto(giftCard.Id, giftCard.Code, giftCard.Amount, giftCard.Balance, giftCard.Status);
    }

    public async Task<IEnumerable<AddressDto>> GetAddressesAsync(Guid userId) =>
        await db.Addresses.AsNoTracking().Where(a => a.UserId == userId && a.IsActive)
            .Select(a => new AddressDto(a.Id, a.FullName, a.Phone, a.AddressLine1, a.AddressLine2,
                a.City, a.State, a.Pincode, a.Country, a.IsDefault)).ToListAsync();

    public async Task<AddressDto> CreateAddressAsync(Guid userId, CreateAddressRequest request)
    {
        if (request.IsDefault)
        {
            var existing = await db.Addresses.Where(a => a.UserId == userId && a.IsDefault).ToListAsync();
            existing.ForEach(a => a.IsDefault = false);
        }

        var address = new Address
        {
            UserId = userId,
            FullName = request.FullName,
            Phone = request.Phone,
            AddressLine1 = request.AddressLine1,
            AddressLine2 = request.AddressLine2,
            City = request.City,
            State = request.State,
            Pincode = request.Pincode,
            Country = request.Country,
            IsDefault = request.IsDefault
        };

        db.Addresses.Add(address);
        await db.SaveChangesAsync();

        return new AddressDto(address.Id, address.FullName, address.Phone, address.AddressLine1,
            address.AddressLine2, address.City, address.State, address.Pincode, address.Country, address.IsDefault);
    }

    public async Task<IEnumerable<WishlistItemDto>> GetWishlistAsync(Guid userId) =>
        await db.WishlistItems.AsNoTracking()
            .Include(w => w.Product).ThenInclude(p => p.Images)
            .Where(w => w.UserId == userId)
            .OrderByDescending(w => w.CreatedAt)
            .Select(w => new WishlistItemDto(w.ProductId, w.Product.Name, w.Product.Price, w.Product.SalePrice,
                w.Product.Images.OrderBy(i => i.SortOrder).Select(i => i.ImageUrl).FirstOrDefault(),
                w.Product.Rating, w.Product.StockQuantity))
            .ToListAsync();

    public async Task AddToWishlistAsync(Guid userId, AddToWishlistRequest request)
    {
        var exists = await db.WishlistItems.AnyAsync(w => w.UserId == userId && w.ProductId == request.ProductId);
        if (!exists)
        {
            db.WishlistItems.Add(new WishlistItem { UserId = userId, ProductId = request.ProductId });
            await db.SaveChangesAsync();
        }
    }

    public async Task RemoveFromWishlistAsync(Guid userId, Guid productId)
    {
        var item = await db.WishlistItems.FirstOrDefaultAsync(w => w.UserId == userId && w.ProductId == productId);
        if (item != null)
        {
            db.WishlistItems.Remove(item);
            await db.SaveChangesAsync();
        }
    }

    public async Task<IEnumerable<NotificationDto>> GetNotificationsAsync(Guid userId) =>
        await db.Notifications.AsNoTracking()
            .Where(n => n.UserId == userId)
            .OrderByDescending(n => n.CreatedAt).Take(20)
            .Select(n => new NotificationDto(n.Id, n.Title, n.Message, n.Type, n.IsRead, n.Link, n.CreatedAt))
            .ToListAsync();

    public async Task MarkNotificationReadAsync(Guid userId, Guid id)
    {
        var notification = await db.Notifications.FirstOrDefaultAsync(n => n.Id == id && n.UserId == userId);
        if (notification != null)
        {
            notification.IsRead = true;
            await db.SaveChangesAsync();
        }
    }

    public async Task MarkAllNotificationsReadAsync(Guid userId)
    {
        var items = await db.Notifications.Where(n => n.UserId == userId && !n.IsRead).ToListAsync();
        items.ForEach(n => n.IsRead = true);
        await db.SaveChangesAsync();
    }

    private static OrderDto MapOrder(Order order) =>
        new(order.Id, order.OrderNumber, order.Status, order.Total, order.CreatedAt,
            order.Items.Select(i => new OrderItemDto(i.ProductId, i.Product?.Name ?? "Product",
                i.Quantity, i.UnitPrice, i.TotalPrice,
                i.Product?.Images.OrderBy(img => img.SortOrder).Select(img => img.ImageUrl).FirstOrDefault())).ToList());
}

public class AdminService(VadicMallDbContext db) : IAdminService
{
    public async Task<DashboardStatsDto> GetDashboardStatsAsync()
    {
        var revenue = await db.Payments.Where(p => p.Status == PaymentStatus.Success).SumAsync(p => (decimal?)p.Amount) ?? 0;
        return new DashboardStatsDto(
            await db.Users.CountAsync(u => u.Role == UserRole.Customer),
            await db.AstrologerProfiles.CountAsync(a => a.IsApproved),
            await db.Orders.CountAsync(),
            await db.PoojaBookings.CountAsync(),
            revenue,
            await db.Orders.CountAsync(o => o.Status == OrderStatus.Pending),
            await db.PoojaBookings.CountAsync(b => b.Status == BookingStatus.Pending),
            await db.Products.CountAsync(p => p.StockQuantity < 10));
    }

    public async Task<IEnumerable<RevenueChartDto>> GetRevenueChartAsync(int months = 6)
    {
        var result = new List<RevenueChartDto>();
        for (var i = months - 1; i >= 0; i--)
        {
            var date = DateTime.UtcNow.AddMonths(-i);
            var start = new DateTime(date.Year, date.Month, 1, 0, 0, 0, DateTimeKind.Utc);
            var end = start.AddMonths(1);
            var revenue = await db.Payments
                .Where(p => p.Status == PaymentStatus.Success && p.CreatedAt >= start && p.CreatedAt < end)
                .SumAsync(p => (decimal?)p.Amount) ?? 0;
            result.Add(new RevenueChartDto(start.ToString("MMM yyyy"), revenue));
        }
        return result;
    }

    public async Task<IEnumerable<RecentOrderDto>> GetRecentOrdersAsync(int count = 10) =>
        await db.Orders.AsNoTracking().Include(o => o.User)
            .OrderByDescending(o => o.CreatedAt).Take(count)
            .Select(o => new RecentOrderDto(o.Id, o.OrderNumber,
                $"{o.User.FirstName} {o.User.LastName}", o.Total, o.Status.ToString(), o.CreatedAt))
            .ToListAsync();

    public async Task<IEnumerable<AdminUserDto>> GetUsersAsync()
    {
        var users = await db.Users.AsNoTracking().Include(u => u.UserPermissions)
            .OrderByDescending(u => u.CreatedAt).ToListAsync();
        var approvals = await db.AstrologerProfiles.AsNoTracking().ToDictionaryAsync(a => a.UserId, a => a.IsApproved);

        return users.Select(u => new AdminUserDto(u.Id, u.Email, u.FirstName, u.LastName,
            u.Role.ToString(), u.IsActive, u.CreatedAt,
            approvals.TryGetValue(u.Id, out var approved) ? approved : null,
            u.IsStaffApproved, u.UserPermissions.Select(p => p.Permission.ToString()).ToList()));
    }

    public async Task<IEnumerable<AdminProductDto>> GetProductsAsync() =>
        await db.Products.AsNoTracking().Include(p => p.Category).Include(p => p.Images)
            .Select(p => new AdminProductDto(p.Id, p.Name, p.Category.Name, p.Price,
                p.SalePrice, p.StockQuantity, p.IsFeatured, p.IsActive,
                p.Images.OrderBy(i => i.SortOrder).Select(i => i.ImageUrl).FirstOrDefault())).ToListAsync();

    public async Task<IEnumerable<AdminPoojaDto>> GetPoojaServicesAsync() =>
        await db.PoojaServices.AsNoTracking()
            .Select(p => new AdminPoojaDto(p.Id, p.Name, p.Category, p.Price, p.IsFeatured, p.IsActive, p.ImageUrl)).ToListAsync();

    public async Task<IEnumerable<AdminBookingDto>> GetBookingsAsync() =>
        await db.PoojaBookings.AsNoTracking()
            .Include(b => b.User).Include(b => b.PoojaService)
            .OrderByDescending(b => b.CreatedAt)
            .Select(b => new AdminBookingDto(b.Id, b.PoojaService.Name,
                $"{b.User.FirstName} {b.User.LastName}", b.ScheduledDate, b.ScheduledTime,
                b.Status.ToString(), b.Amount, b.PoojaService.ImageUrl))
            .ToListAsync();

    public async Task<IEnumerable<AdminOrderDto>> GetOrdersAsync() =>
        await db.Orders.AsNoTracking().Include(o => o.User)
            .OrderByDescending(o => o.CreatedAt)
            .Select(o => new AdminOrderDto(o.Id, o.OrderNumber,
                $"{o.User.FirstName} {o.User.LastName}", o.Total, o.Status.ToString(), o.CreatedAt))
            .ToListAsync();

    public async Task<IEnumerable<AdminCategoryDto>> GetCategoriesAsync() =>
        await db.ProductCategories.AsNoTracking().OrderBy(c => c.Name)
            .Select(c => new AdminCategoryDto(c.Id, c.Name, c.Slug)).ToListAsync();

    public async Task<AdminProductDto> CreateProductAsync(CreateProductRequest request)
    {
        var category = await db.ProductCategories.FindAsync(request.CategoryId)
            ?? throw new KeyNotFoundException("Category not found");

        var baseSlug = Slugify(request.Name);
        var slug = baseSlug;
        var suffix = 1;
        while (await db.Products.AnyAsync(p => p.Slug == slug))
            slug = $"{baseSlug}-{++suffix}";

        var product = new Product
        {
            Name = request.Name,
            Slug = slug,
            Description = request.Description,
            CategoryId = request.CategoryId,
            Price = request.Price,
            SalePrice = request.SalePrice,
            StockQuantity = request.StockQuantity,
            IsFeatured = request.IsFeatured,
            FestivalTag = request.FestivalTag,
            Sku = $"VM-{slug.ToUpperInvariant()}"
        };

        for (var i = 0; i < request.ImageUrls.Count; i++)
            product.Images.Add(new ProductImage { ImageUrl = request.ImageUrls[i], IsPrimary = i == 0, SortOrder = i });

        db.Products.Add(product);
        await db.SaveChangesAsync();

        return new AdminProductDto(product.Id, product.Name, category.Name, product.Price,
            product.SalePrice, product.StockQuantity, product.IsFeatured, product.IsActive, request.ImageUrls.FirstOrDefault());
    }

    private static string Slugify(string name)
    {
        var slug = System.Text.RegularExpressions.Regex.Replace(name.ToLowerInvariant(), @"[^a-z0-9]+", "-").Trim('-');
        return string.IsNullOrEmpty(slug) ? Guid.NewGuid().ToString("N")[..8] : slug;
    }

    public async Task<AdminProductDetailDto?> GetProductByIdAsync(Guid id)
    {
        var p = await db.Products.AsNoTracking().Include(x => x.Images)
            .FirstOrDefaultAsync(x => x.Id == id);
        if (p == null) return null;

        return new AdminProductDetailDto(p.Id, p.Name, p.Description, p.CategoryId, p.Price, p.SalePrice,
            p.StockQuantity, p.IsFeatured, p.IsActive, p.FestivalTag,
            p.Images.OrderBy(i => i.SortOrder).Select(i => i.ImageUrl).ToList());
    }

    public async Task<AdminProductDto> UpdateProductAsync(Guid id, UpdateProductRequest request)
    {
        var product = await db.Products.Include(p => p.Images).Include(p => p.Category)
            .FirstOrDefaultAsync(p => p.Id == id)
            ?? throw new KeyNotFoundException("Product not found");

        var category = await db.ProductCategories.FindAsync(request.CategoryId)
            ?? throw new KeyNotFoundException("Category not found");

        product.Name = request.Name;
        product.Description = request.Description;
        product.CategoryId = request.CategoryId;
        product.Price = request.Price;
        product.SalePrice = request.SalePrice;
        product.StockQuantity = request.StockQuantity;
        product.IsFeatured = request.IsFeatured;
        product.IsActive = request.IsActive;
        product.FestivalTag = request.FestivalTag;
        product.UpdatedAt = DateTime.UtcNow;

        db.ProductImages.RemoveRange(product.Images);
        for (var i = 0; i < request.ImageUrls.Count; i++)
            db.ProductImages.Add(new ProductImage { ProductId = product.Id, ImageUrl = request.ImageUrls[i], IsPrimary = i == 0, SortOrder = i });

        await db.SaveChangesAsync();

        return new AdminProductDto(product.Id, product.Name, category.Name, product.Price,
            product.SalePrice, product.StockQuantity, product.IsFeatured, product.IsActive,
            request.ImageUrls.FirstOrDefault());
    }

    public async Task<AdminProductDto> UpdateProductStockAsync(Guid id, UpdateStockRequest request)
    {
        var product = await db.Products.Include(p => p.Category).Include(p => p.Images).FirstOrDefaultAsync(p => p.Id == id)
            ?? throw new KeyNotFoundException("Product not found");

        product.StockQuantity = request.InStock
            ? (product.StockQuantity > 0 ? product.StockQuantity : 10)
            : 0;
        product.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();

        return new AdminProductDto(product.Id, product.Name, product.Category.Name, product.Price,
            product.SalePrice, product.StockQuantity, product.IsFeatured, product.IsActive,
            product.Images.OrderBy(i => i.SortOrder).Select(i => i.ImageUrl).FirstOrDefault());
    }

    public async Task<AdminUserDto> UpdateUserStatusAsync(Guid id, UpdateUserStatusRequest request)
    {
        var user = await db.Users.FirstOrDefaultAsync(u => u.Id == id)
            ?? throw new KeyNotFoundException("User not found");

        user.IsActive = request.IsActive;
        user.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();

        var approved = await db.AstrologerProfiles.Where(a => a.UserId == id).Select(a => (bool?)a.IsApproved).FirstOrDefaultAsync();
        var permissions = await db.UserPermissions.Where(p => p.UserId == id).Select(p => p.Permission.ToString()).ToListAsync();
        return new AdminUserDto(user.Id, user.Email, user.FirstName, user.LastName,
            user.Role.ToString(), user.IsActive, user.CreatedAt, approved, user.IsStaffApproved, permissions);
    }

    public async Task<AdminUserDto> UpdateAstrologerApprovalAsync(Guid userId, UpdateAstrologerApprovalRequest request)
    {
        var profile = await db.AstrologerProfiles.Include(a => a.User).FirstOrDefaultAsync(a => a.UserId == userId)
            ?? throw new KeyNotFoundException("Astrologer profile not found");

        profile.IsApproved = request.Approved;
        profile.UpdatedAt = DateTime.UtcNow;

        db.Notifications.Add(new Notification
        {
            UserId = userId,
            Title = request.Approved ? "Astrologer Application Approved" : "Astrologer Application Declined",
            Message = request.Approved
                ? "Congratulations! Your astrologer profile has been verified and is now visible to customers."
                : "Your astrologer application was declined after review. Contact support for details.",
            Type = "astrologer_approval",
            Link = "/astrologers"
        });

        await db.SaveChangesAsync();

        var user = profile.User;
        var permissions = await db.UserPermissions.Where(p => p.UserId == userId).Select(p => p.Permission.ToString()).ToListAsync();
        return new AdminUserDto(user.Id, user.Email, user.FirstName, user.LastName,
            user.Role.ToString(), user.IsActive, user.CreatedAt, profile.IsApproved, user.IsStaffApproved, permissions);
    }

    public async Task<AdminUserDto> UpdateStaffApprovalAsync(Guid userId, UpdateStaffApprovalRequest request)
    {
        var user = await db.Users.FirstOrDefaultAsync(u => u.Id == userId)
            ?? throw new KeyNotFoundException("User not found");

        user.IsStaffApproved = request.IsApproved;
        user.UpdatedAt = DateTime.UtcNow;

        if (!request.IsApproved)
            db.UserPermissions.RemoveRange(db.UserPermissions.Where(p => p.UserId == userId));

        db.Notifications.Add(new Notification
        {
            UserId = userId,
            Title = request.IsApproved ? "Staff Access Approved" : "Staff Access Revoked",
            Message = request.IsApproved
                ? "You have been approved for staff access. An administrator will assign your permissions shortly."
                : "Your staff access and all assigned permissions have been revoked.",
            Type = "staff_approval",
            Link = "/"
        });

        await db.SaveChangesAsync();

        var astrologerApproved = await db.AstrologerProfiles.Where(a => a.UserId == userId).Select(a => (bool?)a.IsApproved).FirstOrDefaultAsync();
        return new AdminUserDto(user.Id, user.Email, user.FirstName, user.LastName,
            user.Role.ToString(), user.IsActive, user.CreatedAt, astrologerApproved, user.IsStaffApproved, []);
    }

    public async Task<AdminUserDto> UpdateUserPermissionsAsync(Guid userId, UpdateUserPermissionsRequest request)
    {
        var user = await db.Users.Include(u => u.UserPermissions).FirstOrDefaultAsync(u => u.Id == userId)
            ?? throw new KeyNotFoundException("User not found");

        if (!user.IsStaffApproved)
            throw new InvalidOperationException("Approve this user for staff access before assigning permissions.");

        var requested = request.Permissions.Select(p =>
            Enum.TryParse<StaffPermission>(p, out var parsed) ? parsed : (StaffPermission?)null)
            .Where(p => p.HasValue).Select(p => p!.Value).Distinct().ToList();

        db.UserPermissions.RemoveRange(user.UserPermissions);
        foreach (var permission in requested)
            db.UserPermissions.Add(new UserPermission { UserId = userId, Permission = permission });

        user.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();

        var astrologerApproved = await db.AstrologerProfiles.Where(a => a.UserId == userId).Select(a => (bool?)a.IsApproved).FirstOrDefaultAsync();
        return new AdminUserDto(user.Id, user.Email, user.FirstName, user.LastName,
            user.Role.ToString(), user.IsActive, user.CreatedAt, astrologerApproved, user.IsStaffApproved,
            requested.Select(p => p.ToString()).ToList());
    }

    public async Task<IEnumerable<AdminCouponDto>> GetCouponsAsync() =>
        await db.Coupons.AsNoTracking().OrderByDescending(c => c.CreatedAt)
            .Select(c => new AdminCouponDto(c.Id, c.Code, c.Description, c.Type.ToString(), c.Value,
                c.MinOrderValue, c.MaxDiscount, c.UsageLimit, c.UsedCount, c.ValidFrom, c.ValidTo, c.FestivalTag, c.IsActive))
            .ToListAsync();

    public async Task<AdminCouponDto> CreateCouponAsync(CreateCouponRequest request)
    {
        if (await db.Coupons.AnyAsync(c => c.Code == request.Code.ToUpperInvariant()))
            throw new InvalidOperationException($"Coupon code \"{request.Code}\" already exists.");

        if (!Enum.TryParse<CouponType>(request.Type, out var type))
            throw new InvalidOperationException("Invalid coupon type.");

        var coupon = new Coupon
        {
            Code = request.Code.ToUpperInvariant(),
            Description = request.Description,
            Type = type,
            Value = request.Value,
            MinOrderValue = request.MinOrderValue,
            MaxDiscount = request.MaxDiscount,
            UsageLimit = request.UsageLimit,
            ValidFrom = request.ValidFrom,
            ValidTo = request.ValidTo,
            FestivalTag = request.FestivalTag
        };

        db.Coupons.Add(coupon);
        await db.SaveChangesAsync();

        return new AdminCouponDto(coupon.Id, coupon.Code, coupon.Description, coupon.Type.ToString(), coupon.Value,
            coupon.MinOrderValue, coupon.MaxDiscount, coupon.UsageLimit, coupon.UsedCount, coupon.ValidFrom, coupon.ValidTo, coupon.FestivalTag, coupon.IsActive);
    }

    public async Task<AdminCouponDto> UpdateCouponAsync(Guid id, UpdateCouponRequest request)
    {
        var coupon = await db.Coupons.FirstOrDefaultAsync(c => c.Id == id)
            ?? throw new KeyNotFoundException("Coupon not found");

        if (!Enum.TryParse<CouponType>(request.Type, out var type))
            throw new InvalidOperationException("Invalid coupon type.");

        coupon.Description = request.Description;
        coupon.Type = type;
        coupon.Value = request.Value;
        coupon.MinOrderValue = request.MinOrderValue;
        coupon.MaxDiscount = request.MaxDiscount;
        coupon.UsageLimit = request.UsageLimit;
        coupon.ValidFrom = request.ValidFrom;
        coupon.ValidTo = request.ValidTo;
        coupon.FestivalTag = request.FestivalTag;
        coupon.IsActive = request.IsActive;
        coupon.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();

        return new AdminCouponDto(coupon.Id, coupon.Code, coupon.Description, coupon.Type.ToString(), coupon.Value,
            coupon.MinOrderValue, coupon.MaxDiscount, coupon.UsageLimit, coupon.UsedCount, coupon.ValidFrom, coupon.ValidTo, coupon.FestivalTag, coupon.IsActive);
    }

    public async Task DeleteCouponAsync(Guid id)
    {
        var coupon = await db.Coupons.FirstOrDefaultAsync(c => c.Id == id)
            ?? throw new KeyNotFoundException("Coupon not found");

        if (await db.CouponUsages.AnyAsync(u => u.CouponId == id))
            throw new InvalidOperationException($"Coupon \"{coupon.Code}\" has usage history and cannot be deleted. Deactivate it instead.");

        db.Coupons.Remove(coupon);
        await db.SaveChangesAsync();
    }

    public async Task<AdminPoojaDetailDto?> GetPoojaServiceByIdAsync(Guid id)
    {
        var p = await db.PoojaServices.AsNoTracking().FirstOrDefaultAsync(x => x.Id == id);
        return p == null ? null : new AdminPoojaDetailDto(p.Id, p.Name, p.Category, p.Description,
            p.Price, p.SalePrice, p.DurationMinutes, p.IsFeatured, p.IsActive, p.ImageUrl);
    }

    public async Task<AdminPoojaDto> UpdatePoojaServiceAsync(Guid id, UpdatePoojaRequest request)
    {
        var service = await db.PoojaServices.FirstOrDefaultAsync(p => p.Id == id)
            ?? throw new KeyNotFoundException("Pooja service not found");

        service.Name = request.Name;
        service.Category = request.Category;
        service.Description = request.Description;
        service.Price = request.Price;
        service.SalePrice = request.SalePrice;
        service.DurationMinutes = request.DurationMinutes;
        service.IsFeatured = request.IsFeatured;
        service.IsActive = request.IsActive;
        if (!string.IsNullOrWhiteSpace(request.ImageUrl)) service.ImageUrl = request.ImageUrl;
        service.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();

        return new AdminPoojaDto(service.Id, service.Name, service.Category, service.Price, service.IsFeatured, service.IsActive, service.ImageUrl);
    }

    public async Task<AdminOrderDetailDto?> GetOrderByIdAsync(Guid id)
    {
        var order = await db.Orders.AsNoTracking()
            .Include(o => o.User)
            .Include(o => o.Items).ThenInclude(i => i.Product).ThenInclude(p => p.Images)
            .Include(o => o.TrackingHistory)
            .FirstOrDefaultAsync(o => o.Id == id);
        if (order == null) return null;

        return new AdminOrderDetailDto(order.Id, order.OrderNumber,
            $"{order.User.FirstName} {order.User.LastName}", order.User.Email,
            order.SubTotal, order.Discount, order.ShippingFee, order.Total, order.Status.ToString(), order.CreatedAt,
            order.Items.Select(i => new OrderItemDto(i.ProductId, i.Product?.Name ?? "Product", i.Quantity, i.UnitPrice, i.TotalPrice,
                i.Product?.Images.OrderBy(img => img.SortOrder).Select(img => img.ImageUrl).FirstOrDefault())).ToList(),
            order.TrackingHistory.OrderBy(t => t.CreatedAt)
                .Select(t => new OrderTrackingDto(t.Status, t.Notes, t.Location, t.CreatedAt)).ToList());
    }

    public async Task<AdminOrderDto> UpdateOrderStatusAsync(Guid id, UpdateOrderStatusRequest request)
    {
        var order = await db.Orders.Include(o => o.User).FirstOrDefaultAsync(o => o.Id == id)
            ?? throw new KeyNotFoundException("Order not found");

        if (!Enum.TryParse<OrderStatus>(request.Status, true, out var status))
            throw new ArgumentException("Invalid order status");

        order.Status = status;
        order.UpdatedAt = DateTime.UtcNow;

        db.OrderTracking.Add(new OrderTracking
        {
            OrderId = order.Id,
            Status = status,
            Notes = request.Notes,
            Location = request.Location
        });

        db.Notifications.Add(new Notification
        {
            UserId = order.UserId,
            Title = "Order Status Updated",
            Message = $"Your order {order.OrderNumber} is now {status}.",
            Type = "order",
            Link = $"/customer/orders/{order.Id}"
        });

        await db.SaveChangesAsync();

        return new AdminOrderDto(order.Id, order.OrderNumber,
            $"{order.User.FirstName} {order.User.LastName}", order.Total, order.Status.ToString(), order.CreatedAt);
    }

    public async Task DeleteProductAsync(Guid id)
    {
        var product = await db.Products.FindAsync(id) ?? throw new KeyNotFoundException("Product not found");

        if (await db.OrderItems.AnyAsync(oi => oi.ProductId == id))
            throw new InvalidOperationException($"\"{product.Name}\" has order history and cannot be deleted. Deactivate it instead.");

        await RemoveProductDependenciesAsync(id);
        db.Products.Remove(product);
        await db.SaveChangesAsync();
    }

    public async Task<BulkDeleteResultDto> DeleteProductsAsync(List<Guid> ids)
    {
        var skipped = new List<string>();
        var deletedCount = 0;

        foreach (var id in ids)
        {
            var product = await db.Products.FindAsync(id);
            if (product == null) continue;

            if (await db.OrderItems.AnyAsync(oi => oi.ProductId == id))
            {
                skipped.Add(product.Name);
                continue;
            }

            await RemoveProductDependenciesAsync(id);
            db.Products.Remove(product);
            deletedCount++;
        }

        await db.SaveChangesAsync();
        return new BulkDeleteResultDto(deletedCount, skipped);
    }

    private async Task RemoveProductDependenciesAsync(Guid productId)
    {
        db.ProductImages.RemoveRange(await db.ProductImages.Where(i => i.ProductId == productId).ToListAsync());
        db.CartItems.RemoveRange(await db.CartItems.Where(c => c.ProductId == productId).ToListAsync());
        db.WishlistItems.RemoveRange(await db.WishlistItems.Where(w => w.ProductId == productId).ToListAsync());
        db.Reviews.RemoveRange(await db.Reviews.Where(r => r.ProductId == productId).ToListAsync());
    }

    public async Task<SettingDto> UpdateSettingImageAsync(string key, string imageUrl)
    {
        var setting = await db.Settings.FirstOrDefaultAsync(s => s.Key == key);
        if (setting == null)
        {
            setting = new Setting { Key = key, Value = imageUrl };
            db.Settings.Add(setting);
        }
        else
        {
            setting.Value = imageUrl;
            setting.UpdatedAt = DateTime.UtcNow;
        }

        await db.SaveChangesAsync();
        return new SettingDto(setting.Key, setting.Value);
    }

    public async Task<IEnumerable<LoadingSkeletonDto>> GetLoadingSkeletonsAsync() =>
        await db.LoadingSkeletons.AsNoTracking().OrderBy(s => s.SortOrder)
            .Select(s => new LoadingSkeletonDto(s.Id, s.Name, s.DisplayName, s.CssClass, s.DurationMs, s.DelayMs, s.Easing, s.ConfigJson, s.IsActive, s.SortOrder))
            .ToListAsync();

    public async Task<LoadingSkeletonDto> SetActiveLoadingSkeletonAsync(int id)
    {
        var target = await db.LoadingSkeletons.FirstOrDefaultAsync(s => s.Id == id)
            ?? throw new KeyNotFoundException("Loading skeleton preset not found");

        var currentlyActive = await db.LoadingSkeletons.Where(s => s.IsActive).ToListAsync();
        foreach (var preset in currentlyActive) preset.IsActive = false;
        target.IsActive = true;
        target.UpdatedAt = DateTime.UtcNow;

        await db.SaveChangesAsync();
        return new LoadingSkeletonDto(target.Id, target.Name, target.DisplayName, target.CssClass,
            target.DurationMs, target.DelayMs, target.Easing, target.ConfigJson, target.IsActive, target.SortOrder);
    }
}
