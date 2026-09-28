"use client";

import { useEffect } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import { ArrowLeft, CheckCircle2, Circle } from "lucide-react";
import { Card, CardContent } from "@/components/ui/card";
import { OrderDetailSkeleton } from "@/components/ui/skeleton";
import { useAuthStore, useAuthHydrated } from "@/store/auth";
import { useCustomerData } from "@/lib/hooks";
import { formatPrice, getImageUrl, checkImageAlreadyFailed } from "@/lib/utils";
import type { OrderTracking } from "@/lib/types";

interface OrderDetail {
  id: string;
  orderNumber: string;
  status: string;
  total: number;
  createdAt: string;
  items: { productId: string; productName: string; quantity: number; unitPrice: number; totalPrice: number; imageUrl?: string }[];
}

export default function OrderDetailPageClient({ params }: { params: { id: string } }) {
  const router = useRouter();
  const { user } = useAuthStore();
  const hydrated = useAuthHydrated();
  const enabled = !!user;

  const { data: order, isLoading: orderLoading } = useCustomerData<OrderDetail>(`order-${params.id}`, `/orders/${params.id}`, enabled);
  const { data: tracking = [], isLoading: trackingLoading } = useCustomerData<OrderTracking[]>(`order-${params.id}-tracking`, `/orders/${params.id}/tracking`, enabled);

  useEffect(() => {
    if (hydrated && !user) router.push("/login");
  }, [hydrated, user, router]);

  if (!hydrated || !user || orderLoading || trackingLoading) return <OrderDetailSkeleton />;
  if (!order) return <div className="py-20 text-center text-gray-500">Order not found.</div>;

  return (
    <div className="mx-auto max-w-3xl animate-fade-in px-4 py-12 lg:px-8">
      <Link href="/customer" className="mb-6 inline-flex items-center gap-2 text-sm text-saffron hover:underline">
        <ArrowLeft className="h-4 w-4" /> Back to Dashboard
      </Link>

      <div className="mb-6 flex items-center justify-between">
        <div>
          <h1 className="font-heading text-2xl font-bold text-krishna">{order.orderNumber}</h1>
          <p className="text-sm text-gray-500">{new Date(order.createdAt).toLocaleString()}</p>
        </div>
        <span className="rounded-full bg-saffron/10 px-4 py-1.5 text-sm font-semibold text-saffron">{order.status}</span>
      </div>

      <Card className="mb-6">
        <CardContent className="p-6">
          <h2 className="mb-4 font-heading text-lg font-semibold text-krishna">Items</h2>
          <div className="space-y-3">
            {order.items.map((item) => (
              <div key={item.productId} className="flex items-center gap-3 text-sm">
                <div className="relative flex h-12 w-12 shrink-0 items-center justify-center overflow-hidden rounded-lg bg-gray-50 text-lg">
                  <span className="absolute inset-0 flex items-center justify-center">📿</span>
                  {item.imageUrl && (
                    // eslint-disable-next-line @next/next/no-img-element
                    <img
                      ref={(el) => checkImageAlreadyFailed(el, () => { if (el) el.style.display = "none"; })}
                      src={getImageUrl(item.imageUrl)}
                      alt={item.productName}
                      className="absolute inset-0 h-full w-full object-cover"
                      onError={(e) => { e.currentTarget.style.display = "none"; }}
                    />
                  )}
                </div>
                <div className="flex flex-1 items-center justify-between">
                  <div>
                    <p className="font-medium text-krishna">{item.productName}</p>
                    <p className="text-gray-500">Qty {item.quantity} × {formatPrice(item.unitPrice)}</p>
                  </div>
                  <p className="font-semibold">{formatPrice(item.totalPrice)}</p>
                </div>
              </div>
            ))}
          </div>
          <div className="mt-4 flex justify-between border-t pt-4 font-semibold text-krishna">
            <span>Total</span>
            <span>{formatPrice(order.total)}</span>
          </div>
        </CardContent>
      </Card>

      <Card>
        <CardContent className="p-6">
          <h2 className="mb-4 font-heading text-lg font-semibold text-krishna">Tracking</h2>
          {tracking.length === 0 ? (
            <p className="text-sm text-gray-500">No tracking updates yet.</p>
          ) : (
            <div className="space-y-4">
              {tracking.map((t, i) => (
                <div key={i} className="flex gap-3">
                  {i === tracking.length - 1 ? (
                    <CheckCircle2 className="mt-0.5 h-5 w-5 shrink-0 text-saffron" />
                  ) : (
                    <Circle className="mt-0.5 h-5 w-5 shrink-0 text-gray-300" />
                  )}
                  <div>
                    <p className="font-medium text-krishna">{t.status}</p>
                    {t.notes && <p className="text-sm text-gray-500">{t.notes}</p>}
                    {t.location && <p className="text-sm text-gray-500">{t.location}</p>}
                    <p className="text-xs text-gray-400">{new Date(t.createdAt).toLocaleString()}</p>
                  </div>
                </div>
              ))}
            </div>
          )}
        </CardContent>
      </Card>
    </div>
  );
}
