import { Skeleton, SectionGridSkeleton } from "@/components/ui/skeleton";

export default function Loading() {
  return (
    <>
      <div className="mx-auto max-w-7xl px-4 pt-12 lg:px-8">
        <div className="mb-10 rounded-2xl bg-krishna-gradient p-10 text-center">
          <Skeleton className="mx-auto h-9 w-80 max-w-full bg-white/10" />
          <Skeleton className="mx-auto mt-3 h-4 w-96 max-w-full bg-white/10" />
        </div>
      </div>
      <SectionGridSkeleton heading={false} />
    </>
  );
}
