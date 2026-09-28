"use client";

import { useRef, useState } from "react";
import * as DialogPrimitive from "@radix-ui/react-dialog";
import { ChevronLeft, ChevronRight, Minus, Plus, X, ZoomIn } from "lucide-react";
import { cn, checkImageAlreadyFailed, getImageUrl } from "@/lib/utils";

const MIN_ZOOM = 1;
const MAX_ZOOM = 3;
const ZOOM_STEP = 0.5;

export function ProductImageGallery({ images, productName }: { images: string[]; productName: string }) {
  const gallery = (images || []).filter(Boolean);
  const [selected, setSelected] = useState(0);
  const [failed, setFailed] = useState<Set<number>>(new Set());
  const [lightboxOpen, setLightboxOpen] = useState(false);
  const [zoom, setZoom] = useState(1);
  const [pan, setPan] = useState({ x: 0, y: 0 });
  const dragRef = useRef<{ startX: number; startY: number; panX: number; panY: number } | null>(null);
  const [isDragging, setIsDragging] = useState(false);

  const markFailed = (i: number) => setFailed((prev) => new Set(prev).add(i));
  const activeSrc = gallery[selected] && !failed.has(selected) ? getImageUrl(gallery[selected]) : undefined;

  const resetZoom = () => {
    setZoom(1);
    setPan({ x: 0, y: 0 });
  };

  const select = (i: number) => {
    setSelected(i);
    resetZoom();
  };

  const showPrev = () => select((selected - 1 + gallery.length) % gallery.length);
  const showNext = () => select((selected + 1) % gallery.length);

  const zoomIn = () => setZoom((z) => Math.min(MAX_ZOOM, +(z + ZOOM_STEP).toFixed(2)));
  const zoomOut = () =>
    setZoom((z) => {
      const next = Math.max(MIN_ZOOM, +(z - ZOOM_STEP).toFixed(2));
      if (next === MIN_ZOOM) setPan({ x: 0, y: 0 });
      return next;
    });

  const openLightbox = () => {
    if (!activeSrc) return;
    resetZoom();
    setLightboxOpen(true);
  };

  const handleWheel = (e: React.WheelEvent) => {
    e.preventDefault();
    if (e.deltaY < 0) zoomIn();
    else zoomOut();
  };

  const handlePointerDown = (e: React.PointerEvent) => {
    if (zoom <= MIN_ZOOM) return;
    dragRef.current = { startX: e.clientX, startY: e.clientY, panX: pan.x, panY: pan.y };
    setIsDragging(true);
    (e.currentTarget as Element).setPointerCapture(e.pointerId);
  };
  const handlePointerMove = (e: React.PointerEvent) => {
    if (!dragRef.current) return;
    setPan({ x: dragRef.current.panX + (e.clientX - dragRef.current.startX), y: dragRef.current.panY + (e.clientY - dragRef.current.startY) });
  };
  const handlePointerUp = () => {
    dragRef.current = null;
    setIsDragging(false);
  };

  return (
    <div>
      <div className="relative flex h-80 items-center justify-center overflow-hidden rounded-2xl bg-gradient-to-br from-krishna/5 to-saffron/10 lg:h-96">
        <span className="absolute inset-0 flex items-center justify-center text-8xl opacity-40">📿</span>
        {activeSrc && (
          // eslint-disable-next-line @next/next/no-img-element
          <img
            ref={(el) => checkImageAlreadyFailed(el, () => markFailed(selected))}
            src={activeSrc}
            alt={productName}
            className="absolute inset-0 h-full w-full cursor-zoom-in object-cover"
            onError={() => markFailed(selected)}
            onClick={openLightbox}
          />
        )}
        {activeSrc && (
          <button
            type="button"
            onClick={openLightbox}
            className="absolute bottom-3 right-3 flex h-9 w-9 items-center justify-center rounded-full bg-white/90 text-krishna shadow hover:bg-white"
            aria-label="Zoom image"
          >
            <ZoomIn className="h-4 w-4" />
          </button>
        )}
        {gallery.length > 1 && (
          <>
            <button
              type="button"
              onClick={showPrev}
              className="absolute left-2 top-1/2 flex h-8 w-8 -translate-y-1/2 items-center justify-center rounded-full bg-white/80 text-krishna shadow hover:bg-white"
              aria-label="Previous image"
            >
              <ChevronLeft className="h-4 w-4" />
            </button>
            <button
              type="button"
              onClick={showNext}
              className="absolute right-2 top-1/2 flex h-8 w-8 -translate-y-1/2 items-center justify-center rounded-full bg-white/80 text-krishna shadow hover:bg-white"
              aria-label="Next image"
            >
              <ChevronRight className="h-4 w-4" />
            </button>
          </>
        )}
      </div>

      {gallery.length > 1 && (
        <div className="mt-3 flex gap-3 overflow-x-auto pb-1">
          {gallery.map((img, i) => (
            <button
              key={img + i}
              type="button"
              onClick={() => select(i)}
              className={cn(
                "h-16 w-16 shrink-0 overflow-hidden rounded-lg border-2 bg-gray-50",
                selected === i ? "border-saffron" : "border-transparent hover:border-gray-200"
              )}
              aria-label={`View image ${i + 1}`}
            >
              {!failed.has(i) ? (
                // eslint-disable-next-line @next/next/no-img-element
                <img
                  ref={(el) => checkImageAlreadyFailed(el, () => markFailed(i))}
                  src={getImageUrl(img)}
                  alt={`${productName} ${i + 1}`}
                  className="h-full w-full object-cover"
                  onError={() => markFailed(i)}
                />
              ) : (
                <span className="flex h-full w-full items-center justify-center text-xl opacity-40">📿</span>
              )}
            </button>
          ))}
        </div>
      )}

      <DialogPrimitive.Root open={lightboxOpen} onOpenChange={setLightboxOpen}>
        <DialogPrimitive.Portal>
          <DialogPrimitive.Overlay className="fixed inset-0 z-50 bg-black/90 data-[state=open]:animate-fade-in" />
          <DialogPrimitive.Content
            className="fixed inset-0 z-50 flex flex-col outline-none"
            onOpenAutoFocus={(e) => e.preventDefault()}
          >
            <DialogPrimitive.Title className="sr-only">{productName} — image preview</DialogPrimitive.Title>
            <div className="flex items-center justify-between gap-3 p-4">
              <div className="flex items-center gap-2 rounded-full bg-white/10 px-2 py-1">
                <button
                  type="button"
                  onClick={zoomOut}
                  disabled={zoom <= MIN_ZOOM}
                  className="flex h-9 w-9 items-center justify-center rounded-full text-white hover:bg-white/10 disabled:opacity-30"
                  aria-label="Zoom out"
                >
                  <Minus className="h-4 w-4" />
                </button>
                <span className="w-12 text-center text-sm text-white">{Math.round(zoom * 100)}%</span>
                <button
                  type="button"
                  onClick={zoomIn}
                  disabled={zoom >= MAX_ZOOM}
                  className="flex h-9 w-9 items-center justify-center rounded-full text-white hover:bg-white/10 disabled:opacity-30"
                  aria-label="Zoom in"
                >
                  <Plus className="h-4 w-4" />
                </button>
              </div>
              <DialogPrimitive.Close asChild>
                <button
                  type="button"
                  className="flex h-9 w-9 items-center justify-center rounded-full bg-white/10 text-white hover:bg-white/20"
                  aria-label="Close"
                >
                  <X className="h-4 w-4" />
                </button>
              </DialogPrimitive.Close>
            </div>

            <div
              className="relative flex flex-1 touch-none items-center justify-center overflow-hidden"
              onWheel={handleWheel}
              onPointerDown={handlePointerDown}
              onPointerMove={handlePointerMove}
              onPointerUp={handlePointerUp}
              onPointerLeave={handlePointerUp}
            >
              {gallery.length > 1 && (
                <button
                  type="button"
                  onClick={showPrev}
                  className="absolute left-4 z-10 flex h-10 w-10 items-center justify-center rounded-full bg-white/10 text-white hover:bg-white/20"
                  aria-label="Previous image"
                >
                  <ChevronLeft className="h-5 w-5" />
                </button>
              )}
              {activeSrc && (
                // eslint-disable-next-line @next/next/no-img-element
                <img
                  src={activeSrc}
                  alt={productName}
                  draggable={false}
                  className="max-h-full max-w-full select-none object-contain"
                  style={{
                    transform: `translate(${pan.x}px, ${pan.y}px) scale(${zoom})`,
                    cursor: zoom > MIN_ZOOM ? (isDragging ? "grabbing" : "grab") : "zoom-in",
                    transition: isDragging ? "none" : "transform 0.15s ease-out",
                  }}
                  onClick={() => {
                    if (zoom === MIN_ZOOM) zoomIn();
                  }}
                />
              )}
              {gallery.length > 1 && (
                <button
                  type="button"
                  onClick={showNext}
                  className="absolute right-4 z-10 flex h-10 w-10 items-center justify-center rounded-full bg-white/10 text-white hover:bg-white/20"
                  aria-label="Next image"
                >
                  <ChevronRight className="h-5 w-5" />
                </button>
              )}
            </div>

            {gallery.length > 1 && (
              <div className="flex justify-center gap-2 p-4">
                {gallery.map((_, i) => (
                  <button
                    key={i}
                    type="button"
                    onClick={() => select(i)}
                    className={cn("h-2 w-2 rounded-full transition-colors", selected === i ? "bg-white" : "bg-white/30")}
                    aria-label={`Go to image ${i + 1}`}
                  />
                ))}
              </div>
            )}
          </DialogPrimitive.Content>
        </DialogPrimitive.Portal>
      </DialogPrimitive.Root>
    </div>
  );
}
