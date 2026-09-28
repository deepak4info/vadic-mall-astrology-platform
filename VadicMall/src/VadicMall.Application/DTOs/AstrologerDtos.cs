using VadicMall.Domain.Enums;

namespace VadicMall.Application.DTOs.Astrologer;

public record AstrologerProfileDto(
    Guid UserId,
    string Name,
    string Email,
    string? Phone,
    string Specialization,
    string Bio,
    int ExperienceYears,
    decimal ConsultationFee,
    decimal Rating,
    int ReviewCount,
    bool IsApproved,
    bool IsFeatured,
    string? Languages);

public record AstrologerBookingDto(
    Guid Id,
    string ServiceName,
    string CustomerName,
    DateTime ScheduledDate,
    string? ScheduledTime,
    BookingStatus Status,
    decimal Amount,
    string? SpecialInstructions,
    string? Notes);
