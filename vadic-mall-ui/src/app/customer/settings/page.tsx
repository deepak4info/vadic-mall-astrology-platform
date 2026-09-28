"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import toast from "react-hot-toast";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import { useAuthStore, useAuthHydrated } from "@/store/auth";
import { getApiErrorMessage } from "@/lib/api";

export default function CustomerSettingsPage() {
  const router = useRouter();
  const { user, changePassword } = useAuthStore();
  const hydrated = useAuthHydrated();
  const [loading, setLoading] = useState(false);
  const [form, setForm] = useState({ currentPassword: "", newPassword: "", confirmPassword: "" });

  useEffect(() => {
    if (hydrated && !user) router.push("/login");
  }, [hydrated, user, router]);

  if (!hydrated || !user) {
    return (
      <div className="mx-auto max-w-3xl px-4 py-12 lg:px-8">
        <Skeleton className="mb-4 h-8 w-48" />
        <div className="mb-8 flex gap-2">
          <Skeleton className="h-9 w-24 rounded-full" />
          <Skeleton className="h-9 w-24 rounded-full" />
          <Skeleton className="h-9 w-24 rounded-full" />
        </div>
        <div className="rounded-2xl border bg-white p-8">
          <Skeleton className="mb-6 h-5 w-40" />
          <div className="space-y-4">
            <Skeleton className="h-11 w-full rounded-xl" />
            <Skeleton className="h-11 w-full rounded-xl" />
            <Skeleton className="h-11 w-full rounded-xl" />
            <Skeleton className="h-11 w-full rounded-xl" />
          </div>
        </div>
      </div>
    );
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (form.newPassword !== form.confirmPassword) {
      toast.error("New passwords do not match");
      return;
    }
    setLoading(true);
    try {
      await changePassword(form.currentPassword, form.newPassword);
      toast.success("Password changed successfully");
      setForm({ currentPassword: "", newPassword: "", confirmPassword: "" });
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Failed to change password"));
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="mx-auto max-w-3xl px-4 py-12 lg:px-8">
      <h1 className="section-title mb-4">Account Settings</h1>
      <div className="mb-8 flex gap-2 text-sm">
        <Link href="/customer" className="rounded-full bg-gray-100 px-4 py-2 font-medium text-gray-600 hover:bg-gray-200">Dashboard</Link>
        <Link href="/customer/addresses" className="rounded-full bg-gray-100 px-4 py-2 font-medium text-gray-600 hover:bg-gray-200">Addresses</Link>
        <Link href="/customer/settings" className="rounded-full bg-saffron px-4 py-2 font-medium text-white">Settings</Link>
      </div>

      <Card>
        <CardContent className="p-8">
          <h2 className="mb-6 font-heading text-lg font-semibold text-krishna">Change Password</h2>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="mb-1 block text-sm font-medium">Current Password</label>
              <Input type="password" autoComplete="current-password" required value={form.currentPassword} onChange={(e) => setForm({ ...form, currentPassword: e.target.value })} />
            </div>
            <div>
              <label className="mb-1 block text-sm font-medium">New Password</label>
              <Input type="password" autoComplete="new-password" required minLength={6} value={form.newPassword} onChange={(e) => setForm({ ...form, newPassword: e.target.value })} />
            </div>
            <div>
              <label className="mb-1 block text-sm font-medium">Confirm New Password</label>
              <Input type="password" autoComplete="new-password" required minLength={6} value={form.confirmPassword} onChange={(e) => setForm({ ...form, confirmPassword: e.target.value })} />
            </div>
            <Button type="submit" disabled={loading} className="w-full">{loading ? "Updating..." : "Update Password"}</Button>
          </form>
        </CardContent>
      </Card>
    </div>
  );
}
