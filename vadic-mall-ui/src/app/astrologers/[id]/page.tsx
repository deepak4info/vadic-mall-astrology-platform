import AstrologerDetailPageClient from "./AstrologerDetailPageClient";

export async function generateStaticParams() {
  return [{ id: "demo-astrologer" }];
}

export default function AstrologerDetailPage({ params }: { params: { id: string } }) {
  return <AstrologerDetailPageClient params={params} />;
}
