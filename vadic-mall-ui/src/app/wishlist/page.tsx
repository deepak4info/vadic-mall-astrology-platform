"use client";

import { useEffect } from "react";
import Link from "next/link";
import { useRouter } from "next/navigation";
import { Heart, ShoppingCart, Star, Trash2 } from "lucide-react";
import toast from "react-hot-toast";
import { Card, CardContent } from "@/components/ui/card";
import { Button } from "@/components/ui/button";
import { CardGridSkeleton, ProductCardSkeleton } from "@/components/ui/skeleton";
import { formatPrice, getDiscountPercent, getImageUrl, checkImageAlreadyFailed } from "@/lib/utils";
import { useAuthStore, useAuthHydrated } from "@/store/auth";
import { useCartStore } from "@/store/cart";
import { useWishlist } from "@/lib/wishlist";

export default function WishlistPage() {
  const router = useRouter();
  const hydrated = useAuthHydrated();
  const { user } = useAuthStore();
  const { items, isLoading, toggle } = useWishlist();
  const addItem = useCartStore((s) => s.addItem);

  useEffect(() => {
    if (hydrated && !user) router.push("/login");
  }, [hydrated, user, router]);

  return (
    <div className="mx-auto max-w-7xl animate-fade-in px-4 py-12 lg:px-8">
      <div className="mb-10 text-center">
        <h1 className="section-title">My Wishlist</h1>
        <p className="mt-2 text-gray-500">Products you&apos;ve saved for later</p>
      </div>

      {!hydrated || !user || isLoading ? (
        <CardGridSkeleton Card={ProductCardSkeleton} count={4} />
      ) : items.length === 0 ? (
        <div className="rounded-2xl border border-dashed py-20 text-center">
          <Heart className="mx-auto h-10 w-10 text-gray-300" />
          <p className="mt-4 text-gray-500">Your wishlist is empty.</p>
          <Link href="/products" className="mt-4 inline-block">
            <Button variant="maroon">Browse Products</Button>
          </Link>
        </div>
      ) : (
        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
          {items.map((item) => {
            const discount = getDiscountPercent(item.price, item.salePrice);
            const displayPrice = item.salePrice ?? item.price;
            return (
              <Card key={item.productId} className="overflow-hidden">
                <Link href={`/products/${item.productId}`} className="relative block h-48 overflow-hidden bg-gradient-to-br from-krishna/5 to-saffron/10">
                  <div className="absolute inset-0 flex items-center justify-center text-5xl opacity-40">📿</div>
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
                  {discount > 0 && (
                    <span className="absolute right-3 top-3 rounded-full bg-red-100 px-2.5 py-0.5 text-xs font-semibold text-red-700">
                      {discount}% OFF
                    </span>
                  )}
                </Link>
                <CardContent className="p-5">
                  <Link href={`/products/${item.productId}`}>
                    <h3 className="font-heading text-lg font-semibold text-krishna hover:text-maroon">{item.productName}</h3>
                  </Link>
                  <div className="mt-2 flex items-center gap-1 text-sm">
                    <Star className="h-4 w-4 fill-gold text-gold" />
                    <span>{item.rating}</span>
                  </div>
                  <div className="mt-3">
                    <span className="font-heading text-xl font-bold text-krishna">{formatPrice(displayPrice)}</span>
                    {item.salePrice && <span className="ml-2 text-sm text-gray-400 line-through">{formatPrice(item.price)}</span>}
                  </div>
                  {item.stockQuantity > 0 ? (
                    <p className="mt-1 text-xs text-gray-500">{item.stockQuantity} in stock</p>
                  ) : (
                    <p className="mt-1 text-xs font-semibold text-red-600">Out of stock</p>
                  )}
                  <div className="mt-4 flex gap-2">
                    <Button
                      size="sm"
                      variant="maroon"
                      className="flex-1"
                      disabled={item.stockQuantity <= 0}
                      onClick={() => {
                        addItem({ productId: item.productId, name: item.productName, price: item.price, salePrice: item.salePrice, imageUrl: item.imageUrl });
                        toast.success("Added to cart!");
                      }}
                    >
                      <ShoppingCart className="mr-1 h-4 w-4" /> Add to Cart
                    </Button>
                    <Button size="sm" variant="maroon-outline" aria-label="Remove from wishlist" onClick={() => toggle(item.productId)}>
                      <Trash2 className="h-4 w-4" />
                    </Button>
                  </div>
                </CardContent>
              </Card>
            );
          })}
        </div>
      )}
    </div>
  );
}
