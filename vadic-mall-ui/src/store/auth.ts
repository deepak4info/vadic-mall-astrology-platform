"use client";

import { useEffect, useState } from "react";
import { create } from "zustand";
import { persist } from "zustand/middleware";
import type { AuthResponse, User } from "@/lib/types";
import { authGet, authPost } from "@/lib/api";

interface AuthState {
  user: User | null;
  token: string | null;
  refreshToken: string | null;
  isLoading: boolean;
  login: (email: string, password: string) => Promise<void>;
  register: (data: { email: string; password: string; firstName: string; lastName: string; phone?: string }) => Promise<void>;
  logout: () => void;
  setAuth: (response: AuthResponse) => void;
  hydrate: () => Promise<void>;
  changePassword: (currentPassword: string, newPassword: string) => Promise<void>;
}

export const useAuthStore = create<AuthState>()(
  persist(
    (set, get) => ({
      user: null,
      token: null,
      refreshToken: null,
      isLoading: false,
      login: async (email, password) => {
        set({ isLoading: true });
        try {
          const response = await authPost<AuthResponse>("/login", { email, password });
          localStorage.setItem("vadic_token", response.token);
          set({ user: response.user, token: response.token, refreshToken: response.refreshToken, isLoading: false });
        } catch (error) {
          set({ isLoading: false });
          throw error;
        }
      },
      register: async (data) => {
        set({ isLoading: true });
        try {
          const response = await authPost<AuthResponse>("/register", data);
          localStorage.setItem("vadic_token", response.token);
          set({ user: response.user, token: response.token, refreshToken: response.refreshToken, isLoading: false });
        } catch {
          set({ isLoading: false });
          throw new Error("Registration failed");
        }
      },
      logout: () => {
        localStorage.removeItem("vadic_token");
        set({ user: null, token: null, refreshToken: null });
      },
      setAuth: (response) => {
        localStorage.setItem("vadic_token", response.token);
        set({ user: response.user, token: response.token, refreshToken: response.refreshToken });
      },
      hydrate: async () => {
        if (!get().token) return;
        try {
          const user = await authGet<User>("/me");
          set({ user });
        } catch {
          localStorage.removeItem("vadic_token");
          set({ user: null, token: null, refreshToken: null });
        }
      },
      changePassword: async (currentPassword, newPassword) => {
        await authPost("/change-password", { currentPassword, newPassword });
      },
    }),
    { name: "vadic-auth" }
  )
);

/**
 * zustand persist reads localStorage asynchronously after first mount, so `user`/`token`
 * are briefly null on a hard page load even for an authenticated session. Route guards must
 * wait for this to settle before deciding to redirect, or they'll bounce logged-in users.
 *
 * `.persist` is only touched inside the effect: on the server there is no `window`, so the
 * persist middleware never attaches `.persist` to the store, and reading it during the
 * initial (SSR) render would throw. `useEffect` never runs on the server, so this is safe.
 */
export function useAuthHydrated() {
  const [hydrated, setHydrated] = useState(false);
  useEffect(() => {
    setHydrated(useAuthStore.persist.hasHydrated());
    return useAuthStore.persist.onFinishHydration(() => setHydrated(true));
  }, []);
  return hydrated;
}
