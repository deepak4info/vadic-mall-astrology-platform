"use client";

import { useState } from "react";
import { getImageUrl, checkImageAlreadyFailed } from "@/lib/utils";

export function PoojaImage({ imageUrl, name }: { imageUrl?: string; name: string }) {
  const [imgError, setImgError] = useState(false);

  return (
    <>
      <span className="absolute inset-0 flex items-center justify-center text-8xl opacity-40">🪔</span>
      {imageUrl && !imgError && (
        // eslint-disable-next-line @next/next/no-img-element
        <img
          ref={(el) => checkImageAlreadyFailed(el, () => setImgError(true))}
          src={getImageUrl(imageUrl)}
          alt={name}
          className="absolute inset-0 h-full w-full object-cover"
          onError={() => setImgError(true)}
        />
      )}
    </>
  );
}
