import { PoojaCard } from "@/components/cards/ServiceCards";
import { fetchCatalog } from "@/lib/api";
import type { PoojaService } from "@/lib/types";

export const metadata = { title: "Pooja Services - Vadic Mall" };

export default async function PoojaPage({ searchParams }: { searchParams: { category?: string; search?: string } }) {
  let services: PoojaService[] = [];
  try {
    services = await fetchCatalog<PoojaService[]>("/catalog/pooja-services", searchParams);
  } catch { /* API unavailable */ }

  const categories = Array.from(new Set(services.map((s) => s.category)));

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <div className="mb-10 text-center">
        <h1 className="section-title">Pooja Services</h1>
        <p className="mt-2 text-gray-500">Authentic Vedic rituals performed by certified pandits at your home or temple</p>
      </div>

      <div className="mb-8 flex flex-wrap gap-2">
        <a href="/pooja" className={`rounded-full px-4 py-2 text-sm font-medium ${!searchParams.category ? "bg-krishna text-white" : "bg-gray-100 text-gray-600 hover:bg-gray-200"}`}>All</a>
        {categories.map((cat) => (
          <a key={cat} href={`/pooja?category=${encodeURIComponent(cat)}`} className={`rounded-full px-4 py-2 text-sm font-medium ${searchParams.category === cat ? "bg-krishna text-white" : "bg-gray-100 text-gray-600 hover:bg-gray-200"}`}>{cat}</a>
        ))}
      </div>

      {services.length === 0 ? (
        <div className="rounded-2xl border border-dashed border-gray-200 py-20 text-center">
          <p className="text-4xl">🪔</p>
          <p className="mt-4 text-gray-500">No pooja services found. Start the API server to load catalog data.</p>
        </div>
      ) : (
        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">
          {services.map((s) => <PoojaCard key={s.id} service={s} />)}
        </div>
      )}
    </div>
  );
}
