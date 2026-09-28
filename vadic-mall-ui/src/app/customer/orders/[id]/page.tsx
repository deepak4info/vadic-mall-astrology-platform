import OrderDetailPageClient from "./OrderDetailPageClient";

export async function generateStaticParams() {
  return [{ id: "demo-order" }];
}

export default function OrderDetailPage({ params }: { params: { id: string } }) {
  return <OrderDetailPageClient params={params} />;
}
