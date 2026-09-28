"use client";

import { useQueryClient } from "@tanstack/react-query";
import toast from "react-hot-toast";
import { Check } from "lucide-react";
import { Card, CardContent } from "@/components/ui/card";
import { Skeleton } from "@/components/ui/skeleton";
import { useAdminData } from "@/lib/hooks";
import { adminPatch, getApiErrorMessage } from "@/lib/api";
import { cn } from "@/lib/utils";

interface LoadingSkeletonPreset {
  id: number;
  name: string;
  displayName: string;
  cssClass: string;
  durationMs: number;
  delayMs: number;
  easing: string;
  isActive: boolean;
  sortOrder: number;
}

export function LoadingSkeletonSettings() {
  const queryClient = useQueryClient();
  const { data: presets = [], isLoading } = useAdminData<LoadingSkeletonPreset[]>("loading-skeletons", "/loading-skeletons");

  const activate = async (preset: LoadingSkeletonPreset) => {
    if (preset.isActive) return;
    try {
      await adminPatch(`/loading-skeletons/${preset.id}/activate`, {});
      toast.success(`"${preset.displayName}" is now the active loading animation`);
      await queryClient.invalidateQueries({ queryKey: ["admin", "loading-skeletons"] });
      await queryClient.invalidateQueries({ queryKey: ["catalog", "loading-skeleton"] });
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Failed to update loading animation"));
    }
  };

  return (
    <Card className="mt-6 max-w-xl">
      <CardContent className="p-6">
        <h2 className="mb-1 font-heading text-lg font-semibold text-krishna">Loading Animation</h2>
        <p className="mb-4 text-sm text-gray-500">
          Pick which shimmer/pulse/wave animation every loading skeleton on the site uses.
        </p>
        {isLoading ? (
          <div className="space-y-3">
            <Skeleton className="h-16 w-full rounded-xl" />
            <Skeleton className="h-16 w-full rounded-xl" />
          </div>
        ) : (
          <div className="space-y-3">
            {presets.map((preset) => (
              <button
                key={preset.id}
                type="button"
                onClick={() => activate(preset)}
                className={cn(
                  "flex w-full items-center gap-4 rounded-xl border-2 p-4 text-left transition-all",
                  preset.isActive ? "border-saffron bg-saffron/5" : "border-gray-100 hover:border-gray-200"
                )}
              >
                <div
                  data-skeleton-anim={preset.name}
                  style={{
                    ["--skeleton-duration" as string]: `${preset.durationMs}ms`,
                    ["--skeleton-delay" as string]: `${preset.delayMs}ms`,
                    ["--skeleton-easing" as string]: preset.easing,
                  }}
                >
                  <div className="skeleton h-10 w-16 shrink-0 rounded-lg" />
                </div>
                <div className="flex-1">
                  <p className="font-medium text-krishna">{preset.displayName}</p>
                  <p className="text-xs text-gray-400">{preset.durationMs}ms · {preset.easing}</p>
                </div>
                {preset.isActive && (
                  <span className="flex h-6 w-6 shrink-0 items-center justify-center rounded-full bg-saffron text-white">
                    <Check className="h-3.5 w-3.5" />
                  </span>
                )}
              </button>
            ))}
          </div>
        )}
      </CardContent>
    </Card>
  );
}
