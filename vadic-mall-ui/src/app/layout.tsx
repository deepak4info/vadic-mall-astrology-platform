import type { Metadata } from "next";
import { Inter, Space_Grotesk } from "next/font/google";
import "./globals.css";
import { Header } from "@/components/layout/Header";
import { Footer } from "@/components/layout/Footer";
import { Providers } from "@/components/providers";
import { GoogleTranslate } from "@/components/layout/GoogleTranslate";
import { fetchCatalog } from "@/lib/api";

const inter = Inter({ subsets: ["latin"], variable: "--font-inter" });
const spaceGrotesk = Space_Grotesk({ subsets: ["latin"], variable: "--font-space-grotesk" });

export const metadata: Metadata = {
  title: "Vadic Mall - Complete Vedic Astrology Platform",
  description: "Book poojas, buy spiritual products, get kundli analysis, and consult expert Vedic astrologers - all in one place.",
};

interface LoadingSkeletonPreset {
  name: string;
  durationMs: number;
  delayMs: number;
  easing: string;
}

// Every skeleton loader on the site (including the ones Suspense shows via loading.tsx, which
// can't fetch data of their own) reads its animation from CSS custom properties set here, once
// per request — so switching the active preset in the admin panel changes every skeleton
// everywhere without touching a single loading.tsx or component.
async function getActiveSkeletonPreset(): Promise<LoadingSkeletonPreset> {
  try {
    return await fetchCatalog<LoadingSkeletonPreset>("/catalog/loading-skeleton");
  } catch {
    return { name: "shimmer", durationMs: 1600, delayMs: 0, easing: "ease-in-out" };
  }
}

export default async function RootLayout({ children }: { children: React.ReactNode }) {
  const skeletonPreset = await getActiveSkeletonPreset();

  return (
    <html
      lang="en"
      data-skeleton-anim={skeletonPreset.name}
      style={{
        "--skeleton-duration": `${skeletonPreset.durationMs}ms`,
        "--skeleton-delay": `${skeletonPreset.delayMs}ms`,
        "--skeleton-easing": skeletonPreset.easing,
      } as React.CSSProperties}
    >
      <body className={`${inter.variable} ${spaceGrotesk.variable} font-sans`}>
        <Providers>
          <GoogleTranslate />
          <Header />
          <main className="min-h-screen">{children}</main>
          <Footer />
        </Providers>
      </body>
    </html>
  );
}
