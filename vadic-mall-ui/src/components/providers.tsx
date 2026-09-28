"use client";

import { QueryClient, QueryClientProvider } from "@tanstack/react-query";
import { Toaster } from "react-hot-toast";
import { useEffect, useState } from "react";
import { useAuthStore, useAuthHydrated } from "@/store/auth";

export function Providers({ children }: { children: React.ReactNode }) {
  const [queryClient] = useState(() => new QueryClient({
    defaultOptions: {
      queries: {
        staleTime: 30_000,
        gcTime: 5 * 60_000,
        retry: 1,
        refetchOnWindowFocus: false,
      },
    },
  }));
  const hydrate = useAuthStore((s) => s.hydrate);
  const authHydrated = useAuthHydrated();

  useEffect(() => {
    // Only revalidate against /auth/me once the persisted token has actually loaded from
    // localStorage — calling this earlier would read a still-null token and no-op.
    if (!authHydrated) return;
    hydrate();

    // An admin granting/revoking staff roles should reach an already-open session without
    // the user having to reload: poll /auth/me (which recomputes permissions fresh from the
    // DB) periodically and again whenever the tab regains focus.
    const interval = setInterval(hydrate, 20_000);
    window.addEventListener("focus", hydrate);
    return () => {
      clearInterval(interval);
      window.removeEventListener("focus", hydrate);
    };
  }, [authHydrated, hydrate]);

  return (
    <QueryClientProvider client={queryClient}>
      {children}
      <Toaster position="top-right" toastOptions={{
        style: { background: "#0d0d2b", color: "#fff", border: "1px solid #FF9933" },
      }} />
    </QueryClientProvider>
  );
}
