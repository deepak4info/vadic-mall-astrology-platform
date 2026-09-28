using Microsoft.EntityFrameworkCore;
using VadicMall.Application.DTOs.Astrologer;
using VadicMall.Application.Interfaces;
using VadicMall.Infrastructure.Data;

namespace VadicMall.Infrastructure.Services;

public class AstrologerService(VadicMallDbContext db) : IAstrologerService
{
    public async Task<AstrologerProfileDto?> GetMyProfileAsync(Guid userId)
    {
        var profile = await db.AstrologerProfiles.AsNoTracking()
            .Include(p => p.User)
            .FirstOrDefaultAsync(p => p.UserId == userId);
        if (profile == null) return null;

        return new AstrologerProfileDto(profile.UserId, $"{profile.User.FirstName} {profile.User.LastName}",
            profile.User.Email, profile.User.Phone, profile.Specialization, profile.Bio,
            profile.ExperienceYears, profile.ConsultationFee, profile.Rating, profile.ReviewCount,
            profile.IsApproved, profile.IsFeatured, profile.Languages);
    }

    public async Task<IEnumerable<AstrologerBookingDto>> GetMyBookingsAsync(Guid userId) =>
        await db.PoojaBookings.AsNoTracking()
            .Include(b => b.PoojaService)
            .Include(b => b.User)
            .Where(b => b.AstrologerId == userId)
            .OrderByDescending(b => b.ScheduledDate)
            .Select(b => new AstrologerBookingDto(b.Id, b.PoojaService.Name,
                $"{b.User.FirstName} {b.User.LastName}", b.ScheduledDate, b.ScheduledTime,
                b.Status, b.Amount, b.SpecialInstructions, b.Notes))
            .ToListAsync();
}
