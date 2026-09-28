"use client";

import { useQueryClient } from "@tanstack/react-query";
import toast from "react-hot-toast";
import { customerDelete, customerPost, getApiErrorMessage, isSessionError } from "@/lib/api";
import { useCustomerData } from "@/lib/hooks";
import { useAuthStore } from "@/store/auth";
import type { WishlistItem } from "@/lib/types";

export function useWishlist() {
  const { user } = useAuthStore();
  const queryClient = useQueryClient();
  const canUseWishlist = !!user && (user.role === "Customer" || user.role === "SuperAdmin");
  const { data: items = [], isLoading } = useCustomerData<WishlistItem[]>("wishlist", "/wishlist", canUseWishlist);

  const isWishlisted = (productId: string) => items.some((i) => i.productId === productId);

  const toggle = async (productId: string) => {
    if (!canUseWishlist) {
      toast.error(user ? "Wishlist is only available for customer accounts" : "Please login to use your wishlist");
      return;
    }
    try {
      if (isWishlisted(productId)) {
        await customerDelete(`/wishlist/${productId}`);
        toast.success("Removed from wishlist");
      } else {
        await customerPost("/wishlist", { productId });
        toast.success("Added to wishlist");
      }
      await queryClient.invalidateQueries({ queryKey: ["customer", "wishlist"] });
    } catch (error) {
      if (!isSessionError(error)) toast.error(getApiErrorMessage(error));
    }
  };

  return { items, isLoading, isWishlisted, toggle, count: items.length };
}
