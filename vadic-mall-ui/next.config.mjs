/** @type {import('next').NextConfig} */

const nextConfig = {
  // Generate a static website in the /out folder
  output: "export",

  // Helps static hosting handle routes consistently
  trailingSlash: true,

  // Required because Next.js Image Optimization
  // is not available with static export
  images: {
    unoptimized: true,
  },

  // Remove the X-Powered-By header
  poweredByHeader: false,
};

export default nextConfig;