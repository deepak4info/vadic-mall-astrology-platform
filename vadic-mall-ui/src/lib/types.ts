export interface User {
  id: string;
  email: string;
  firstName: string;
  lastName: string;
  phone?: string;
  role: string;
  avatarUrl?: string;
  permissions?: string[];
}

export const STAFF_PERMISSIONS = [
  { key: "ManageProducts", label: "Product Manager", description: "Add, edit, delete products, prices, images, stock" },
  { key: "ManagePoojaServices", label: "Pooja Manager", description: "Manage pooja services, images and bookings info" },
  { key: "ManageBookings", label: "Booking Manager", description: "View and update pooja booking status" },
  { key: "ManageOrders", label: "Order Manager", description: "View and update customer orders" },
  { key: "ManageOffers", label: "Offers Manager", description: "Create and manage discount coupons / offers" },
] as const;

export interface AuthResponse {
  token: string;
  refreshToken: string;
  user: User;
  expiresAt: string;
}

export interface PoojaService {
  id: string;
  name: string;
  slug: string;
  category: string;
  description: string;
  price: number;
  salePrice?: number;
  durationMinutes: number;
  imageUrl?: string;
  isFeatured: boolean;
  rating: number;
  reviewCount: number;
  festivalTag?: string;
}

export interface Product {
  id: string;
  name: string;
  slug: string;
  description: string;
  categoryName: string;
  price: number;
  salePrice?: number;
  stockQuantity: number;
  rating: number;
  reviewCount: number;
  isFeatured: boolean;
  primaryImage?: string;
  festivalTag?: string;
}

export interface ProductDetail extends Product {
  images: string[];
  reviews: { id: string; userName: string; rating: number; comment: string; createdAt: string }[];
}

export interface Astrologer {
  id: string;
  name: string;
  specialization: string;
  bio: string;
  experienceYears: number;
  consultationFee: number;
  rating: number;
  reviewCount: number;
  isFeatured: boolean;
  avatarUrl?: string;
  languages?: string;
}

export interface SubscriptionPlan {
  id: string;
  name: string;
  slug: string;
  description: string;
  price: number;
  billingCycle: string;
  features: string[];
  isPopular: boolean;
}

export interface FestivalOffer {
  festival: string;
  description: string;
  discountPercent: number;
  imageUrl?: string;
  services: PoojaService[];
  products: Product[];
}

export interface BlogPost {
  id: string;
  title: string;
  slug: string;
  excerpt: string;
  imageUrl?: string;
  author: string;
  categoryName: string;
  createdAt: string;
  viewCount: number;
}

export interface BlogPostDetail extends BlogPost {
  content: string;
}

export interface Faq {
  id: string;
  question: string;
  answer: string;
  category: string;
}

export interface CartItem {
  id: string;
  productId: string;
  productName: string;
  price: number;
  salePrice?: number;
  imageUrl?: string;
  quantity: number;
  lineTotal: number;
}

export interface Cart {
  items: CartItem[];
  subTotal: number;
  itemCount: number;
}

export interface DashboardStats {
  totalUsers: number;
  totalAstrologers: number;
  totalOrders: number;
  totalBookings: number;
  totalRevenue: number;
  pendingOrders: number;
  pendingBookings: number;
  lowStockProducts: number;
}

export interface Testimonial {
  name: string;
  location: string;
  comment: string;
  rating: number;
  avatarUrl?: string;
}

export interface RevenueChartPoint {
  label: string;
  revenue: number;
}

export interface RecentOrder {
  id: string;
  orderNumber: string;
  customerName: string;
  total: number;
  status: string;
  createdAt: string;
}

export interface AdminUser {
  id: string;
  email: string;
  firstName: string;
  lastName: string;
  role: string;
  isActive: boolean;
  createdAt: string;
  isAstrologerApproved?: boolean | null;
  isStaffApproved: boolean;
  permissions: string[];
}

export interface AdminCoupon {
  id: string;
  code: string;
  description: string;
  type: string;
  value: number;
  minOrderValue?: number;
  maxDiscount?: number;
  usageLimit: number;
  usedCount: number;
  validFrom: string;
  validTo: string;
  festivalTag?: string;
  isActive: boolean;
}

export interface AdminProduct {
  id: string;
  name: string;
  category: string;
  price: number;
  salePrice?: number;
  stockQuantity: number;
  isFeatured: boolean;
  isActive: boolean;
  imageUrl?: string;
}

export interface AdminPooja {
  id: string;
  name: string;
  category: string;
  price: number;
  isFeatured: boolean;
  isActive: boolean;
  imageUrl?: string;
}

export type AdminOrder = RecentOrder;

export interface BulkDeleteResult {
  deletedCount: number;
  skippedProductNames: string[];
}

export interface AdminProductDetail {
  id: string;
  name: string;
  description: string;
  categoryId: string;
  price: number;
  salePrice?: number;
  stockQuantity: number;
  isFeatured: boolean;
  isActive: boolean;
  festivalTag?: string;
  images: string[];
}

export interface AdminPoojaDetail {
  id: string;
  name: string;
  category: string;
  description: string;
  price: number;
  salePrice?: number;
  durationMinutes: number;
  isFeatured: boolean;
  isActive: boolean;
  imageUrl?: string;
}

export interface AdminOrderItem {
  productId: string;
  productName: string;
  quantity: number;
  unitPrice: number;
  totalPrice: number;
  imageUrl?: string;
}

export interface AdminBooking {
  id: string;
  serviceName: string;
  customerName: string;
  scheduledDate: string;
  scheduledTime?: string;
  status: string;
  amount: number;
  imageUrl?: string;
}

export interface AdminOrderDetail {
  id: string;
  orderNumber: string;
  customerName: string;
  customerEmail: string;
  subTotal: number;
  discount: number;
  shippingFee: number;
  total: number;
  status: string;
  createdAt: string;
  items: AdminOrderItem[];
  tracking: OrderTracking[];
}

export const ORDER_STATUSES = ["Pending", "Confirmed", "Processing", "Shipped", "OutForDelivery", "Delivered", "Cancelled", "Returned"] as const;

export interface SearchResults {
  poojas: PoojaService[];
  products: Product[];
  astrologers: Astrologer[];
}

export interface Address {
  id: string;
  fullName: string;
  phone: string;
  addressLine1: string;
  addressLine2?: string;
  city: string;
  state: string;
  pincode: string;
  country: string;
  isDefault: boolean;
}

export interface OrderTracking {
  status: string;
  notes?: string;
  location?: string;
  createdAt: string;
}

export interface UserSubscription {
  id: string;
  planName: string;
  price: number;
  startDate: string;
  endDate: string;
  status: string;
}

export interface AstrologerProfileInfo {
  userId: string;
  name: string;
  email: string;
  phone?: string;
  specialization: string;
  bio: string;
  experienceYears: number;
  consultationFee: number;
  rating: number;
  reviewCount: number;
  isApproved: boolean;
  isFeatured: boolean;
  languages?: string;
}

export interface AstrologerBooking {
  id: string;
  serviceName: string;
  customerName: string;
  scheduledDate: string;
  scheduledTime?: string;
  status: string;
  amount: number;
  specialInstructions?: string;
  notes?: string;
}

export interface WishlistItem {
  productId: string;
  productName: string;
  price: number;
  salePrice?: number;
  imageUrl?: string;
  rating: number;
  stockQuantity: number;
}

export interface AppNotification {
  id: string;
  title: string;
  message: string;
  type: string;
  isRead: boolean;
  link?: string;
  createdAt: string;
}

export interface GiftCardType {
  type: string;
  denominations: number[];
}

export interface GiftCardPurchaseResult {
  id: string;
  code: string;
  amount: number;
  balance: number;
  status: string;
}

export interface AdminCategory {
  id: string;
  name: string;
  slug: string;
}
