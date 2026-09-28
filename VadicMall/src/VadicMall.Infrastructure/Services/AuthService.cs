using Microsoft.EntityFrameworkCore;
using VadicMall.Application.DTOs.Auth;
using VadicMall.Application.Interfaces;
using VadicMall.Domain.Entities;
using VadicMall.Domain.Enums;
using VadicMall.Infrastructure.Data;

namespace VadicMall.Infrastructure.Services;

public class AuthService(VadicMallDbContext db, ITokenService tokenService) : IAuthService
{
    public async Task<AuthResponse> RegisterAsync(RegisterRequest request)
    {
        if (await db.Users.AnyAsync(u => u.Email == request.Email))
            throw new InvalidOperationException("Email already registered");

        var user = new User
        {
            Email = request.Email.ToLowerInvariant(),
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.Password, 11),
            FirstName = request.FirstName,
            LastName = request.LastName,
            Phone = request.Phone,
            Role = UserRole.Customer,
            EmailVerified = false
        };

        db.Users.Add(user);
        await db.SaveChangesAsync();
        return await CreateAuthResponse(user);
    }

    public async Task<AuthResponse> RegisterAstrologerAsync(RegisterAstrologerRequest request)
    {
        if (await db.Users.AnyAsync(u => u.Email == request.Email))
            throw new InvalidOperationException("Email already registered");

        var user = new User
        {
            Email = request.Email.ToLowerInvariant(),
            PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.Password, 11),
            FirstName = request.FirstName,
            LastName = request.LastName,
            Phone = request.Phone,
            Role = UserRole.Astrologer
        };

        user.AstrologerProfile = new AstrologerProfile
        {
            UserId = user.Id,
            Specialization = request.Specialization,
            Bio = request.Bio,
            ExperienceYears = request.ExperienceYears,
            ConsultationFee = request.ConsultationFee,
            IsApproved = false
        };

        db.Users.Add(user);

        var adminIds = await db.Users.Where(u => u.Role == UserRole.SuperAdmin).Select(u => u.Id).ToListAsync();
        foreach (var adminId in adminIds)
        {
            db.Notifications.Add(new Notification
            {
                UserId = adminId,
                Title = "New Astrologer Registration",
                Message = $"{user.FirstName} {user.LastName} ({request.Specialization}) registered as an astrologer and needs verification.",
                Type = "astrologer_registration",
                Link = "/admin?tab=users"
            });
        }

        await db.SaveChangesAsync();
        return await CreateAuthResponse(user);
    }

    public async Task<AuthResponse> LoginAsync(LoginRequest request, string? ipAddress, string? userAgent)
    {
        var user = await db.Users.Include(u => u.AstrologerProfile).Include(u => u.UserPermissions)
            .FirstOrDefaultAsync(u => u.Email == request.Email.ToLowerInvariant());
        var loginLog = new LoginLog
        {
            Email = request.Email,
            IpAddress = ipAddress,
            UserAgent = userAgent
        };

        if (user == null || !BCrypt.Net.BCrypt.Verify(request.Password, user.PasswordHash))
        {
            loginLog.Success = false;
            loginLog.FailureReason = "Invalid credentials";
            db.LoginLogs.Add(loginLog);
            await db.SaveChangesAsync();
            throw new UnauthorizedAccessException("Invalid email or password");
        }

        try
        {
            EnsureLoginEligible(user);
        }
        catch (UnauthorizedAccessException ex)
        {
            loginLog.Success = false;
            loginLog.FailureReason = ex.Message;
            db.LoginLogs.Add(loginLog);
            await db.SaveChangesAsync();
            throw;
        }

        loginLog.Success = true;
        loginLog.UserId = user.Id;
        user.LastLoginAt = DateTime.UtcNow;
        db.LoginLogs.Add(loginLog);
        await db.SaveChangesAsync();

        return await CreateAuthResponse(user);
    }

    public async Task<AuthResponse> RefreshTokenAsync(RefreshTokenRequest request)
    {
        var user = await db.Users.Include(u => u.AstrologerProfile).Include(u => u.UserPermissions).FirstOrDefaultAsync(u =>
            u.RefreshToken == request.RefreshToken &&
            u.RefreshTokenExpiry > DateTime.UtcNow);

        if (user == null)
            throw new UnauthorizedAccessException("Invalid refresh token");

        EnsureLoginEligible(user);

        return await CreateAuthResponse(user);
    }

    private static void EnsureLoginEligible(User user)
    {
        if (!user.IsActive)
            throw new UnauthorizedAccessException("Your account has been deactivated by the administrator. Please contact the administrator for further assistance.");

        if (user.Role == UserRole.Astrologer && user.AstrologerProfile?.IsApproved != true)
            throw new UnauthorizedAccessException("Your request is currently pending. You cannot log in yet because your account has not been approved by the admin. Please contact the administrator for further assistance.");
    }

    public async Task<UserDto?> GetCurrentUserAsync(Guid userId)
    {
        var user = await db.Users.Include(u => u.UserPermissions).FirstOrDefaultAsync(u => u.Id == userId);
        return user == null ? null : MapUser(user);
    }

    public async Task ChangePasswordAsync(Guid userId, ChangePasswordRequest request)
    {
        var user = await db.Users.FindAsync(userId)
            ?? throw new KeyNotFoundException("User not found");

        if (!BCrypt.Net.BCrypt.Verify(request.CurrentPassword, user.PasswordHash))
            throw new UnauthorizedAccessException("Current password is incorrect");

        user.PasswordHash = BCrypt.Net.BCrypt.HashPassword(request.NewPassword, 11);
        user.UpdatedAt = DateTime.UtcNow;
        await db.SaveChangesAsync();
    }

    private async Task<AuthResponse> CreateAuthResponse(User user)
    {
        var refreshToken = tokenService.GenerateRefreshToken();
        user.RefreshToken = refreshToken;
        user.RefreshTokenExpiry = DateTime.UtcNow.AddDays(7);
        await db.SaveChangesAsync();

        var role = user.Role.ToString();
        var token = tokenService.GenerateAccessToken(user.Id, user.Email, role);
        var expiryHours = 8;

        return new AuthResponse(token, refreshToken, MapUser(user), DateTime.UtcNow.AddHours(expiryHours));
    }

    private static UserDto MapUser(User user) =>
        new(user.Id, user.Email, user.FirstName, user.LastName, user.Phone, user.Role.ToString(), user.AvatarUrl,
            user.IsStaffApproved ? user.UserPermissions.Select(p => p.Permission.ToString()).ToList() : []);
}
