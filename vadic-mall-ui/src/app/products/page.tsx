import { ProductCard } from "@/components/cards/ServiceCards";
import { fetchCatalog } from "@/lib/api";
import type { Product } from "@/lib/types";

export const metadata = { title: "Products - Vadic Mall" };

export default async function ProductsPage({ searchParams }: { searchParams: { category?: string; search?: string } }) {
  let products: Product[] = [];
  try {
    products = await fetchCatalog<Product[]>("/catalog/products", searchParams);
  } catch { /* API unavailable */ }

  const categories = Array.from(new Set(products.map((p) => p.categoryName)));

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <div className="mb-10 text-center">
        <h1 className="section-title">Spiritual Products</h1>
        <p className="mt-2 text-gray-500">Certified gemstones, malas, pooja samagri, and spiritual essentials</p>
      </div>

      <div className="mb-8 flex flex-wrap gap-2">
        <a href="/products" className={`rounded-full px-4 py-2 text-sm font-medium ${!searchParams.category ? "bg-maroon text-white" : "bg-gray-100 text-gray-600 hover:bg-gray-200"}`}>All</a>
        {categories.map((cat) => (
          <a key={cat} href={`/products?category=${encodeURIComponent(cat)}`} className={`rounded-full px-4 py-2 text-sm font-medium ${searchParams.category === cat ? "bg-maroon text-white" : "bg-gray-100 text-gray-600 hover:bg-gray-200"}`}>{cat}</a>
        ))}
      </div>

      {products.length === 0 ? (
        <div className="rounded-2xl border border-dashed py-20 text-center">
          <p className="text-4xl">📿</p>
          <p className="mt-4 text-gray-500">No products found.</p>
        </div>
      ) : (
        <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
          {products.map((p) => <ProductCard key={p.id} product={p} />)}
        </div>
      )}
    </div>
  );
}
