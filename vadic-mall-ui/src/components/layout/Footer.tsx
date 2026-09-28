import Link from "next/link";
import { Sparkles, Mail, Phone, MapPin } from "lucide-react";

export function Footer() {
  return (
    <footer className="bg-krishna text-white">
      <div className="mx-auto max-w-7xl px-4 py-16 lg:px-8">
        <div className="grid gap-12 md:grid-cols-2 lg:grid-cols-4">
          <div>
            <div className="mb-4 flex items-center gap-2">
              <Sparkles className="h-8 w-8 text-saffron" />
              <span className="font-heading text-2xl font-bold">Vadic Mall</span>
            </div>
            <p className="text-sm text-white/70">
              Your one-stop digital marketplace for authentic Vedic astrology, pooja services, spiritual products, and expert consultations.
            </p>
          </div>

          <div>
            <h4 className="mb-4 font-heading font-semibold text-saffron">Services</h4>
            <ul className="space-y-2 text-sm text-white/70">
              <li><Link href="/pooja" className="hover:text-saffron">Pooja Services</Link></li>
              <li><Link href="/products" className="hover:text-saffron">Spiritual Products</Link></li>
              <li><Link href="/kundli" className="hover:text-saffron">Kundli Analysis</Link></li>
              <li><Link href="/astrologers" className="hover:text-saffron">Astrologer Consultation</Link></li>
            </ul>
          </div>

          <div>
            <h4 className="mb-4 font-heading font-semibold text-saffron">Quick Links</h4>
            <ul className="space-y-2 text-sm text-white/70">
              <li><Link href="/about" className="hover:text-saffron">About Us</Link></li>
              <li><Link href="/blog" className="hover:text-saffron">Blog</Link></li>
              <li><Link href="/faq" className="hover:text-saffron">FAQ</Link></li>
              <li><Link href="/contact" className="hover:text-saffron">Contact</Link></li>
              <li><Link href="/gift-cards" className="hover:text-saffron">Gift Cards</Link></li>
            </ul>
          </div>

          <div>
            <h4 className="mb-4 font-heading font-semibold text-saffron">Contact</h4>
            <ul className="space-y-3 text-sm text-white/70">
              <li className="flex items-center gap-2"><Mail className="h-4 w-4 text-saffron" /> info@vadicmall.com</li>
              <li className="flex items-center gap-2"><Phone className="h-4 w-4 text-saffron" /> +91 98765 43210</li>
              <li className="flex items-start gap-2"><MapPin className="mt-0.5 h-4 w-4 shrink-0 text-saffron" /> Bangalore, India</li>
            </ul>
          </div>
        </div>

        <div className="mt-12 flex flex-col items-center justify-between gap-4 border-t border-white/10 pt-8 text-sm text-white/50 md:flex-row">
          <p>© 2026 Vadic Mall. All rights reserved. Jai Shree Krishna!</p>
          <div className="flex gap-6">
            <Link href="/terms" className="hover:text-saffron">Terms</Link>
            <Link href="/privacy" className="hover:text-saffron">Privacy</Link>
            <Link href="/shipping" className="hover:text-saffron">Shipping</Link>
          </div>
        </div>
      </div>
    </footer>
  );
}
