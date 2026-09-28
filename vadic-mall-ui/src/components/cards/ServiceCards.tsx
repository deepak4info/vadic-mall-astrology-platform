"use client";

import Link from "next/link";
import { useState } from "react";
import { Star, Clock, ArrowRight, Heart } from "lucide-react";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { cn, formatPrice, getDiscountPercent, getImageUrl, checkImageAlreadyFailed } from "@/lib/utils";
import { useWishlist } from "@/lib/wishlist";
import type { PoojaService, Product, Astrologer } from "@/lib/types";

export function PoojaCard({ service }: { service: PoojaService }) {
  const discount = getDiscountPercent(service.price, service.salePrice);
  const displayPrice = service.salePrice ?? service.price;
  const [imgError, setImgError] = useState(false);

  return (
    <Card className="group overflow-hidden">
      <div className="relative h-48 bg-gradient-to-br from-krishna to-krishna-navy">
        <div className="absolute inset-0 flex items-center justify-center text-6xl opacity-30">🪔</div>
        {service.imageUrl && !imgError && (
          // eslint-disable-next-line @next/next/no-img-element
          <img
            ref={(el) => checkImageAlreadyFailed(el, () => setImgError(true))}
            src={getImageUrl(service.imageUrl)}
            alt={service.name}
            className="absolute inset-0 h-full w-full object-cover"
            onError={() => setImgError(true)}
          />
        )}
        {service.isFeatured && <Badge variant="featured" className="absolute left-3 top-3">Featured</Badge>}
        {discount > 0 && <Badge variant="sale" className="absolute right-3 top-3">{discount}% OFF</Badge>}
        {service.festivalTag && <Badge variant="festival" className="absolute bottom-3 left-3">{service.festivalTag}</Badge>}
      </div>
      <CardContent className="p-5">
        <p className="text-xs font-medium text-saffron">{service.category}</p>
        <h3 className="mt-1 font-heading text-lg font-semibold text-krishna group-hover:text-saffron">{service.name}</h3>
        <p className="mt-2 line-clamp-2 text-sm text-gray-500">{service.description}</p>
        <div className="mt-3 flex items-center gap-3 text-sm text-gray-500">
          <span className="flex items-center gap-1"><Star className="h-4 w-4 fill-gold text-gold" />{service.rating}</span>
          <span className="flex items-center gap-1"><Clock className="h-4 w-4" />{service.durationMinutes} min</span>
        </div>
        <div className="mt-4 flex items-center justify-between">
          <div>
            <span className="font-heading text-xl font-bold text-krishna">{formatPrice(displayPrice)}</span>
            {service.salePrice && <span className="ml-2 text-sm text-gray-400 line-through">{formatPrice(service.price)}</span>}
          </div>
          <Link href={`/pooja/${service.id}`}>
            <Button size="sm" variant="krishna">Book Now</Button>
          </Link>
        </div>
      </CardContent>
    </Card>
  );
}

export function ProductCard({ product }: { product: Product }) {
  const discount = getDiscountPercent(product.price, product.salePrice);
  const displayPrice = product.salePrice ?? product.price;
  const { isWishlisted, toggle } = useWishlist();
  const wishlisted = isWishlisted(product.id);
  const [imgError, setImgError] = useState(false);

  return (
    <Card className="group overflow-hidden">
      <div className="relative h-48 bg-gradient-to-br from-krishna/5 to-saffron/10">
        <div className="absolute inset-0 flex items-center justify-center text-5xl opacity-40">📿</div>
        {product.primaryImage && !imgError && (
          // eslint-disable-next-line @next/next/no-img-element
          <img
            ref={(el) => checkImageAlreadyFailed(el, () => setImgError(true))}
            src={getImageUrl(product.primaryImage)}
            alt={product.name}
            className="absolute inset-0 h-full w-full object-cover"
            onError={() => setImgError(true)}
          />
        )}
        {discount > 0 && <Badge variant="sale" className="absolute right-3 top-3">{discount}% OFF</Badge>}
        {product.isFeatured && <Badge variant="featured" className="absolute left-3 top-3">Featured</Badge>}
        <button
          type="button"
          onClick={(e) => {
            e.preventDefault();
            toggle(product.id);
          }}
          aria-label={wishlisted ? "Remove from wishlist" : "Add to wishlist"}
          className="absolute bottom-3 right-3 flex h-9 w-9 items-center justify-center rounded-full bg-white/90 shadow-md transition-transform hover:scale-110"
        >
          <Heart className={cn("h-4 w-4", wishlisted ? "fill-red-500 text-red-500" : "text-gray-400")} />
        </button>
      </div>
      <CardContent className="p-5">
        <p className="text-xs font-medium text-maroon">{product.categoryName}</p>
        <h3 className="mt-1 font-heading text-lg font-semibold text-krishna group-hover:text-maroon">{product.name}</h3>
        <div className="mt-2 flex items-center gap-1 text-sm">
          <Star className="h-4 w-4 fill-gold text-gold" />
          <span>{product.rating}</span>
          <span className="text-gray-400">({product.reviewCount})</span>
        </div>
        <div className="mt-4 flex items-center justify-between">
          <div>
            <span className="font-heading text-xl font-bold text-krishna">{formatPrice(displayPrice)}</span>
            {product.salePrice && <span className="ml-2 text-sm text-gray-400 line-through">{formatPrice(product.price)}</span>}
          </div>
          <Link href={`/products/${product.id}`}>
            <Button size="sm" variant="maroon-outline">View</Button>
          </Link>
        </div>
      </CardContent>
    </Card>
  );
}

export function AstrologerCard({ astrologer }: { astrologer: Astrologer }) {
  const [imgError, setImgError] = useState(false);

  return (
    <Card className="group text-center">
      <CardContent className="p-6">
        <div className="relative mx-auto mb-4 flex h-20 w-20 items-center justify-center overflow-hidden rounded-full bg-gradient-to-br from-saffron to-gold text-3xl">
          <span className="absolute inset-0 flex items-center justify-center">🧘</span>
          {astrologer.avatarUrl && !imgError && (
            // eslint-disable-next-line @next/next/no-img-element
            <img
              ref={(el) => checkImageAlreadyFailed(el, () => setImgError(true))}
              src={getImageUrl(astrologer.avatarUrl)}
              alt={astrologer.name}
              className="absolute inset-0 h-full w-full object-cover"
              onError={() => setImgError(true)}
            />
          )}
        </div>
        {astrologer.isFeatured && <Badge variant="featured" className="mb-2">Top Rated</Badge>}
        <h3 className="font-heading text-lg font-semibold text-krishna">{astrologer.name}</h3>
        <p className="text-sm text-saffron">{astrologer.specialization}</p>
        <p className="mt-2 line-clamp-2 text-sm text-gray-500">{astrologer.bio}</p>
        <div className="mt-3 flex items-center justify-center gap-4 text-sm text-gray-500">
          <span className="flex items-center gap-1"><Star className="h-4 w-4 fill-gold text-gold" />{astrologer.rating}</span>
          <span>{astrologer.experienceYears}+ yrs</span>
        </div>
        <p className="mt-3 font-heading text-lg font-bold text-krishna">{formatPrice(astrologer.consultationFee)}<span className="text-sm font-normal text-gray-400">/session</span></p>
        <Link href={`/astrologers/${astrologer.id}`} className="mt-4 block">
          <Button className="w-full" size="sm">Consult Now <ArrowRight className="ml-1 h-4 w-4" /></Button>
        </Link>
      </CardContent>
    </Card>
  );
}
