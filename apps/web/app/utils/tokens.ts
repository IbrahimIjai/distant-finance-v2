import { SUPPORTED_CHAINS } from "./reown-config";

export interface Token {
	tokenId: string;
	name: string;
	symbol: string;
	decimals: number | "fiat";
	chainId: SUPPORTED_CHAINS;
	address: string;
	logoURI: string;
	type: "crypto" | "fiat";
}

const TOKEN_ADDRESSES = {
	xNGN: {
		[SUPPORTED_CHAINS.BASE]: "0x1111111111111111111111111111111111111111",
		[SUPPORTED_CHAINS.LISK]: "0x2222222222222222222222222222222222222222",
		[SUPPORTED_CHAINS.CELO]: "0x3333333333333333333333333333333333333333",
	},
	USDC: {
		[SUPPORTED_CHAINS.BASE]: "0x4444444444444444444444444444444444444444",
		[SUPPORTED_CHAINS.LISK]: "0x5555555555555555555555555555555555555555",
		[SUPPORTED_CHAINS.CELO]: "0x6666666666666666666666666666666666666666",
	},
	USDT: {
		[SUPPORTED_CHAINS.BASE]: "0x7777777777777777777777777777777777777777",
		[SUPPORTED_CHAINS.LISK]: "0x8888888888888888888888888888888888888888",
		[SUPPORTED_CHAINS.CELO]: "0x9999999999999999999999999999999999999999",
	},
} as const;

// Create tokens for all supported chains
const createCryptoTokens = (): Token[] => {
	const tokens: Token[] = [];
	// xNGN tokens
	Object.entries(TOKEN_ADDRESSES.xNGN).forEach(([chainId, address]) => {
		tokens.push({
			tokenId: `${address}:${chainId}`,
			name: "xNGN",
			symbol: "xNGN",
			decimals: 6,
			chainId: chainId as SUPPORTED_CHAINS,
			address,
			logoURI: "/tokens/nigerian.svg",
			type: "crypto",
		});
	});

	// USDC tokens
	Object.entries(TOKEN_ADDRESSES.USDC).forEach(([chainId, address]) => {
		tokens.push({
			tokenId: `${address}:${chainId}`,
			name: "USD Coin",
			symbol: "USDC",
			decimals: 6,
			chainId: chainId as SUPPORTED_CHAINS,
			address,
			logoURI: "/tokens/usdc.png",
			type: "crypto",
		});
	});

	// USDT tokens
	Object.entries(TOKEN_ADDRESSES.USDT).forEach(([chainId, address]) => {
		tokens.push({
			tokenId: `${address}:${chainId}`,
			name: "Tether USD",
			symbol: "USDT",
			decimals: 6,
			chainId: chainId as SUPPORTED_CHAINS,
			address,
			logoURI: "/tokens/usdt.jpg",
			type: "crypto",
		});
	});

	return tokens;
};

const FIAT_TOKENS: Token[] = [
	{
		tokenId: "ngn",
		name: "Nigerian Naira",
		symbol: "NGN",
		decimals: "fiat",
		chainId: SUPPORTED_CHAINS.BASE,
		address: "fiat",
		logoURI: "/tokens/nigerian.svg",
		type: "fiat",
	},
	{
		tokenId: "ngn",
		name: "Nigerian Naira",
		symbol: "NGN",
		decimals: "fiat",
		chainId: SUPPORTED_CHAINS.CELO,
		address: "fiat",
		logoURI: "/tokens/nigerian.svg",
		type: "fiat",
	},
	{
		tokenId: "kes",
		name: "Kenyan Shilling",
		symbol: "KES",
		decimals: "fiat",
		chainId: SUPPORTED_CHAINS.BASE,
		address: "fiat",
		logoURI: "/tokens/kenya.svg",
		type: "fiat",
	},
];

export const ALL_TOKENS: Token[] = [...createCryptoTokens(), ...FIAT_TOKENS];

// Utility functions
export const findToken = (
	address: string,
	chainId: number,
): Token | undefined => {
	console.log("Searching for address:", address, "chainId:", chainId);
	console.log("ALL_TOKENS:", ALL_TOKENS);
	const normAddress = address.toLowerCase();
	return ALL_TOKENS.find(
		(token) =>
			token.address.toLowerCase() === normAddress &&
			token.chainId.toString() === chainId.toString(),
	);
};

export const findTokenById = (tokenId: string): Token | undefined => {
	return ALL_TOKENS.find((token) => token.tokenId === tokenId);
};

export const getTokensBySymbol = (symbol: string): Token[] => {
	return ALL_TOKENS.filter((token) => token.symbol === symbol);
};

export const getFiatTokens = (): Token[] => {
	return ALL_TOKENS.filter((token) => token.type === "fiat");
};

export const getCryptoTokens = (): Token[] => {
	return ALL_TOKENS.filter((token) => token.type === "crypto");
};
