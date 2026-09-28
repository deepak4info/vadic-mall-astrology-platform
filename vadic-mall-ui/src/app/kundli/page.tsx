"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import toast from "react-hot-toast";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import { useAuthStore } from "@/store/auth";
import { useCatalog } from "@/lib/hooks";
import { customerPost, getApiErrorMessage } from "@/lib/api";
import { getImageUrl } from "@/lib/utils";

const plans = [
  { name: "Basic Kundli", price: 499, features: ["Birth Chart", "Planetary Positions", "Basic Analysis"] },
  { name: "Detailed Kundli", price: 999, features: ["Everything in Basic", "Dasha Analysis", "Remedies", "PDF Report"] },
  { name: "Premium Kundli", price: 1999, features: ["Everything in Detailed", "Marriage Matching", "Career Guidance", "Astrologer Consultation"] },
];

export default function KundliPage() {
  const router = useRouter();
  const { user } = useAuthStore();
  const [loading, setLoading] = useState(false);
  const [selectedPlan, setSelectedPlan] = useState(plans[0]);
  const [form, setForm] = useState({ name: "", dateOfBirth: "", timeOfBirth: "", placeOfBirth: "", gender: "male" });
  const { data: banner } = useCatalog<{ key: string; value: string }>("setting-kundli-banner", "/catalog/settings/kundli_banner_image");
  const bannerUrl = getImageUrl(banner?.value);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!user) { router.push("/login"); return; }
    setLoading(true);
    try {
      await customerPost("/kundli-requests", { ...form, amount: selectedPlan.price });
      toast.success("Kundli request submitted!");
      router.push("/customer");
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Request failed"));
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <div className="mb-10 text-center">
        <h1 className="section-title">Kundli Analysis</h1>
        <p className="mt-2 text-gray-500">Get detailed Vedic birth chart analysis from expert astrologers</p>
      </div>

      <div className="grid gap-8 lg:grid-cols-5 lg:items-start">
        <Card className="lg:col-span-3">
          <div className="relative flex h-40 items-center justify-center overflow-hidden rounded-t-2xl bg-gradient-to-br from-krishna to-krishna-navy">
            {bannerUrl ? (
              // eslint-disable-next-line @next/next/no-img-element
              <img src={bannerUrl} alt="Kundli" className="absolute inset-0 h-full w-full object-cover" />
            ) : (
              <span className="text-6xl opacity-40">⭐</span>
            )}
          </div>
          <CardContent className="p-8">
            <h2 className="mb-6 font-heading text-xl font-semibold text-krishna">Enter Birth Details</h2>
            <form onSubmit={handleSubmit} className="space-y-5">
              <div>
                <label className="mb-1.5 block text-sm font-medium text-gray-700">Full Name</label>
                <Input required value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} />
              </div>
              <div className="grid gap-5 sm:grid-cols-2">
                <div>
                  <label className="mb-1.5 block text-sm font-medium text-gray-700">Date of Birth</label>
                  <Input type="date" required value={form.dateOfBirth} onChange={(e) => setForm({ ...form, dateOfBirth: e.target.value })} />
                </div>
                <div>
                  <label className="mb-1.5 block text-sm font-medium text-gray-700">Time of Birth</label>
                  <Input type="time" required value={form.timeOfBirth} onChange={(e) => setForm({ ...form, timeOfBirth: e.target.value })} />
                </div>
              </div>
              <div className="grid gap-5 sm:grid-cols-2">
                <div>
                  <label className="mb-1.5 block text-sm font-medium text-gray-700">Place of Birth</label>
                  <Input required placeholder="City, State" value={form.placeOfBirth} onChange={(e) => setForm({ ...form, placeOfBirth: e.target.value })} />
                </div>
                <div>
                  <label className="mb-1.5 block text-sm font-medium text-gray-700">Gender</label>
                  <select className="flex h-11 w-full rounded-xl border border-gray-200 px-4" value={form.gender} onChange={(e) => setForm({ ...form, gender: e.target.value })}>
                    <option value="male">Male</option>
                    <option value="female">Female</option>
                  </select>
                </div>
              </div>

              <div className="rounded-xl bg-saffron/5 p-4 text-sm text-gray-600">
                🔒 Your birth details are kept confidential and used only to prepare your Kundli report.
              </div>

              <div className="flex items-center justify-between rounded-xl border border-gray-100 bg-gray-50 px-4 py-3">
                <span className="text-sm text-gray-500">Selected plan</span>
                <span className="font-heading font-semibold text-krishna">{selectedPlan.name} · ₹{selectedPlan.price}</span>
              </div>

              <Button type="submit" disabled={loading} className="w-full" size="lg">
                {loading ? "Submitting..." : `Request ${selectedPlan.name} — ₹${selectedPlan.price}`}
              </Button>
            </form>
          </CardContent>
        </Card>

        <div className="flex flex-col gap-6 lg:col-span-2">
          {plans.map((plan) => (
            <Card
              key={plan.name}
              className={`flex-1 cursor-pointer text-center transition-all ${selectedPlan.name === plan.name ? "border-saffron ring-2 ring-saffron" : ""}`}
              onClick={() => setSelectedPlan(plan)}
            >
              <CardContent className="flex h-full flex-col justify-center p-6">
                <h3 className="font-heading text-lg font-semibold text-krishna">{plan.name}</h3>
                <p className="mt-2 font-heading text-3xl font-bold text-saffron">₹{plan.price}</p>
                <ul className="mt-4 space-y-2 text-sm text-gray-500">
                  {plan.features.map((f) => <li key={f}>✓ {f}</li>)}
                </ul>
              </CardContent>
            </Card>
          ))}
        </div>
      </div>
    </div>
  );
}
