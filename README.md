# 0xmove

[![pnpm](https://img.shields.io/badge/pnpm-%3E%3D9-green)](https://pnpm.io/)
[![Turbo](https://img.shields.io/badge/Turbo-Monorepo-blue)](https://turbo.build/)

0xmove is an open-source experimental DeFi-fiat hybrid protocol designed to enable users to earn sustainable APR on fiat (NGN, KES) and stablecoins (USDC, USDT) through bidirectional liquidity pools. It acts as a seamless onramp and offramp bridge, allowing users to deposit local fiat for yield-bearing stablecoin exposure or vice versa, all powered by Paystack for real-world fiat integrations. Built for emerging markets, 0xmove emphasizes transparency, low-risk yields, and community governance—starting with a sandboxed MVP for testing.

The protocol features:
- **Fiat Pools**: Deposit NGN/KES to earn 5-10% APR via merchant lending or bonds, with direct Paystack payouts.
- **Stable Pools**: Mirror 3-7% APR from protocols like Aave/Compound, with 1:1 pegged swaps.
- **Bidirectional Flows**: Onramp (fiat → stables + yield) or offramp (stables → fiat + yield) in one click.
- **Sustainability**: Conservative yields backed by reserves, 0.5% ramp fees for ops, and open-source audits.

This repo uses [Turbo](https://turbo.build/) for monorepo management, [Nuxt](https://nuxt.com/) for the web app, Drizzle for the database, and Solidity for the staking contracts. It's experimental—use sandbox mode initially! Head to [0xmove.xyz](https://0xmove.xyz) for more (once live).

## Features
- **Yield-Bearing Ramps**: Earn APR on deposits before/after on/offramping.
- **Paystack Integration**: Sandboxed fiat in/out for NGN/KES (live mode toggleable).
- **Open-Source Contracts**: Staking protocol for pool liquidity, deployable on Polygon/Base.
- **Modern Stack**: TypeScript, ESLint, Tailwind UI components, and Drizzle ORM for scalable backend.
- **Metrics Dashboard**: Track TVL, ramp volume, and APR via public queries.
- **Community-First**: MIT-licensed, with bounties for contributions (e.g., new pools).

## Quick Start

### Prerequisites
- Node.js ≥18
- pnpm ≥9 (install via [pnpm.io](https://pnpm.io/installation))
- Foundry for contract testing (install via `curl -L https://foundry.paradigm.xyz | bash`)
- Paystack sandbox account (sign up at [paystack.com](https://paystack.com))

### Installation

1. Clone the repo:
   ```bash
   git clone https://github.com/yourusername/0xmove.git
   cd 0xmove
   ```

2. Install dependencies:
   ```bash
   pnpm install
   ```

3. Set up environment variables:
   - Copy `.env.example` to `.env` in root, `apps/api`, and `apps/web`
   - Add your Paystack keys (sandbox mode), RPC URLs, and DB creds
   
   ```bash
   # Example .env
   DATABASE_URL=postgresql://user:pass@localhost:5432/0xmove
   PAYSTACK_SECRET_KEY=sk_test_yourkey
   BETTER_AUTH_SECRET=your_secret_key
   BETTER_AUTH_URL=http://localhost:3010
   ```

4. Run migrations:
   ```bash
   pnpm turbo run db:migrate
   ```

## Development

Start all services:
```bash
pnpm turbo run dev
```

- **Web**: http://localhost:3000 (Nuxt dev server with hot reload)
- **API**: http://localhost:3010 (API endpoints)
- **Contracts**: Auto-compiles Solidity in `contracts/`

Build for production:
```bash
pnpm turbo run build
pnpm start
```

Lint and format:
```bash
pnpm turbo run lint
pnpm turbo run format
```

## Contracts Deployment

1. Install Foundry if not done
2. Compile and test:
   ```bash
   cd contracts/test-staking
   forge build
   forge test
   ```

## Project Structure

```
0xmove/
├── apps/
│   ├── api/                     # Backend API (Node.js/Express + Drizzle)
│   │   ├── src/
│   │   │   ├── db/              # Database schemas and queries
│   │   │   ├── lib/             # Auth and utilities
│   │   │   └── index.ts         # Server entry
│   │   ├── migrations/          # Database migrations
│   │   ├── drizzle.config.ts
│   │   └── package.json
│   └── web/                     # Frontend (Nuxt 3)
│       ├── app/
│       │   ├── components/      # Vue components
│       │   ├── composables/     # Vue composables
│       │   ├── layouts/         # Nuxt layouts
│       │   ├── pages/           # Nuxt pages
│       │   └── plugins/         # Nuxt plugins
│       ├── server/              # Server-side API routes
│       ├── public/              # Static assets
│       ├── nuxt.config.ts
│       └── package.json
├── contracts/
│   ├── marketplace-contract/    # NFT Marketplace contracts
│   │   ├── src/
│   │   │   └── NFTMarketPlace.sol
│   │   ├── test/
│   │   └── foundry.toml
│   └── test-staking/           # Staking protocol contracts
│       ├── src/
│       │   ├── Staking.sol     # Core staking contract
│       │   └── RewardsDistributionRecipient.sol
│       ├── test/
│       └── foundry.toml
├── packages/
│   ├── database/               # Shared database config (Prisma)
│   │   ├── prisma/
│   │   │   └── schema.prisma
│   │   └── src/
│   ├── eslint-config-custom/   # Shared ESLint configs
│   ├── tsconfig/              # Shared TypeScript configs
│   └── ui/                    # Shared UI components
│       └── src/
├── turbo.json                 # Turbo pipelines
├── pnpm-workspace.yaml        # Monorepo workspaces
├── package.json               # Root dependencies
└── README.md                  # This file!
```

## Contributing

We welcome contributions to make 0xmove more robust and accessible! Whether it's bug fixes, new features (e.g., KES pool enhancements), or docs—fork, branch, and PR.

### Guidelines

- **Branching**: Use `feat/<feature>`, `fix/<issue>`, or `docs/<update>`
- **Commits**: Follow Conventional Commits (e.g., `feat(api): add ramp endpoint`)
- **Testing**: Ensure tests pass (`pnpm turbo run test`) and lint (`pnpm turbo run lint`)
- **PRs**:
  - Reference issues (e.g., "Fixes #42")
  - Include changelog entry in `CHANGELOG.md`
  - For contracts: Add Slither scan results

**Bounties**: Check GitHub Issues for paid tasks (e.g., $100 for UI polish).

## Code of Conduct

This project follows the [Contributor Covenant](https://www.contributor-covenant.org/).