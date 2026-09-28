import { fetchCatalog } from "@/lib/api";
import type { Faq } from "@/lib/types";

export const metadata = { title: "FAQ - Vadic Mall" };

export default async function FaqPage() {
  let faqs: Faq[] = [];
  try {
    faqs = await fetchCatalog<Faq[]>("/catalog/faqs");
  } catch { /* API unavailable */ }

  const grouped = faqs.reduce<Record<string, Faq[]>>((acc, faq) => {
    (acc[faq.category] ??= []).push(faq);
    return acc;
  }, {});

  return (
    <div className="mx-auto max-w-3xl px-4 py-12 lg:px-8">
      <h1 className="section-title mb-8 text-center">Frequently Asked Questions</h1>
      {Object.entries(grouped).map(([category, items]) => (
        <div key={category} className="mb-8">
          <h2 className="mb-4 font-heading text-lg font-semibold text-saffron">{category}</h2>
          <div className="space-y-3">
            {items.map((faq) => (
              <details key={faq.id} className="group rounded-xl border bg-white">
                <summary className="cursor-pointer p-4 font-medium text-krishna hover:text-saffron">{faq.question}</summary>
                <p className="border-t px-4 py-3 text-sm text-gray-600">{faq.answer}</p>
              </details>
            ))}
          </div>
        </div>
      ))}
    </div>
  );
}
