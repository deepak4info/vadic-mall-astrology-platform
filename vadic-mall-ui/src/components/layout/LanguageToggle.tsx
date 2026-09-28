"use client";

import { useEffect, useRef, useState } from "react";
import { usePathname } from "next/navigation";
import { Languages } from "lucide-react";

type Lang = "en" | "hi";

function getCookieLang(): Lang {
  if (typeof document === "undefined") return "en";
  const match = document.cookie.match(/googtrans=\/en\/(\w+)/);
  return match?.[1] === "hi" ? "hi" : "en";
}

function applyGoogleTranslate(target: Lang): boolean {
  const select = document.querySelector<HTMLSelectElement>(".goog-te-combo");
  if (!select) return false;
  select.value = target;
  select.dispatchEvent(new Event("change"));
  return true;
}

export function LanguageToggle() {
  const [lang, setLang] = useState<Lang>("en");
  const [open, setOpen] = useState(false);
  const pathname = usePathname();
  const ref = useRef<HTMLDivElement>(null);

  useEffect(() => {
    setLang(getCookieLang());
  }, []);

  useEffect(() => {
    function onClickOutside(e: MouseEvent) {
      if (ref.current && !ref.current.contains(e.target as Node)) setOpen(false);
    }
    document.addEventListener("mousedown", onClickOutside);
    return () => document.removeEventListener("mousedown", onClickOutside);
  }, []);

  useEffect(() => {
    if (lang !== "hi") return;
    const id = setTimeout(() => applyGoogleTranslate("hi"), 500);
    return () => clearTimeout(id);
  }, [pathname, lang]);

  const handleSelect = (target: Lang) => {
    setOpen(false);
    if (target === lang) return;
    setLang(target);
    document.cookie = `googtrans=/en/${target}; path=/`;
    const applied = applyGoogleTranslate(target);
    if (!applied) window.location.reload();
  };

  return (
    <div ref={ref} className="relative">
      <button
        type="button"
        onClick={() => setOpen((v) => !v)}
        aria-label="Change language"
        className="notranslate flex items-center gap-1 rounded-lg p-2 text-white hover:bg-white/10"
      >
        <Languages className="h-5 w-5" />
        <span className="text-xs font-semibold">{lang === "hi" ? "हि" : "EN"}</span>
      </button>

      {open && (
        <div className="notranslate absolute right-0 top-full z-[60] mt-2 w-40 overflow-hidden rounded-2xl border border-gray-100 bg-white p-1 text-left shadow-xl">
          <button
            type="button"
            onClick={() => handleSelect("en")}
            className={`block w-full rounded-xl px-3 py-2 text-left text-sm font-medium transition-colors ${lang === "en" ? "bg-krishna text-white" : "text-krishna hover:bg-krishna/5"}`}
          >
            English
          </button>
          <button
            type="button"
            onClick={() => handleSelect("hi")}
            className={`block w-full rounded-xl px-3 py-2 text-left text-sm font-medium transition-colors ${lang === "hi" ? "bg-krishna text-white" : "text-krishna hover:bg-krishna/5"}`}
          >
            हिंदी
          </button>
        </div>
      )}
    </div>
  );
}
