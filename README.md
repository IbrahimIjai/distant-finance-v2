# 0xmove

[![License: MIT](https://img.shields.io/badge/License-MIT-yellow.svg)](https://opensource.org/licenses/MIT)
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
- Foundry or Hardhat for contract testing (install via `curl -L https://foundry.paradigm.xyz | bash` for Foundry)
- Paystack sandbox account (sign up at [paystack.com](https://paystack.com))

### Installation
1. Clone the repo:
   ```bash
   git clone https://github.com/yourusername/0xmove.git
   cd 0xmove
   Install dependencies:
bashpnpm install

Set up environment variables:

Copy .env.example to .env in root, apps/api, and apps/web.
Add your Paystack keys (sandbox mode), RPC URLs, and DB creds (e.g., PostgreSQL for Drizzle).

bash# Example .env
DATABASE_URL=postgresql://user:pass@localhost:5432/0xmove
PAYSTACK_SECRET_KEY=sk_test_yourkey

Run migrations (for Drizzle DB):
bashpnpm turbo run db:migrate


Development

Start all services (API on http://localhost:3010, Web on http://localhost:3000, Contracts in watch mode):
bashpnpm turbo run dev

Web: http://localhost:3000 (Nuxt dev server with hot reload).
API: http://localhost:3010 (e.g., /api/pools for pool data).
Contracts: Auto-compiles Solidity in contracts/; test with pnpm turbo run test:contracts.


Build for production:
bashpnpm turbo run build
pnpm start  # Or turbo run start

Lint and format:
bashpnpm turbo run lint
pnpm turbo run format


Contracts Deployment

Install Foundry if not done.
Compile and test:
bashcd contracts
forge build
forge test

Project Structure

0xmove/
├── apps/
│   ├── api/                  # Backend API (Node.js/Express + Drizzle)
│   │   ├── src/
│   │   │   ├── routes/       # API endpoints (e.g., /pools, /ramps)
│   │   │   ├── db/           # Drizzle schemas and queries
│   │   │   └── index.ts      # Server entry
│   │   ├── package.json
│   │   └── turbo.json
│   └── web/                  # Frontend (Nuxt 3)
│       ├── pages/            # Nuxt pages (e.g., /pools, /dashboard)
│       ├── components/       # Reusable UI (e.g., PoolCard.vue)
│       ├── composables/      # Vue composables (e.g., useRamp)
│       ├── nuxt.config.ts
│       └── package.json
├── contracts/                # Solidity staking protocol
│   ├── src/
│   │   └── Staking.sol       # Core staking contract for pools
│   ├── script/
│   │   └── DeployStaking.s.sol  # Deployment script
│   ├── test/
│   │   └── Staking.t.sol     # Foundry tests
│   ├── foundry.toml
│   └── README.md             # Contract-specific docs
├── packages/
│   ├── database/             # Shared Drizzle config
│   │   ├── schema.ts
│   │   └── drizzle.config.ts
│   │   └── package.json
│   ├── ui/                   # Shared UI components (Tailwind/Vue)
│   │   ├── components/
│   │   └── package.json
│   └── configs/              # Shared tooling
│       ├── eslint/
│       │   └── eslintrc.js
│       ├── tsconfig/
│       │   └── tsconfig.json
│       └── package.json
├── .env.example              # Root env template
├── turbo.json                # Turbo pipelines (dev, build, lint)
├── pnpm-workspace.yaml       # Monorepo workspaces
├── package.json              # Root deps (Turbo, types)
└── README.md                 # This file!


Contributing
We welcome contributions to make 0xmove more robust and accessible! Whether it's bug fixes, new features (e.g., KES pool enhancements), or docs—fork, branch, and PR.
Guidelines

Branching: Use feat/<feature>, fix/<issue>, or docs/<update>.
Commits: Follow Conventional Commits (e.g., feat(api): add ramp endpoint).
Testing: Ensure tests pass (pnpm turbo run test) and lint (pnpm turbo run lint).
PRs:

Reference issues (e.g., "Fixes #42").
Include changelog entry in CHANGELOG.md.
For contracts: Add Slither scan results.


Bounties: Check GitHub Issues for paid tasks (e.g., $100 for UI polish).

Code of Conduct
This project follows the Contributor Covenant.