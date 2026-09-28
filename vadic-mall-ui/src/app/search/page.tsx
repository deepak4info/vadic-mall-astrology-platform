import { Search } from "lucide-react";
import { PoojaCard, ProductCard, AstrologerCard } from "@/components/cards/ServiceCards";
import { fetchCatalog } from "@/lib/api";
import type { SearchResults } from "@/lib/types";

export const metadata = { title: "Search - Vadic Mall" };

export default async function SearchPage({ searchParams }: { searchParams: { q?: string } }) {
  const q = searchParams.q?.trim() ?? "";
  let results: SearchResults = { poojas: [], products: [], astrologers: [] };
  if (q) {
    try {
      results = await fetchCatalog<SearchResults>("/catalog/search", { q });
    } catch { /* API unavailable */ }
  }

  const totalCount = results.poojas.length + results.products.length + results.astrologers.length;

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <h1 className="section-title mb-2">Search Results</h1>
      <p className="mb-10 text-gray-500">
        {q ? `${totalCount} result${totalCount === 1 ? "" : "s"} for "${q}"` : "Enter a search term to get started."}
      </p>

      {q && totalCount === 0 && (
        <div className="rounded-2xl border border-dashed py-20 text-center">
          <Search className="mx-auto h-12 w-12 text-gray-300" />
          <p className="mt-4 text-gray-500">No matches found. Try a different search term.</p>
        </div>
      )}

      {results.poojas.length > 0 && (
        <section className="mb-12">
          <h2 className="mb-4 font-heading text-lg font-semibold text-krishna">Pooja Services</h2>
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
            {results.poojas.map((s) => <PoojaCard key={s.id} service={s} />)}
          </div>
        </section>
      )}

      {results.products.length > 0 && (
        <section className="mb-12">
          <h2 className="mb-4 font-heading text-lg font-semibold text-krishna">Products</h2>
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
            {results.products.map((p) => <ProductCard key={p.id} product={p} />)}
          </div>
        </section>
      )}

      {results.astrologers.length > 0 && (
        <section className="mb-12">
          <h2 className="mb-4 font-heading text-lg font-semibold text-krishna">Astrologers</h2>
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
            {results.astrologers.map((a) => <AstrologerCard key={a.id} astrologer={a} />)}
          </div>
        </section>
      )}
    </div>
  );
}
