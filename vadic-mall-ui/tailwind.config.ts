import type { Config } from "tailwindcss";

const config: Config = {
  content: [
    "./src/pages/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/components/**/*.{js,ts,jsx,tsx,mdx}",
    "./src/app/**/*.{js,ts,jsx,tsx,mdx}",
  ],
  theme: {
    extend: {
      colors: {
        krishna: {
          DEFAULT: "#0d0d2b",
          navy: "#1a1a4e",
          light: "#2a2a6e",
        },
        saffron: {
          DEFAULT: "#FF9933",
          dark: "#E68A00",
          light: "#FFB366",
        },
        gold: "#FFD700",
        maroon: {
          DEFAULT: "#7A1E3C",
          dark: "#5C1730",
          light: "#A13A5C",
        },
        indigo: {
          DEFAULT: "#4338CA",
          dark: "#332C9E",
          light: "#6366F1",
        },
      },
      fontFamily: {
        sans: ["var(--font-inter)", "system-ui", "sans-serif"],
        heading: ["var(--font-space-grotesk)", "system-ui", "sans-serif"],
      },
      animation: {
        "diya-glow": "diyaGlow 2s ease-in-out infinite",
        float: "float 3s ease-in-out infinite",
        "pulse-slow": "pulse 3s ease-in-out infinite",
        "fade-in": "fadeIn 0.4s ease-out",
        shimmer: "shimmer 1.6s ease-in-out infinite",
      },
      keyframes: {
        diyaGlow: {
          "0%, 100%": { boxShadow: "0 0 20px rgba(255, 153, 51, 0.4)" },
          "50%": { boxShadow: "0 0 40px rgba(255, 153, 51, 0.8)" },
        },
        float: {
          "0%, 100%": { transform: "translateY(0)" },
          "50%": { transform: "translateY(-10px)" },
        },
        fadeIn: {
          "0%": { opacity: "0", transform: "translateY(6px)" },
          "100%": { opacity: "1", transform: "translateY(0)" },
        },
        shimmer: {
          "0%": { backgroundPosition: "-400px 0" },
          "100%": { backgroundPosition: "400px 0" },
        },
      },
      backgroundImage: {
        "krishna-gradient": "linear-gradient(135deg, #0d0d2b 0%, #1a1a4e 50%, #0d0d2b 100%)",
        "saffron-gradient": "linear-gradient(135deg, #FF9933 0%, #E68A00 100%)",
      },
    },
  },
  plugins: [],
};
export default config;
