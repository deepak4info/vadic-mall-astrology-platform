import { describe, expect, it } from "vitest";
import { getApiErrorMessage } from "@/lib/api";

describe("api helpers", () => {
  it("returns the caller's fallback for non-axios errors", () => {
    // Only an axios response body carries a real backend message; a bare Error's
    // .message (e.g. "Request failed with status code 403") is not meant for users.
    expect(getApiErrorMessage(new Error("x"), "failed")).toBe("failed");
    expect(getApiErrorMessage({}, "failed")).toBe("failed");
  });
});
