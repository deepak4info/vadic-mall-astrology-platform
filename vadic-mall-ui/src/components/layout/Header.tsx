"use client";

import Link from "next/link";
import { usePathname, useRouter } from "next/navigation";
import { ShoppingCart, User, Menu, X, Sparkles, Search, Heart, Bell, ShieldCheck } from "lucide-react";
import { useEffect, useRef, useState } from "react";
import { cn } from "@/lib/utils";
import { useAuthStore } from "@/store/auth";
import { useCartStore } from "@/store/cart";
import { useWishlist } from "@/lib/wishlist";
import { useNotifications } from "@/lib/notifications";
import { Button } from "@/components/ui/button";
import { LanguageToggle } from "@/components/layout/LanguageToggle";
import { STAFF_PERMISSIONS } from "@/lib/types";

function staffRoleLabel(permissions: string[] | undefined): string | null {
  if (!permissions || permissions.length === 0) return null;
  if (permissions.length === 1) {
    return STAFF_PERMISSIONS.find((p) => p.key === permissions[0])?.label ?? "Staff Panel";
  }
  return "Staff Panel";
}

const navLinks = [
  { href: "/pooja", label: "Pooja" },
  { href: "/products", label: "Products" },
  { href: "/kundli", label: "Kundli" },
  { href: "/astrologers", label: "Astrologers" },
  { href: "/festival", label: "Offers" },
  { href: "/gift-cards", label: "Gift Cards" },
  { href: "/subscription", label: "Plans" },
];

function NotificationBell() {
  const { user } = useAuthStore();
  const { items, unreadCount, markRead, markAllRead } = useNotifications();
  const [open, setOpen] = useState(false);
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    function onClickOutside(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
    }
    document.addEventListener("mousedown", onClickOutside);
    return () => document.removeEventListener("mousedown", onClickOutside);
  }, []);

  if (!user) return null;

  return (
    <div ref={ref} className="relative">
      <button type="button" onClick={() => setOpen((v) => !v)} className="relative rounded-lg p-2 text-white hover:bg-white/10">
        <Bell className="h-5 w-5" />
        {unreadCount > 0 && (
          <span className="absolute -right-1 -top-1 flex h-5 w-5 items-center justify-center rounded-full bg-saffron text-xs font-bold text-white">
            {unreadCount}
          </span>
        )}
      </button>

      {open && (
        <div className="absolute right-0 top-full mt-2 w-80 rounded-2xl border border-gray-100 bg-white p-2 text-left shadow-xl">
          <div className="flex items-center justify-between px-3 py-2">
            <p className="font-heading font-semibold text-krishna">Notifications</p>
            {unreadCount > 0 && (
              <button type="button" onClick={() => markAllRead()} className="text-xs font-medium text-saffron hover:underline">
                Mark all read
              </button>
            )}
          </div>
          <div className="max-h-80 overflow-y-auto">
            {items.length === 0 ? (
              <p className="px-3 py-6 text-center text-sm text-gray-400">No notifications yet.</p>
            ) : (
              items.map((n) => (
                <Link
                  key={n.id}
                  href={n.link || "#"}
                  onClick={() => {
                    if (!n.isRead) markRead(n.id);
                    setOpen(false);
                  }}
                  className={cn(
                    "block rounded-xl px-3 py-2 text-sm transition-colors hover:bg-saffron/5",
                    !n.isRead && "bg-saffron/5"
                  )}
                >
                  <div className="flex items-start gap-2">
                    {!n.isRead && <span className="mt-1.5 h-2 w-2 shrink-0 rounded-full bg-saffron" />}
                    <div className={n.isRead ? "pl-4" : ""}>
                      <p className="font-medium text-krishna">{n.title}</p>
                      <p className="text-xs text-gray-500">{n.message}</p>
                      <p className="mt-1 text-[10px] text-gray-400">{new Date(n.createdAt).toLocaleString()}</p>
                    </div>
                  </div>
                </Link>
              ))
            )}
          </div>
        </div>
      )}
    </div>
  );
}

export function Header() {
  const pathname = usePathname();
  const router = useRouter();
  const [mobileOpen, setMobileOpen] = useState(false);
  const [searchOpen, setSearchOpen] = useState(false);
  const [query, setQuery] = useState("");
  const { user, logout } = useAuthStore();
  const cartCount = useCartStore((s) => s.itemCount());
  const { count: wishlistCount } = useWishlist();

  const handleSearch = (e: React.FormEvent) => {
    e.preventDefault();
    if (!query.trim()) return;
    router.push(`/search?q=${encodeURIComponent(query.trim())}`);
    setSearchOpen(false);
    setMobileOpen(false);
  };

  return (
    <header className="sticky top-0 z-50 bg-krishna-gradient shadow-lg">
      <div className="mx-auto flex max-w-7xl items-center justify-between px-4 py-4 lg:px-8">
        <Link href="/" className="flex items-center gap-2">
          <div className="flex h-10 w-10 items-center justify-center rounded-full bg-saffron/20 animate-diya-glow">
            <Sparkles className="h-6 w-6 text-saffron" />
          </div>
          <div>
            <span className="font-heading text-xl font-bold text-white">Vadic Mall</span>
            <p className="text-xs text-saffron-light">Vedic Tradition Meets Technology</p>
          </div>
        </Link>

        <nav className="hidden items-center gap-1 lg:flex">
          {navLinks.map((link) => (
            <Link
              key={link.href}
              href={link.href}
              className={cn(
                "relative px-3 py-2 text-sm font-medium transition-colors",
                "after:absolute after:bottom-0 after:left-1/2 after:h-0.5 after:w-0 after:-translate-x-1/2 after:rounded-full after:bg-saffron after:transition-all after:duration-300 hover:after:w-[calc(100%-1.5rem)]",
                pathname === link.href ? "text-white after:w-[calc(100%-1.5rem)]" : "text-white/80 hover:text-white"
              )}
            >
              {link.label}
            </Link>
          ))}
        </nav>

        <div className="flex items-center gap-2">
          <div className="hidden items-center lg:flex">
            {searchOpen ? (
              <form onSubmit={handleSearch} className="flex items-center">
                <input
                  autoFocus
                  type="search"
                  value={query}
                  onChange={(e) => setQuery(e.target.value)}
                  onBlur={() => !query && setSearchOpen(false)}
                  placeholder="Search products, poojas, astrologers..."
                  className="w-56 rounded-lg border border-white/20 bg-white/10 px-3 py-2 text-sm text-white placeholder:text-white/50 focus:outline-none focus:ring-2 focus:ring-saffron"
                />
              </form>
            ) : (
              <button type="button" onClick={() => setSearchOpen(true)} className="rounded-lg p-2 text-white hover:bg-white/10">
                <Search className="h-5 w-5" />
              </button>
            )}
          </div>

          <Link href={user ? "/wishlist" : "/login"} className="relative rounded-lg p-2 text-white hover:bg-white/10">
            <Heart className="h-5 w-5" />
            {wishlistCount > 0 && (
              <span className="absolute -right-1 -top-1 flex h-5 w-5 items-center justify-center rounded-full bg-saffron text-xs font-bold text-white">
                {wishlistCount}
              </span>
            )}
          </Link>

          <NotificationBell />

          <Link href="/cart" className="relative rounded-lg p-2 text-white hover:bg-white/10">
            <ShoppingCart className="h-5 w-5" />
            {cartCount > 0 && (
              <span className="absolute -right-1 -top-1 flex h-5 w-5 items-center justify-center rounded-full bg-saffron text-xs font-bold text-white">
                {cartCount}
              </span>
            )}
          </Link>

          {user ? (
            <div className="hidden items-center gap-2 sm:flex">
              <Link
                href={user.role === "SuperAdmin" ? "/admin" : user.role === "Customer" ? "/customer" : user.role === "Astrologer" ? "/astrologer" : "/"}
                className="flex items-center gap-2 rounded-lg px-3 py-2 text-sm text-white hover:bg-white/10"
              >
                <User className="h-4 w-4" />
                {user.firstName}
              </Link>
              {user.role !== "SuperAdmin" && staffRoleLabel(user.permissions) && (
                <Link
                  href="/admin"
                  className="flex items-center gap-1.5 rounded-lg bg-saffron/20 px-3 py-2 text-sm font-medium text-saffron-light hover:bg-saffron/30"
                  title="Open your staff admin access"
                >
                  <ShieldCheck className="h-4 w-4" />
                  {staffRoleLabel(user.permissions)}
                </Link>
              )}
              <Button variant="outline" size="sm" onClick={logout} className="border-white/30 text-white hover:bg-white hover:text-krishna">
                Logout
              </Button>
              <LanguageToggle />
            </div>
          ) : (
            <div className="hidden items-center gap-2 sm:flex">
              <Link href="/login">
                <Button size="sm">Login</Button>
              </Link>
              <LanguageToggle />
            </div>
          )}

          <div className="sm:hidden">
            <LanguageToggle />
          </div>

          <button className="rounded-lg p-2 text-white lg:hidden" onClick={() => setMobileOpen(!mobileOpen)}>
            {mobileOpen ? <X className="h-6 w-6" /> : <Menu className="h-6 w-6" />}
          </button>
        </div>
      </div>

      {mobileOpen && (
        <div className="border-t border-white/10 bg-krishna-navy px-4 py-4 lg:hidden">
          <form onSubmit={handleSearch} className="mb-3 flex">
            <input
              type="search"
              value={query}
              onChange={(e) => setQuery(e.target.value)}
              placeholder="Search..."
              className="w-full rounded-lg border border-white/20 bg-white/10 px-3 py-2 text-sm text-white placeholder:text-white/50 focus:outline-none focus:ring-2 focus:ring-saffron"
            />
          </form>
          {navLinks.map((link) => (
            <Link
              key={link.href}
              href={link.href}
              onClick={() => setMobileOpen(false)}
              className="block rounded-lg px-4 py-3 text-white hover:bg-white/10"
            >
              {link.label}
            </Link>
          ))}
          {!user && (
            <Link href="/login" onClick={() => setMobileOpen(false)} className="mt-2 block">
              <Button className="w-full">Login</Button>
            </Link>
          )}
        </div>
      )}
    </header>
  );
}
