import { describe, expect, it } from "vitest";
import { getApiErrorMessage } from "@/lib/api";
import { normalizeApiUrl } from "@/lib/api-url";

describe("api helpers", () => {
  it("returns the caller's fallback for non-axios errors", () => {
    // Only an axios response body carries a real backend message; a bare Error's
    // .message (e.g. "Request failed with status code 403") is not meant for users.
    expect(getApiErrorMessage(new Error("x"), "failed")).toBe("failed");
    expect(getApiErrorMessage({}, "failed")).toBe("failed");
  });

  it("upgrades HTTP API URLs to HTTPS for production deployments", () => {
    expect(normalizeApiUrl("http://api.example.com/api", true)).toBe("https://api.example.com/api");
  });

  it("preserves HTTP API URLs outside production", () => {
    expect(normalizeApiUrl("http://localhost:5080/api", false)).toBe("http://localhost:5080/api");
  });
});
