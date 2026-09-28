"use client";

import { useEffect, useState } from "react";
import { useQueryClient } from "@tanstack/react-query";
import toast from "react-hot-toast";
import { ImagePlus, X } from "lucide-react";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { adminGet, adminPostForm, adminPutForm, getApiErrorMessage } from "@/lib/api";
import { useAdminData } from "@/lib/hooks";
import { getImageUrl } from "@/lib/utils";
import type { AdminCategory, AdminProduct, AdminProductDetail } from "@/lib/types";

const emptyForm = {
  name: "",
  description: "",
  categoryId: "",
  price: "",
  salePrice: "",
  stockQuantity: "",
  isFeatured: false,
  isActive: true,
  festivalTag: "",
};

type ImageSlot = { file: File | null; existingUrl: string | null; preview: string };

export function AddProductModal({
  open,
  onOpenChange,
  productId,
}: {
  open: boolean;
  onOpenChange: (open: boolean) => void;
  productId?: string;
}) {
  const isEdit = !!productId;
  const queryClient = useQueryClient();
  const { data: categories = [] } = useAdminData<AdminCategory[]>("categories", "/categories", open);
  const [form, setForm] = useState(emptyForm);
  const [slots, setSlots] = useState<ImageSlot[]>([]);
  const [submitting, setSubmitting] = useState(false);
  const [loading, setLoading] = useState(isEdit);

  const reset = () => {
    setForm(emptyForm);
    setSlots([]);
  };

  useEffect(() => {
    if (!open) return;
    if (!productId) {
      reset();
      return;
    }
    setLoading(true);
    adminGet<AdminProductDetail>(`/products/${productId}`)
      .then((p) => {
        setForm({
          name: p.name,
          description: p.description,
          categoryId: p.categoryId,
          price: String(p.price),
          salePrice: p.salePrice != null ? String(p.salePrice) : "",
          stockQuantity: String(p.stockQuantity),
          isFeatured: p.isFeatured,
          isActive: p.isActive,
          festivalTag: p.festivalTag || "",
        });
        const loadedSlots: ImageSlot[] = [];
        (p.images || []).forEach((url) => {
          const preview = getImageUrl(url);
          if (preview) loadedSlots.push({ file: null, existingUrl: url, preview });
        });
        setSlots(loadedSlots);
      })
      .catch(() => toast.error("Failed to load product"))
      .finally(() => setLoading(false));
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open, productId]);

  const handleAddImages = (files: FileList | null) => {
    if (!files || files.length === 0) return;
    const added = Array.from(files).map((file) => ({ file, existingUrl: null, preview: URL.createObjectURL(file) }));
    setSlots((prev) => [...prev, ...added]);
  };

  const handleRemoveSlot = (index: number) => {
    setSlots((prev) => prev.filter((_, i) => i !== index));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!form.categoryId) {
      toast.error("Please select a category");
      return;
    }
    setSubmitting(true);
    try {
      const formData = new FormData();
      formData.append("name", form.name);
      formData.append("description", form.description);
      formData.append("categoryId", form.categoryId);
      formData.append("price", form.price);
      if (form.salePrice) formData.append("salePrice", form.salePrice);
      formData.append("stockQuantity", form.stockQuantity || "0");
      formData.append("isFeatured", String(form.isFeatured));
      if (isEdit) formData.append("isActive", String(form.isActive));
      if (form.festivalTag) formData.append("festivalTag", form.festivalTag);
      // Every slot — however many there are — is sent through: new files go in "images"
      // (in order) with a matching "NEW" marker in "imageOrder"; kept existing images are
      // sent as their URL directly in "imageOrder", so the backend can rebuild the exact
      // display order while persisting every image, not just a fixed number of them.
      slots.forEach((slot) => {
        if (slot.file) {
          formData.append("images", slot.file);
          if (isEdit) formData.append("imageOrder", "NEW");
        } else if (slot.existingUrl) {
          formData.append("imageOrder", slot.existingUrl);
        }
      });

      if (isEdit) {
        await adminPutForm<AdminProduct>(`/products/${productId}`, formData);
        toast.success("Product updated successfully");
      } else {
        await adminPostForm<AdminProduct>("/products", formData);
        toast.success("Product created successfully");
      }
      await queryClient.invalidateQueries({ queryKey: ["admin", "products"] });
      reset();
      onOpenChange(false);
    } catch (error) {
      toast.error(getApiErrorMessage(error, isEdit ? "Failed to update product" : "Failed to create product"));
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={(v) => { onOpenChange(v); if (!v) reset(); }}>
      <DialogContent className="max-w-2xl">
        <DialogHeader>
          <DialogTitle>{isEdit ? "Edit Product" : "Add New Product"}</DialogTitle>
        </DialogHeader>
        {loading ? (
          <p className="py-10 text-center text-sm text-gray-500">Loading product...</p>
        ) : (
          <form onSubmit={handleSubmit} className="space-y-4">
            <div>
              <p className="mb-2 text-sm font-medium text-gray-700">
                Product images — add as many as you like; the first one is used as the main image
              </p>
              <div className="flex flex-wrap gap-2 sm:gap-3">
                {slots.map((slot, i) => (
                  <div key={i} className="relative h-20 w-20 sm:h-24 sm:w-24">
                    <div
                      className={
                        i === 0
                          ? "h-full w-full overflow-hidden rounded-xl border-2 border-saffron/60"
                          : "h-full w-full overflow-hidden rounded-xl border-2 border-gray-200"
                      }
                    >
                      {/* eslint-disable-next-line @next/next/no-img-element */}
                      <img
                        src={slot.preview}
                        alt={i === 0 ? "Main image" : `Image ${i + 1}`}
                        className="h-full w-full object-cover"
                        onError={() => handleRemoveSlot(i)}
                      />
                    </div>
                    {i === 0 && (
                      <span className="pointer-events-none absolute bottom-1 left-1 rounded bg-black/50 px-1.5 py-0.5 text-[10px] text-white">
                        Main
                      </span>
                    )}
                    <button
                      type="button"
                      onClick={() => handleRemoveSlot(i)}
                      className="absolute -right-1.5 -top-1.5 flex h-5 w-5 items-center justify-center rounded-full bg-maroon text-white shadow"
                      aria-label="Remove image"
                    >
                      <X className="h-3 w-3" />
                    </button>
                  </div>
                ))}
                <label className="flex h-20 w-20 cursor-pointer flex-col items-center justify-center gap-1 rounded-xl border-2 border-dashed border-gray-200 bg-gray-50 text-center hover:border-saffron sm:h-24 sm:w-24">
                  <ImagePlus className="h-5 w-5 text-gray-400" />
                  <span className="px-1 text-[10px] leading-tight text-gray-400">
                    {slots.length === 0 ? "Add main image" : "Add image"}
                  </span>
                  <input
                    type="file"
                    accept="image/*"
                    multiple
                    className="hidden"
                    onChange={(e) => {
                      handleAddImages(e.target.files);
                      e.target.value = "";
                    }}
                  />
                </label>
              </div>
            </div>

            <Input
              required
              placeholder="Product name"
              value={form.name}
              onChange={(e) => setForm({ ...form, name: e.target.value })}
            />

            <textarea
              required
              placeholder="Description"
              value={form.description}
              onChange={(e) => setForm({ ...form, description: e.target.value })}
              rows={3}
              className="flex w-full rounded-xl border border-gray-200 bg-white px-4 py-2 text-sm placeholder:text-gray-400 focus:border-saffron focus:outline-none focus:ring-2 focus:ring-saffron/20"
            />

            <select
              required
              value={form.categoryId}
              onChange={(e) => setForm({ ...form, categoryId: e.target.value })}
              className="flex h-11 w-full rounded-xl border border-gray-200 bg-white px-4 py-2 text-sm focus:border-saffron focus:outline-none focus:ring-2 focus:ring-saffron/20"
            >
              <option value="">Select category</option>
              {categories.map((c) => (
                <option key={c.id} value={c.id}>{c.name}</option>
              ))}
            </select>

            <div className="grid grid-cols-2 gap-3">
              <Input
                required
                type="number"
                min="0"
                step="0.01"
                placeholder="Price (₹)"
                value={form.price}
                onChange={(e) => setForm({ ...form, price: e.target.value })}
              />
              <Input
                type="number"
                min="0"
                step="0.01"
                placeholder="Sale price (optional)"
                value={form.salePrice}
                onChange={(e) => setForm({ ...form, salePrice: e.target.value })}
              />
            </div>

            <div className="grid grid-cols-2 gap-3">
              <Input
                required
                type="number"
                min="0"
                placeholder="Stock quantity"
                value={form.stockQuantity}
                onChange={(e) => setForm({ ...form, stockQuantity: e.target.value })}
              />
              <Input
                placeholder="Festival tag (optional)"
                value={form.festivalTag}
                onChange={(e) => setForm({ ...form, festivalTag: e.target.value })}
              />
            </div>

            <div className="flex flex-wrap items-center gap-4">
              <label className="flex items-center gap-2 text-sm text-gray-600">
                <input
                  type="checkbox"
                  checked={form.isFeatured}
                  onChange={(e) => setForm({ ...form, isFeatured: e.target.checked })}
                  className="h-4 w-4 rounded border-gray-300 text-saffron focus:ring-saffron"
                />
                Mark as featured
              </label>
              {isEdit && (
                <label className="flex items-center gap-2 text-sm text-gray-600">
                  <input
                    type="checkbox"
                    checked={form.isActive}
                    onChange={(e) => setForm({ ...form, isActive: e.target.checked })}
                    className="h-4 w-4 rounded border-gray-300 text-saffron focus:ring-saffron"
                  />
                  Active (visible in store)
                </label>
              )}
            </div>

            <Button type="submit" variant="indigo" className="w-full" size="lg" disabled={submitting}>
              {submitting ? "Saving..." : isEdit ? "Save Changes" : "Create Product"}
            </Button>
          </form>
        )}
      </DialogContent>
    </Dialog>
  );
}
