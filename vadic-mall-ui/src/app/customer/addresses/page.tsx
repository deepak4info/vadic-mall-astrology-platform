"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import toast from "react-hot-toast";
import { MapPin, Plus } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import { AddressListSkeleton, Skeleton } from "@/components/ui/skeleton";
import { useAuthStore, useAuthHydrated } from "@/store/auth";
import { useCustomerData } from "@/lib/hooks";
import { customerPost, getApiErrorMessage } from "@/lib/api";
import { useQueryClient } from "@tanstack/react-query";
import type { Address } from "@/lib/types";

const emptyForm = { fullName: "", phone: "", addressLine1: "", addressLine2: "", city: "", state: "", pincode: "", country: "India", isDefault: false };

export default function AddressesPage() {
  const router = useRouter();
  const queryClient = useQueryClient();
  const { user } = useAuthStore();
  const hydrated = useAuthHydrated();
  const enabled = !!user;
  const [showForm, setShowForm] = useState(false);
  const [loading, setLoading] = useState(false);
  const [form, setForm] = useState(emptyForm);

  const { data: addresses = [], isLoading } = useCustomerData<Address[]>("addresses", "/addresses", enabled);

  useEffect(() => {
    if (hydrated && !user) router.push("/login");
  }, [hydrated, user, router]);

  if (!hydrated || !user) {
    return (
      <div className="mx-auto max-w-3xl px-4 py-12 lg:px-8">
        <Skeleton className="mb-4 h-8 w-40" />
        <div className="mb-8 flex gap-2">
          <Skeleton className="h-9 w-24 rounded-full" />
          <Skeleton className="h-9 w-24 rounded-full" />
          <Skeleton className="h-9 w-24 rounded-full" />
        </div>
        <AddressListSkeleton />
      </div>
    );
  }

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      await customerPost("/addresses", form);
      toast.success("Address added");
      queryClient.invalidateQueries({ queryKey: ["customer", "addresses"] });
      setForm(emptyForm);
      setShowForm(false);
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Failed to add address"));
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="mx-auto max-w-3xl px-4 py-12 lg:px-8">
      <h1 className="section-title mb-4">Addresses</h1>
      <div className="mb-8 flex gap-2 text-sm">
        <Link href="/customer" className="rounded-full bg-gray-100 px-4 py-2 font-medium text-gray-600 hover:bg-gray-200">Dashboard</Link>
        <Link href="/customer/addresses" className="rounded-full bg-saffron px-4 py-2 font-medium text-white">Addresses</Link>
        <Link href="/customer/settings" className="rounded-full bg-gray-100 px-4 py-2 font-medium text-gray-600 hover:bg-gray-200">Settings</Link>
      </div>

      {isLoading ? (
        <AddressListSkeleton />
      ) : (
        <div className="animate-fade-in space-y-4">
          {addresses.length === 0 && !showForm && (
            <div className="rounded-2xl border border-dashed py-12 text-center text-gray-500">No saved addresses yet.</div>
          )}
          {addresses.map((addr) => (
            <Card key={addr.id}>
              <CardContent className="flex items-start gap-4 p-6">
                <MapPin className="mt-0.5 h-5 w-5 shrink-0 text-saffron" />
                <div>
                  <div className="flex items-center gap-2">
                    <p className="font-semibold text-krishna">{addr.fullName}</p>
                    {addr.isDefault && <span className="rounded-full bg-saffron/10 px-2 py-0.5 text-xs font-medium text-saffron">Default</span>}
                  </div>
                  <p className="text-sm text-gray-500">{addr.phone}</p>
                  <p className="mt-1 text-sm text-gray-600">{addr.addressLine1}{addr.addressLine2 ? `, ${addr.addressLine2}` : ""}</p>
                  <p className="text-sm text-gray-600">{addr.city}, {addr.state} {addr.pincode}, {addr.country}</p>
                </div>
              </CardContent>
            </Card>
          ))}

          {showForm ? (
            <Card>
              <CardContent className="p-6">
                <form onSubmit={handleSubmit} className="space-y-4">
                  <div className="grid grid-cols-2 gap-4">
                    <div><label className="mb-1 block text-sm font-medium">Full Name</label><Input required value={form.fullName} onChange={(e) => setForm({ ...form, fullName: e.target.value })} /></div>
                    <div><label className="mb-1 block text-sm font-medium">Phone</label><Input required value={form.phone} onChange={(e) => setForm({ ...form, phone: e.target.value })} /></div>
                  </div>
                  <div><label className="mb-1 block text-sm font-medium">Address Line 1</label><Input required value={form.addressLine1} onChange={(e) => setForm({ ...form, addressLine1: e.target.value })} /></div>
                  <div><label className="mb-1 block text-sm font-medium">Address Line 2 (Optional)</label><Input value={form.addressLine2} onChange={(e) => setForm({ ...form, addressLine2: e.target.value })} /></div>
                  <div className="grid grid-cols-3 gap-4">
                    <div><label className="mb-1 block text-sm font-medium">City</label><Input required value={form.city} onChange={(e) => setForm({ ...form, city: e.target.value })} /></div>
                    <div><label className="mb-1 block text-sm font-medium">State</label><Input required value={form.state} onChange={(e) => setForm({ ...form, state: e.target.value })} /></div>
                    <div><label className="mb-1 block text-sm font-medium">Pincode</label><Input required value={form.pincode} onChange={(e) => setForm({ ...form, pincode: e.target.value })} /></div>
                  </div>
                  <label className="flex items-center gap-2 text-sm text-gray-600">
                    <input type="checkbox" checked={form.isDefault} onChange={(e) => setForm({ ...form, isDefault: e.target.checked })} />
                    Set as default address
                  </label>
                  <div className="flex gap-3">
                    <Button type="submit" disabled={loading}>{loading ? "Saving..." : "Save Address"}</Button>
                    <Button type="button" variant="outline" onClick={() => setShowForm(false)}>Cancel</Button>
                  </div>
                </form>
              </CardContent>
            </Card>
          ) : (
            <Button variant="outline" onClick={() => setShowForm(true)}><Plus className="mr-2 h-4 w-4" /> Add New Address</Button>
          )}
        </div>
      )}
    </div>
  );
}
