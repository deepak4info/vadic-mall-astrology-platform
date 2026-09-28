"use client";

import { useEffect, useRef, useState } from "react";
import { useRouter } from "next/navigation";
import { useQueryClient } from "@tanstack/react-query";
import toast from "react-hot-toast";
import { Users, ShoppingBag, Calendar, DollarSign, Package, AlertTriangle, Plus, Eye, Pencil, PackageCheck, PackageX, UserCheck, UserX, Check, X, Trash2, ShieldCheck, Tag } from "lucide-react";
import { Card, CardContent } from "@/components/ui/card";
import { Badge } from "@/components/ui/badge";
import { Button } from "@/components/ui/button";
import { AdminOverviewSkeleton, AdminTableSkeleton, ChartBarsSkeleton, RecentListSkeleton, Skeleton } from "@/components/ui/skeleton";
import { useAuthStore, useAuthHydrated } from "@/store/auth";
import { useAdminData } from "@/lib/hooks";
import { adminPatch, adminDelete, adminPost, getApiErrorMessage } from "@/lib/api";
import { formatPrice, getImageUrl, checkImageAlreadyFailed } from "@/lib/utils";
import type { DashboardStats, RevenueChartPoint, RecentOrder, AdminUser, AdminProduct, AdminPooja, AdminOrder, AdminBooking, AdminCoupon, BulkDeleteResult } from "@/lib/types";
import { STAFF_PERMISSIONS } from "@/lib/types";

function staffRoleLabels(permissions: string[]): string[] {
  return permissions.map((key) => STAFF_PERMISSIONS.find((p) => p.key === key)?.label ?? key);
}
import { RevenueChart } from "./RevenueChart";
import { AdminTable, type Column } from "./AdminTable";
import { AddProductModal } from "./AddProductModal";
import { CouponModal } from "./CouponModal";
import { UserViewDialog, ProductViewDialog, PoojaViewDialog, EditPoojaModal, OrderDetailDialog, ManagePermissionsDialog } from "./AdminDetailDialogs";
import { SiteContentSettings } from "./SiteContentSettings";
import { LoadingSkeletonSettings } from "./LoadingSkeletonSettings";

const tabs = [
  { key: "dashboard", label: "Dashboard", permission: null as string | null },
  { key: "users", label: "Users", permission: null },
  { key: "products", label: "Products", permission: "ManageProducts" },
  { key: "poojas", label: "Pooja Services", permission: "ManagePoojaServices" },
  { key: "orders", label: "Orders", permission: "ManageOrders" },
  { key: "bookings", label: "Bookings", permission: "ManageBookings" },
  { key: "offers", label: "Offers", permission: "ManageOffers" },
  { key: "settings", label: "Site Content", permission: null },
] as const;

type Tab = (typeof tabs)[number]["key"];

export default function AdminDashboard() {
  const router = useRouter();
  const { user } = useAuthStore();
  const hydrated = useAuthHydrated();
  const [tab, setTab] = useState<Tab>("dashboard");
  const [addProductOpen, setAddProductOpen] = useState(false);
  const [editProductId, setEditProductId] = useState<string | null>(null);
  const [viewProduct, setViewProduct] = useState<AdminProduct | null>(null);
  const [viewUser, setViewUser] = useState<AdminUser | null>(null);
  const [viewPoojaId, setViewPoojaId] = useState<string | null>(null);
  const [editPoojaId, setEditPoojaId] = useState<string | null>(null);
  const [viewOrderId, setViewOrderId] = useState<string | null>(null);
  const [stockUpdating, setStockUpdating] = useState<string | null>(null);
  const [statusUpdating, setStatusUpdating] = useState<string | null>(null);
  const [approvalUpdating, setApprovalUpdating] = useState<string | null>(null);
  const [deletingProductId, setDeletingProductId] = useState<string | null>(null);
  const [selectedProductIds, setSelectedProductIds] = useState<Set<string>>(new Set());
  const [bulkDeleting, setBulkDeleting] = useState(false);
  const [rolesUser, setRolesUser] = useState<AdminUser | null>(null);
  const [addCouponOpen, setAddCouponOpen] = useState(false);
  const [editCouponId, setEditCouponId] = useState<string | null>(null);
  const [deletingCouponId, setDeletingCouponId] = useState<string | null>(null);
  const queryClient = useQueryClient();

  const isSuperAdmin = user?.role === "SuperAdmin";
  const permissions = user?.permissions ?? [];
  const can = (permission: string | null) => isSuperAdmin || (permission != null && permissions.includes(permission));
  const isStaff = !isSuperAdmin && permissions.length > 0;
  const visibleTabs = tabs.filter((t) => can(t.permission));

  const { data: stats, isLoading } = useAdminData<DashboardStats>("dashboard", "/dashboard", isSuperAdmin && tab === "dashboard");
  const { data: revenue = [], isLoading: revenueLoading } = useAdminData<RevenueChartPoint[]>("revenue", "/dashboard/charts/revenue?months=6", isSuperAdmin && tab === "dashboard");
  const { data: recentOrders = [], isLoading: recentLoading } = useAdminData<RecentOrder[]>("recent-orders", "/dashboard/recent-orders?count=10", isSuperAdmin && tab === "dashboard");
  const { data: users = [], isLoading: usersLoading } = useAdminData<AdminUser[]>("users", "/users", isSuperAdmin && tab === "users");
  const { data: products = [], isLoading: productsLoading } = useAdminData<AdminProduct[]>("products", "/products", can("ManageProducts") && tab === "products");
  const { data: poojas = [], isLoading: poojasLoading } = useAdminData<AdminPooja[]>("poojas", "/pooja-services", can("ManagePoojaServices") && tab === "poojas");
  const { data: orders = [], isLoading: ordersLoading } = useAdminData<AdminOrder[]>("orders", "/orders", can("ManageOrders") && tab === "orders");
  const { data: bookings = [], isLoading: bookingsLoading } = useAdminData<AdminBooking[]>("bookings", "/bookings", can("ManageBookings") && tab === "bookings");
  const { data: coupons = [], isLoading: couponsLoading } = useAdminData<AdminCoupon[]>("coupons", "/coupons", can("ManageOffers") && tab === "offers");

  useEffect(() => {
    if (hydrated && (!user || (!isSuperAdmin && !isStaff))) router.push("/login");
  }, [hydrated, user, isSuperAdmin, isStaff, router]);

  const tabInitialized = useRef(false);
  useEffect(() => {
    // Runs exactly once, the first time the session is ready — not on every `user` change.
    // The user object is refetched periodically (and on window focus) to pick up permission
    // grants live; re-running this on every one of those refreshes would snap the currently
    // open tab back to whatever `?tab=` was in the URL at page load, which felt like the
    // dashboard "going back" whenever a click (e.g. a delete confirm dialog) refocused the window.
    if (!hydrated || !user || tabInitialized.current) return;
    tabInitialized.current = true;
    const requested = new URLSearchParams(window.location.search).get("tab");
    const requestedTab = tabs.find((t) => t.key === requested && can(t.permission));
    setTab(requestedTab?.key ?? visibleTabs[0]?.key ?? "dashboard");
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, [hydrated, user]);

  if (!hydrated || !user || (!isSuperAdmin && !isStaff)) {
    return (
      <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
        <Skeleton className="mb-6 h-8 w-56" />
        <div className="mb-8 flex flex-wrap gap-2">
          {Array.from({ length: 5 }).map((_, i) => <Skeleton key={i} className="h-9 w-24 rounded-full" />)}
        </div>
        <AdminOverviewSkeleton />
      </div>
    );
  }
  if (isSuperAdmin && (isLoading || !stats)) {
    return (
      <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
        <h1 className="section-title mb-6">Admin Dashboard</h1>
        <div className="mb-8 flex flex-wrap gap-2 text-sm">
          {visibleTabs.map((t) => (
            <button key={t.key} className={`rounded-full px-4 py-2 font-medium ${tab === t.key ? "bg-indigo text-white" : "bg-gray-100 text-gray-600"}`}>
              {t.label}
            </button>
          ))}
        </div>
        <AdminOverviewSkeleton />
      </div>
    );
  }

  const toggleStock = async (p: AdminProduct) => {
    setStockUpdating(p.id);
    try {
      await adminPatch(`/products/${p.id}/stock`, { inStock: p.stockQuantity <= 0 });
      await queryClient.invalidateQueries({ queryKey: ["admin", "products"] });
      toast.success(p.stockQuantity > 0 ? "Marked out of stock" : "Marked in stock");
    } catch (error) {
      toast.error(getApiErrorMessage(error));
    } finally {
      setStockUpdating(null);
    }
  };

  const deleteProduct = async (p: AdminProduct) => {
    if (!window.confirm(`Delete "${p.name}"? This cannot be undone.`)) return;
    setDeletingProductId(p.id);
    try {
      await adminDelete(`/products/${p.id}`);
      await queryClient.invalidateQueries({ queryKey: ["admin", "products"] });
      setSelectedProductIds((prev) => {
        const next = new Set(prev);
        next.delete(p.id);
        return next;
      });
      toast.success("Product deleted");
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Failed to delete product"));
    } finally {
      setDeletingProductId(null);
    }
  };

  const toggleSelectProduct = (id: string) => {
    setSelectedProductIds((prev) => {
      const next = new Set(prev);
      if (next.has(id)) next.delete(id);
      else next.add(id);
      return next;
    });
  };

  const toggleSelectAllProducts = () => {
    setSelectedProductIds((prev) => (prev.size === products.length ? new Set() : new Set(products.map((p) => p.id))));
  };

  const bulkDeleteSelected = async () => {
    const count = selectedProductIds.size;
    if (count === 0) return;
    if (!window.confirm(`Delete ${count} selected product${count > 1 ? "s" : ""}? This cannot be undone.`)) return;
    setBulkDeleting(true);
    try {
      const result = await adminPost<BulkDeleteResult>("/products/bulk-delete", { ids: Array.from(selectedProductIds) });
      await queryClient.invalidateQueries({ queryKey: ["admin", "products"] });
      setSelectedProductIds(new Set());
      if (result.skippedProductNames.length > 0) {
        toast.error(`${result.deletedCount} deleted. Skipped (has order history): ${result.skippedProductNames.join(", ")}`, { duration: 6000 });
      } else {
        toast.success(`${result.deletedCount} product${result.deletedCount === 1 ? "" : "s"} deleted`);
      }
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Bulk delete failed"));
    } finally {
      setBulkDeleting(false);
    }
  };

  const toggleUserStatus = async (u: AdminUser) => {
    setStatusUpdating(u.id);
    try {
      await adminPatch(`/users/${u.id}/status`, { isActive: !u.isActive });
      await queryClient.invalidateQueries({ queryKey: ["admin", "users"] });
      toast.success(u.isActive ? "User deactivated" : "User activated");
    } catch (error) {
      toast.error(getApiErrorMessage(error));
    } finally {
      setStatusUpdating(null);
    }
  };

  const setAstrologerApproval = async (u: AdminUser, approved: boolean) => {
    setApprovalUpdating(u.id);
    try {
      await adminPatch(`/users/${u.id}/astrologer-approval`, { approved });
      await queryClient.invalidateQueries({ queryKey: ["admin", "users"] });
      toast.success(approved ? "Astrologer approved" : "Astrologer declined");
    } catch (error) {
      toast.error(getApiErrorMessage(error));
    } finally {
      setApprovalUpdating(null);
    }
  };

  const deleteCoupon = async (c: AdminCoupon) => {
    if (!window.confirm(`Delete offer "${c.code}"? This cannot be undone.`)) return;
    setDeletingCouponId(c.id);
    try {
      await adminDelete(`/coupons/${c.id}`);
      await queryClient.invalidateQueries({ queryKey: ["admin", "coupons"] });
      toast.success("Offer deleted");
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Failed to delete offer"));
    } finally {
      setDeletingCouponId(null);
    }
  };

  const cards: { icon: typeof Users; label: string; value: string; tab: Tab | null }[] = stats ? [
    { icon: Users, label: "Total Users", value: stats.totalUsers.toString(), tab: "users" },
    { icon: Users, label: "Astrologers", value: stats.totalAstrologers.toString(), tab: "users" },
    { icon: ShoppingBag, label: "Total Orders", value: stats.totalOrders.toString(), tab: "orders" },
    { icon: Calendar, label: "Bookings", value: stats.totalBookings.toString(), tab: "bookings" },
    { icon: DollarSign, label: "Revenue", value: formatPrice(stats.totalRevenue), tab: null },
    { icon: Package, label: "Pending Orders", value: stats.pendingOrders.toString(), tab: "orders" },
    { icon: AlertTriangle, label: "Low Stock", value: stats.lowStockProducts.toString(), tab: "products" },
  ] : [];

  const userColumns: Column<AdminUser>[] = [
    {
      header: "Name",
      render: (u) => {
        const hasRoles = u.isStaffApproved && u.permissions.length > 0;
        return (
          <span className={hasRoles ? "rounded-lg bg-indigo/10 px-2 py-1 font-semibold text-indigo" : undefined}>
            {u.firstName} {u.lastName}
          </span>
        );
      },
    },
    { header: "Email", render: (u) => u.email },
    {
      header: "Role",
      render: (u) => {
        const labels = u.isStaffApproved ? staffRoleLabels(u.permissions) : [];
        if (labels.length === 0) return <Badge>{u.role}</Badge>;
        return (
          <div className="flex flex-wrap gap-1">
            {labels.map((label) => (
              <span key={label} className="rounded-full bg-indigo px-2 py-0.5 text-xs font-semibold text-white">
                {label}
              </span>
            ))}
          </div>
        );
      },
    },
    { header: "Status", render: (u) => (u.isActive ? <span className="text-green-600">Active</span> : <span className="text-gray-400">Inactive</span>) },
    {
      header: "Verification",
      render: (u) => {
        if (u.role !== "Astrologer" || u.isAstrologerApproved == null) return <span className="text-gray-300">—</span>;
        return u.isAstrologerApproved ? (
          <span className="rounded-full bg-green-100 px-2 py-0.5 text-xs font-semibold text-green-700">Approved</span>
        ) : (
          <span className="rounded-full bg-amber-100 px-2 py-0.5 text-xs font-semibold text-amber-700">Pending</span>
        );
      },
    },
    { header: "Joined", render: (u) => new Date(u.createdAt).toLocaleDateString() },
    {
      header: "Actions",
      render: (u) => (
        <div className="flex flex-wrap gap-2">
          <Button size="sm" variant="indigo-ghost" onClick={() => setViewUser(u)}><Eye className="h-4 w-4" /></Button>
          <Button
            size="sm"
            variant="warning-outline"
            disabled={statusUpdating === u.id}
            onClick={() => toggleUserStatus(u)}
            title={u.isActive ? "Ban (deactivate)" : "Activate"}
          >
            {u.isActive ? <UserX className="h-4 w-4" /> : <UserCheck className="h-4 w-4" />}
          </Button>
          {u.role === "Astrologer" && u.isAstrologerApproved != null && !u.isAstrologerApproved && (
            <>
              <Button
                size="sm"
                variant="success"
                disabled={approvalUpdating === u.id}
                onClick={() => setAstrologerApproval(u, true)}
                title="Approve astrologer"
              >
                <Check className="mr-1 h-4 w-4" /> Approve
              </Button>
              <Button
                size="sm"
                variant="danger-outline"
                disabled={approvalUpdating === u.id}
                onClick={() => setAstrologerApproval(u, false)}
                title="Decline astrologer"
              >
                <X className="mr-1 h-4 w-4" /> Decline
              </Button>
            </>
          )}
          {u.role === "Astrologer" && u.isAstrologerApproved === true && (
            <Button
              size="sm"
              variant="danger-outline"
              disabled={approvalUpdating === u.id}
              onClick={() => setAstrologerApproval(u, false)}
              title="Revoke approval"
            >
              <X className="mr-1 h-4 w-4" /> Revoke
            </Button>
          )}
          {u.role !== "SuperAdmin" && (
            <Button size="sm" variant="indigo-outline" onClick={() => setRolesUser(u)} title="Manage roles">
              <ShieldCheck className="mr-1 h-4 w-4" /> Roles
            </Button>
          )}
        </div>
      ),
    },
  ];

  const couponColumns: Column<AdminCoupon>[] = [
    { header: "Code", render: (c) => <span className="font-mono font-semibold text-krishna">{c.code}</span> },
    { header: "Description", render: (c) => c.description },
    {
      header: "Discount",
      render: (c) => (c.type === "Percentage" ? `${c.value}%` : c.type === "FixedAmount" ? formatPrice(c.value) : "Free Shipping"),
    },
    { header: "Usage", render: (c) => `${c.usedCount} / ${c.usageLimit}` },
    { header: "Valid Till", render: (c) => new Date(c.validTo).toLocaleDateString() },
    { header: "Status", render: (c) => (c.isActive ? <span className="text-green-600">Active</span> : <span className="text-gray-400">Inactive</span>) },
    {
      header: "Actions",
      render: (c) => (
        <div className="flex gap-2">
          <Button size="sm" variant="indigo-ghost" onClick={() => setEditCouponId(c.id)}><Pencil className="h-4 w-4" /></Button>
          <Button
            size="sm"
            variant="indigo-ghost"
            disabled={deletingCouponId === c.id}
            onClick={() => deleteCoupon(c)}
            title="Delete offer"
          >
            <Trash2 className="h-4 w-4 text-red-600" />
          </Button>
        </div>
      ),
    },
  ];

  const productColumns: Column<AdminProduct>[] = [
    {
      header: (
        <input
          type="checkbox"
          checked={products.length > 0 && selectedProductIds.size === products.length}
          onChange={toggleSelectAllProducts}
          className="h-4 w-4 rounded border-gray-300 text-indigo focus:ring-indigo"
          aria-label="Select all products"
        />
      ),
      render: (p) => (
        <input
          type="checkbox"
          checked={selectedProductIds.has(p.id)}
          onChange={() => toggleSelectProduct(p.id)}
          className="h-4 w-4 rounded border-gray-300 text-indigo focus:ring-indigo"
          aria-label={`Select ${p.name}`}
        />
      ),
    },
    {
      header: "",
      render: (p) => (
        <div className="relative flex h-10 w-10 items-center justify-center overflow-hidden rounded-lg bg-gray-50 text-base">
          <span className="absolute inset-0 flex items-center justify-center">📿</span>
          {p.imageUrl && (
            // eslint-disable-next-line @next/next/no-img-element
            <img
              ref={(el) => checkImageAlreadyFailed(el, () => { if (el) el.style.display = "none"; })}
              src={getImageUrl(p.imageUrl)}
              alt={p.name}
              className="absolute inset-0 h-full w-full object-cover"
              onError={(e) => { e.currentTarget.style.display = "none"; }}
            />
          )}
        </div>
      ),
    },
    { header: "Name", render: (p) => p.name },
    { header: "Category", render: (p) => p.category },
    { header: "Price", render: (p) => <>{p.salePrice ? <><span className="text-saffron">{formatPrice(p.salePrice)}</span> <span className="text-gray-400 line-through">{formatPrice(p.price)}</span></> : formatPrice(p.price)}</> },
    {
      header: "Stock",
      render: (p) => (
        <div className="flex items-center gap-2">
          <span>{p.stockQuantity}</span>
          {p.stockQuantity > 0 ? (
            <span className="rounded-full bg-green-100 px-2 py-0.5 text-xs font-semibold text-green-700">In Stock</span>
          ) : (
            <span className="rounded-full bg-red-100 px-2 py-0.5 text-xs font-semibold text-red-600">Out of Stock</span>
          )}
        </div>
      ),
    },
    { header: "Featured", render: (p) => (p.isFeatured ? "✓" : "—") },
    { header: "Status", render: (p) => (p.isActive ? <span className="text-green-600">Active</span> : <span className="text-gray-400">Inactive</span>) },
    {
      header: "Actions",
      render: (p) => (
        <div className="flex flex-wrap gap-2">
          <Button size="sm" variant="indigo-ghost" onClick={() => setViewProduct(p)}><Eye className="h-4 w-4" /></Button>
          <Button size="sm" variant="indigo-ghost" onClick={() => setEditProductId(p.id)}><Pencil className="h-4 w-4" /></Button>
          <Button
            size="sm"
            variant="indigo-outline"
            disabled={stockUpdating === p.id}
            onClick={() => toggleStock(p)}
            title={p.stockQuantity > 0 ? "Mark Out of Stock" : "Mark In Stock"}
          >
            {p.stockQuantity > 0 ? <PackageX className="h-4 w-4" /> : <PackageCheck className="h-4 w-4" />}
          </Button>
          <Button
            size="sm"
            variant="indigo-ghost"
            disabled={deletingProductId === p.id}
            onClick={() => deleteProduct(p)}
            title="Delete product"
          >
            <Trash2 className="h-4 w-4 text-red-600" />
          </Button>
        </div>
      ),
    },
  ];

  const poojaColumns: Column<AdminPooja>[] = [
    {
      header: "",
      render: (p) => (
        <div className="relative flex h-10 w-10 items-center justify-center overflow-hidden rounded-lg bg-gray-50 text-base">
          <span className="absolute inset-0 flex items-center justify-center">🪔</span>
          {p.imageUrl && (
            // eslint-disable-next-line @next/next/no-img-element
            <img
              ref={(el) => checkImageAlreadyFailed(el, () => { if (el) el.style.display = "none"; })}
              src={getImageUrl(p.imageUrl)}
              alt={p.name}
              className="absolute inset-0 h-full w-full object-cover"
              onError={(e) => { e.currentTarget.style.display = "none"; }}
            />
          )}
        </div>
      ),
    },
    { header: "Name", render: (p) => p.name },
    { header: "Category", render: (p) => p.category },
    { header: "Price", render: (p) => formatPrice(p.price) },
    { header: "Featured", render: (p) => (p.isFeatured ? "✓" : "—") },
    { header: "Status", render: (p) => (p.isActive ? <span className="text-green-600">Active</span> : <span className="text-gray-400">Inactive</span>) },
    {
      header: "Actions",
      render: (p) => (
        <div className="flex gap-2">
          <Button size="sm" variant="indigo-ghost" onClick={() => setViewPoojaId(p.id)}><Eye className="h-4 w-4" /></Button>
          <Button size="sm" variant="indigo-ghost" onClick={() => setEditPoojaId(p.id)}><Pencil className="h-4 w-4" /></Button>
        </div>
      ),
    },
  ];

  const bookingColumns: Column<AdminBooking>[] = [
    {
      header: "",
      render: (b) => (
        <div className="relative flex h-10 w-10 items-center justify-center overflow-hidden rounded-lg bg-gray-50 text-base">
          <span className="absolute inset-0 flex items-center justify-center">🪔</span>
          {b.imageUrl && (
            // eslint-disable-next-line @next/next/no-img-element
            <img
              ref={(el) => checkImageAlreadyFailed(el, () => { if (el) el.style.display = "none"; })}
              src={getImageUrl(b.imageUrl)}
              alt={b.serviceName}
              className="absolute inset-0 h-full w-full object-cover"
              onError={(e) => { e.currentTarget.style.display = "none"; }}
            />
          )}
        </div>
      ),
    },
    { header: "Service", render: (b) => b.serviceName },
    { header: "Customer", render: (b) => b.customerName },
    { header: "Scheduled", render: (b) => `${new Date(b.scheduledDate).toLocaleDateString()}${b.scheduledTime ? ` ${b.scheduledTime}` : ""}` },
    { header: "Amount", render: (b) => formatPrice(b.amount) },
    { header: "Status", render: (b) => <Badge>{b.status}</Badge> },
  ];

  const orderColumns: Column<AdminOrder>[] = [
    { header: "Order #", render: (o) => o.orderNumber },
    { header: "Customer", render: (o) => o.customerName },
    { header: "Total", render: (o) => formatPrice(o.total) },
    { header: "Status", render: (o) => <Badge>{o.status}</Badge> },
    { header: "Date", render: (o) => new Date(o.createdAt).toLocaleDateString() },
    {
      header: "Actions",
      render: (o) => (
        <Button size="sm" variant="indigo-ghost" onClick={() => setViewOrderId(o.id)}><Eye className="h-4 w-4" /></Button>
      ),
    },
  ];

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <h1 className="section-title mb-6">Admin Dashboard</h1>

      <div className="mb-8 flex flex-wrap gap-2 text-sm">
        {visibleTabs.map((t) => (
          <button
            key={t.key}
            onClick={() => setTab(t.key)}
            className={`rounded-full px-4 py-2 font-medium transition-colors ${tab === t.key ? "bg-indigo text-white" : "bg-gray-100 text-gray-600 hover:bg-gray-200"}`}
          >
            {t.label}
          </button>
        ))}
      </div>

      {tab === "dashboard" && (
        <div className="animate-fade-in">
          <div className="mb-10 grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
            {cards.map((c) => (
              <Card
                key={c.label}
                onClick={c.tab ? () => setTab(c.tab as Tab) : undefined}
                className={c.tab ? "cursor-pointer transition-shadow hover:shadow-lg" : undefined}
              >
                <CardContent className="flex items-center gap-4 p-6">
                  <c.icon className="h-8 w-8 text-saffron" />
                  <div><p className="text-2xl font-bold text-krishna">{c.value}</p><p className="text-sm text-gray-500">{c.label}</p></div>
                </CardContent>
              </Card>
            ))}
          </div>

          <div className="mb-10 grid gap-6 lg:grid-cols-2">
            <Card>
              <CardContent className="p-6">
                <h2 className="mb-4 font-heading text-lg font-semibold text-krishna">Revenue (Last 6 Months)</h2>
                {revenueLoading ? <ChartBarsSkeleton /> : <div className="animate-fade-in"><RevenueChart data={revenue} /></div>}
              </CardContent>
            </Card>
            <Card>
              <CardContent className="p-6">
                <h2 className="mb-4 font-heading text-lg font-semibold text-krishna">Recent Orders</h2>
                {recentLoading ? <RecentListSkeleton /> : (
                  <div className="animate-fade-in space-y-3">
                    {recentOrders.length === 0 ? <p className="text-sm text-gray-500">No recent orders.</p> : recentOrders.map((o) => (
                      <div key={o.id} className="flex items-center justify-between text-sm">
                        <div>
                          <p className="font-medium text-krishna">{o.orderNumber}</p>
                          <p className="text-gray-500">{o.customerName}</p>
                        </div>
                        <div className="text-right">
                          <p className="font-semibold">{formatPrice(o.total)}</p>
                          <p className="text-xs text-saffron">{o.status}</p>
                        </div>
                      </div>
                    ))}
                  </div>
                )}
              </CardContent>
            </Card>
          </div>
        </div>
      )}

      {tab === "users" && (usersLoading ? <AdminTableSkeleton columns={7} /> : <div className="animate-fade-in"><AdminTable columns={userColumns} rows={users} emptyLabel="No users found." /></div>)}
      {tab === "products" && (
        <>
          <div className="mb-4 flex items-center justify-between gap-3">
            {selectedProductIds.size > 0 ? (
              <div className="flex items-center gap-3 rounded-xl bg-indigo/10 px-4 py-2">
                <span className="text-sm font-medium text-indigo">{selectedProductIds.size} selected</span>
                <Button size="sm" variant="indigo" disabled={bulkDeleting} onClick={bulkDeleteSelected}>
                  <Trash2 className="mr-2 h-4 w-4" /> {bulkDeleting ? "Deleting..." : "Delete Selected"}
                </Button>
                <button type="button" className="text-sm text-gray-500 hover:underline" onClick={() => setSelectedProductIds(new Set())}>
                  Clear
                </button>
              </div>
            ) : <div />}
            <Button variant="indigo" onClick={() => setAddProductOpen(true)}>
              <Plus className="mr-2 h-4 w-4" /> Add Product
            </Button>
          </div>
          {productsLoading ? <AdminTableSkeleton columns={9} /> : <div className="animate-fade-in"><AdminTable columns={productColumns} rows={products} emptyLabel="No products found." /></div>}
        </>
      )}
      {tab === "poojas" && (poojasLoading ? <AdminTableSkeleton columns={7} /> : <div className="animate-fade-in"><AdminTable columns={poojaColumns} rows={poojas} emptyLabel="No pooja services found." /></div>)}
      {tab === "orders" && (ordersLoading ? <AdminTableSkeleton columns={6} /> : <div className="animate-fade-in"><AdminTable columns={orderColumns} rows={orders} emptyLabel="No orders found." /></div>)}
      {tab === "bookings" && (bookingsLoading ? <AdminTableSkeleton columns={6} /> : <div className="animate-fade-in"><AdminTable columns={bookingColumns} rows={bookings} emptyLabel="No bookings found." /></div>)}
      {tab === "offers" && (
        <>
          <div className="mb-4 flex justify-end">
            <Button variant="indigo" onClick={() => setAddCouponOpen(true)}>
              <Tag className="mr-2 h-4 w-4" /> Add Offer
            </Button>
          </div>
          {couponsLoading ? <AdminTableSkeleton columns={7} /> : <div className="animate-fade-in"><AdminTable columns={couponColumns} rows={coupons} emptyLabel="No offers found." /></div>}
        </>
      )}
      {tab === "settings" && (
        <>
          <SiteContentSettings />
          <LoadingSkeletonSettings />
        </>
      )}

      <AddProductModal open={addProductOpen} onOpenChange={setAddProductOpen} />
      <AddProductModal open={!!editProductId} onOpenChange={(o) => !o && setEditProductId(null)} productId={editProductId ?? undefined} />
      <ProductViewDialog open={!!viewProduct} onOpenChange={(o) => !o && setViewProduct(null)} product={viewProduct} />
      <UserViewDialog open={!!viewUser} onOpenChange={(o) => !o && setViewUser(null)} user={viewUser} />
      <PoojaViewDialog open={!!viewPoojaId} onOpenChange={(o) => !o && setViewPoojaId(null)} poojaId={viewPoojaId} />
      <EditPoojaModal open={!!editPoojaId} onOpenChange={(o) => !o && setEditPoojaId(null)} poojaId={editPoojaId} />
      <OrderDetailDialog open={!!viewOrderId} onOpenChange={(o) => !o && setViewOrderId(null)} orderId={viewOrderId} />
      <ManagePermissionsDialog open={!!rolesUser} onOpenChange={(o) => !o && setRolesUser(null)} user={rolesUser} />
      <CouponModal open={addCouponOpen} onOpenChange={setAddCouponOpen} />
      <CouponModal open={!!editCouponId} onOpenChange={(o) => !o && setEditCouponId(null)} couponId={editCouponId ?? undefined} />
    </div>
  );
}
