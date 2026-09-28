"use client";

import Link from "next/link";
import { useEffect, useState } from "react";
import { fetchCatalog } from "@/lib/api";
import type { BlogPostDetail } from "@/lib/types";

export default function BlogPostPageClient({ params }: { params: { slug: string } }) {
  const [post, setPost] = useState<BlogPostDetail | null>(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    let active = true;

    async function loadPost() {
      try {
        const result = await fetchCatalog<BlogPostDetail>(`/catalog/blog/${params.slug}`);
        if (active) setPost(result);
      } catch {
        if (active) setPost(null);
      } finally {
        if (active) setLoading(false);
      }
    }

    loadPost();
    return () => {
      active = false;
    };
  }, [params.slug]);

  if (loading) return <div className="py-20 text-center text-gray-500">Loading article...</div>;
  if (!post) return <div className="py-20 text-center text-gray-500">Article not found.</div>;

  return (
    <article className="mx-auto max-w-3xl px-4 py-12">
      <Link href="/blog" className="text-sm text-saffron hover:underline">← Back to Blog</Link>
      <p className="mt-4 text-sm font-medium text-saffron">{post.categoryName}</p>
      <h1 className="mt-2 font-heading text-3xl font-bold text-krishna md:text-4xl">{post.title}</h1>
      <p className="mt-4 text-sm text-gray-400">By {post.author}</p>
      <div className="prose prose-lg mt-8 max-w-none text-gray-600">
        <p>{post.content}</p>
      </div>
    </article>
  );
}
