"use client";

import { useState } from "react";
import { useQueryClient } from "@tanstack/react-query";
import toast from "react-hot-toast";
import { ImagePlus } from "lucide-react";
import { Button } from "@/components/ui/button";
import { Card, CardContent } from "@/components/ui/card";
import { useCatalog } from "@/lib/hooks";
import { adminPutForm, getApiErrorMessage } from "@/lib/api";
import { getImageUrl } from "@/lib/utils";

const KUNDLI_BANNER_KEY = "kundli_banner_image";

export function SiteContentSettings() {
  const queryClient = useQueryClient();
  const { data: setting } = useCatalog<{ key: string; value: string }>("setting-kundli-banner", `/catalog/settings/${KUNDLI_BANNER_KEY}`);
  const [file, setFile] = useState<File | null>(null);
  const [preview, setPreview] = useState<string | null>(null);
  const [saving, setSaving] = useState(false);

  const currentUrl = preview ?? getImageUrl(setting?.value) ?? null;

  const handleFileChange = (selected: File | null) => {
    setFile(selected);
    if (selected) setPreview(URL.createObjectURL(selected));
  };

  const handleSave = async () => {
    if (!file) {
      toast.error("Please choose an image first");
      return;
    }
    setSaving(true);
    try {
      const formData = new FormData();
      formData.append("image", file);
      await adminPutForm(`/settings/${KUNDLI_BANNER_KEY}`, formData);
      toast.success("Kundli banner updated");
      await queryClient.invalidateQueries({ queryKey: ["catalog", "setting-kundli-banner"] });
      setFile(null);
    } catch (error) {
      toast.error(getApiErrorMessage(error, "Failed to update banner"));
    } finally {
      setSaving(false);
    }
  };

  return (
    <Card className="max-w-xl">
      <CardContent className="p-6">
        <h2 className="mb-1 font-heading text-lg font-semibold text-krishna">Kundli Page Banner</h2>
        <p className="mb-4 text-sm text-gray-500">
          Shown at the top of the &quot;Enter Birth Details&quot; card on the public Kundli page.
        </p>
        <label className="flex h-40 cursor-pointer flex-col items-center justify-center gap-2 overflow-hidden rounded-xl border-2 border-dashed border-gray-200 bg-gray-50 hover:border-saffron">
          {currentUrl ? (
            // eslint-disable-next-line @next/next/no-img-element
            <img src={currentUrl} alt="Kundli banner" className="h-full w-full object-cover" />
          ) : (
            <>
              <ImagePlus className="h-6 w-6 text-gray-400" />
              <span className="text-sm text-gray-400">Click to upload banner image</span>
            </>
          )}
          <input type="file" accept="image/*" className="hidden" onChange={(e) => handleFileChange(e.target.files?.[0] ?? null)} />
        </label>
        <Button className="mt-4" disabled={!file || saving} onClick={handleSave}>
          {saving ? "Saving..." : "Save Banner"}
        </Button>
      </CardContent>
    </Card>
  );
}
