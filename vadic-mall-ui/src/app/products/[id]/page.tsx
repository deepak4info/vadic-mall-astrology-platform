import ProductDetailPageClient from "./ProductDetailPageClient";

export async function generateStaticParams() {
  return [{ id: "demo-product" }];
}

export default function ProductDetailPage({ params }: { params: { id: string } }) {
  return <ProductDetailPageClient params={params} />;
}
