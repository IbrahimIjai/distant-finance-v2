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


  export const CHAIN_METADATA: Record<
    SUPPORTED_CHAINS,
    { name: string; logo: string }
  > = {
    [SUPPORTED_CHAINS.BASE]: { name: "Base", logo: "/chains/base.svg" },
    [SUPPORTED_CHAINS.LISK]: { name: "Lisk", logo: "/chains/lisk.svg" },
    [SUPPORTED_CHAINS.CELO]: { name: "Celo", logo: "/chains/celo.svg" },
    [SUPPORTED_CHAINS.SOLANA]: { name: "Solana", logo: "/chains/solana.svg" },
    [SUPPORTED_CHAINS.SOLANA_TESTNET]: {
      name: "Solana Testnet",
      logo: "/chains/solana.svg",
    },
  };
export function getChainName(chainId: SUPPORTED_CHAINS): string {
  return CHAIN_METADATA[chainId]?.name || `Chain ${chainId}`;
}

export function getChainLogo(chainId: SUPPORTED_CHAINS): string {
  return CHAIN_METADATA[chainId]?.logo;
}
