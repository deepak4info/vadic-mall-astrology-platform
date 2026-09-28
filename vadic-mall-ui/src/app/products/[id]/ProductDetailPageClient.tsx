"use client";

import Link from "next/link";
import { ArrowLeft, Star, ShoppingCart, Heart } from "lucide-react";
import toast from "react-hot-toast";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ProductDetailSkeleton } from "@/components/ui/skeleton";
import { ProductImageGallery } from "@/components/product/ProductImageGallery";
import { useCatalogItem } from "@/lib/hooks";
import { cn, formatPrice, getDiscountPercent } from "@/lib/utils";
import { useCartStore } from "@/store/cart";
import { useWishlist } from "@/lib/wishlist";
import type { ProductDetail } from "@/lib/types";

export default function ProductDetailPageClient({ params }: { params: { id: string } }) {
  const addItem = useCartStore((s) => s.addItem);
  const { data: product, isLoading, isError } = useCatalogItem<ProductDetail>("product", `/catalog/products/${params.id}`);
  const { isWishlisted, toggle } = useWishlist();

  if (isLoading) return <ProductDetailSkeleton />;
  if (isError || !product) return <div className="py-20 text-center text-gray-500">Product not found.</div>;

  const discount = getDiscountPercent(product.price, product.salePrice);
  const displayPrice = product.salePrice ?? product.price;

  const handleAddToCart = () => {
    addItem({ productId: product.id, name: product.name, price: product.price, salePrice: product.salePrice, imageUrl: product.primaryImage });
    toast.success("Added to cart!");
  };

  return (
    <div className="mx-auto max-w-7xl animate-fade-in px-4 py-12 lg:px-8">
      <Link href="/products" className="mb-6 inline-flex items-center gap-2 text-sm text-maroon hover:underline">
        <ArrowLeft className="h-4 w-4" /> Back to Products
      </Link>
      <div className="grid gap-10 lg:grid-cols-2">
        <ProductImageGallery images={product.images} productName={product.name} />
        <div>
          <Badge>{product.categoryName}</Badge>
          <h1 className="mt-3 font-heading text-3xl font-bold text-krishna">{product.name}</h1>
          <div className="mt-2 flex items-center gap-1 text-sm">
            <Star className="h-4 w-4 fill-gold text-gold" />
            {product.rating} ({product.reviewCount} reviews)
          </div>
          <p className="mt-6 text-gray-600">{product.description}</p>
          <div className="mt-6 flex items-baseline gap-3">
            <span className="font-heading text-3xl font-bold text-krishna">{formatPrice(displayPrice)}</span>
            {product.salePrice && <span className="text-lg text-gray-400 line-through">{formatPrice(product.price)}</span>}
            {discount > 0 && <Badge variant="sale">{discount}% OFF</Badge>}
          </div>
          {product.stockQuantity > 0 ? (
            <p className="mt-2 text-sm text-gray-500">{product.stockQuantity} in stock</p>
          ) : (
            <p className="mt-2 text-sm font-semibold text-red-600">Out of stock</p>
          )}
          <div className="mt-8 flex gap-4">
            <Button variant="maroon" onClick={handleAddToCart} size="lg" disabled={product.stockQuantity <= 0}>
              <ShoppingCart className="mr-2 h-5 w-5" /> Add to Cart
            </Button>
            <Link href="/cart"><Button variant="maroon-outline" size="lg">View Cart</Button></Link>
            <Button variant="maroon-outline" size="lg" onClick={() => toggle(product.id)} aria-label="Toggle wishlist">
              <Heart className={cn("h-5 w-5", isWishlisted(product.id) ? "fill-red-500 text-red-500" : "")} />
            </Button>
          </div>
        </div>
      </div>
    </div>
  );
}
