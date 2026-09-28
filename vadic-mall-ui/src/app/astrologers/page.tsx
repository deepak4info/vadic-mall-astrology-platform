import { AstrologerCard } from "@/components/cards/ServiceCards";
import { fetchCatalog } from "@/lib/api";
import type { Astrologer } from "@/lib/types";

export const metadata = { title: "Astrologers - Vadic Mall" };

export default async function AstrologersPage() {
  let astrologers: Astrologer[] = [];
  try {
    astrologers = await fetchCatalog<Astrologer[]>("/catalog/astrologers");
  } catch { /* API unavailable */ }

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <div className="mb-10 text-center">
        <h1 className="section-title">Expert Vedic Astrologers</h1>
        <p className="mt-2 text-gray-500">Consult with verified astrologers for personalized guidance</p>
      </div>
      <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
        {astrologers.map((a) => <AstrologerCard key={a.id} astrologer={a} />)}
      </div>
    </div>
  );
}
