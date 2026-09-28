import { AstrologerCardSkeleton, ListingPageSkeleton } from "@/components/ui/skeleton";

export default function Loading() {
  return <ListingPageSkeleton Card={AstrologerCardSkeleton} columns="grid gap-6 sm:grid-cols-2 lg:grid-cols-3" count={6} />;
}
