import axios from "axios";
import type { AuthResponse } from "@/lib/types";

const API_URL = process.env.NEXT_PUBLIC_API_URL || "https://deepak4info-001-site1.ftempurl.com/api";

export const api = axios.create({
  baseURL: API_URL,
  headers: { "Content-Type": "application/json" },
  timeout: 15000,
});

api.interceptors.request.use((config) => {
  if (typeof window !== "undefined") {
    const token = localStorage.getItem("vadic_token");
    if (token) config.headers.Authorization = `Bearer ${token}`;
  }
  return config;
});

let refreshPromise: Promise<string | null> | null = null;

async function refreshAuthToken(): Promise<string | null> {
  // Lazy import avoids a circular import at module-load time (store/auth.ts imports this file).
  const { useAuthStore } = await import("@/store/auth");
  const { refreshToken, setAuth, logout } = useAuthStore.getState();
  if (!refreshToken) {
    logout();
    return null;
  }
  if (!refreshPromise) {
    refreshPromise = axios
      .post<AuthResponse>(`${API_URL}/auth/refresh-token`, { refreshToken })
      .then(({ data }) => {
        setAuth(data);
        return data.token;
      })
      .catch(() => {
        logout();
        return null;
      })
      .finally(() => {
        refreshPromise = null;
      });
  }
  return refreshPromise;
}

api.interceptors.response.use(
  (response) => response,
  async (error) => {
    const original = axios.isAxiosError(error) ? error.config : undefined;
    const status = axios.isAxiosError(error) ? error.response?.status : undefined;
    // A 403 here always means the caller's role/approval status no longer permits this
    // request (e.g. an astrologer banned or declined mid-session) — never a normal,
    // user-facing failure — so it's treated exactly like an expired token: try to
    // refresh, and if that also fails, the account really is invalid and gets logged out.
    if (
      (status === 401 || status === 403) &&
      original &&
      !(original as { _retry?: boolean })._retry &&
      !original.url?.includes("/auth/")
    ) {
      (original as { _retry?: boolean })._retry = true;
      const newToken = await refreshAuthToken();
      if (newToken) {
        original.headers = original.headers ?? {};
        original.headers.Authorization = `Bearer ${newToken}`;
        return api(original);
      }
    }
    return Promise.reject(error);
  }
);

export function getApiErrorMessage(error: unknown, fallback = "Something went wrong") {
  if (axios.isAxiosError(error)) {
    const data = error.response?.data as { message?: string } | undefined;
    // Deliberately no fallback to axios's own error.message here — for a bare 401/403
    // with no response body (a role/session check failing, not a business-logic error),
    // that text is just "Request failed with status code 403", which is meaningless and
    // alarming to a real user. Silently fall back to the caller's friendly message instead.
    return data?.message || fallback;
  }
  return fallback;
}

// True when a request failed because the session/role is no longer valid (token expired,
// or the account got banned/declined mid-session) rather than because the action itself
// failed. Callers use this to skip showing an error toast — the axios interceptor is
// already logging the user out, so surfacing a message here would just be noise.
export function isSessionError(error: unknown) {
  return axios.isAxiosError(error) && (error.response?.status === 401 || error.response?.status === 403);
}

export async function fetchCatalog<T>(path: string, params?: Record<string, string | number | boolean | undefined>) {
  const { data } = await api.get<T>(path, { params });
  return data;
}

export async function postCatalog<T>(path: string, body: unknown) {
  const { data } = await api.post<T>(path, body);
  return data;
}

export async function authPost<T>(path: string, body: unknown) {
  const { data } = await api.post<T>(`/auth${path}`, body);
  return data;
}

export async function authGet<T>(path: string) {
  const { data } = await api.get<T>(`/auth${path}`);
  return data;
}

export async function customerGet<T>(path: string) {
  const { data } = await api.get<T>(`/customer${path}`);
  return data;
}

export async function customerPost<T>(path: string, body?: unknown) {
  const { data } = await api.post<T>(`/customer${path}`, body);
  return data;
}

export async function customerDelete<T>(path: string) {
  const { data } = await api.delete<T>(`/customer${path}`);
  return data;
}

export async function notificationsGet<T>(path = "") {
  const { data } = await api.get<T>(`/notifications${path}`);
  return data;
}

export async function notificationsPost<T>(path: string, body?: unknown) {
  const { data } = await api.post<T>(`/notifications${path}`, body);
  return data;
}

export async function adminGet<T>(path: string) {
  const { data } = await api.get<T>(`/admin${path}`);
  return data;
}

export async function adminPost<T>(path: string, body?: unknown) {
  const { data } = await api.post<T>(`/admin${path}`, body);
  return data;
}

export async function astrologerGet<T>(path: string) {
  const { data } = await api.get<T>(`/astrologer${path}`);
  return data;
}

export async function adminPostForm<T>(path: string, formData: FormData) {
  const { data } = await api.post<T>(`/admin${path}`, formData, {
    headers: { "Content-Type": undefined },
  });
  return data;
}

export async function adminPutForm<T>(path: string, formData: FormData) {
  const { data } = await api.put<T>(`/admin${path}`, formData, {
    headers: { "Content-Type": undefined },
  });
  return data;
}

export async function adminPut<T>(path: string, body: unknown) {
  const { data } = await api.put<T>(`/admin${path}`, body);
  return data;
}

export async function adminPatch<T>(path: string, body: unknown) {
  const { data } = await api.patch<T>(`/admin${path}`, body);
  return data;
}

export async function adminDelete<T>(path: string) {
  const { data } = await api.delete<T>(`/admin${path}`);
  return data;
}
