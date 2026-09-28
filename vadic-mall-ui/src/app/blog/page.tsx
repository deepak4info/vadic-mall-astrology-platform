import Link from "next/link";
import { fetchCatalog } from "@/lib/api";
import type { BlogPost } from "@/lib/types";

export const metadata = { title: "Blog - Vadic Mall" };

export default async function BlogPage() {
  let posts: BlogPost[] = [];
  try {
    posts = await fetchCatalog<BlogPost[]>("/catalog/blog");
  } catch { /* API unavailable */ }

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <h1 className="section-title mb-8">Astrology Blog</h1>
      <div className="grid gap-6 md:grid-cols-2 lg:grid-cols-3">
        {posts.map((post) => (
          <Link key={post.id} href={`/blog/${post.slug}`} className="group rounded-2xl border bg-white p-6 shadow-sm transition-all hover:shadow-lg">
            <p className="text-xs font-medium text-saffron">{post.categoryName}</p>
            <h2 className="mt-2 font-heading text-lg font-semibold text-krishna group-hover:text-saffron">{post.title}</h2>
            <p className="mt-2 line-clamp-3 text-sm text-gray-500">{post.excerpt}</p>
            <p className="mt-4 text-xs text-gray-400">By {post.author} · {post.viewCount} views</p>
          </Link>
        ))}
      </div>
    </div>
  );
}
