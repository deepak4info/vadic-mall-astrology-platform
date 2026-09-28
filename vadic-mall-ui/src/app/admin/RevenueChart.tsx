import type { RevenueChartPoint } from "@/lib/types";
import { formatPrice } from "@/lib/utils";

export function RevenueChart({ data }: { data: RevenueChartPoint[] }) {
  const max = Math.max(...data.map((d) => d.revenue), 1);

  return (
    <div className="flex h-48 items-end gap-3">
      {data.map((point) => (
        <div key={point.label} className="flex flex-1 flex-col items-center gap-2">
          <span className="text-xs font-medium text-gray-500">{formatPrice(point.revenue)}</span>
          <div
            className="w-full rounded-t-lg bg-gradient-to-t from-saffron to-gold transition-all"
            style={{ height: `${Math.max((point.revenue / max) * 140, 4)}px` }}
          />
          <span className="text-xs text-gray-400">{point.label}</span>
        </div>
      ))}
    </div>
  );
}
