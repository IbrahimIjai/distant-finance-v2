import {
	base,
	celo,
	type AppKitNetwork,
	baseSepolia,
} from "@reown/appkit/networks";

export const chains: [AppKitNetwork, ...AppKitNetwork[]] = [
	baseSepolia,
	base,
	celo,
];

export const SUPPORTED_CHAINS = {
	BASE: base.id,
	BASE_SEPOLIA: baseSepolia.id,
	CELO: celo.id,
} as const;

export type SUPPORTED_CHAINS =
	(typeof SUPPORTED_CHAINS)[keyof typeof SUPPORTED_CHAINS];

export const CHAIN_METADATA: Record<
	SUPPORTED_CHAINS,
	{ name: string; logo: string }
> = {
	[SUPPORTED_CHAINS.BASE]: { name: "Base", logo: "/chains/base.svg" },
	[SUPPORTED_CHAINS.BASE_SEPOLIA]: { name: "Base Sepolia", logo: "/chains/base-sepolia.svg" },
	[SUPPORTED_CHAINS.CELO]: { name: "Celo", logo: "/chains/celo.svg" },
};
export function getChainName(chainId: SUPPORTED_CHAINS): string {
	return CHAIN_METADATA[chainId]?.name || `Chain ${chainId}`;
}

export function getChainLogo(chainId: SUPPORTED_CHAINS): string {
	return CHAIN_METADATA[chainId]?.logo;
}
