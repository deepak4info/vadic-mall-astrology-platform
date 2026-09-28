namespace VadicMall.Application.DTOs.Auth;

public record RegisterRequest(string Email, string Password, string FirstName, string LastName, string? Phone);
public record RegisterAstrologerRequest(string Email, string Password, string FirstName, string LastName, string Phone, string Specialization, string Bio, int ExperienceYears, decimal ConsultationFee);
public record LoginRequest(string Email, string Password);
public record AuthResponse(string Token, string RefreshToken, UserDto User, DateTime ExpiresAt);
public record UserDto(Guid Id, string Email, string FirstName, string LastName, string? Phone, string Role, string? AvatarUrl, List<string>? Permissions = null);
public record RefreshTokenRequest(string RefreshToken);
public record ChangePasswordRequest(string CurrentPassword, string NewPassword);
