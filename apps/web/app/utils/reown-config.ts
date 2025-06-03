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