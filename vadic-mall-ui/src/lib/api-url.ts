const DEFAULT_API_URL = "https://errajeshverma05-001-site1.etempurl.com/api";

export function getApiUrl() {
  const apiUrl = process.env.NEXT_PUBLIC_API_URL || DEFAULT_API_URL;
  return normalizeApiUrl(apiUrl);
}

export function normalizeApiUrl(apiUrl: string, forceHttps = process.env.NODE_ENV === "production") {
  return forceHttps ? apiUrl.replace(/^http:/i, "https:") : apiUrl;
}
