"use client";

import { useEffect, useState } from "react";
import { useQueryClient } from "@tanstack/react-query";
import toast from "react-hot-toast";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { adminPost, adminPut, getApiErrorMessage } from "@/lib/api";
import type { AdminCoupon } from "@/lib/types";

const emptyForm = {
  code: "",
  description: "",
  type: "Percentage",
  value: "",
  minOrderValue: "",
  maxDiscount: "",
  usageLimit: "100",
  validFrom: new Date().toISOString().slice(0, 10),
  validTo: "",
  festivalTag: "",
  isActive: true,
};

export function CouponModal({ open, onOpenChange, couponId }: { open: boolean; onOpenChange: (open: boolean) => void; couponId?: string }) {
  const isEdit = !!couponId;
  const queryClient = useQueryClient();
  const [form, setForm] = useState(emptyForm);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (!open) return;
    if (!couponId) {
      setForm(emptyForm);
      return;
    }
    const coupons = queryClient.getQueryData<AdminCoupon[]>(["admin", "coupons"]);
    const existing = coupons?.find((c) => c.id === couponId);
    if (existing) {
      setForm({
        code: existing.code,
        description: existing.description,
        type: existing.type,
        value: String(existing.value),
        minOrderValue: existing.minOrderValue != null ? String(existing.minOrderValue) : "",
        maxDiscount: existing.maxDiscount != null ? String(existing.maxDiscount) : "",
        usageLimit: String(existing.usageLimit),
        validFrom: existing.validFrom.slice(0, 10),
        validTo: existing.validTo.slice(0, 10),
        festivalTag: existing.festivalTag ?? "",
        isActive: existing.isActive,
      });
    }
  }, [open, couponId, queryClient]);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setSubmitting(true);
    try {
      const payload = {
        code: form.code.toUpperCase(),
        description: form.description,
        type: form.type,
        value: Number(form.value),
        minOrderValue: form.minOrderValue ? Number(form.minOrderValue) : null,
        maxDiscount: form.maxDiscount ? Number(form.maxDiscount) : null,
        usageLimit: Number(form.usageLimit),
        validFrom: new Date(form.validFrom).toISOString(),
        validTo: new Date(form.validTo).toISOString(),
        festivalTag: form.festivalTag || null,
        isActive: form.isActive,
      };
      if (isEdit) await adminPut(`/coupons/${couponId}`, payload);
      else await adminPost("/coupons", payload);
      await queryClient.invalidateQueries({ queryKey: ["admin", "coupons"] });
      toast.success(isEdit ? "Offer updated" : "Offer created");
      onOpenChange(false);
    } catch (error) {
      toast.error(getApiErrorMessage(error, isEdit ? "Failed to update offer" : "Failed to create offer"));
    } finally {
      setSubmitting(false);
    }
  };

  const inputClass = "flex h-11 w-full rounded-xl border border-gray-200 bg-white px-4 py-2 text-sm focus:border-saffron focus:outline-none focus:ring-2 focus:ring-saffron/20";

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader><DialogTitle>{isEdit ? "Edit Offer" : "Add Offer"}</DialogTitle></DialogHeader>
        <form onSubmit={handleSubmit} className="space-y-4">
          <input
            required
            disabled={isEdit}
            value={form.code}
            onChange={(e) => setForm({ ...form, code: e.target.value })}
            placeholder="Coupon code (e.g. DIWALI25)"
            className={`${inputClass} uppercase disabled:bg-gray-50 disabled:text-gray-400`}
          />
          <input
            required
            value={form.description}
            onChange={(e) => setForm({ ...form, description: e.target.value })}
            placeholder="Description"
            className={inputClass}
          />
          <div className="grid grid-cols-2 gap-3">
            <select value={form.type} onChange={(e) => setForm({ ...form, type: e.target.value })} className={inputClass}>
              <option value="Percentage">Percentage</option>
              <option value="FixedAmount">Fixed Amount</option>
              <option value="FreeShipping">Free Shipping</option>
            </select>
            <input
              required
              type="number" min="0" step="0.01"
              value={form.value}
              onChange={(e) => setForm({ ...form, value: e.target.value })}
              placeholder={form.type === "Percentage" ? "Discount %" : "Discount amount"}
              className={inputClass}
            />
          </div>
          <div className="grid grid-cols-2 gap-3">
            <input
              type="number" min="0" step="0.01"
              value={form.minOrderValue}
              onChange={(e) => setForm({ ...form, minOrderValue: e.target.value })}
              placeholder="Min order value"
              className={inputClass}
            />
            <input
              type="number" min="0" step="0.01"
              value={form.maxDiscount}
              onChange={(e) => setForm({ ...form, maxDiscount: e.target.value })}
              placeholder="Max discount cap"
              className={inputClass}
            />
          </div>
          <div className="grid grid-cols-2 gap-3">
            <input
              required
              type="number" min="1"
              value={form.usageLimit}
              onChange={(e) => setForm({ ...form, usageLimit: e.target.value })}
              placeholder="Usage limit"
              className={inputClass}
            />
            <input
              value={form.festivalTag}
              onChange={(e) => setForm({ ...form, festivalTag: e.target.value })}
              placeholder="Festival tag (optional)"
              className={inputClass}
            />
          </div>
          <div className="grid grid-cols-2 gap-3">
            <div>
              <label className="mb-1 block text-xs text-gray-500">Valid From</label>
              <input required type="date" value={form.validFrom} onChange={(e) => setForm({ ...form, validFrom: e.target.value })} className={inputClass} />
            </div>
            <div>
              <label className="mb-1 block text-xs text-gray-500">Valid To</label>
              <input required type="date" value={form.validTo} onChange={(e) => setForm({ ...form, validTo: e.target.value })} className={inputClass} />
            </div>
          </div>
          <label className="flex items-center gap-2 text-sm text-gray-600">
            <input type="checkbox" checked={form.isActive} onChange={(e) => setForm({ ...form, isActive: e.target.checked })} className="h-4 w-4 rounded border-gray-300 text-saffron focus:ring-saffron" />
            Active
          </label>
          <Button type="submit" variant="indigo" className="w-full" size="lg" disabled={submitting}>
            {submitting ? "Saving..." : isEdit ? "Save Changes" : "Create Offer"}
          </Button>
        </form>
      </DialogContent>
    </Dialog>
  );
}
