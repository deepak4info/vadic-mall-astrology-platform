import Link from "next/link";
import { ArrowRight, Star, Shield, Truck, HeadphonesIcon, Users } from "lucide-react";
import { Button } from "@/components/ui/button";
import { PoojaCard, ProductCard, AstrologerCard } from "@/components/cards/ServiceCards";
import { NewsletterForm } from "@/components/NewsletterForm";
import { fetchCatalog } from "@/lib/api";
import type { PoojaService, Product, Astrologer, BlogPost, Testimonial } from "@/lib/types";

async function getHomeData() {
  try {
    const [poojas, products, astrologers, blog, testimonials] = await Promise.all([
      fetchCatalog<PoojaService[]>("/catalog/pooja-services", { featured: true }),
      fetchCatalog<Product[]>("/catalog/products", { featured: true }),
      fetchCatalog<Astrologer[]>("/catalog/astrologers"),
      fetchCatalog<BlogPost[]>("/catalog/blog"),
      fetchCatalog<Testimonial[]>("/catalog/testimonials"),
    ]);
    return {
      poojas: poojas.slice(0, 4),
      products: products.slice(0, 4),
      astrologers: astrologers.filter((a) => a.isFeatured).slice(0, 4),
      blog: blog.slice(0, 3),
      testimonials: testimonials.slice(0, 4),
    };
  } catch {
    return { poojas: [], products: [], astrologers: [], blog: [], testimonials: [] };
  }
}

const stats = [
  { label: "Happy Devotees", value: "10,000+" },
  { label: "Poojas Performed", value: "5,000+" },
  { label: "Expert Astrologers", value: "50+" },
  { label: "Products Delivered", value: "25,000+" },
];

const trustBadges = [
  { icon: Shield, title: "Authentic Services", desc: "Certified pandits & verified astrologers" },
  { icon: Truck, title: "Pan India Delivery", desc: "Free shipping above ₹999" },
  { icon: HeadphonesIcon, title: "24/7 Support", desc: "Dedicated spiritual guidance team" },
  { icon: Star, title: "4.9 Rating", desc: "Trusted by thousands of devotees" },
];

export default async function HomePage() {
  const { poojas, products, astrologers, blog, testimonials } = await getHomeData();

  return (
    <>
      {/* Hero */}
      <section className="relative overflow-hidden bg-krishna-gradient py-20 lg:py-32">
        <div className="absolute inset-0 opacity-10">
          <div className="absolute left-1/4 top-1/4 h-64 w-64 animate-float rounded-full bg-saffron blur-3xl" />
          <div className="absolute bottom-1/4 right-1/4 h-48 w-48 animate-float rounded-full bg-gold blur-3xl" style={{ animationDelay: "1s" }} />
        </div>
        <div className="relative mx-auto max-w-7xl px-4 text-center lg:px-8">
          <p className="mb-4 text-sm font-semibold uppercase tracking-widest text-saffron animate-fade-in">🕉️ Jai Shree Krishna</p>
          <h1 className="font-heading text-4xl font-bold text-white md:text-6xl lg:text-7xl animate-fade-in">
            Vedic Tradition<br /><span className="gradient-text">Meets Modern Technology</span>
          </h1>
          <p className="mx-auto mt-6 max-w-2xl text-lg text-white/70 animate-fade-in">
            Book authentic poojas, purchase certified spiritual products, get detailed kundli analysis, and consult verified Vedic astrologers — all from the comfort of your home.
          </p>
          <div className="mt-10 flex flex-wrap items-center justify-center gap-4 animate-fade-in">
            <Link href="/pooja"><Button size="lg">Book a Pooja <ArrowRight className="ml-2 h-5 w-5" /></Button></Link>
            <Link href="/products"><Button size="lg" variant="outline" className="border-white text-white hover:bg-white hover:text-krishna">Shop Products</Button></Link>
            <Link href="/kundli"><Button size="lg" variant="ghost" className="text-white hover:bg-white/10">Get Kundli</Button></Link>
          </div>
        </div>
      </section>

      {/* Quick Categories */}
      <section className="mx-auto max-w-7xl px-4 py-16 lg:px-8">
        <div className="grid grid-cols-2 gap-4 md:grid-cols-3 lg:grid-cols-6">
          {[
            { href: "/pooja", icon: "🪔", label: "Pooja Services" },
            { href: "/products?category=gemstones", icon: "💎", label: "Gemstones" },
            { href: "/kundli", icon: "⭐", label: "Kundli" },
            { href: "/astrologers", icon: "🧘", label: "Astrologers" },
            { href: "/festival", icon: "🎉", label: "Festival Offers" },
            { href: "/gift-cards", icon: "🎁", label: "Gift Cards" },
          ].map((cat) => (
            <Link key={cat.href} href={cat.href} className="group rounded-2xl border border-gray-100 bg-white p-6 text-center shadow-sm transition-all hover:border-saffron hover:shadow-lg">
              <span className="text-3xl">{cat.icon}</span>
              <p className="mt-2 text-sm font-semibold text-krishna group-hover:text-saffron">{cat.label}</p>
            </Link>
          ))}
        </div>
      </section>

      {/* Stats */}
      <section className="bg-krishna py-12">
        <div className="mx-auto grid max-w-7xl grid-cols-2 gap-8 px-4 lg:grid-cols-4 lg:px-8">
          {stats.map((stat) => (
            <div key={stat.label} className="text-center">
              <p className="font-heading text-3xl font-bold text-saffron md:text-4xl">{stat.value}</p>
              <p className="mt-1 text-sm text-white/70">{stat.label}</p>
            </div>
          ))}
        </div>
      </section>

      {/* Featured Poojas */}
      {poojas.length > 0 && (
        <section className="mx-auto max-w-7xl px-4 py-16 lg:px-8">
          <div className="mb-8 flex items-end justify-between">
            <div>
              <h2 className="section-title">Featured Pooja Services</h2>
              <p className="mt-2 text-gray-500">Authentic Vedic rituals performed by certified pandits</p>
            </div>
            <Link href="/pooja" className="hidden text-saffron hover:underline sm:block">View All →</Link>
          </div>
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
            {poojas.map((p) => <PoojaCard key={p.id} service={p} />)}
          </div>
        </section>
      )}

      {/* Featured Products */}
      {products.length > 0 && (
        <section className="bg-gray-50 py-16">
          <div className="mx-auto max-w-7xl px-4 lg:px-8">
            <div className="mb-8 flex items-end justify-between">
              <div>
                <h2 className="section-title">Popular Products</h2>
                <p className="mt-2 text-gray-500">Certified gemstones, malas, and spiritual essentials</p>
              </div>
              <Link href="/products" className="hidden text-saffron hover:underline sm:block">View All →</Link>
            </div>
            <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
              {products.map((p) => <ProductCard key={p.id} product={p} />)}
            </div>
          </div>
        </section>
      )}

      {/* Top Astrologers */}
      {astrologers.length > 0 && (
        <section className="mx-auto max-w-7xl px-4 py-16 lg:px-8">
          <div className="mb-8 text-center">
            <h2 className="section-title">Top Astrologers</h2>
            <p className="mt-2 text-gray-500">Consult with verified Vedic astrology experts</p>
          </div>
          <div className="grid gap-6 sm:grid-cols-2 lg:grid-cols-4">
            {astrologers.map((a) => <AstrologerCard key={a.id} astrologer={a} />)}
          </div>
        </section>
      )}

      {/* Trust Badges */}
      <section className="border-y border-gray-100 bg-white py-12">
        <div className="mx-auto grid max-w-7xl grid-cols-2 gap-8 px-4 lg:grid-cols-4 lg:px-8">
          {trustBadges.map((badge) => (
            <div key={badge.title} className="flex items-start gap-3">
              <div className="flex h-10 w-10 shrink-0 items-center justify-center rounded-xl bg-saffron/10">
                <badge.icon className="h-5 w-5 text-saffron" />
              </div>
              <div>
                <p className="font-semibold text-krishna">{badge.title}</p>
                <p className="text-sm text-gray-500">{badge.desc}</p>
              </div>
            </div>
          ))}
        </div>
      </section>

      {/* Testimonials */}
      {testimonials.length > 0 && (
        <section className="bg-krishna-gradient py-16">
          <div className="mx-auto max-w-7xl px-4 lg:px-8">
            <h2 className="mb-8 text-center font-heading text-3xl font-bold text-white">What Devotees Say</h2>
            <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-4">
              {testimonials.map((t) => (
                <div key={t.name} className="glass-card p-6">
                  <div className="mb-3 flex gap-1">
                    {Array.from({ length: t.rating }).map((_, i) => (
                      <Star key={i} className="h-4 w-4 fill-gold text-gold" />
                    ))}
                  </div>
                  <p className="text-sm text-white/80">&ldquo;{t.comment}&rdquo;</p>
                  <div className="mt-4 flex items-center gap-2">
                    <Users className="h-8 w-8 rounded-full bg-saffron/20 p-1.5 text-saffron" />
                    <div>
                      <p className="text-sm font-semibold text-white">{t.name}</p>
                      <p className="text-xs text-white/50">{t.location}</p>
                    </div>
                  </div>
                </div>
              ))}
            </div>
          </div>
        </section>
      )}

      {/* Blog */}
      {blog.length > 0 && (
        <section className="mx-auto max-w-7xl px-4 py-16 lg:px-8">
          <div className="mb-8 flex items-end justify-between">
            <h2 className="section-title">Latest from Our Blog</h2>
            <Link href="/blog" className="text-saffron hover:underline">View All →</Link>
          </div>
          <div className="grid gap-6 md:grid-cols-3">
            {blog.map((post) => (
              <Link key={post.id} href={`/blog/${post.slug}`} className="group rounded-2xl border border-gray-100 bg-white p-6 shadow-sm transition-all hover:shadow-lg">
                <p className="text-xs font-medium text-saffron">{post.categoryName}</p>
                <h3 className="mt-2 font-heading text-lg font-semibold text-krishna group-hover:text-saffron">{post.title}</h3>
                <p className="mt-2 line-clamp-2 text-sm text-gray-500">{post.excerpt}</p>
                <p className="mt-4 text-xs text-gray-400">By {post.author}</p>
              </Link>
            ))}
          </div>
        </section>
      )}

      {/* Newsletter CTA */}
      <section className="bg-saffron-gradient py-16">
        <div className="mx-auto max-w-2xl px-4 text-center">
          <h2 className="font-heading text-3xl font-bold text-white">Stay Connected with Divine Wisdom</h2>
          <p className="mt-2 text-white/80">Subscribe for astrology tips, festival guides, and exclusive offers</p>
          <NewsletterForm />
        </div>
      </section>
    </>
  );
}
