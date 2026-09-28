"use client";

import Link from "next/link";
import { Clock, Star, ArrowLeft } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { useCatalogItem } from "@/lib/hooks";
import { formatPrice, getDiscountPercent } from "@/lib/utils";
import type { PoojaService } from "@/lib/types";
import { PoojaBookingForm } from "./BookingForm";
import { PoojaImage } from "./PoojaImage";

export default function PoojaDetailPageClient({ params }: { params: { id: string } }) {
  const { data: service, isLoading, isError } = useCatalogItem<PoojaService>("pooja-service", `/catalog/pooja-services/${params.id}`);

  if (isLoading) return <div className="mx-auto max-w-7xl px-4 py-20 text-center text-gray-500">Loading...</div>;
  if (isError || !service) return (
    <div className="mx-auto max-w-7xl px-4 py-20 text-center">
      <p className="text-gray-500">Pooja service not found.</p>
      <Link href="/pooja"><Button variant="krishna" className="mt-4">Back to Poojas</Button></Link>
    </div>
  );

  const discount = getDiscountPercent(service.price, service.salePrice);
  const displayPrice = service.salePrice ?? service.price;

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <Link href="/pooja" className="mb-6 inline-flex items-center gap-2 text-sm text-saffron hover:underline">
        <ArrowLeft className="h-4 w-4" /> Back to Pooja Services
      </Link>

      <div className="grid gap-10 lg:grid-cols-2">
        <div className="relative flex h-80 items-center justify-center overflow-hidden rounded-2xl bg-gradient-to-br from-krishna to-krishna-navy lg:h-full">
          <PoojaImage imageUrl={service.imageUrl} name={service.name} />
          {discount > 0 && <Badge variant="sale" className="absolute right-4 top-4">{discount}% OFF</Badge>}
        </div>

        <div>
          <Badge>{service.category}</Badge>
          <h1 className="mt-3 font-heading text-3xl font-bold text-krishna">{service.name}</h1>
          <div className="mt-3 flex items-center gap-4 text-sm text-gray-500">
            <span className="flex items-center gap-1"><Star className="h-4 w-4 fill-gold text-gold" />{service.rating} ({service.reviewCount} reviews)</span>
            <span className="flex items-center gap-1"><Clock className="h-4 w-4" />{service.durationMinutes} minutes</span>
          </div>
          <p className="mt-6 text-gray-600 leading-relaxed">{service.description}</p>
          <div className="mt-6">
            <span className="font-heading text-3xl font-bold text-krishna">{formatPrice(displayPrice)}</span>
            {service.salePrice && <span className="ml-3 text-lg text-gray-400 line-through">{formatPrice(service.price)}</span>}
          </div>
          <PoojaBookingForm serviceId={service.id} serviceName={service.name} amount={displayPrice} />
        </div>
      </div>
    </div>
  );
}
