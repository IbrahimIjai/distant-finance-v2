import {
  lisk,
  base,
  celo,
  solana,
  solanaTestnet,
  type AppKitNetwork,
} from "@reown/appkit/networks";

export const chains: [AppKitNetwork, ...AppKitNetwork[]] = [
  lisk,
  base,
  celo,
  solana,
  solanaTestnet,
];

export const SUPPORTED_CHAINS = {
  BASE: base.id,
  LISK: lisk.id,
  CELO: celo.id,
  SOLANA: solana.id,
  SOLANA_TESTNET: solanaTestnet.id,
} as const;

export type SUPPORTED_CHAINS =
  (typeof SUPPORTED_CHAINS)[keyof typeof SUPPORTED_CHAINS];
