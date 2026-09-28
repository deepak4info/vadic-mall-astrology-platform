"use client";

import { useState } from "react";
import toast from "react-hot-toast";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { postCatalog, getApiErrorMessage } from "@/lib/api";

export function NewsletterForm() {
  const [email, setEmail] = useState("");
  const [loading, setLoading] = useState(false);

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      await postCatalog("/catalog/newsletter", { email });
      toast.success("Subscribed! Watch your inbox for divine wisdom.");
      setEmail("");
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Subscription failed"));
    } finally {
      setLoading(false);
    }
  };

  return (
    <form onSubmit={handleSubmit} className="mx-auto mt-6 flex max-w-md gap-3">
      <Input
        type="email"
        required
        placeholder="you@example.com"
        value={email}
        onChange={(e) => setEmail(e.target.value)}
        className="bg-white"
      />
      <Button type="submit" variant="krishna" size="lg" disabled={loading}>
        {loading ? "..." : "Subscribe"}
      </Button>
    </form>
  );
}
