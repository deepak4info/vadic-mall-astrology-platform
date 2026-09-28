"use client";

import { useState } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import toast from "react-hot-toast";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { useAuthStore } from "@/store/auth";
import { getApiErrorMessage } from "@/lib/api";

export default function LoginPage() {
  const router = useRouter();
  const { login, isLoading } = useAuthStore();
  const [email, setEmail] = useState("");
  const [password, setPassword] = useState("");
  const [errorMessage, setErrorMessage] = useState<string | null>(null);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    try {
      await login(email, password);
      toast.success("Welcome back!");
      router.push("/");
    } catch (error) {
      setErrorMessage(getApiErrorMessage(error, "Invalid email or password"));
    }
  };

  return (
    <div className="flex min-h-[70vh] items-center justify-center px-4 py-12">
      <Card className="w-full max-w-md">
        <CardContent className="p-8">
          <div className="mb-6 text-center">
            <h1 className="font-heading text-2xl font-bold text-krishna">Welcome Back</h1>
            <p className="mt-1 text-sm text-gray-500">Sign in to your Vadic Mall account</p>
          </div>
          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <label className="mb-1 block text-sm font-medium">Email</label>
              <Input type="email" autoComplete="email" required value={email} onChange={(e) => setEmail(e.target.value)} placeholder="you@example.com" />
            </div>
            <div>
              <label className="mb-1 block text-sm font-medium">Password</label>
              <Input type="password" autoComplete="current-password" required value={password} onChange={(e) => setPassword(e.target.value)} />
            </div>
            <Button type="submit" disabled={isLoading} className="w-full">{isLoading ? "Signing in..." : "Sign In"}</Button>
          </form>
          <div className="mt-6 rounded-xl bg-gray-50 p-4 text-xs text-gray-500">
            <p className="font-semibold text-krishna">Demo Accounts:</p>
            <p>Admin: admin@vadicmall.com / Admin@123</p>
            <p>Customer: customer@vadicmall.com / Customer@123</p>
          </div>
          <p className="mt-4 text-center text-sm text-gray-500">
            Don&apos;t have an account? <Link href="/register" className="text-saffron hover:underline">Register</Link>
          </p>
        </CardContent>
      </Card>

      <Dialog open={!!errorMessage} onOpenChange={(open) => !open && setErrorMessage(null)}>
        <DialogContent>
          <DialogHeader>
            <DialogTitle>Login Failed</DialogTitle>
          </DialogHeader>
          <p className="text-sm text-gray-600">{errorMessage}</p>
          <Button className="mt-6 w-full" onClick={() => setErrorMessage(null)}>OK</Button>
        </DialogContent>
      </Dialog>
    </div>
  );
}
