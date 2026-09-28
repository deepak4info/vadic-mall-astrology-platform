"use client";

import { useQuery, useQueryClient } from "@tanstack/react-query";
import { notificationsGet, notificationsPost, getApiErrorMessage, isSessionError } from "@/lib/api";
import { useAuthStore } from "@/store/auth";
import type { AppNotification } from "@/lib/types";
import toast from "react-hot-toast";

const QUERY_KEY = ["notifications"];

export function useNotifications() {
  const { user } = useAuthStore();
  const queryClient = useQueryClient();
  const enabled = !!user;
  const { data: items = [], isLoading } = useQuery({
    queryKey: QUERY_KEY,
    queryFn: () => notificationsGet<AppNotification[]>(),
    enabled,
  });
  const unreadCount = items.filter((n) => !n.isRead).length;

  const invalidate = () => queryClient.invalidateQueries({ queryKey: QUERY_KEY });

  const markRead = async (id: string) => {
    try {
      await notificationsPost(`/${id}/read`);
      await invalidate();
    } catch (error) {
      if (!isSessionError(error)) toast.error(getApiErrorMessage(error));
    }
  };

  const markAllRead = async () => {
    try {
      await notificationsPost("/read-all");
      await invalidate();
    } catch (error) {
      if (!isSessionError(error)) toast.error(getApiErrorMessage(error));
    }
  };

  return { items, isLoading, unreadCount, markRead, markAllRead };
}
