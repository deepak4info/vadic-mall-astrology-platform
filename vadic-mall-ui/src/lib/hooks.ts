"use client";

import { keepPreviousData, useQuery } from "@tanstack/react-query";
import { adminGet, api, astrologerGet, customerGet, fetchCatalog } from "./api";

// `placeholderData: keepPreviousData` keeps the last successful result on screen (instead of
// unmounting into a full loading state) while a query re-fetches under a new key — e.g.
// switching a category filter or an admin tab. The UI can dim/fade the stale content via
// `isFetching` without ever flashing a blank skeleton for data it already had.

export function useCatalog<T>(key: string, path: string, params?: Record<string, string | number | boolean | undefined>) {
  return useQuery({
    queryKey: ["catalog", key, params],
    queryFn: () => fetchCatalog<T>(path, params),
    placeholderData: keepPreviousData,
  });
}

export function useCatalogItem<T>(key: string, path: string, enabled = true) {
  return useQuery({
    // `path` (not just `key`) must be part of the cache key: two different items (e.g.
    // /catalog/products/A vs /catalog/products/B) were previously sharing one cache entry
    // under the same static `key` label, so navigating from one item's page to another's
    // served the first item's cached data instead of fetching the new one.
    queryKey: ["catalog", key, path],
    queryFn: async () => (await api.get<T>(path)).data,
    enabled,
  });
}

export function useCustomerData<T>(key: string, path: string, enabled = true) {
  return useQuery({
    // Keyed by path as well as `key` for the same reason as `useCatalogItem` above — two
    // different customer endpoints called with the same `key` label would otherwise collide.
    queryKey: ["customer", key, path],
    queryFn: () => customerGet<T>(path),
    enabled,
    placeholderData: keepPreviousData,
  });
}

export function useAdminData<T>(key: string, path: string, enabled = true) {
  return useQuery({
    queryKey: ["admin", key, path],
    queryFn: () => adminGet<T>(path),
    enabled,
    placeholderData: keepPreviousData,
  });
}

export function useAstrologerData<T>(key: string, path: string, enabled = true) {
  return useQuery({
    queryKey: ["astrologer", key, path],
    queryFn: () => astrologerGet<T>(path),
    enabled,
    placeholderData: keepPreviousData,
  });
}
