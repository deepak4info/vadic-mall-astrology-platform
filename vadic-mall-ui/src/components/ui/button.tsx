import * as React from "react";
import { Slot } from "@radix-ui/react-slot";
import { cva, type VariantProps } from "class-variance-authority";
import { cn } from "@/lib/utils";

const buttonVariants = cva(
  "inline-flex items-center justify-center whitespace-nowrap rounded-xl text-sm font-semibold transition-all focus-visible:outline-none focus-visible:ring-2 focus-visible:ring-saffron disabled:pointer-events-none disabled:opacity-50",
  {
    variants: {
      variant: {
        default: "bg-saffron text-white hover:bg-saffron-dark hover:scale-105 active:scale-95",
        outline: "border-2 border-saffron text-saffron hover:bg-saffron hover:text-white",
        ghost: "hover:bg-saffron/10 text-krishna",
        krishna: "bg-krishna text-white hover:bg-krishna-navy",
        maroon: "bg-maroon text-white hover:bg-maroon-dark hover:scale-105 active:scale-95",
        "maroon-outline": "border-2 border-maroon text-maroon hover:bg-maroon hover:text-white",
        // No hover:scale transform on the indigo variants (unlike default/maroon) — these
        // back admin table row actions that get swapped or removed the instant they're
        // clicked (Approve -> Revoke, row re-fetch), and a mid-transition scale transform
        // on a element about to unmount is what reads as the hover color "sticking".
        indigo: "bg-indigo text-white hover:bg-indigo-dark",
        "indigo-outline": "border-2 border-indigo text-indigo hover:bg-indigo hover:text-white",
        "indigo-ghost": "hover:bg-indigo/10 text-krishna",
        // Distinct, semantic colors for approve/reject/ban-style actions so each is
        // identifiable at a glance — built on Tailwind's own green/red/amber scales
        // (not custom theme colors), so there's no risk of a stale-config mismatch.
        success: "bg-green-600 text-white hover:bg-green-700",
        "danger-outline": "border-2 border-red-500 text-red-600 hover:bg-red-500 hover:text-white",
        "warning-outline": "border-2 border-amber-500 text-amber-600 hover:bg-amber-500 hover:text-white",
      },
      size: {
        default: "h-11 px-6 py-2",
        sm: "h-9 px-4",
        lg: "h-12 px-8 text-base",
        icon: "h-10 w-10",
      },
    },
    defaultVariants: { variant: "default", size: "default" },
  }
);

export interface ButtonProps
  extends React.ButtonHTMLAttributes<HTMLButtonElement>,
    VariantProps<typeof buttonVariants> {
  asChild?: boolean;
}

const Button = React.forwardRef<HTMLButtonElement, ButtonProps>(
  ({ className, variant, size, asChild = false, ...props }, ref) => {
    const Comp = asChild ? Slot : "button";
    return <Comp className={cn(buttonVariants({ variant, size, className }))} ref={ref} {...props} />;
  }
);
Button.displayName = "Button";

export { Button, buttonVariants };
