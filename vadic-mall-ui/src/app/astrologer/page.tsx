"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";
import { User, Calendar, Star, BadgeCheck } from "lucide-react";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { DashboardSkeleton } from "@/components/ui/skeleton";
import { useAuthStore, useAuthHydrated } from "@/store/auth";
import { useAstrologerData } from "@/lib/hooks";
import { formatPrice } from "@/lib/utils";
import type { AstrologerProfileInfo, AstrologerBooking } from "@/lib/types";

export default function AstrologerDashboard() {
  const router = useRouter();
  const { user } = useAuthStore();
  const hydrated = useAuthHydrated();
  const enabled = !!user && user.role === "Astrologer";

  const { data: profile, isLoading: profileLoading } = useAstrologerData<AstrologerProfileInfo>("profile", "/profile", enabled);
  const { data: bookings = [], isLoading: bookingsLoading } = useAstrologerData<AstrologerBooking[]>("bookings", "/bookings", enabled);

  useEffect(() => {
    if (hydrated && (!user || user.role !== "Astrologer")) router.push("/login");
  }, [hydrated, user, router]);

  if (!hydrated || !user || user.role !== "Astrologer" || profileLoading || bookingsLoading) {
    return <DashboardSkeleton tiles={4} />;
  }

  if (!profile) return <div className="py-20 text-center text-gray-500">Profile not found.</div>;

  return (
    <div className="mx-auto max-w-7xl animate-fade-in px-4 py-12 lg:px-8">
      <div className="mb-6 flex flex-wrap items-center justify-between gap-4">
        <div className="flex items-center gap-4">
          <div className="flex h-14 w-14 items-center justify-center rounded-full bg-saffron/10"><User className="h-7 w-7 text-saffron" /></div>
          <div>
            <h1 className="font-heading text-2xl font-bold text-krishna">Welcome, {profile.name}!</h1>
            <p className="text-gray-500">{profile.email}</p>
          </div>
        </div>
        {profile.isApproved ? (
          <span className="flex items-center gap-1 rounded-full bg-green-100 px-3 py-1.5 text-sm font-semibold text-green-700">
            <BadgeCheck className="h-4 w-4" /> Verified
          </span>
        ) : (
          <span className="rounded-full bg-amber-100 px-3 py-1.5 text-sm font-semibold text-amber-700">Pending Verification</span>
        )}
      </div>

      <div className="mb-10 grid gap-6 md:grid-cols-4">
        <Card>
          <CardContent className="flex items-center gap-4 p-6">
            <Star className="h-8 w-8 text-saffron" />
            <div><p className="text-2xl font-bold text-krishna">{profile.rating.toFixed(1)}</p><p className="text-sm text-gray-500">Rating ({profile.reviewCount})</p></div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="flex items-center gap-4 p-6">
            <Calendar className="h-8 w-8 text-saffron" />
            <div><p className="text-2xl font-bold text-krishna">{bookings.length}</p><p className="text-sm text-gray-500">Bookings</p></div>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-6">
            <p className="text-sm text-gray-500">Consultation Fee</p>
            <p className="text-2xl font-bold text-krishna">{formatPrice(profile.consultationFee)}</p>
          </CardContent>
        </Card>
        <Card>
          <CardContent className="p-6">
            <p className="text-sm text-gray-500">Experience</p>
            <p className="text-2xl font-bold text-krishna">{profile.experienceYears} yrs</p>
          </CardContent>
        </Card>
      </div>

      <div className="grid gap-8 lg:grid-cols-2">
        <div>
          <h2 className="mb-4 font-heading text-lg font-semibold text-krishna">My Profile</h2>
          <Card>
            <CardContent className="space-y-3 p-6 text-sm">
              <Row label="Specialization" value={profile.specialization} />
              <Row label="Phone" value={profile.phone || "—"} />
              <Row label="Languages" value={profile.languages || "—"} />
              <Row label="Featured" value={profile.isFeatured ? "Yes" : "No"} />
              <div>
                <p className="mb-1 font-medium text-gray-500">Bio</p>
                <p className="text-gray-600">{profile.bio}</p>
              </div>
            </CardContent>
          </Card>
        </div>

        <div>
          <h2 className="mb-4 font-heading text-lg font-semibold text-krishna">My Bookings</h2>
          {bookings.length === 0 ? (
            <p className="text-gray-500">
              {profile.isApproved
                ? "No bookings assigned to you yet."
                : "Bookings will appear here once your profile is verified by the admin."}
            </p>
          ) : (
            <div className="space-y-3">
              {bookings.map((b) => (
                <div key={b.id} className="flex items-center justify-between rounded-xl border bg-white p-4">
                  <div>
                    <p className="font-medium text-krishna">{b.serviceName}</p>
                    <p className="text-sm text-gray-500">{b.customerName} · {new Date(b.scheduledDate).toLocaleDateString()}{b.scheduledTime ? ` at ${b.scheduledTime}` : ""}</p>
                  </div>
                  <div className="text-right">
                    <p className="font-semibold">{formatPrice(b.amount)}</p>
                    <Badge>{b.status}</Badge>
                  </div>
                </div>
              ))}
            </div>
          )}
        </div>
      </div>
    </div>
  );
}

function Row({ label, value }: { label: string; value: string }) {
  return (
    <div className="flex justify-between border-b border-gray-100 pb-2 last:border-0">
      <span className="text-gray-500">{label}</span>
      <span className="font-medium text-krishna">{value}</span>
    </div>
  );
}
