# Vadic Mall — Vedic Astrology Platform

**Vadic Mall** is a full-stack Vedic astrology and spiritual services platform built with **.NET Core 8** (Clean Architecture) and **Next.js 14** (App Router). Book poojas, shop spiritual products, request kundli analysis, and consult expert astrologers — all in one place with a Krishna + Saffron theme.

## Architecture

```
VadicMall/                  # .NET 8 Backend (Clean Architecture)
├── src/VadicMall.Domain/       # Entities, Enums
├── src/VadicMall.Application/  # DTOs, Interfaces
├── src/VadicMall.Infrastructure/ # EF Core, Services, JWT
└── src/VadicMall.Api/          # REST API Controllers

vadic-mall-ui/              # Next.js 14 Frontend
└── src/app/                    # App Router pages
```

## Features

- **Authentication** — JWT-based auth with role-based access (SuperAdmin, Astrologer, Customer)
- **Pooja Services** — Browse, book, and track Vedic pooja rituals
- **Product Catalog** — Gemstones, malas, pooja samagri, idols, yantras, and more
- **Kundli Analysis** — Birth chart requests with status tracking
- **Astrologer Consultation** — Verified astrologer profiles and booking
- **Shopping Cart & Orders** — Add to cart, checkout, order tracking
- **Coupons & Festival Offers** — Discount codes and festival-specific sales
- **Subscription Plans** — Basic, Premium, Elite, Family, Business tiers
- **Gift Cards** — Digital gifting for services and products
- **Admin Dashboard** — Analytics, user/order/booking management
- **Blog & FAQ** — Content and support pages

## Quick Start

### Prerequisites

- [.NET 8 SDK](https://dotnet.microsoft.com/download/dotnet/8.0)
- [Node.js 18+](https://nodejs.org/)

### Backend

```bash
cd VadicMall
chmod +x setup.sh
./setup.sh
```

API runs at **http://localhost:5080** — Swagger UI at **http://localhost:5080/swagger**

### Frontend

```bash
cd vadic-mall-ui
chmod +x run.sh
./run.sh
```

UI runs at **http://localhost:4318**

### Docker

```bash
docker-compose up -d
```

## Demo Accounts

| Role     | Email                    | Password      |
|----------|--------------------------|---------------|
| Admin    | admin@vadicmall.com      | Admin@123     |
| Customer | customer@vadicmall.com   | Customer@123  |
| Astrologer | pandit.sharma@vadicmall.com | Astro@123 |

## API Endpoints

| Group    | Base Path        | Description                    |
|----------|------------------|--------------------------------|
| Auth     | `/api/auth`      | Register, login, refresh token |
| Catalog  | `/api/catalog`   | Public product/service data    |
| Customer | `/api/customer`  | Cart, orders, bookings (auth)  |
| Admin    | `/api/admin`     | Dashboard, management (auth)   |
| Health   | `/api/health`    | Health check                   |

## Environment Variables

### Backend (`VadicMall/src/VadicMall.Api/appsettings.json`)

| Key | Default | Description |
|-----|---------|-------------|
| `ConnectionStrings:DefaultConnection` | `Server=localhost,1433;...` | SQL Server connection string |
| `Jwt:Secret` | (see appsettings) | JWT signing key (32+ chars) |
| `Cors:Origins` | `localhost:4318` | Allowed frontend origins |

### Frontend (`vadic-mall-ui/.env.local`)

| Key | Default | Description |
|-----|---------|-------------|
| `NEXT_PUBLIC_API_URL` | `http://localhost:5080/api` | Backend API base URL |

## Database

Uses **SQL Server** for both local development and production; the API creates the schema on startup (`EnsureCreatedAsync`) but does not seed demo data. Point `DefaultConnection` at your own instance, e.g.:

```json
"ConnectionStrings": {
  "DefaultConnection": "Server=localhost,1433;Database=VadicMall;User Id=sa;Password=***;TrustServerCertificate=True;"
}
```

## Troubleshooting

### UI shows "Ready" but pages are blank or won't open

1. **Open the correct URL in your browser** — use **http://localhost:4318** (not `http://0.0.0.0:4318`; that address does not work in browsers).
2. **Start the API first** — in a separate terminal run `cd VadicMall && ./setup.sh`. Without the API, the homepage still loads but product/pooja sections stay empty.
3. **Clear stale Next.js cache** — after a git pull or failed build, run:
   ```bash
   cd vadic-mall-ui
   npm run dev:clean
   ```
4. **Copy env file** (optional): `cp .env.example .env.local`

### `compdef: command not found` (Mac zsh)

Harmless oh-my-zsh warning — ignore it. The dev server still starts correctly.

### `setup.sh: bad interpreter` or `^M` errors (Mac)

Windows line endings — run: `sed -i '' 's/\r$//' VadicMall/setup.sh vadic-mall-ui/run.sh`

### Port already in use

```bash
# Mac
lsof -ti:4318 | xargs kill -9
# Then restart
cd vadic-mall-ui && npm run dev
```

## Tech Stack

**Backend:** .NET 8, EF Core, JWT, BCrypt, Serilog, Swagger  
**Frontend:** Next.js 14, TypeScript, Tailwind CSS, TanStack Query, Zustand, Radix UI  
**Database:** SQL Server

---

🕉️ **Jai Shree Krishna!** — Vadic Mall: Where Vedic Tradition Meets Modern Technology
