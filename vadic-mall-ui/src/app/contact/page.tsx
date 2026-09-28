"use client";

import { useState } from "react";
import toast from "react-hot-toast";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { Card, CardContent } from "@/components/ui/card";
import { postCatalog } from "@/lib/api";
import { Mail, Phone, MapPin } from "lucide-react";

export default function ContactPage() {
  const [loading, setLoading] = useState(false);
  const [form, setForm] = useState({ name: "", email: "", phone: "", subject: "", message: "" });

  const handleSubmit = async (e: React.FormEvent) => {
    e.preventDefault();
    setLoading(true);
    try {
      await postCatalog("/catalog/contact", form);
      toast.success("Message sent! We will respond shortly.");
      setForm({ name: "", email: "", phone: "", subject: "", message: "" });
    } catch {
      toast.error("Failed to send message");
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="mx-auto max-w-7xl px-4 py-12 lg:px-8">
      <h1 className="section-title mb-8 text-center">Contact Us</h1>
      <div className="grid gap-10 lg:grid-cols-2">
        <Card>
          <CardContent className="p-8">
            <form onSubmit={handleSubmit} className="space-y-4">
              <div className="grid grid-cols-2 gap-4">
                <div><label className="mb-1 block text-sm font-medium">Name</label><Input required value={form.name} onChange={(e) => setForm({ ...form, name: e.target.value })} /></div>
                <div><label className="mb-1 block text-sm font-medium">Phone</label><Input value={form.phone} onChange={(e) => setForm({ ...form, phone: e.target.value })} /></div>
              </div>
              <div><label className="mb-1 block text-sm font-medium">Email</label><Input type="email" required value={form.email} onChange={(e) => setForm({ ...form, email: e.target.value })} /></div>
              <div><label className="mb-1 block text-sm font-medium">Subject</label><Input required value={form.subject} onChange={(e) => setForm({ ...form, subject: e.target.value })} /></div>
              <div><label className="mb-1 block text-sm font-medium">Message</label><textarea className="flex min-h-[120px] w-full rounded-xl border border-gray-200 px-4 py-3 text-sm focus:border-saffron focus:outline-none" required value={form.message} onChange={(e) => setForm({ ...form, message: e.target.value })} /></div>
              <Button type="submit" disabled={loading} className="w-full">{loading ? "Sending..." : "Send Message"}</Button>
            </form>
          </CardContent>
        </Card>
        <div className="space-y-6">
          {[
            { icon: Mail, label: "Email", value: "info@vadicmall.com" },
            { icon: Phone, label: "Phone", value: "+91 98765 43210" },
            { icon: MapPin, label: "Address", value: "Vedic Mall Technologies, Bangalore, India" },
          ].map((item) => (
            <div key={item.label} className="flex items-start gap-4 rounded-2xl border bg-white p-6">
              <item.icon className="h-6 w-6 text-saffron" />
              <div><p className="font-semibold text-krishna">{item.label}</p><p className="text-gray-500">{item.value}</p></div>
            </div>
          ))}
        </div>
      </div>
    </div>
  );
}
