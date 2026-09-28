import { clsx, type ClassValue } from "clsx";
import { twMerge } from "tailwind-merge";

export function cn(...inputs: ClassValue[]) {
  return twMerge(clsx(inputs));
}

export function formatPrice(amount: number) {
  return new Intl.NumberFormat("en-IN", {
    style: "currency",
    currency: "INR",
    maximumFractionDigits: 0,
  }).format(amount);
}

export function getDiscountPercent(price: number, salePrice?: number | null) {
  if (!salePrice || salePrice >= price) return 0;
  return Math.round(((price - salePrice) / price) * 100);
}

const API_ORIGIN = (process.env.NEXT_PUBLIC_API_URL || "https://deepak4info-001-site1.ftempurl.com/api").replace(/\/api$/, "");

// Product/pooja image URLs come back from the API as paths relative to the .NET server
// (e.g. "/images/products/x.jpg"), not the Next.js origin, so they need the API's own
// origin prefixed before they're usable in an <img src>.
export function getImageUrl(path?: string | null) {
  if (!path) return undefined;
  if (/^https?:\/\//i.test(path)) return path;
  return `${API_ORIGIN}${path}`;
}

// The browser can finish loading (and failing) an <img> before React attaches its onError
// listener — this happens for any SSR-rendered image, since the browser's HTML parser starts
// fetching img src as soon as it sees the tag, well before React's JS bundle even runs. Error
// events on media elements fire once and don't replay, so an already-failed image would
// otherwise never be caught. Pass this as a ref callback to catch that case at mount time,
// alongside a normal onError handler for images that fail later.
export function checkImageAlreadyFailed(el: HTMLImageElement | null, onFail: () => void) {
  if (el && el.complete && el.naturalWidth === 0) onFail();
}
