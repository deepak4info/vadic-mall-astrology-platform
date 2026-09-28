"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { Package, Calendar, Star, User, CreditCard } from "lucide-react";
import { Card, CardContent } from "@/components/ui/card";
import { DashboardSkeleton } from "@/components/ui/skeleton";
import { useAuthStore, useAuthHydrated } from "@/store/auth";
import { useCustomerData } from "@/lib/hooks";
import { formatPrice } from "@/lib/utils";
import type { UserSubscription } from "@/lib/types";

export default function CustomerDashboard() {
  const router = useRouter();
  const { user } = useAuthStore();
  const hydrated = useAuthHydrated();
  const enabled = !!user;

  const { data: orders = [], isLoading: ordersLoading } = useCustomerData<
    { id: string; orderNumber: string; status: string; total: number; createdAt: string }[]
  >("orders", "/orders", enabled);

  const { data: bookings = [], isLoading: bookingsLoading } = useCustomerData<
    { id: string; serviceName: string; scheduledDate: string; status: string; amount: number }[]
  >("bookings", "/pooja-bookings", enabled);

  const { data: kundlis = [], isLoading: kundlisLoading } = useCustomerData<
    { id: string; name: string; status: string; amount: number; createdAt: string }[]
  >("kundlis", "/kundli-requests", enabled);

  const { data: subscriptions = [], isLoading: subscriptionsLoading } = useCustomerData<UserSubscription[]>("subscriptions", "/subscriptions", enabled);

  useEffect(() => {
    if (hydrated && !user) router.push("/login");
  }, [hydrated, user, router]);

  if (!hydrated || !user || ordersLoading || bookingsLoading || kundlisLoading || subscriptionsLoading) return <DashboardSkeleton tiles={4} tabs />;

  return (
    <div className="mx-auto max-w-7xl animate-fade-in px-4 py-12 lg:px-8">
      <div className="mb-6 flex items-center gap-4">
        <div className="flex h-14 w-14 items-center justify-center rounded-full bg-saffron/10"><User className="h-7 w-7 text-saffron" /></div>
        <div>
          <h1 className="font-heading text-2xl font-bold text-krishna">Welcome, {user.firstName}!</h1>
          <p className="text-gray-500">{user.email}</p>
        </div>
      </div>

      <div className="mb-8 flex gap-2 text-sm">
        <Link href="/customer" className="rounded-full bg-saffron px-4 py-2 font-medium text-white">Dashboard</Link>
        <Link href="/customer/addresses" className="rounded-full bg-gray-100 px-4 py-2 font-medium text-gray-600 hover:bg-gray-200">Addresses</Link>
        <Link href="/customer/settings" className="rounded-full bg-gray-100 px-4 py-2 font-medium text-gray-600 hover:bg-gray-200">Settings</Link>
      </div>

      <div className="mb-10 grid gap-6 md:grid-cols-4">
        {[
          { icon: Package, label: "My Orders", count: orders.length },
          { icon: Calendar, label: "Pooja Bookings", count: bookings.length },
          { icon: Star, label: "Kundli Requests", count: kundlis.length },
          { icon: CreditCard, label: "Subscriptions", count: subscriptions.length },
        ].map((stat) => (
          <Card key={stat.label}>
            <CardContent className="flex items-center gap-4 p-6">
              <stat.icon className="h-8 w-8 text-saffron" />
              <div><p className="text-2xl font-bold text-krishna">{stat.count}</p><p className="text-sm text-gray-500">{stat.label}</p></div>
            </CardContent>
          </Card>
        ))}
      </div>

      <div className="grid gap-8 lg:grid-cols-2">
        <Section title="Recent Orders" empty="No orders yet." items={orders.map((o) => ({ key: o.id, href: `/customer/orders/${o.id}`, title: o.orderNumber, sub: new Date(o.createdAt).toLocaleDateString(), value: formatPrice(o.total), status: o.status }))} />
        <Section title="Pooja Bookings" empty="No bookings yet." items={bookings.map((b) => ({ key: b.id, title: b.serviceName, sub: new Date(b.scheduledDate).toLocaleDateString(), value: formatPrice(b.amount), status: b.status }))} />
      </div>

      <div className="mt-8">
        <h2 className="mb-4 font-heading text-lg font-semibold text-krishna">My Subscriptions</h2>
        {subscriptions.length === 0 ? (
          <p className="text-gray-500">No active subscriptions. <Link href="/subscription" className="text-saffron hover:underline">Browse plans</Link></p>
        ) : (
          <div className="grid gap-4 sm:grid-cols-2 lg:grid-cols-3">
            {subscriptions.map((s) => (
              <div key={s.id} className="rounded-xl border bg-white p-4">
                <p className="font-medium text-krishna">{s.planName}</p>
                <p className="text-sm text-gray-500">{new Date(s.startDate).toLocaleDateString()} – {new Date(s.endDate).toLocaleDateString()}</p>
                <div className="mt-2 flex items-center justify-between">
                  <span className="font-semibold">{formatPrice(s.price)}</span>
                  <span className="text-xs font-medium text-saffron">{s.status}</span>
                </div>
              </div>
            ))}
          </div>
        )}
      </div>
    </div>
  );
}

function Section({ title, empty, items }: { title: string; empty: string; items: { key: string; href?: string; title: string; sub: string; value: string; status: string }[] }) {
  return (
    <div>
      <h2 className="mb-4 font-heading text-lg font-semibold text-krishna">{title}</h2>
      {items.length === 0 ? <p className="text-gray-500">{empty}</p> : (
        <div className="space-y-3">
          {items.map((item) => {
            const row = (
              <div className="flex items-center justify-between rounded-xl border bg-white p-4 transition-colors hover:border-saffron">
                <div><p className="font-medium text-krishna">{item.title}</p><p className="text-sm text-gray-500">{item.sub}</p></div>
                <div className="text-right"><p className="font-semibold">{item.value}</p><p className="text-xs text-saffron">{item.status}</p></div>
              </div>
            );
            return item.href ? <Link key={item.key} href={item.href}>{row}</Link> : <div key={item.key}>{row}</div>;
          })}
        </div>
      )}
    </div>
  );
}
