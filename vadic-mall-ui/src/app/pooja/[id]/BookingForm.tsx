"use client";

import { useState } from "react";
import { useRouter } from "next/navigation";
import toast from "react-hot-toast";
import { Button } from "@/components/ui/button";
import { Input } from "@/components/ui/input";
import { useAuthStore } from "@/store/auth";
import { customerPost, getApiErrorMessage } from "@/lib/api";

export function PoojaBookingForm({ serviceId, serviceName, amount }: { serviceId: string; serviceName: string; amount: number }) {
  const router = useRouter();
  const { user } = useAuthStore();
  const [loading, setLoading] = useState(false);
  const [date, setDate] = useState("");
  const [time, setTime] = useState("");
  const [instructions, setInstructions] = useState("");

  const handleBook = async () => {
    if (!user) { router.push("/login"); return; }
    if (!date) { toast.error("Please select a date"); return; }

    setLoading(true);
    try {
      await customerPost("/pooja-bookings", {
        poojaServiceId: serviceId,
        scheduledDate: date,
        scheduledTime: time,
        specialInstructions: instructions,
      });
      toast.success(`${serviceName} booked successfully!`);
      router.push("/customer");
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Booking failed"));
    } finally {
      setLoading(false);
    }
  };

  return (
    <div className="mt-8 space-y-4 rounded-2xl border border-gray-100 bg-gray-50 p-6">
      <h3 className="font-heading font-semibold text-krishna">Book This Pooja</h3>
      <div className="grid gap-4 sm:grid-cols-2">
        <div>
          <label className="mb-1 block text-sm font-medium">Preferred Date</label>
          <Input type="date" value={date} onChange={(e) => setDate(e.target.value)} min={new Date().toISOString().split("T")[0]} />
        </div>
        <div>
          <label className="mb-1 block text-sm font-medium">Preferred Time</label>
          <Input type="time" value={time} onChange={(e) => setTime(e.target.value)} />
        </div>
      </div>
      <div>
        <label className="mb-1 block text-sm font-medium">Special Instructions (Optional)</label>
        <Input value={instructions} onChange={(e) => setInstructions(e.target.value)} placeholder="Any specific requirements..." />
      </div>
      <Button onClick={handleBook} disabled={loading} variant="krishna" className="w-full" size="lg">
        {loading ? "Booking..." : `Book Now — ₹${amount}`}
      </Button>
    </div>
  );
}
