"use client";

import Link from "next/link";
import { Minus, Plus, Trash2, ShoppingBag } from "lucide-react";
import { Button } from "@/components/ui/button";
import { useCartStore } from "@/store/cart";
import { formatPrice, getImageUrl, checkImageAlreadyFailed } from "@/lib/utils";

export default function CartPage() {
  const { items, updateQuantity, removeItem, subTotal, itemCount } = useCartStore();
  const shipping = subTotal() >= 999 ? 0 : 99;
  const total = subTotal() + shipping;

  if (items.length === 0) {
    return (
      <div className="mx-auto max-w-7xl px-4 py-20 text-center">
        <ShoppingBag className="mx-auto h-16 w-16 text-gray-300" />
        <h1 className="mt-4 font-heading text-2xl font-bold text-krishna">Your cart is empty</h1>
        <p className="mt-2 text-gray-500">Explore our spiritual products and add items to your cart</p>
        <Link href="/products"><Button className="mt-6">Shop Products</Button></Link>
      </div>
    );
  }

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <h1 className="section-title mb-8">Shopping Cart ({itemCount()} items)</h1>
      <div className="grid gap-8 lg:grid-cols-3">
        <div className="space-y-4 lg:col-span-2">
          {items.map((item) => (
            <div key={item.productId} className="flex items-center gap-4 rounded-2xl border bg-white p-4 shadow-sm">
              <div className="relative flex h-20 w-20 shrink-0 items-center justify-center overflow-hidden rounded-xl bg-gray-50 text-2xl">
                <span className="absolute inset-0 flex items-center justify-center">📿</span>
                {item.imageUrl && (
                  // eslint-disable-next-line @next/next/no-img-element
                  <img
                    ref={(el) => checkImageAlreadyFailed(el, () => { if (el) el.style.display = "none"; })}
                    src={getImageUrl(item.imageUrl)}
                    alt={item.name}
                    className="absolute inset-0 h-full w-full object-cover"
                    onError={(e) => { e.currentTarget.style.display = "none"; }}
                  />
                )}
              </div>
              <div className="flex-1">
                <h3 className="font-semibold text-krishna">{item.name}</h3>
                <p className="text-sm text-saffron">{formatPrice(item.salePrice ?? item.price)}</p>
              </div>
              <div className="flex items-center gap-2">
                <button onClick={() => updateQuantity(item.productId, item.quantity - 1)} className="rounded-lg border p-1 hover:bg-gray-50"><Minus className="h-4 w-4" /></button>
                <span className="w-8 text-center font-medium">{item.quantity}</span>
                <button onClick={() => updateQuantity(item.productId, item.quantity + 1)} className="rounded-lg border p-1 hover:bg-gray-50"><Plus className="h-4 w-4" /></button>
              </div>
              <p className="w-24 text-right font-semibold">{formatPrice((item.salePrice ?? item.price) * item.quantity)}</p>
              <button onClick={() => removeItem(item.productId)} className="text-red-400 hover:text-red-600"><Trash2 className="h-5 w-5" /></button>
            </div>
          ))}
        </div>

        <div className="rounded-2xl border bg-white p-6 shadow-sm h-fit">
          <h2 className="font-heading text-lg font-semibold text-krishna">Order Summary</h2>
          <div className="mt-4 space-y-2 text-sm">
            <div className="flex justify-between"><span>Subtotal</span><span>{formatPrice(subTotal())}</span></div>
            <div className="flex justify-between"><span>Shipping</span><span>{shipping === 0 ? "FREE" : formatPrice(shipping)}</span></div>
            {subTotal() < 999 && <p className="text-xs text-saffron">Add {formatPrice(999 - subTotal())} more for free shipping</p>}
            <div className="flex justify-between border-t pt-2 font-semibold text-krishna"><span>Total</span><span>{formatPrice(total)}</span></div>
          </div>
          <Link href="/checkout" className="mt-6 block"><Button className="w-full" size="lg">Proceed to Checkout</Button></Link>
        </div>
      </div>
    </div>
  );
}
