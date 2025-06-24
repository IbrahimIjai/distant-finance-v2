import type { Address } from "viem";
import { findToken, type Token } from "./tokens";
import { SUPPORTED_CHAINS } from "./reown-config";

export interface Pool {
	poolAddress: Address;
	chainId: SUPPORTED_CHAINS;
	token: Token;
	volume: number;
	fees: number;
	tvl: number;
	apr: number;
	type: "fiat" | "stablecoin";
}

// Mock pool data based on your tokens
export const pools = ref<Pool[]>([
	{
		poolAddress: "0xBaseXngnPoolAddress" as Address,
		chainId: SUPPORTED_CHAINS.BASE,
		token: findToken(
			"0x1111111111111111111111111111111111111111",
			SUPPORTED_CHAINS.BASE,
		)!,
		volume: 1000000,
		fees: 5000,
		tvl: 3000000,
		apr: 10.0,
		type: "fiat", // xNGN is minted when user deposits NGN
	},
	{
		poolAddress: "0xCeloXngnPoolAddress" as Address,
		chainId: SUPPORTED_CHAINS.CELO,
		token: findToken(
			"0x3333333333333333333333333333333333333333",
			SUPPORTED_CHAINS.CELO,
		)!,
		volume: 800000,
		fees: 4000,
		tvl: 2000000,
		apr: 9.5,
		type: "fiat", // xNGN is minted when user deposits NGN
	},
	{
		poolAddress: "0xBaseUsdcPoolAddress" as Address, // TODO: replace with actual deployed pool address
		chainId: SUPPORTED_CHAINS.BASE,
		token: findToken(
			"0x4444444444444444444444444444444444444444",
			SUPPORTED_CHAINS.BASE,
		)!,
		volume: 2250000,
		fees: 6750,
		tvl: 8500000,
		apr: 12.5,
		type: "stablecoin",
	},
	{
		poolAddress: "0xCeloUsdcPoolAddress" as Address, // TODO: replace with actual deployed pool address
		chainId: SUPPORTED_CHAINS.CELO,
		token: findToken(
			"0x6666666666666666666666666666666666666666",
			SUPPORTED_CHAINS.CELO,
		)!,
		volume: 1200000,
		fees: 3600,
		tvl: 4000000,
		apr: 11.0,
		type: "stablecoin",
	},
]);
