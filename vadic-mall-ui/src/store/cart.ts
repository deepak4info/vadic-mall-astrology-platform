"use client";

import { create } from "zustand";
import { persist } from "zustand/middleware";

export interface LocalCartItem {
  productId: string;
  name: string;
  price: number;
  salePrice?: number;
  imageUrl?: string;
  quantity: number;
}

interface CartState {
  items: LocalCartItem[];
  addItem: (item: Omit<LocalCartItem, "quantity">, quantity?: number) => void;
  removeItem: (productId: string) => void;
  updateQuantity: (productId: string, quantity: number) => void;
  clearCart: () => void;
  itemCount: () => number;
  subTotal: () => number;
}

export const useCartStore = create<CartState>()(
  persist(
    (set, get) => ({
      items: [],
      addItem: (item, quantity = 1) => {
        const existing = get().items.find((i) => i.productId === item.productId);
        if (existing) {
          set({
            items: get().items.map((i) =>
              i.productId === item.productId ? { ...i, quantity: i.quantity + quantity } : i
            ),
          });
        } else {
          set({ items: [...get().items, { ...item, quantity }] });
        }
      },
      removeItem: (productId) => set({ items: get().items.filter((i) => i.productId !== productId) }),
      updateQuantity: (productId, quantity) => {
        if (quantity <= 0) {
          get().removeItem(productId);
          return;
        }
        set({
          items: get().items.map((i) => (i.productId === productId ? { ...i, quantity } : i)),
        });
      },
      clearCart: () => set({ items: [] }),
      itemCount: () => get().items.reduce((sum, i) => sum + i.quantity, 0),
      subTotal: () =>
        get().items.reduce((sum, i) => sum + (i.salePrice ?? i.price) * i.quantity, 0),
    }),
    { name: "vadic-cart" }
  )
);
