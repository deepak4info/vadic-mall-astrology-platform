"use client";

import { useEffect, useState } from "react";
import { useRouter } from "next/navigation";
import toast from "react-hot-toast";
import { Check, Copy, MessageCircle, Share2 } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { CardGridSkeleton, GiftCardTypeSkeleton } from "@/components/ui/skeleton";
import { useCatalog } from "@/lib/hooks";
import { customerPost, getApiErrorMessage } from "@/lib/api";
import { useAuthStore } from "@/store/auth";
import type { GiftCardPurchaseResult, GiftCardType } from "@/lib/types";

const VISIBLE_MS = 5 * 60 * 1000;

function PurchasedCardPanel({ result, purchasedAt }: { result: GiftCardPurchaseResult; purchasedAt: number }) {
  const [now, setNow] = useState(Date.now());
  const [copied, setCopied] = useState(false);

  useEffect(() => {
    const id = setInterval(() => setNow(Date.now()), 1000);
    return () => clearInterval(id);
  }, []);

  const remainingMs = Math.max(0, purchasedAt + VISIBLE_MS - now);
  const expired = remainingMs <= 0;
  const minutes = Math.floor(remainingMs / 60000);
  const seconds = Math.floor((remainingMs % 60000) / 1000);

  const shareText = `I sent you a Vadic Mall gift card worth ₹${result.amount.toLocaleString("en-IN")}! Use code ${result.code} at checkout.`;

  const copyCode = async () => {
    await navigator.clipboard.writeText(result.code);
    setCopied(true);
    toast.success("Code copied to clipboard");
    setTimeout(() => setCopied(false), 2000);
  };

  const shareNative = async () => {
    if (navigator.share) {
      try {
        await navigator.share({ title: "Vadic Mall Gift Card", text: shareText });
      } catch {
        /* user cancelled share sheet */
      }
    } else {
      await navigator.clipboard.writeText(shareText);
      toast.success("Share message copied to clipboard");
    }
  };

  const shareWhatsApp = () => {
    window.open(`https://wa.me/?text=${encodeURIComponent(shareText)}`, "_blank");
  };

  return (
    <Card className="mb-10 border-2 border-saffron">
      <CardContent className="p-6 text-center">
        <p className="text-sm font-medium text-saffron">Gift Card Purchased!</p>
        <p className="mt-1 text-2xl font-heading font-bold text-krishna">₹{result.amount.toLocaleString("en-IN")}</p>

        <div className="mx-auto mt-4 max-w-sm rounded-xl border border-dashed border-saffron/50 bg-saffron/5 p-4">
          {expired ? (
            <p className="text-sm text-gray-500">
              Code hidden for security. It&apos;s saved in your <span className="font-medium text-saffron">Notifications</span> — click the bell icon in the header.
            </p>
          ) : (
            <>
              <p className="font-mono text-xl font-bold tracking-widest text-krishna">{result.code}</p>
              <p className="mt-1 text-xs text-gray-500">
                Visible for {minutes}:{seconds.toString().padStart(2, "0")} — copy or share it before it hides
              </p>
            </>
          )}
        </div>

        {!expired && (
          <div className="mt-4 flex flex-wrap items-center justify-center gap-3">
            <Button variant="outline" size="sm" onClick={copyCode}>
              {copied ? <Check className="mr-2 h-4 w-4" /> : <Copy className="mr-2 h-4 w-4" />}
              {copied ? "Copied" : "Copy Code"}
            </Button>
            <Button variant="outline" size="sm" onClick={shareWhatsApp}>
              <MessageCircle className="mr-2 h-4 w-4" /> WhatsApp
            </Button>
            <Button variant="outline" size="sm" onClick={shareNative}>
              <Share2 className="mr-2 h-4 w-4" /> Share
            </Button>
          </div>
        )}
        <p className="mt-4 text-xs text-gray-400">Share this code with anyone — they can redeem it on Vadic Mall at checkout.</p>
      </CardContent>
    </Card>
  );
}

export default function GiftCardsPage() {
  const router = useRouter();
  const { user } = useAuthStore();
  const [loading, setLoading] = useState<string | null>(null);
  const [purchase, setPurchase] = useState<{ result: GiftCardPurchaseResult; purchasedAt: number } | null>(null);
  const { data: types = [], isLoading } = useCatalog<GiftCardType[]>("gift-cards", "/catalog/gift-cards");

  const buy = async (type: string, amount: number) => {
    if (!user) { router.push("/login"); return; }
    setLoading(`${type}-${amount}`);
    try {
      const result = await customerPost<GiftCardPurchaseResult>("/gift-cards/purchase", { type, amount, paymentMethod: "UPI" });
      setPurchase({ result, purchasedAt: Date.now() });
      toast.success("Gift card purchased!");
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Purchase failed"));
    } finally {
      setLoading(null);
    }
  };

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <div className="mb-10 text-center">
        <h1 className="section-title">Gift Cards</h1>
        <p className="mt-2 text-gray-500">Share the gift of spirituality with your loved ones</p>
      </div>

      {purchase && <PurchasedCardPanel key={purchase.result.id} result={purchase.result} purchasedAt={purchase.purchasedAt} />}

      {isLoading ? <CardGridSkeleton Card={GiftCardTypeSkeleton} count={2} className="grid gap-6 md:grid-cols-2" /> : (
        <div className="grid animate-fade-in gap-6 md:grid-cols-2">
          {types.map((gc) => (
            <Card key={gc.type}>
              <CardContent className="p-6">
                <h3 className="font-heading text-xl font-semibold text-krishna">{gc.type}</h3>
                <div className="mt-4 flex flex-wrap gap-3">
                  {gc.denominations.map((d) => (
                    <Button key={d} variant="outline" size="sm" disabled={loading === `${gc.type}-${d}`} onClick={() => buy(gc.type, d)}>
                      {loading === `${gc.type}-${d}` ? "..." : `₹${d.toLocaleString("en-IN")}`}
                    </Button>
                  ))}
                </div>
              </CardContent>
            </Card>
          ))}
        </div>
      )}
    </div>
  );
}
