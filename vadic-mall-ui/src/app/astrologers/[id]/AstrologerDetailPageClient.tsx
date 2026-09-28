"use client";

import Link from "next/link";
import { useRouter } from "next/navigation";
import { Star, ArrowLeft } from "lucide-react";
import { Button } from "@/components/ui/button";
import { DetailPanelSkeleton } from "@/components/ui/skeleton";
import { useCatalogItem } from "@/lib/hooks";
import { formatPrice } from "@/lib/utils";
import type { Astrologer } from "@/lib/types";

export default function AstrologerDetailPageClient({ params }: { params: { id: string } }) {
  const router = useRouter();
  const { data: astrologer, isLoading, isError } = useCatalogItem<Astrologer>("astrologer", `/catalog/astrologers/${params.id}`);

  if (isLoading) return <DetailPanelSkeleton />;
  if (isError || !astrologer) return <div className="py-20 text-center text-gray-500">Astrologer not found.</div>;

  return (
    <div className="mx-auto max-w-3xl animate-fade-in px-4 py-12">
      <Link href="/astrologers" className="mb-6 inline-flex items-center gap-2 text-sm text-saffron hover:underline">
        <ArrowLeft className="h-4 w-4" /> Back
      </Link>
      <div className="rounded-2xl border bg-white p-8 text-center shadow-sm">
        <div className="mx-auto mb-4 flex h-24 w-24 items-center justify-center rounded-full bg-gradient-to-br from-saffron to-gold text-4xl">🧘</div>
        <h1 className="font-heading text-2xl font-bold text-krishna">{astrologer.name}</h1>
        <p className="text-saffron">{astrologer.specialization}</p>
        <div className="mt-3 flex items-center justify-center gap-4 text-sm text-gray-500">
          <span className="flex items-center gap-1"><Star className="h-4 w-4 fill-gold text-gold" />{astrologer.rating}</span>
          <span>{astrologer.experienceYears}+ years experience</span>
          <span>{astrologer.languages}</span>
        </div>
        <p className="mt-6 text-left text-gray-600">{astrologer.bio}</p>
        <p className="mt-6 font-heading text-2xl font-bold text-krishna">{formatPrice(astrologer.consultationFee)}<span className="text-sm font-normal text-gray-400">/session</span></p>
        <Button className="mt-6 w-full" size="lg" onClick={() => router.push("/pooja")}>Book Consultation</Button>
      </div>
    </div>
  );
}
