import type { ComponentType, CSSProperties } from "react";
import { cn } from "@/lib/utils";

/** Base shimmer block — compose these into shapes that mirror the real content. */
export function Skeleton({ className, style }: { className?: string; style?: CSSProperties }) {
  return <div className={cn("skeleton", className)} style={style} />;
}

export function PoojaCardSkeleton() {
  return (
    <div className="overflow-hidden rounded-2xl border border-gray-100 bg-white shadow-sm">
      <Skeleton className="h-48 w-full rounded-none" />
      <div className="p-5">
        <Skeleton className="h-3 w-20" />
        <Skeleton className="mt-2 h-5 w-3/4" />
        <Skeleton className="mt-3 h-3 w-full" />
        <Skeleton className="mt-1.5 h-3 w-2/3" />
        <div className="mt-3 flex items-center gap-3">
          <Skeleton className="h-3 w-10" />
          <Skeleton className="h-3 w-14" />
        </div>
        <div className="mt-4 flex items-center justify-between">
          <Skeleton className="h-6 w-20" />
          <Skeleton className="h-8 w-24 rounded-xl" />
        </div>
      </div>
    </div>
  );
}

export function ProductCardSkeleton() {
  return (
    <div className="overflow-hidden rounded-2xl border border-gray-100 bg-white shadow-sm">
      <Skeleton className="h-48 w-full rounded-none" />
      <div className="p-5">
        <Skeleton className="h-3 w-20" />
        <Skeleton className="mt-2 h-5 w-3/4" />
        <Skeleton className="mt-2 h-3 w-24" />
        <div className="mt-4 flex items-center justify-between">
          <Skeleton className="h-6 w-20" />
          <Skeleton className="h-8 w-16 rounded-xl" />
        </div>
      </div>
    </div>
  );
}

export function AstrologerCardSkeleton() {
  return (
    <div className="rounded-2xl border border-gray-100 bg-white p-6 text-center shadow-sm">
      <Skeleton className="mx-auto mb-4 h-20 w-20 rounded-full" />
      <Skeleton className="mx-auto h-5 w-2/3" />
      <Skeleton className="mx-auto mt-2 h-3 w-1/2" />
      <Skeleton className="mx-auto mt-3 h-3 w-full" />
      <Skeleton className="mx-auto mt-1.5 h-3 w-4/5" />
      <div className="mt-3 flex items-center justify-center gap-4">
        <Skeleton className="h-3 w-10" />
        <Skeleton className="h-3 w-14" />
      </div>
      <Skeleton className="mx-auto mt-3 h-5 w-24" />
      <Skeleton className="mt-4 h-9 w-full rounded-xl" />
    </div>
  );
}

export function BlogCardSkeleton() {
  return (
    <div className="rounded-2xl border border-gray-100 bg-white p-6 shadow-sm">
      <Skeleton className="h-3 w-16" />
      <Skeleton className="mt-2 h-5 w-4/5" />
      <Skeleton className="mt-3 h-3 w-full" />
      <Skeleton className="mt-1.5 h-3 w-full" />
      <Skeleton className="mt-1.5 h-3 w-2/3" />
      <Skeleton className="mt-4 h-3 w-1/3" />
    </div>
  );
}

/** Generic grid of any card skeleton — pass the matching skeleton component for the section. */
export function CardGridSkeleton({
  Card,
  count = 8,
  className = "grid gap-6 sm:grid-cols-2 lg:grid-cols-4",
}: {
  Card: ComponentType;
  count?: number;
  className?: string;
}) {
  return (
    <div className={className}>
      {Array.from({ length: count }).map((_, i) => (
        <Card key={i} />
      ))}
    </div>
  );
}

export function ProductDetailSkeleton() {
  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <Skeleton className="mb-6 h-4 w-32" />
      <div className="grid gap-10 lg:grid-cols-2">
        <div>
          <Skeleton className="h-80 w-full rounded-2xl lg:h-96" />
          <div className="mt-3 flex gap-3">
            {Array.from({ length: 4 }).map((_, i) => (
              <Skeleton key={i} className="h-16 w-16 shrink-0 rounded-lg" />
            ))}
          </div>
        </div>
        <div>
          <Skeleton className="h-5 w-24 rounded-full" />
          <Skeleton className="mt-3 h-8 w-3/4" />
          <Skeleton className="mt-3 h-4 w-32" />
          <Skeleton className="mt-6 h-4 w-full" />
          <Skeleton className="mt-2 h-4 w-5/6" />
          <Skeleton className="mt-2 h-4 w-2/3" />
          <Skeleton className="mt-6 h-9 w-36" />
          <div className="mt-8 flex gap-4">
            <Skeleton className="h-11 w-36 rounded-xl" />
            <Skeleton className="h-11 w-28 rounded-xl" />
            <Skeleton className="h-11 w-11 rounded-xl" />
          </div>
        </div>
      </div>
    </div>
  );
}

export function DetailPanelSkeleton() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-12">
      <Skeleton className="mb-6 h-4 w-20" />
      <div className="rounded-2xl border bg-white p-8 text-center shadow-sm">
        <Skeleton className="mx-auto mb-4 h-24 w-24 rounded-full" />
        <Skeleton className="mx-auto h-6 w-1/2" />
        <Skeleton className="mx-auto mt-2 h-4 w-1/3" />
        <div className="mt-3 flex items-center justify-center gap-4">
          <Skeleton className="h-3 w-16" />
          <Skeleton className="h-3 w-24" />
          <Skeleton className="h-3 w-20" />
        </div>
        <Skeleton className="mx-auto mt-6 h-4 w-full" />
        <Skeleton className="mx-auto mt-2 h-4 w-5/6" />
        <Skeleton className="mx-auto mt-6 h-7 w-32" />
        <Skeleton className="mt-6 h-11 w-full rounded-xl" />
      </div>
    </div>
  );
}

export function ListingPageSkeleton({
  Card,
  columns = "grid gap-6 sm:grid-cols-2 lg:grid-cols-4",
  count = 8,
}: {
  Card: ComponentType;
  columns?: string;
  count?: number;
}) {
  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <div className="mb-10 text-center">
        <Skeleton className="mx-auto h-9 w-72" />
        <Skeleton className="mx-auto mt-3 h-4 w-96 max-w-full" />
      </div>
      <div className="mb-8 flex flex-wrap justify-center gap-2">
        {Array.from({ length: 5 }).map((_, i) => (
          <Skeleton key={i} className="h-9 w-24 rounded-full" />
        ))}
      </div>
      <CardGridSkeleton Card={Card} count={count} className={columns} />
    </div>
  );
}

export function StatTileSkeleton() {
  return (
    <div className="rounded-2xl border bg-white p-6">
      <div className="flex items-center gap-3">
        <Skeleton className="h-10 w-10 rounded-xl" />
        <div className="flex-1">
          <Skeleton className="h-6 w-16" />
          <Skeleton className="mt-1.5 h-3 w-20" />
        </div>
      </div>
    </div>
  );
}

export function AdminTableSkeleton({ columns = 5, rows = 6 }: { columns?: number; rows?: number }) {
  return (
    <div className="overflow-x-auto rounded-2xl border bg-white">
      <table className="w-full min-w-[600px] text-left text-sm">
        <thead>
          <tr className="border-b bg-gray-50">
            {Array.from({ length: columns }).map((_, i) => (
              <th key={i} className="px-4 py-3"><Skeleton className="h-3 w-16" /></th>
            ))}
          </tr>
        </thead>
        <tbody>
          {Array.from({ length: rows }).map((_, r) => (
            <tr key={r} className="border-b last:border-0">
              {Array.from({ length: columns }).map((_, c) => (
                <td key={c} className="px-4 py-3"><Skeleton className="h-4 w-full max-w-[120px]" /></td>
              ))}
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}

export function ArticleSkeleton() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-12">
      <Skeleton className="h-4 w-28" />
      <Skeleton className="mt-4 h-3 w-24" />
      <Skeleton className="mt-2 h-9 w-full" />
      <Skeleton className="mt-1 h-9 w-2/3" />
      <Skeleton className="mt-4 h-3 w-32" />
      <div className="mt-8 space-y-3">
        {Array.from({ length: 6 }).map((_, i) => (
          <Skeleton key={i} className={cn("h-4", i % 3 === 2 ? "w-2/3" : "w-full")} />
        ))}
      </div>
    </div>
  );
}

export function AccordionSkeleton() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-12 lg:px-8">
      <Skeleton className="mx-auto mb-8 h-8 w-80 max-w-full" />
      {Array.from({ length: 3 }).map((_, g) => (
        <div key={g} className="mb-8">
          <Skeleton className="mb-4 h-5 w-40" />
          <div className="space-y-3">
            {Array.from({ length: 4 }).map((_, i) => (
              <Skeleton key={i} className="h-12 w-full rounded-xl" />
            ))}
          </div>
        </div>
      ))}
    </div>
  );
}

export function PoojaDetailSkeleton() {
  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <Skeleton className="mb-6 h-4 w-44" />
      <div className="grid gap-10 lg:grid-cols-2">
        <Skeleton className="h-80 w-full rounded-2xl lg:h-full" />
        <div>
          <Skeleton className="h-5 w-24 rounded-full" />
          <Skeleton className="mt-3 h-8 w-3/4" />
          <Skeleton className="mt-3 h-4 w-48" />
          <Skeleton className="mt-6 h-4 w-full" />
          <Skeleton className="mt-2 h-4 w-5/6" />
          <Skeleton className="mt-2 h-4 w-2/3" />
          <Skeleton className="mt-6 h-8 w-32" />
          <Skeleton className="mt-6 h-40 w-full rounded-xl" />
        </div>
      </div>
    </div>
  );
}

export function SectionGridSkeleton({ heading = true }: { heading?: boolean }) {
  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      {heading && (
        <div className="mb-10 text-center">
          <Skeleton className="mx-auto h-9 w-72" />
          <Skeleton className="mx-auto mt-3 h-4 w-96 max-w-full" />
        </div>
      )}
      <Skeleton className="mb-4 h-5 w-40" />
      <CardGridSkeleton Card={ProductCardSkeleton} count={4} />
      <Skeleton className="mb-4 mt-10 h-5 w-40" />
      <CardGridSkeleton Card={PoojaCardSkeleton} count={4} className="grid gap-6 sm:grid-cols-2 lg:grid-cols-3" />
    </div>
  );
}

export function HomeSkeleton() {
  return (
    <>
      <div className="bg-krishna-gradient py-20 lg:py-32">
        <div className="mx-auto max-w-3xl px-4 text-center">
          <Skeleton className="mx-auto h-4 w-40 bg-white/10" />
          <Skeleton className="mx-auto mt-4 h-12 w-full bg-white/10" />
          <Skeleton className="mx-auto mt-2 h-12 w-2/3 bg-white/10" />
          <Skeleton className="mx-auto mt-6 h-4 w-full bg-white/10" />
          <div className="mt-10 flex justify-center gap-4">
            <Skeleton className="h-12 w-40 rounded-xl bg-white/10" />
            <Skeleton className="h-12 w-40 rounded-xl bg-white/10" />
          </div>
        </div>
      </div>
      <div className="mx-auto max-w-7xl px-4 py-16 lg:px-8">
        <div className="grid grid-cols-2 gap-4 md:grid-cols-3 lg:grid-cols-6">
          {Array.from({ length: 6 }).map((_, i) => (
            <Skeleton key={i} className="h-24 rounded-2xl" />
          ))}
        </div>
      </div>
      <div className="mx-auto max-w-7xl px-4 pb-16 lg:px-8">
        <Skeleton className="mb-8 h-8 w-56" />
        <CardGridSkeleton Card={PoojaCardSkeleton} count={4} />
      </div>
    </>
  );
}

export function DashboardSkeleton({ tiles = 4, tabs = false }: { tiles?: number; tabs?: boolean }) {
  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <div className="mb-6 flex items-center gap-4">
        <Skeleton className="h-14 w-14 rounded-full" />
        <div>
          <Skeleton className="h-6 w-48" />
          <Skeleton className="mt-2 h-3 w-32" />
        </div>
      </div>
      {tabs && (
        <div className="mb-8 flex gap-2">
          <Skeleton className="h-9 w-28 rounded-full" />
          <Skeleton className="h-9 w-28 rounded-full" />
          <Skeleton className="h-9 w-28 rounded-full" />
        </div>
      )}
      <div className={cn("mb-10 grid gap-6", tiles === 4 ? "md:grid-cols-4" : "md:grid-cols-2")}>
        {Array.from({ length: tiles }).map((_, i) => <StatTileSkeleton key={i} />)}
      </div>
      <div className="grid gap-8 lg:grid-cols-2">
        {[0, 1].map((col) => (
          <div key={col}>
            <Skeleton className="mb-4 h-5 w-32" />
            <div className="space-y-3">
              {Array.from({ length: 3 }).map((_, i) => (
                <div key={i} className="flex items-center justify-between rounded-xl border bg-white p-4">
                  <div>
                    <Skeleton className="h-4 w-32" />
                    <Skeleton className="mt-2 h-3 w-24" />
                  </div>
                  <div className="text-right">
                    <Skeleton className="ml-auto h-4 w-16" />
                    <Skeleton className="ml-auto mt-2 h-3 w-14" />
                  </div>
                </div>
              ))}
            </div>
          </div>
        ))}
      </div>
    </div>
  );
}

export function OrderDetailSkeleton() {
  return (
    <div className="mx-auto max-w-3xl px-4 py-12 lg:px-8">
      <Skeleton className="mb-6 h-4 w-36" />
      <div className="mb-6 flex items-center justify-between">
        <div>
          <Skeleton className="h-6 w-40" />
          <Skeleton className="mt-2 h-3 w-28" />
        </div>
        <Skeleton className="h-7 w-24 rounded-full" />
      </div>
      <div className="mb-6 rounded-2xl border bg-white p-6">
        <Skeleton className="mb-4 h-5 w-16" />
        <div className="space-y-3">
          {Array.from({ length: 2 }).map((_, i) => (
            <div key={i} className="flex items-center gap-3">
              <Skeleton className="h-12 w-12 shrink-0 rounded-lg" />
              <div className="flex-1">
                <Skeleton className="h-4 w-40" />
                <Skeleton className="mt-1.5 h-3 w-24" />
              </div>
              <Skeleton className="h-4 w-16" />
            </div>
          ))}
        </div>
      </div>
      <div className="rounded-2xl border bg-white p-6">
        <Skeleton className="mb-4 h-5 w-24" />
        <div className="space-y-4">
          {Array.from({ length: 3 }).map((_, i) => (
            <div key={i} className="flex gap-3">
              <Skeleton className="h-5 w-5 shrink-0 rounded-full" />
              <div className="flex-1">
                <Skeleton className="h-4 w-28" />
                <Skeleton className="mt-1.5 h-3 w-36" />
              </div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}

export function AddressListSkeleton() {
  return (
    <div className="space-y-4">
      {Array.from({ length: 2 }).map((_, i) => (
        <div key={i} className="flex items-start gap-4 rounded-2xl border bg-white p-6">
          <Skeleton className="mt-0.5 h-5 w-5 shrink-0 rounded-full" />
          <div className="flex-1">
            <Skeleton className="h-4 w-40" />
            <Skeleton className="mt-2 h-3 w-28" />
            <Skeleton className="mt-2 h-3 w-full max-w-xs" />
            <Skeleton className="mt-1.5 h-3 w-3/4 max-w-xs" />
          </div>
        </div>
      ))}
    </div>
  );
}

export function GiftCardTypeSkeleton() {
  return (
    <div className="rounded-2xl border border-gray-100 bg-white p-6 shadow-sm">
      <Skeleton className="h-6 w-32" />
      <div className="mt-4 flex flex-wrap gap-3">
        {Array.from({ length: 5 }).map((_, i) => (
          <Skeleton key={i} className="h-9 w-20 rounded-xl" />
        ))}
      </div>
    </div>
  );
}

export function PlanCardSkeleton() {
  return (
    <div className="rounded-2xl border border-gray-100 bg-white p-6 text-center shadow-sm">
      <Skeleton className="mx-auto h-5 w-24" />
      <Skeleton className="mx-auto mt-4 h-9 w-28" />
      <Skeleton className="mx-auto mt-2 h-3 w-full" />
      <div className="mt-4 space-y-2">
        {Array.from({ length: 4 }).map((_, i) => (
          <Skeleton key={i} className="h-3 w-full" />
        ))}
      </div>
      <Skeleton className="mt-6 h-9 w-full rounded-xl" />
    </div>
  );
}

export function ChartBarsSkeleton() {
  return (
    <div className="flex h-48 items-end gap-3">
      {[40, 65, 35, 80, 55, 95].map((h, i) => (
        <Skeleton key={i} className="flex-1 rounded-t-md rounded-b-none" style={{ height: `${h}%` }} />
      ))}
    </div>
  );
}


export function RecentListSkeleton({ rows = 4 }: { rows?: number }) {
  return (
    <div className="space-y-3">
      {Array.from({ length: rows }).map((_, i) => (
        <div key={i} className="flex items-center justify-between">
          <div>
            <Skeleton className="h-4 w-28" />
            <Skeleton className="mt-1.5 h-3 w-20" />
          </div>
          <div className="text-right">
            <Skeleton className="ml-auto h-4 w-16" />
            <Skeleton className="ml-auto mt-1.5 h-3 w-12" />
          </div>
        </div>
      ))}
    </div>
  );
}

export function AdminOverviewSkeleton() {
  return (
    <>
      <div className="mb-10 grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
        {Array.from({ length: 7 }).map((_, i) => <StatTileSkeleton key={i} />)}
      </div>
      <div className="mb-10 grid gap-6 lg:grid-cols-2">
        <div className="rounded-2xl border bg-white p-6">
          <Skeleton className="mb-4 h-5 w-48" />
          <ChartBarsSkeleton />
        </div>
        <div className="rounded-2xl border bg-white p-6">
          <Skeleton className="mb-4 h-5 w-32" />
          <RecentListSkeleton />
        </div>
      </div>
    </>
  );
}
