"use client";

import { useRouter } from "next/navigation";
import toast from "react-hot-toast";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { CardGridSkeleton, PlanCardSkeleton } from "@/components/ui/skeleton";
import { useCatalog } from "@/lib/hooks";
import { customerPost, getApiErrorMessage } from "@/lib/api";
import { useAuthStore } from "@/store/auth";
import type { SubscriptionPlan } from "@/lib/types";

export default function SubscriptionPage() {
  const router = useRouter();
  const { user } = useAuthStore();
  const { data: plans = [], isLoading } = useCatalog<SubscriptionPlan[]>("plans", "/catalog/subscription-plans");

  const subscribe = async (plan: SubscriptionPlan) => {
    if (!user) { router.push("/login"); return; }
    try {
      await customerPost("/subscriptions", { subscriptionPlanId: plan.id, paymentMethod: "UPI" });
      toast.success(`Subscribed to ${plan.name}!`);
      router.push("/customer");
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Subscription failed"));
    }
  };

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <div className="mb-10 text-center">
        <h1 className="section-title">Subscription Plans</h1>
        <p className="mt-2 text-gray-500">Unlock premium astrology services with our subscription plans</p>
      </div>
      {isLoading ? (
        <CardGridSkeleton Card={PlanCardSkeleton} count={5} className="grid gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5" />
      ) : (
        <div className="grid animate-fade-in gap-6 md:grid-cols-2 lg:grid-cols-3 xl:grid-cols-5">
          {plans.map((plan) => (
            <Card key={plan.id} className={`relative ${plan.isPopular ? "border-saffron ring-2 ring-saffron" : ""}`}>
              {plan.isPopular && <Badge className="absolute -top-3 left-1/2 -translate-x-1/2">Most Popular</Badge>}
              <CardContent className="p-6 text-center">
                <h3 className="font-heading text-lg font-semibold text-krishna">{plan.name}</h3>
                <p className="mt-4 font-heading text-3xl font-bold text-saffron">₹{plan.price}<span className="text-sm font-normal text-gray-400">/mo</span></p>
                <p className="mt-2 text-sm text-gray-500">{plan.description}</p>
                <ul className="mt-4 space-y-2 text-left text-sm text-gray-600">
                  {plan.features.map((f) => <li key={f}>✓ {f}</li>)}
                </ul>
                <Button className="mt-6 w-full" variant={plan.isPopular ? "default" : "outline"} onClick={() => subscribe(plan)}>Subscribe</Button>
              </CardContent>
            </Card>
          ))}
        </div>
      )}
    </div>
  );
}
