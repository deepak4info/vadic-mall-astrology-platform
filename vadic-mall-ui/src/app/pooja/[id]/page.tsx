import PoojaDetailPageClient from "./PoojaDetailPageClient";

export async function generateStaticParams() {
  return [{ id: "demo-pooja" }];
}

export default function PoojaDetailPage({ params }: { params: { id: string } }) {
  return <PoojaDetailPageClient params={params} />;
}
