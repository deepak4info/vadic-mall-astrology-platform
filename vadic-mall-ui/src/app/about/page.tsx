export const metadata = { title: "About - Vadic Mall" };

export default function AboutPage() {
  return (
    <div className="mx-auto max-w-4xl px-4 py-12 lg:px-8">
      <h1 className="section-title mb-8">About Vadic Mall</h1>
      <div className="prose prose-lg max-w-none space-y-6 text-gray-600">
        <p>Vadic Mall is a comprehensive digital marketplace for authentic Vedic astrology and spiritual services. Our mission is to make traditional Vedic practices accessible to every home through modern technology while preserving the sanctity of ancient traditions.</p>
        <h2 className="font-heading text-xl font-semibold text-krishna">Our Mission</h2>
        <p>Bridge the gap between traditional Vedic practices and modern technology, making authentic astrology accessible to everyone.</p>
        <h2 className="font-heading text-xl font-semibold text-krishna">Our Values</h2>
        <ul className="list-disc pl-6 space-y-2">
          <li>Authenticity in every ritual and product</li>
          <li>Verified and certified astrologers and pandits</li>
          <li>Transparent pricing with no hidden charges</li>
          <li>Devotion to customer satisfaction</li>
        </ul>
      </div>
    </div>
  );
}
