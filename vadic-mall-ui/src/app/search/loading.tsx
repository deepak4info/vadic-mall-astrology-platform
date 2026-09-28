import { Skeleton, SectionGridSkeleton } from "@/components/ui/skeleton";

export default function Loading() {
  return (
    <>
      <div className="mx-auto max-w-7xl px-4 pt-12 lg:px-8">
        <Skeleton className="mb-2 h-9 w-64" />
        <Skeleton className="h-4 w-48" />
      </div>
      <SectionGridSkeleton heading={false} />
    </>
  );
}
