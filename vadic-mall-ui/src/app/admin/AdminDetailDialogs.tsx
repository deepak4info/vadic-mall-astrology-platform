"use client";

import { useEffect, useState } from "react";
import { useQueryClient } from "@tanstack/react-query";
import toast from "react-hot-toast";
import { Dialog, DialogContent, DialogHeader, DialogTitle } from "@/components/ui/dialog";
import { Button } from "@/components/ui/button";
import { Badge } from "@/components/ui/badge";
import { ImagePlus } from "lucide-react";
import { adminGet, adminPut, adminPutForm, adminPatch, getApiErrorMessage } from "@/lib/api";
import { cn, formatPrice, getImageUrl, checkImageAlreadyFailed } from "@/lib/utils";
import type { AdminUser, AdminProduct, AdminProductDetail, AdminPoojaDetail, AdminOrderDetail } from "@/lib/types";
import { ORDER_STATUSES, STAFF_PERMISSIONS } from "@/lib/types";

function Field({ label, value }: { label: string; value: React.ReactNode }) {
  return (
    <div className="flex justify-between border-b border-gray-100 py-2 text-sm last:border-0">
      <span className="text-gray-500">{label}</span>
      <span className="font-medium text-krishna">{value}</span>
    </div>
  );
}

export function UserViewDialog({ open, onOpenChange, user }: { open: boolean; onOpenChange: (o: boolean) => void; user: AdminUser | null }) {
  if (!user) return null;
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader><DialogTitle>User Details</DialogTitle></DialogHeader>
        <Field label="Name" value={`${user.firstName} ${user.lastName}`} />
        <Field label="Email" value={user.email} />
        <Field label="Role" value={<Badge>{user.role}</Badge>} />
        <Field label="Status" value={user.isActive ? <span className="text-green-600">Active</span> : <span className="text-gray-400">Inactive</span>} />
        <Field label="Joined" value={new Date(user.createdAt).toLocaleString()} />
      </DialogContent>
    </Dialog>
  );
}

export function ManagePermissionsDialog({ open, onOpenChange, user }: { open: boolean; onOpenChange: (o: boolean) => void; user: AdminUser | null }) {
  const queryClient = useQueryClient();
  const [approved, setApproved] = useState(false);
  const [permissions, setPermissions] = useState<string[]>([]);
  const [approving, setApproving] = useState(false);
  const [saving, setSaving] = useState(false);

  useEffect(() => {
    if (!open || !user) return;
    setApproved(user.isStaffApproved);
    setPermissions(user.permissions);
  }, [open, user]);

  if (!user) return null;

  const refresh = () => queryClient.invalidateQueries({ queryKey: ["admin", "users"] });

  const handleApprovalToggle = async () => {
    const next = !approved;
    setApproving(true);
    try {
      await adminPatch(`/users/${user.id}/staff-approval`, { isApproved: next });
      setApproved(next);
      if (!next) setPermissions([]);
      await refresh();
      toast.success(next ? "User approved for staff access" : "Staff access revoked");
    } catch (error) {
      toast.error(getApiErrorMessage(error));
    } finally {
      setApproving(false);
    }
  };

  const togglePermission = (key: string) => {
    setPermissions((prev) => (prev.includes(key) ? prev.filter((p) => p !== key) : [...prev, key]));
  };

  const handleSavePermissions = async () => {
    setSaving(true);
    try {
      await adminPut(`/users/${user.id}/permissions`, { permissions });
      await refresh();
      toast.success("Roles updated");
      onOpenChange(false);
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Failed to update roles"));
    } finally {
      setSaving(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader><DialogTitle>Manage Roles — {user.firstName} {user.lastName}</DialogTitle></DialogHeader>

        <div className="flex items-center justify-between rounded-xl border border-gray-100 bg-gray-50 px-4 py-3">
          <div>
            <p className="text-sm font-medium text-krishna">Approved for staff access</p>
            <p className="text-xs text-gray-500">Must be approved before any role can be assigned.</p>
          </div>
          <button
            type="button"
            role="switch"
            aria-checked={approved}
            disabled={approving}
            onClick={handleApprovalToggle}
            className={`relative inline-flex h-6 w-11 shrink-0 items-center rounded-full transition-colors duration-200 ${approved ? "bg-krishna" : "bg-gray-300"} disabled:opacity-60`}
          >
            <span
              className={`inline-block h-5 w-5 transform rounded-full bg-white shadow transition-transform duration-200 ease-in-out ${approved ? "translate-x-[22px]" : "translate-x-0.5"}`}
            />
          </button>
        </div>

        <div className={`space-y-2 pt-2 ${!approved ? "pointer-events-none opacity-50" : ""}`}>
          <p className="text-sm font-medium text-gray-500">Assign one or more roles</p>
          {STAFF_PERMISSIONS.map((p) => (
            <label key={p.key} className="flex cursor-pointer items-start gap-3 rounded-xl border border-gray-100 p-3 hover:bg-gray-50">
              <input
                type="checkbox"
                checked={permissions.includes(p.key)}
                onChange={() => togglePermission(p.key)}
                className="mt-0.5 h-4 w-4 rounded border-gray-300 text-indigo focus:ring-indigo"
              />
              <span>
                <span className="block text-sm font-medium text-krishna">{p.label}</span>
                <span className="block text-xs text-gray-500">{p.description}</span>
              </span>
            </label>
          ))}
        </div>

        <Button variant="indigo" className="w-full" size="lg" disabled={!approved || saving} onClick={handleSavePermissions}>
          {saving ? "Saving..." : "Save Roles"}
        </Button>
      </DialogContent>
    </Dialog>
  );
}

export function ProductViewDialog({ open, onOpenChange, product }: { open: boolean; onOpenChange: (o: boolean) => void; product: AdminProduct | null }) {
  const [detail, setDetail] = useState<AdminProductDetail | null>(null);

  useEffect(() => {
    if (!open || !product) { setDetail(null); return; }
    adminGet<AdminProductDetail>(`/products/${product.id}`).then(setDetail).catch(() => toast.error("Failed to load product"));
  }, [open, product]);

  if (!product) return null;
  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader><DialogTitle>{product.name}</DialogTitle></DialogHeader>
        {detail?.images && detail.images.length > 0 && (
          <div className="mb-4 grid grid-cols-5 gap-2">
            {detail.images.map((img, i) => (
              // eslint-disable-next-line @next/next/no-img-element
              <img
                key={img + i}
                ref={(el) => checkImageAlreadyFailed(el, () => { if (el) el.style.display = "none"; })}
                src={getImageUrl(img)}
                alt={`${product.name} ${i + 1}`}
                className={cn("aspect-square rounded-xl object-cover", i === 0 && "col-span-5 h-40 w-full sm:col-span-2 sm:h-auto")}
                onError={(e) => { e.currentTarget.style.display = "none"; }}
              />
            ))}
          </div>
        )}
        <Field label="Category" value={product.category} />
        <Field label="Price" value={formatPrice(product.price)} />
        {product.salePrice && <Field label="Sale Price" value={formatPrice(product.salePrice)} />}
        <Field label="Stock" value={product.stockQuantity > 0 ? <span className="text-green-600">In Stock ({product.stockQuantity})</span> : <span className="text-red-500">Out of Stock</span>} />
        <Field label="Featured" value={product.isFeatured ? "Yes" : "No"} />
        <Field label="Status" value={product.isActive ? <span className="text-green-600">Active</span> : <span className="text-gray-400">Inactive</span>} />
        {detail?.festivalTag && <Field label="Festival Tag" value={detail.festivalTag} />}
        {detail && (
          <div className="pt-3">
            <p className="mb-1 text-sm font-medium text-gray-500">Description</p>
            <p className="text-sm text-gray-600">{detail.description}</p>
          </div>
        )}
      </DialogContent>
    </Dialog>
  );
}

export function PoojaViewDialog({ open, onOpenChange, poojaId }: { open: boolean; onOpenChange: (o: boolean) => void; poojaId: string | null }) {
  const [detail, setDetail] = useState<AdminPoojaDetail | null>(null);

  useEffect(() => {
    if (!open || !poojaId) { setDetail(null); return; }
    adminGet<AdminPoojaDetail>(`/pooja-services/${poojaId}`).then(setDetail).catch(() => toast.error("Failed to load pooja service"));
  }, [open, poojaId]);

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader><DialogTitle>{detail?.name || "Pooja Service"}</DialogTitle></DialogHeader>
        {!detail ? (
          <p className="py-6 text-center text-sm text-gray-500">Loading...</p>
        ) : (
          <>
            {detail.imageUrl && (
              // eslint-disable-next-line @next/next/no-img-element
              <img
                ref={(el) => checkImageAlreadyFailed(el, () => { if (el) el.style.display = "none"; })}
                src={getImageUrl(detail.imageUrl)}
                alt={detail.name}
                className="mb-4 h-40 w-full rounded-xl object-cover"
                onError={(e) => { e.currentTarget.style.display = "none"; }}
              />
            )}
            <Field label="Category" value={detail.category} />
            <Field label="Price" value={formatPrice(detail.price)} />
            {detail.salePrice && <Field label="Sale Price" value={formatPrice(detail.salePrice)} />}
            <Field label="Duration" value={`${detail.durationMinutes} min`} />
            <Field label="Featured" value={detail.isFeatured ? "Yes" : "No"} />
            <Field label="Status" value={detail.isActive ? <span className="text-green-600">Active</span> : <span className="text-gray-400">Inactive</span>} />
            <div className="pt-3">
              <p className="mb-1 text-sm font-medium text-gray-500">Description</p>
              <p className="text-sm text-gray-600">{detail.description}</p>
            </div>
          </>
        )}
      </DialogContent>
    </Dialog>
  );
}

export function EditPoojaModal({ open, onOpenChange, poojaId }: { open: boolean; onOpenChange: (o: boolean) => void; poojaId: string | null }) {
  const queryClient = useQueryClient();
  const [form, setForm] = useState<AdminPoojaDetail | null>(null);
  const [image, setImage] = useState<File | null>(null);
  const [preview, setPreview] = useState<string | null>(null);
  const [submitting, setSubmitting] = useState(false);

  useEffect(() => {
    if (!open || !poojaId) { setForm(null); setImage(null); setPreview(null); return; }
    adminGet<AdminPoojaDetail>(`/pooja-services/${poojaId}`)
      .then((p) => { setForm(p); setPreview(getImageUrl(p.imageUrl) ?? null); })
      .catch(() => toast.error("Failed to load pooja service"));
  }, [open, poojaId]);

  const handleImageChange = (e: React.ChangeEvent<HTMLInputElement>) => {
    const file = e.target.files?.[0] ?? null;
    setImage(file);
    if (file) setPreview(URL.createObjectURL(file));
  };

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    if (!form || !poojaId) return;
    setSubmitting(true);
    try {
      const formData = new FormData();
      formData.append("name", form.name);
      formData.append("category", form.category);
      formData.append("description", form.description);
      formData.append("price", String(form.price));
      if (form.salePrice) formData.append("salePrice", String(form.salePrice));
      formData.append("durationMinutes", String(form.durationMinutes));
      formData.append("isFeatured", String(form.isFeatured));
      formData.append("isActive", String(form.isActive));
      if (image) formData.append("image", image);

      await adminPutForm(`/pooja-services/${poojaId}`, formData);
      await queryClient.invalidateQueries({ queryKey: ["admin", "poojas"] });
      toast.success("Pooja service updated");
      onOpenChange(false);
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Failed to update pooja service"));
    } finally {
      setSubmitting(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent>
        <DialogHeader><DialogTitle>Edit Pooja Service</DialogTitle></DialogHeader>
        {!form ? (
          <p className="py-6 text-center text-sm text-gray-500">Loading...</p>
        ) : (
          <form onSubmit={handleSubmit} className="space-y-4">
            <label className="flex cursor-pointer flex-col items-center justify-center gap-2 rounded-xl border-2 border-dashed border-gray-200 bg-gray-50 py-6 text-center hover:border-saffron">
              {preview ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img
                  src={preview}
                  alt="Preview"
                  className="h-24 w-24 rounded-lg object-cover"
                  onError={() => setPreview(null)}
                />
              ) : (
                <ImagePlus className="h-8 w-8 text-gray-400" />
              )}
              <span className="text-sm text-gray-500">{image ? image.name : "Click to upload pooja image"}</span>
              <input type="file" accept="image/*" className="hidden" onChange={handleImageChange} />
            </label>
            <input
              required
              value={form.name}
              onChange={(e) => setForm({ ...form, name: e.target.value })}
              placeholder="Name"
              className="flex h-11 w-full rounded-xl border border-gray-200 bg-white px-4 py-2 text-sm focus:border-saffron focus:outline-none focus:ring-2 focus:ring-saffron/20"
            />
            <input
              required
              value={form.category}
              onChange={(e) => setForm({ ...form, category: e.target.value })}
              placeholder="Category"
              className="flex h-11 w-full rounded-xl border border-gray-200 bg-white px-4 py-2 text-sm focus:border-saffron focus:outline-none focus:ring-2 focus:ring-saffron/20"
            />
            <textarea
              required
              rows={3}
              value={form.description}
              onChange={(e) => setForm({ ...form, description: e.target.value })}
              placeholder="Description"
              className="flex w-full rounded-xl border border-gray-200 bg-white px-4 py-2 text-sm focus:border-saffron focus:outline-none focus:ring-2 focus:ring-saffron/20"
            />
            <div className="grid grid-cols-2 gap-3">
              <input
                required
                type="number" min="0" step="0.01"
                value={form.price}
                onChange={(e) => setForm({ ...form, price: Number(e.target.value) })}
                placeholder="Price"
                className="flex h-11 w-full rounded-xl border border-gray-200 bg-white px-4 py-2 text-sm focus:border-saffron focus:outline-none focus:ring-2 focus:ring-saffron/20"
              />
              <input
                type="number" min="0" step="0.01"
                value={form.salePrice ?? ""}
                onChange={(e) => setForm({ ...form, salePrice: e.target.value ? Number(e.target.value) : undefined })}
                placeholder="Sale price"
                className="flex h-11 w-full rounded-xl border border-gray-200 bg-white px-4 py-2 text-sm focus:border-saffron focus:outline-none focus:ring-2 focus:ring-saffron/20"
              />
            </div>
            <input
              required
              type="number" min="1"
              value={form.durationMinutes}
              onChange={(e) => setForm({ ...form, durationMinutes: Number(e.target.value) })}
              placeholder="Duration (minutes)"
              className="flex h-11 w-full rounded-xl border border-gray-200 bg-white px-4 py-2 text-sm focus:border-saffron focus:outline-none focus:ring-2 focus:ring-saffron/20"
            />
            <div className="flex flex-wrap gap-4">
              <label className="flex items-center gap-2 text-sm text-gray-600">
                <input type="checkbox" checked={form.isFeatured} onChange={(e) => setForm({ ...form, isFeatured: e.target.checked })} className="h-4 w-4 rounded border-gray-300 text-saffron focus:ring-saffron" />
                Featured
              </label>
              <label className="flex items-center gap-2 text-sm text-gray-600">
                <input type="checkbox" checked={form.isActive} onChange={(e) => setForm({ ...form, isActive: e.target.checked })} className="h-4 w-4 rounded border-gray-300 text-saffron focus:ring-saffron" />
                Active
              </label>
            </div>
            <Button type="submit" variant="indigo" className="w-full" size="lg" disabled={submitting}>
              {submitting ? "Saving..." : "Save Changes"}
            </Button>
          </form>
        )}
      </DialogContent>
    </Dialog>
  );
}

export function OrderDetailDialog({ open, onOpenChange, orderId }: { open: boolean; onOpenChange: (o: boolean) => void; orderId: string | null }) {
  const queryClient = useQueryClient();
  const [detail, setDetail] = useState<AdminOrderDetail | null>(null);
  const [status, setStatus] = useState("");
  const [notes, setNotes] = useState("");
  const [updating, setUpdating] = useState(false);

  const load = () => {
    if (!orderId) return;
    adminGet<AdminOrderDetail>(`/orders/${orderId}`)
      .then((d) => { setDetail(d); setStatus(d.status); })
      .catch(() => toast.error("Failed to load order"));
  };

  useEffect(() => {
    if (!open || !orderId) { setDetail(null); setNotes(""); return; }
    load();
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [open, orderId]);

  const handleUpdateStatus = async () => {
    if (!orderId) return;
    setUpdating(true);
    try {
      await adminPut(`/orders/${orderId}/status`, { status, notes: notes || null, location: null });
      await queryClient.invalidateQueries({ queryKey: ["admin", "orders"] });
      toast.success("Order status updated");
      setNotes("");
      load();
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Failed to update order status"));
    } finally {
      setUpdating(false);
    }
  };

  return (
    <Dialog open={open} onOpenChange={onOpenChange}>
      <DialogContent className="max-w-xl">
        <DialogHeader><DialogTitle>Order {detail?.orderNumber || ""}</DialogTitle></DialogHeader>
        {!detail ? (
          <p className="py-6 text-center text-sm text-gray-500">Loading...</p>
        ) : (
          <div className="space-y-4">
            <Field label="Customer" value={`${detail.customerName} (${detail.customerEmail})`} />
            <Field label="Sub Total" value={formatPrice(detail.subTotal)} />
            {detail.discount > 0 && <Field label="Discount" value={`- ${formatPrice(detail.discount)}`} />}
            <Field label="Shipping" value={formatPrice(detail.shippingFee)} />
            <Field label="Total" value={formatPrice(detail.total)} />
            <Field label="Placed On" value={new Date(detail.createdAt).toLocaleString()} />

            <div>
              <p className="mb-2 text-sm font-medium text-gray-500">Items</p>
              <div className="space-y-2 rounded-xl border border-gray-100 p-3">
                {detail.items.map((i) => (
                  <div key={i.productId} className="flex items-center gap-3 text-sm">
                    <div className="relative flex h-10 w-10 shrink-0 items-center justify-center overflow-hidden rounded-lg bg-gray-50 text-base">
                      <span className="absolute inset-0 flex items-center justify-center">📿</span>
                      {i.imageUrl && (
                        // eslint-disable-next-line @next/next/no-img-element
                        <img
                          ref={(el) => checkImageAlreadyFailed(el, () => { if (el) el.style.display = "none"; })}
                          src={getImageUrl(i.imageUrl)}
                          alt={i.productName}
                          className="absolute inset-0 h-full w-full object-cover"
                          onError={(e) => { e.currentTarget.style.display = "none"; }}
                        />
                      )}
                    </div>
                    <span className="flex-1">{i.productName} × {i.quantity}</span>
                    <span className="font-medium">{formatPrice(i.totalPrice)}</span>
                  </div>
                ))}
              </div>
            </div>

            <div>
              <p className="mb-2 text-sm font-medium text-gray-500">Tracking History</p>
              <div className="space-y-2">
                {detail.tracking.map((t, i) => (
                  <div key={i} className="text-sm">
                    <span className="font-medium text-krishna">{t.status}</span>
                    {t.notes && <span className="text-gray-500"> — {t.notes}</span>}
                    <span className="block text-xs text-gray-400">{new Date(t.createdAt).toLocaleString()}</span>
                  </div>
                ))}
              </div>
            </div>

            <div className="rounded-xl border border-dashed border-saffron/40 bg-saffron/5 p-3">
              <p className="mb-2 text-sm font-medium text-krishna">Update Status</p>
              <div className="flex flex-wrap gap-2">
                <select
                  value={status}
                  onChange={(e) => setStatus(e.target.value)}
                  className="h-10 flex-1 rounded-lg border border-gray-200 bg-white px-3 text-sm focus:border-saffron focus:outline-none focus:ring-2 focus:ring-saffron/20"
                >
                  {ORDER_STATUSES.map((s) => <option key={s} value={s}>{s}</option>)}
                </select>
                <Button size="sm" variant="indigo" onClick={handleUpdateStatus} disabled={updating || status === detail.status}>
                  {updating ? "Updating..." : "Update"}
                </Button>
              </div>
              <input
                value={notes}
                onChange={(e) => setNotes(e.target.value)}
                placeholder="Note (optional)"
                className="mt-2 h-9 w-full rounded-lg border border-gray-200 bg-white px-3 text-sm focus:border-saffron focus:outline-none focus:ring-2 focus:ring-saffron/20"
              />
            </div>
          </div>
        )}
      </DialogContent>
    </Dialog>
  );
}
