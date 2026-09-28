import { BlogCardSkeleton, CardGridSkeleton, Skeleton } from "@/components/ui/skeleton";

export default function Loading() {
  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <Skeleton className="mb-8 h-9 w-64" />
      <CardGridSkeleton Card={BlogCardSkeleton} count={6} className="grid gap-6 md:grid-cols-2 lg:grid-cols-3" />
    </div>
  );
}
