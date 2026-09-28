using System.Text.Json;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.DependencyInjection;
using VadicMall.Domain.Entities;
using VadicMall.Domain.Enums;

namespace VadicMall.Infrastructure.Data;

public static class SeedData
{
    public static async Task InitializeAsync(IServiceProvider services)
    {
        using var scope = services.CreateScope();
        var db = scope.ServiceProvider.GetRequiredService<VadicMallDbContext>();
        await db.Database.EnsureCreatedAsync();

        if (await db.Users.AnyAsync()) return;

        // Admin user
        var admin = new User
        {
            Email = "admin@vadicmall.com",
            PasswordHash = BCrypt.Net.BCrypt.HashPassword("Admin@123", 11),
            FirstName = "Super",
            LastName = "Admin",
            Role = UserRole.SuperAdmin,
            EmailVerified = true
        };
        db.Users.Add(admin);

        // Demo customer
        var customer = new User
        {
            Email = "customer@vadicmall.com",
            PasswordHash = BCrypt.Net.BCrypt.HashPassword("Customer@123", 11),
            FirstName = "Demo",
            LastName = "Customer",
            Phone = "+91 9876543210",
            Role = UserRole.Customer,
            EmailVerified = true
        };
        db.Users.Add(customer);

        // Astrologers
        var astrologers = new[]
        {
            ("Pandit", "Sharma", "Vedic Astrology", "25 years of experience in Vedic astrology and pooja rituals.", 25, 999m, 4.9m, 342),
            ("Dr.", "Venkatesh", "Marriage Astrology", "Expert in marriage compatibility and relationship counseling.", 18, 799m, 4.8m, 256),
            ("Acharya", "Mishra", "Career Astrology", "Specializes in career guidance through planetary analysis.", 15, 699m, 4.7m, 189),
            ("Guru", "Anand", "Nadi Astrology", "Renowned Nadi astrologer with ancient palm leaf readings.", 30, 1499m, 4.9m, 412),
            ("Pandit", "Rao", "Medical Astrology", "Combines Ayurveda with astrological health remedies.", 20, 899m, 4.6m, 167)
        };

        foreach (var (first, last, spec, bio, exp, fee, rating, reviews) in astrologers)
        {
            var user = new User
            {
                Email = $"{first.ToLower()}.{last.ToLower()}@vadicmall.com",
                PasswordHash = BCrypt.Net.BCrypt.HashPassword("Astro@123", 11),
                FirstName = first,
                LastName = last,
                Role = UserRole.Astrologer,
                EmailVerified = true
            };
            user.AstrologerProfile = new AstrologerProfile
            {
                UserId = user.Id,
                Specialization = spec,
                Bio = bio,
                ExperienceYears = exp,
                ConsultationFee = fee,
                Rating = rating,
                ReviewCount = reviews,
                IsApproved = true,
                IsFeatured = rating >= 4.8m,
                Languages = "Hindi, English, Sanskrit"
            };
            db.Users.Add(user);
        }

        // Pooja Services
        var poojas = new[]
        {
            ("Ganesh Puja", "ganesh-puja", "Ganesh Puja", "Remove obstacles and invite prosperity with authentic Ganesh Puja.", 2100m, 1800m, 90, true, "Ganesh Chaturthi"),
            ("Satyanarayan Puja", "satyanarayan-puja", "Satyanarayan Puja", "Sacred puja for peace, prosperity and fulfillment of wishes.", 3500m, (decimal?)null, 120, true, (string?)null),
            ("Griha Pravesh", "griha-pravesh", "Griha Pravesh", "House warming ceremony for positive energy in your new home.", 5100m, 4590m, 180, true, (string?)null),
            ("Navgraha Shanti", "navgraha-shanti", "Navgraha Shanti", "Pacify all nine planets for harmony and success.", 7500m, (decimal?)null, 240, false, "Navratri"),
            ("Rudrabhishek", "rudrabhishek", "Rudrabhishek", "Powerful Shiva worship for spiritual growth and protection.", 4100m, 3280m, 150, true, "Maha Shivratri"),
            ("Durga Puja", "durga-puja", "Durga Puja", "Invoke Goddess Durga for strength and victory over obstacles.", 5500m, 4125m, 180, true, "Navratri"),
            ("Lakshmi Puja", "lakshmi-puja", "Lakshmi Puja", "Attract wealth and abundance with sacred Lakshmi worship.", 3100m, 2170m, 120, true, "Diwali"),
            ("Mundan Sanskar", "mundan-sanskar", "Mundan Sanskar", "Traditional first haircut ceremony for children.", 2100m, (decimal?)null, 60, false, (string?)null),
            ("Vivah Puja", "vivah-puja", "Vivah Puja", "Complete Vedic wedding ceremony with all rituals.", 15000m, (decimal?)null, 360, true, (string?)null),
            ("Yajna", "yajna", "Yajna", "Sacred fire ritual for purification and divine blessings.", 8500m, (decimal?)null, 300, false, (string?)null)
        };

        foreach (var (name, slug, cat, desc, price, sale, dur, featured, festival) in poojas)
        {
            db.PoojaServices.Add(new PoojaService
            {
                Name = name, Slug = slug, Category = cat, Description = desc,
                Price = price, SalePrice = sale, DurationMinutes = dur,
                IsFeatured = featured, Rating = 4.5m + (decimal)(Random.Shared.NextDouble() * 0.5),
                ReviewCount = Random.Shared.Next(50, 300), FestivalTag = festival,
                ImageUrl = $"/images/pooja/{slug}.jpg"
            });
        }

        // Product Categories
        var categories = new Dictionary<string, string>
        {
            ["gemstones"] = "Gemstones",
            ["malas"] = "Malas",
            ["pooja-samagri"] = "Pooja Samagri",
            ["spiritual-books"] = "Spiritual Books",
            ["idols"] = "Idols & Images",
            ["yantras"] = "Yantras",
            ["rudraksha"] = "Rudraksha",
            ["home-decor"] = "Home Decor"
        };

        var categoryIds = new Dictionary<string, Guid>();
        foreach (var (slug, name) in categories)
        {
            var cat = new ProductCategory { Name = name, Slug = slug, Description = $"Authentic {name} for spiritual practice" };
            db.ProductCategories.Add(cat);
            categoryIds[slug] = cat.Id;
        }

        // Products
        var products = new[]
        {
            ("Natural Ruby (Manik)", "ruby-manik", "gemstones", "Certified natural ruby for Sun planet remedies.", 25000m, 22500m, 15, true, "Diwali"),
            ("Blue Sapphire (Neelam)", "blue-sapphire", "gemstones", "Premium Ceylon blue sapphire for Saturn.", 45000m, (decimal?)null, 8, true, (string?)null),
            ("5 Mukhi Rudraksha Mala", "rudraksha-mala-5", "malas", "Authentic Nepali 5 Mukhi Rudraksha mala, 108 beads.", 1200m, 960m, 50, true, "Maha Shivratri"),
            ("Puja Thali Set (Brass)", "puja-thali-brass", "pooja-samagri", "Complete brass puja thali with diya, bell, and kalash.", 899m, (decimal?)null, 100, false, (string?)null),
            ("Bhagavad Gita (Hindi)", "bhagavad-gita-hindi", "spiritual-books", "Illustrated Bhagavad Gita with commentary.", 350m, 280m, 200, true, (string?)null),
            ("Brass Ganesha Idol", "ganesha-idol-brass", "idols", "Handcrafted brass Ganesha idol, 6 inches.", 1499m, 1199m, 30, true, "Ganesh Chaturthi"),
            ("Sri Yantra (Copper)", "sri-yantra-copper", "yantras", "Energized Sri Yantra for prosperity and success.", 2100m, (decimal?)null, 25, true, "Diwali"),
            ("7 Mukhi Rudraksha", "rudraksha-7-mukhi", "rudraksha", "Rare 7 Mukhi Rudraksha from Nepal.", 3500m, 2800m, 12, false, (string?)null),
            ("Incense Sticks Set", "incense-sticks-set", "pooja-samagri", "Premium sandalwood and rose incense, 12 packs.", 499m, (decimal?)null, 150, false, (string?)null),
            ("Krishna Wall Hanging", "krishna-wall-hanging", "home-decor", "Beautiful Krishna devotional wall art with frame.", 799m, 639m, 40, true, "Krishna Janmashtami"),
            ("Yellow Sapphire (Pukhraj)", "yellow-sapphire", "gemstones", "Natural yellow sapphire for Jupiter blessings.", 35000m, 31500m, 6, true, (string?)null),
            ("Tulsi Mala", "tulsi-mala", "malas", "Sacred Tulsi mala for chanting and meditation.", 299m, (decimal?)null, 80, false, (string?)null)
        };

        foreach (var (name, slug, catSlug, desc, price, sale, stock, featured, festival) in products)
        {
            var product = new Product
            {
                Name = name, Slug = slug, Description = desc,
                CategoryId = categoryIds[catSlug],
                Price = price, SalePrice = sale, StockQuantity = stock,
                IsFeatured = featured, FestivalTag = festival,
                Rating = 4.3m + (decimal)(Random.Shared.NextDouble() * 0.7),
                ReviewCount = Random.Shared.Next(20, 150),
                Sku = $"VM-{slug.ToUpperInvariant()[..8]}"
            };
            product.Images.Add(new ProductImage
            {
                ImageUrl = $"/images/products/{slug}.jpg",
                IsPrimary = true,
                SortOrder = 0
            });
            db.Products.Add(product);
        }

        db.SubscriptionPlans.AddRange(
            new SubscriptionPlan { Name = "Basic", Slug = "basic", Description = "Monthly horoscope and kundli checks", Price = 199m, Features = "[\"Monthly Horoscope\",\"2 Kundli Checks\",\"Astrology Articles\"]" },
            new SubscriptionPlan { Name = "Premium", Slug = "premium", Description = "Weekly horoscope with pooja bookings", Price = 499m, Features = "[\"Weekly Horoscope\",\"5 Kundli Checks\",\"2 Pooja Bookings\",\"Chat Support\"]", IsPopular = true },
            new SubscriptionPlan { Name = "Elite", Slug = "elite", Description = "Daily horoscope with unlimited kundli", Price = 999m, Features = "[\"Daily Horoscope\",\"Unlimited Kundli\",\"10 Pooja Bookings\",\"Astrologer Chat\",\"Priority Support\"]" },
            new SubscriptionPlan { Name = "Family", Slug = "family", Description = "Elite features for 5 family members", Price = 1999m, Features = "[\"5 Members\",\"All Elite Features\",\"Family Pooja\",\"Group Consultations\"]" },
            new SubscriptionPlan { Name = "Business", Slug = "business", Description = "For professional astrologers", Price = 4999m, Features = "[\"20+ Services\",\"Priority Listing\",\"Advanced Analytics\",\"Dedicated Support\"]" }
        );

        // Coupons
        db.Coupons.AddRange(
            new Coupon { Code = "DIWALI30", Description = "Diwali special 30% off", Type = CouponType.Percentage, Value = 30, MinOrderValue = 500, MaxDiscount = 2000, UsageLimit = 1000, ValidFrom = DateTime.UtcNow.AddDays(-30), ValidTo = DateTime.UtcNow.AddDays(60), FestivalTag = "Diwali" },
            new Coupon { Code = "WELCOME100", Description = "Welcome discount for new users", Type = CouponType.FixedAmount, Value = 100, MinOrderValue = 999, UsageLimit = 5000, ValidFrom = DateTime.UtcNow.AddDays(-90), ValidTo = DateTime.UtcNow.AddDays(365) },
            new Coupon { Code = "NAVRATRI25", Description = "Navratri festival discount", Type = CouponType.Percentage, Value = 25, MinOrderValue = 1000, MaxDiscount = 1500, UsageLimit = 500, ValidFrom = DateTime.UtcNow.AddDays(-10), ValidTo = DateTime.UtcNow.AddDays(30), FestivalTag = "Navratri" }
        );

        // Blog
        var blogCat = new BlogCategory { Name = "Astrology Tips", Slug = "astrology-tips" };
        db.BlogCategories.Add(blogCat);
        db.BlogPosts.AddRange(
            new BlogPost { Title = "Understanding Your Birth Chart", Slug = "understanding-birth-chart", Excerpt = "Learn the basics of Vedic birth chart interpretation.", Content = "Your birth chart, or Kundli, is a cosmic snapshot of the sky at the moment of your birth...", Author = "Pandit Sharma", CategoryId = blogCat.Id, ImageUrl = "/images/blog/birth-chart.jpg", ViewCount = 1250 },
            new BlogPost { Title = "Diwali Puja Guide 2026", Slug = "diwali-puja-guide", Excerpt = "Complete guide to performing Lakshmi Puja this Diwali.", Content = "Diwali, the festival of lights, is the perfect time for Lakshmi Puja...", Author = "Acharya Mishra", CategoryId = blogCat.Id, ImageUrl = "/images/blog/diwali-guide.jpg", ViewCount = 890 },
            new BlogPost { Title = "Gemstones and Planetary Remedies", Slug = "gemstones-planetary-remedies", Excerpt = "How to choose the right gemstone for your planetary dosha.", Content = "In Vedic astrology, gemstones are powerful tools for balancing planetary energies...", Author = "Dr. Venkatesh", CategoryId = blogCat.Id, ImageUrl = "/images/blog/gemstones.jpg", ViewCount = 654 }
        );

        // FAQs
        db.Faqs.AddRange(
            new Faq { Question = "How do I book a pooja service?", Answer = "Browse our pooja catalog, select a service, choose date and time, and complete payment. Our pandits will perform the ritual and send prasad.", Category = "Pooja", SortOrder = 1 },
            new Faq { Question = "Are gemstones certified?", Answer = "Yes, all our gemstones come with authenticity certificates from recognized gemological laboratories.", Category = "Products", SortOrder = 2 },
            new Faq { Question = "How long does kundli analysis take?", Answer = "Standard kundli analysis is delivered within 24-48 hours. Premium analysis may take up to 72 hours.", Category = "Kundli", SortOrder = 3 },
            new Faq { Question = "What payment methods are accepted?", Answer = "We accept UPI, credit/debit cards, net banking, wallets, and Cash on Delivery for eligible orders.", Category = "Payment", SortOrder = 4 },
            new Faq { Question = "Can I cancel a pooja booking?", Answer = "Yes, cancellations made 48 hours before the scheduled date receive a full refund.", Category = "Pooja", SortOrder = 5 }
        );

        // Settings
        db.Settings.AddRange(
            new Setting { Key = "site_name", Value = "Vadic Mall", Description = "Application name" },
            new Setting { Key = "support_email", Value = "info@vadicmall.com", Description = "Support email" },
            new Setting { Key = "support_phone", Value = "+91 98765 43210", Description = "Support phone" },
            new Setting { Key = "free_shipping_threshold", Value = "999", Description = "Free shipping above this amount" }
        );

        await db.SaveChangesAsync();
    }
}
