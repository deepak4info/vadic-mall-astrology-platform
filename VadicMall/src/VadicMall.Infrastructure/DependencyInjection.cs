using System.Security.Claims;
using System.Text;
using Microsoft.AspNetCore.Authentication.JwtBearer;
using Microsoft.EntityFrameworkCore;
using Microsoft.Extensions.Configuration;
using Microsoft.Extensions.DependencyInjection;
using Microsoft.IdentityModel.Tokens;
using VadicMall.Application.Interfaces;
using VadicMall.Domain.Enums;
using VadicMall.Infrastructure.Data;
using VadicMall.Infrastructure.Services;

namespace VadicMall.Infrastructure;

public static class DependencyInjection
{
    public static IServiceCollection AddInfrastructure(this IServiceCollection services, IConfiguration configuration)
    {
        var connectionString = configuration.GetConnectionString("DefaultConnection");
        services.AddDbContext<VadicMallDbContext>(options =>
        {
            if (connectionString?.Contains("Data Source=", StringComparison.OrdinalIgnoreCase) == true)
                options.UseSqlite(connectionString);
            else
                options.UseSqlServer(connectionString);
        });

        services.AddAuthentication(JwtBearerDefaults.AuthenticationScheme)
            .AddJwtBearer(options =>
            {
                options.TokenValidationParameters = new TokenValidationParameters
                {
                    ValidateIssuer = true,
                    ValidateAudience = true,
                    ValidateLifetime = true,
                    ValidateIssuerSigningKey = true,
                    ValidIssuer = configuration["Jwt:Issuer"],
                    ValidAudience = configuration["Jwt:Audience"],
                    IssuerSigningKey = new SymmetricSecurityKey(
                        Encoding.UTF8.GetBytes(configuration["Jwt:Secret"]!))
                };

                // Re-checks the user's live status on every request so a ban or a declined
                // astrologer approval takes effect immediately, instead of waiting out the
                // access token's lifetime (JWTs are otherwise stateless and can't be revoked).
                options.Events = new JwtBearerEvents
                {
                    OnTokenValidated = async context =>
                    {
                        var userId = context.Principal?.FindFirstValue(ClaimTypes.NameIdentifier);
                        if (!Guid.TryParse(userId, out var id))
                        {
                            context.Fail("Invalid token");
                            return;
                        }

                        var db = context.HttpContext.RequestServices.GetRequiredService<VadicMallDbContext>();
                        var status = await db.Users.AsNoTracking()
                            .Where(u => u.Id == id)
                            .Select(u => new
                            {
                                u.IsActive,
                                u.Role,
                                IsApproved = u.AstrologerProfile != null ? (bool?)u.AstrologerProfile.IsApproved : null,
                                u.IsStaffApproved,
                                Permissions = u.UserPermissions.Select(p => p.Permission)
                            })
                            .FirstOrDefaultAsync();

                        if (status == null || !status.IsActive)
                        {
                            context.Fail("Account is deactivated");
                            return;
                        }

                        if (status.Role == UserRole.Astrologer && status.IsApproved != true)
                        {
                            context.Fail("Astrologer account is not approved");
                            return;
                        }

                        // Permissions are re-derived from the DB on every request (never baked into the JWT
                        // itself) so a permission grant or revoke takes effect immediately, the same way
                        // account deactivation and astrologer approval already do above.
                        if (status.IsStaffApproved)
                        {
                            var identity = (ClaimsIdentity)context.Principal!.Identity!;
                            foreach (var permission in status.Permissions)
                                identity.AddClaim(new Claim("perm", permission.ToString()));
                        }
                    }
                };
            });

        services.AddAuthorization(options =>
        {
            options.AddPolicy("AdminOnly", policy => policy.RequireRole("SuperAdmin"));
            options.AddPolicy("AstrologerOnly", policy => policy.RequireRole("Astrologer", "SuperAdmin"));
            options.AddPolicy("CustomerOnly", policy => policy.RequireRole("Customer", "SuperAdmin"));

            // A SuperAdmin always passes every permission policy; a staff member (any other role that has
            // been approved and granted this specific permission) passes only that one, so a "Product
            // Manager" can reach the Products admin endpoints but nothing else in the admin section.
            foreach (var permission in Enum.GetNames<StaffPermission>())
            {
                options.AddPolicy(permission, policy => policy.RequireAssertion(ctx =>
                    ctx.User.IsInRole("SuperAdmin") || ctx.User.HasClaim("perm", permission)));
            }
        });

        services.AddScoped<ITokenService, TokenService>();
        services.AddScoped<IAuthService, AuthService>();
        services.AddScoped<ICatalogService, CatalogService>();
        services.AddScoped<ICustomerService, CustomerService>();
        services.AddScoped<IAdminService, AdminService>();
        services.AddScoped<IAstrologerService, AstrologerService>();

        return services;
    }
}
