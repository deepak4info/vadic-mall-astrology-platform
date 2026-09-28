import { PoojaCard, ProductCard } from "@/components/cards/ServiceCards";
import { fetchCatalog } from "@/lib/api";
import type { FestivalOffer } from "@/lib/types";
import { Badge } from "@/components/ui/badge";

export const metadata = { title: "Festival Offers - Vadic Mall" };

export default async function FestivalPage() {
  let offers: FestivalOffer[] = [];
  try {
    offers = await fetchCatalog<FestivalOffer[]>("/catalog/festival-offers");
  } catch { /* API unavailable */ }

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <div className="mb-10 rounded-2xl bg-krishna-gradient p-10 text-center">
        <h1 className="font-heading text-4xl font-bold text-white">Festival Special Offers</h1>
        <p className="mt-2 text-white/70">Celebrate with exclusive discounts on poojas and spiritual products</p>
      </div>

      {offers.length === 0 ? (
        <p className="text-center text-gray-500">No festival offers available right now.</p>
      ) : (
        offers.map((offer) => (
          <div key={offer.festival} className="mb-16">
            <div className="mb-6 flex items-center gap-3">
              <h2 className="font-heading text-2xl font-bold text-krishna">{offer.festival}</h2>
              <Badge variant="festival">Up to {offer.discountPercent}% OFF</Badge>
            </div>
            <p className="mb-6 text-gray-500">{offer.description}</p>
            {offer.services.length > 0 && (
              <div className="mb-8">
                <h3 className="mb-4 font-semibold text-krishna">Pooja Services</h3>
                <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3">{offer.services.map((s) => <PoojaCard key={s.id} service={s} />)}</div>
              </div>
            )}
            {offer.products.length > 0 && (
              <div>
                <h3 className="mb-4 font-semibold text-krishna">Products</h3>
                <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">{offer.products.map((p) => <ProductCard key={p.id} product={p} />)}</div>
              </div>
            )}
          </div>
        ))
      )}
    </div>
  );
}
