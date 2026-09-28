"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import toast from "react-hot-toast";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import { authPost, getApiErrorMessage } from "@/lib/api";
import { useAuthStore } from "@/store/auth";
import type { AuthResponse } from "@/lib/types";

export default function RegisterAstrologerPage() {
  const router = useRouter();
  const setAuth = useAuthStore((s) => s.setAuth);
  const [loading, setLoading] = useState(false);
  const [form, setForm] = useState({
    email: "",
    password: "",
    firstName: "",
    lastName: "",
    phone: "",
    specialization: "",
    bio: "",
    experienceYears: "",
    consultationFee: "",
  });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      const response = await authPost<AuthResponse>("/register-astrologer", {
        ...form,
        experienceYears: Number(form.experienceYears),
        consultationFee: Number(form.consultationFee),
      });
      setAuth(response);
      toast.success("Astrologer account created! Our team will verify your profile before it goes live.");
      router.push("/");
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Registration failed"));
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="flex min-h-[70vh] items-center justify-center px-4 py-12">
      <Card className="w-full max-w-lg">
        <CardContent className="p-8">
          <h1 className="mb-6 text-center font-heading text-2xl font-bold text-krishna">Register as Astrologer</h1>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div><label className="mb-1 block text-sm font-medium">First Name</label><Input required value={form.firstName} onChange={(e) => setForm({ ...form, firstName: e.target.value })} /></div>
              <div><label className="mb-1 block text-sm font-medium">Last Name</label><Input required value={form.lastName} onChange={(e) => setForm({ ...form, lastName: e.target.value })} /></div>
            </div>
            <div><label className="mb-1 block text-sm font-medium">Email</label><Input type="email" autoComplete="email" required value={form.email} onChange={(e) => setForm({ ...form, email: e.target.value })} /></div>
            <div><label className="mb-1 block text-sm font-medium">Phone</label><Input autoComplete="tel" required value={form.phone} onChange={(e) => setForm({ ...form, phone: e.target.value })} /></div>
            <div><label className="mb-1 block text-sm font-medium">Password</label><Input type="password" autoComplete="new-password" required minLength={6} value={form.password} onChange={(e) => setForm({ ...form, password: e.target.value })} /></div>
            <div><label className="mb-1 block text-sm font-medium">Specialization</label><Input required placeholder="e.g. Vedic Astrology, Numerology" value={form.specialization} onChange={(e) => setForm({ ...form, specialization: e.target.value })} /></div>
            <div>
              <label className="mb-1 block text-sm font-medium">Bio</label>
              <textarea className="flex min-h-[100px] w-full rounded-xl border border-gray-200 px-4 py-3 text-sm focus:border-saffron focus:outline-none" required value={form.bio} onChange={(e) => setForm({ ...form, bio: e.target.value })} />
            </div>
            <div className="grid grid-cols-2 gap-4">
              <div><label className="mb-1 block text-sm font-medium">Experience (Years)</label><Input type="number" min={0} required value={form.experienceYears} onChange={(e) => setForm({ ...form, experienceYears: e.target.value })} /></div>
              <div><label className="mb-1 block text-sm font-medium">Consultation Fee (₹)</label><Input type="number" min={0} required value={form.consultationFee} onChange={(e) => setForm({ ...form, consultationFee: e.target.value })} /></div>
            </div>
            <Button type="submit" disabled={loading} className="w-full">{loading ? "Creating..." : "Register"}</Button>
          </form>
          <p className="mt-4 text-center text-sm text-gray-500">
            Already have an account? <Link href="/login" className="text-saffron hover:underline">Login</Link>
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
