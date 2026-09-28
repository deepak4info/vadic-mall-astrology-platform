export const metadata = { title: "Shipping & Returns - Vadic Mall" };

export default function ShippingPage() {
  return (
    <div className="mx-auto max-w-4xl px-4 py-12 lg:px-8">
      <h1 className="section-title mb-8">Shipping &amp; Returns</h1>
      <div className="prose prose-lg max-w-none space-y-6 text-gray-600">
        <h2 className="font-heading text-xl font-semibold text-krishna">Shipping</h2>
        <p>We deliver spiritual products, gemstones, and pooja samagri across India. Orders above ₹999 qualify for free shipping; orders below this amount carry a flat shipping fee of ₹99. Most orders are dispatched within 2-3 business days and delivered within 5-7 business days depending on location.</p>
        <h2 className="font-heading text-xl font-semibold text-krishna">Order Tracking</h2>
        <p>Once your order ships, you can track its status from the Orders section of your customer dashboard.</p>
        <h2 className="font-heading text-xl font-semibold text-krishna">Returns &amp; Exchanges</h2>
        <p>Unopened, unused products can be returned within 7 days of delivery. Certified gemstones and personalized items (such as kundli reports and pooja bookings) are non-returnable once the service has been performed or the report generated.</p>
        <h2 className="font-heading text-xl font-semibold text-krishna">Refunds</h2>
        <p>Approved refunds are processed back to the original payment method within 5-7 business days.</p>
        <h2 className="font-heading text-xl font-semibold text-krishna">Contact</h2>
        <p>For help with a shipment or return, reach out via the Contact page with your order number.</p>
      </div>
    </div>
  );
}
