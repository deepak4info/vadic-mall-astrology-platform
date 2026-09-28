import { cn } from "@/lib/utils";

interface BadgeProps {
  children: React.ReactNode;
  variant?: "default" | "sale" | "featured" | "festival";
  className?: string;
}

export function Badge({ children, variant = "default", className }: BadgeProps) {
  return (
    <span
      className={cn(
        "inline-flex items-center rounded-full px-2.5 py-0.5 text-xs font-semibold",
        variant === "default" && "bg-krishna/10 text-krishna",
        variant === "sale" && "bg-red-100 text-red-700",
        variant === "featured" && "bg-gold/20 text-amber-800",
        variant === "festival" && "bg-saffron/20 text-saffron-dark",
        className
      )}
    >
      {children}
    </span>
  );
}
