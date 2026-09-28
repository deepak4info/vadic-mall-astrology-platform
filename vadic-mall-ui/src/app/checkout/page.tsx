"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import Link from "next/link";
import toast from "react-hot-toast";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Skeleton } from "@/components/ui/skeleton";
import { useCartStore } from "@/store/cart";
import { useAuthStore } from "@/store/auth";
import { useCustomerData } from "@/lib/hooks";
import { customerDelete, customerPost, postCatalog, getApiErrorMessage } from "@/lib/api";
import { formatPrice } from "@/lib/utils";
import type { Address } from "@/lib/types";

interface CouponValidation {
  isValid: boolean;
  message: string;
  discountAmount: number;
  couponCode: string | null;
}

interface GiftCardValidation {
  isValid: boolean;
  message: string;
  balance: number;
  code: string | null;
}

export default function CheckoutPage() {
  const router = useRouter();
  const { items, subTotal, clearCart } = useCartStore();
  const { user } = useAuthStore();
  const [loading, setLoading] = useState(false);
  const [coupon, setCoupon] = useState("");
  const [couponResult, setCouponResult] = useState<CouponValidation | null>(null);
  const [validatingCoupon, setValidatingCoupon] = useState(false);
  const [giftCard, setGiftCard] = useState("");
  const [giftCardResult, setGiftCardResult] = useState<GiftCardValidation | null>(null);
  const [validatingGiftCard, setValidatingGiftCard] = useState(false);
  const [paymentMethod, setPaymentMethod] = useState("UPI");
  const [addressId, setAddressId] = useState<string | null>(null);

  const { data: addresses = [], isLoading: addressesLoading } = useCustomerData<Address[]>("addresses", "/addresses", !!user);

  useEffect(() => {
    if (addresses.length > 0 && !addressId) {
      setAddressId(addresses.find((a) => a.isDefault)?.id ?? addresses[0].id);
    }
  }, [addresses, addressId]);

  const shipping = subTotal() >= 999 ? 0 : 99;
  const discount = couponResult?.isValid ? couponResult.discountAmount : 0;
  const totalBeforeGiftCard = Math.max(subTotal() + shipping - discount, 0);
  const giftCardApplied = giftCardResult?.isValid ? Math.min(giftCardResult.balance, totalBeforeGiftCard) : 0;
  const total = Math.max(totalBeforeGiftCard - giftCardApplied, 0);

  const handleValidateCoupon = async () => {
    if (!coupon.trim()) return;
    setValidatingCoupon(true);
    try {
      const result = await postCatalog<CouponValidation>("/catalog/coupons/validate", { code: coupon, orderTotal: subTotal() });
      setCouponResult(result);
      if (result.isValid) toast.success(result.message);
      else toast.error(result.message);
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Could not validate coupon"));
    } finally {
      setValidatingCoupon(false);
    }
  };

  const handleValidateGiftCard = async () => {
    if (!giftCard.trim()) return;
    setValidatingGiftCard(true);
    try {
      const result = await postCatalog<GiftCardValidation>("/catalog/gift-cards/validate", { code: giftCard });
      setGiftCardResult(result);
      if (result.isValid) toast.success(result.message);
      else toast.error(result.message);
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Could not validate gift card"));
    } finally {
      setValidatingGiftCard(false);
    }
  };

  const handlePlaceOrder = async () => {
    if (!user) { router.push("/login"); return; }
    if (items.length === 0) { toast.error("Cart is empty"); return; }

    setLoading(true);
    try {
      await customerDelete("/cart/clear");
      for (const item of items) {
        await customerPost("/cart", { productId: item.productId, quantity: item.quantity });
      }
      await customerPost("/orders", {
        shippingAddressId: addressId,
        couponCode: couponResult?.isValid ? couponResult.couponCode ?? coupon : undefined,
        giftCardCode: giftCardResult?.isValid ? giftCardResult.code ?? giftCard : undefined,
        paymentMethod,
      });
      clearCart();
      toast.success("Order placed successfully!");
      router.push("/customer");
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Order failed"));
    } finally {
      setLoading(false);
    }
  };

  if (items.length === 0) {
    return (
      <div className="py-20 text-center">
        <p className="text-gray-500">Your cart is empty.</p>
        <Button className="mt-4" onClick={() => router.push("/products")}>Shop Now</Button>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-3xl px-4 py-12">
      <h1 className="section-title mb-8">Checkout</h1>
      <div className="space-y-6">
        <div className="rounded-2xl border bg-white p-6">
          <div className="flex items-center justify-between">
            <h2 className="font-semibold text-krishna">Shipping Address</h2>
            <Link href="/customer/addresses" className="text-xs text-saffron hover:underline">Manage addresses</Link>
          </div>
          {addressesLoading ? (
            <div className="mt-4 space-y-2">
              <Skeleton className="h-16 w-full rounded-xl" />
              <Skeleton className="h-16 w-full rounded-xl" />
            </div>
          ) : addresses.length === 0 ? (
            <p className="mt-3 text-sm text-gray-500">No saved address. <Link href="/customer/addresses" className="text-saffron hover:underline">Add one</Link> or continue without one.</p>
          ) : (
            <div className="mt-4 animate-fade-in space-y-2">
              {addresses.map((addr) => (
                <label key={addr.id} className={`flex cursor-pointer items-start gap-3 rounded-xl border-2 p-3 text-sm transition-all ${addressId === addr.id ? "border-saffron bg-saffron/5" : "border-gray-200 hover:border-gray-300"}`}>
                  <input type="radio" name="address" className="mt-1" checked={addressId === addr.id} onChange={() => setAddressId(addr.id)} />
                  <div>
                    <p className="font-medium text-krishna">{addr.fullName} <span className="font-normal text-gray-500">· {addr.phone}</span></p>
                    <p className="text-gray-500">{addr.addressLine1}{addr.addressLine2 ? `, ${addr.addressLine2}` : ""}, {addr.city}, {addr.state} {addr.pincode}</p>
                  </div>
                </label>
              ))}
            </div>
          )}
        </div>

        <div className="rounded-2xl border bg-white p-6">
          <h2 className="font-semibold text-krishna">Payment Method</h2>
          <div className="mt-4 grid grid-cols-2 gap-3 sm:grid-cols-4">
            {["UPI", "Card", "Net Banking", "COD"].map((m) => (
              <button key={m} type="button" onClick={() => setPaymentMethod(m)} className={`rounded-xl border-2 p-3 text-sm font-medium transition-all ${paymentMethod === m ? "border-saffron bg-saffron/5 text-saffron" : "border-gray-200 hover:border-gray-300"}`}>{m}</button>
            ))}
          </div>
        </div>

        <div className="rounded-2xl border bg-white p-6">
          <h2 className="font-semibold text-krishna">Coupon Code</h2>
          <div className="mt-3 flex gap-3">
            <Input placeholder="Enter coupon code (e.g. WELCOME100)" value={coupon} onChange={(e) => { setCoupon(e.target.value); setCouponResult(null); }} />
            <Button type="button" variant="outline" disabled={validatingCoupon || !coupon.trim()} onClick={handleValidateCoupon}>
              {validatingCoupon ? "Checking..." : "Apply"}
            </Button>
          </div>
          {couponResult && (
            <p className={`mt-2 text-sm ${couponResult.isValid ? "text-green-600" : "text-red-500"}`}>{couponResult.message}</p>
          )}
        </div>

        <div className="rounded-2xl border bg-white p-6">
          <h2 className="font-semibold text-krishna">Gift Card</h2>
          <div className="mt-3 flex gap-3">
            <Input placeholder="Enter gift card code" value={giftCard} onChange={(e) => { setGiftCard(e.target.value); setGiftCardResult(null); }} />
            <Button type="button" variant="outline" disabled={validatingGiftCard || !giftCard.trim()} onClick={handleValidateGiftCard}>
              {validatingGiftCard ? "Checking..." : "Apply"}
            </Button>
          </div>
          {giftCardResult && (
            <p className={`mt-2 text-sm ${giftCardResult.isValid ? "text-green-600" : "text-red-500"}`}>{giftCardResult.message}</p>
          )}
        </div>

        <div className="rounded-2xl border bg-white p-6">
          <h2 className="font-semibold text-krishna">Order Total</h2>
          <div className="mt-3 space-y-2 text-sm">
            <div className="flex justify-between"><span>Subtotal ({items.length} items)</span><span>{formatPrice(subTotal())}</span></div>
            <div className="flex justify-between"><span>Shipping</span><span>{shipping === 0 ? "FREE" : formatPrice(shipping)}</span></div>
            {discount > 0 && <div className="flex justify-between text-green-600"><span>Coupon Discount</span><span>-{formatPrice(discount)}</span></div>}
            {giftCardApplied > 0 && <div className="flex justify-between text-green-600"><span>Gift Card Applied</span><span>-{formatPrice(giftCardApplied)}</span></div>}
            <div className="flex justify-between border-t pt-2 text-lg font-bold text-krishna"><span>Total</span><span>{formatPrice(total)}</span></div>
          </div>
          <Button onClick={handlePlaceOrder} disabled={loading} className="mt-6 w-full" size="lg">
            {loading ? "Processing..." : `Place Order — ${formatPrice(total)}`}
          </Button>
        </div>
      </div>
    </div>
  );
}
