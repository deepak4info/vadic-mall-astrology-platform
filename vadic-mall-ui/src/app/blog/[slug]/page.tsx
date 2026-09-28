import BlogPostPageClient from "./BlogPostPageClient";

export async function generateStaticParams() {
  return [{ slug: "demo-post" }];
}

export default function BlogPostPage({ params }: { params: { slug: string } }) {
  return <BlogPostPageClient params={params} />;
}
