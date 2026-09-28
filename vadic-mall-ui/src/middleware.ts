import { NextResponse } from "next/server";
import type { NextRequest } from "next/server";

const API_URL = process.env.NEXT_PUBLIC_API_URL || "https://deepak4info-001-site1.ftempurl.com/api";
const apiOrigin = new URL(API_URL).origin;
const isDev = process.env.NODE_ENV === "development";

export function middleware(request: NextRequest) {
  const nonce = Buffer.from(crypto.randomUUID()).toString("base64");

  const csp = `
    default-src 'self';
    script-src 'self' 'nonce-${nonce}' 'strict-dynamic'${isDev ? " 'unsafe-eval'" : ""};
    style-src 'self' 'unsafe-inline' https://www.gstatic.com;
    img-src 'self' data: blob: ${apiOrigin} https://www.gstatic.com https://www.google.com https://fonts.gstatic.com http://translate.google.com https://translate.google.com https://translate.googleapis.com;
    font-src 'self' https://fonts.gstatic.com;
    connect-src 'self' ${apiOrigin} https://translate.googleapis.com https://translate.google.com https://translate-pa.googleapis.com${isDev ? " ws:" : ""};
    frame-src 'self' https://translate.google.com;
    object-src 'none';
    base-uri 'self';
    form-action 'self';
    frame-ancestors 'none';
    ${isDev ? "" : "upgrade-insecure-requests;"}
  `.replace(/\s{2,}/g, " ").trim();

  const requestHeaders = new Headers(request.headers);
  requestHeaders.set("x-nonce", nonce);
  requestHeaders.set("Content-Security-Policy", csp);

  const response = NextResponse.next({ request: { headers: requestHeaders } });
  response.headers.set("Content-Security-Policy", csp);
  return response;
}

export const config = {
  matcher: [
    {
      source: "/((?!_next/static|_next/image|favicon.ico).*)",
      missing: [
        { type: "header", key: "next-router-prefetch" },
        { type: "header", key: "purpose", value: "prefetch" },
      ],
    },
  ],
};
