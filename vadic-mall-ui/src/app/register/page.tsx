"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import toast from "react-hot-toast";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import { useAuthStore } from "@/store/auth";

export default function RegisterPage() {
  const router = useRouter();
  const { register, isLoading } = useAuthStore();
  const [form, setForm] = useState({ email: "", password: "", firstName: "", lastName: "", phone: "" });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await register(form);
      toast.success("Account created!");
      router.push("/");
    } catch {
      toast.error("Registration failed");
    }
  };

  return (
    <div className="flex min-h-[70vh] items-center justify-center px-4 py-12">
      <Card className="w-full max-w-md">
        <CardContent className="p-8">
          <h1 className="mb-6 text-center font-heading text-2xl font-bold text-krishna">Create Account</h1>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div className="grid grid-cols-2 gap-4">
              <div><label className="mb-1 block text-sm font-medium">First Name</label><Input required value={form.firstName} onChange={(e) => setForm({ ...form, firstName: e.target.value })} /></div>
              <div><label className="mb-1 block text-sm font-medium">Last Name</label><Input required value={form.lastName} onChange={(e) => setForm({ ...form, lastName: e.target.value })} /></div>
            </div>
            <div><label className="mb-1 block text-sm font-medium">Email</label><Input type="email" autoComplete="email" required value={form.email} onChange={(e) => setForm({ ...form, email: e.target.value })} /></div>
            <div><label className="mb-1 block text-sm font-medium">Phone</label><Input autoComplete="tel" value={form.phone} onChange={(e) => setForm({ ...form, phone: e.target.value })} /></div>
            <div><label className="mb-1 block text-sm font-medium">Password</label><Input type="password" autoComplete="new-password" required minLength={6} value={form.password} onChange={(e) => setForm({ ...form, password: e.target.value })} /></div>
            <Button type="submit" disabled={isLoading} className="w-full">{isLoading ? "Creating..." : "Register"}</Button>
          </form>
          <p className="mt-4 text-center text-sm text-gray-500">
            Already have an account? <Link href="/login" className="text-saffron hover:underline">Login</Link>
          </p>
          <p className="mt-2 text-center text-sm">
            <Link href="/register-astrologer" className="text-saffron hover:underline">Register as Astrologer</Link>
          </p>
        </CardContent>
      </Card>
    </div>
  );
}
