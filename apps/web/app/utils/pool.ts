import type { Address } from "viem";
import type { Token } from "@/utils/tokens";
import { findToken } from "./tokens";
import {  SUPPORTED_CHAINS } from "./reown-config";

export interface Pool {
  poolAddress: Address;
  chainId: SUPPORTED_CHAINS;
  token: Address;
  volume: number;
  fees: number;
  tvl: number;
  apr: number;
  type: "fiat" | "stablecoin";
}
  
// Mock pool data based on your tokens
export const pools = ref<Pool[]>([
  {
    poolAddress: "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913", // Base USDC pool
    chainId: SUPPORTED_CHAINS.BASE,
    token:    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913",
    volume: 2250000,
    fees: 6750,
    tvl: 8500000,
    apr: 12.5,
    type: "stablecoin",
  },
  {
    poolAddress: "0xYourLiskUSDTPool",  // placeholder – replace with actual pool address
    chainId: SUPPORTED_CHAINS.LISK,
    token:    "0x05d...c117b9",
    volume: 123456,
    fees:  123,
    tvl:   789012,
    apr:   8.5,
    type: "stablecoin",
  },
  {
    poolAddress: "0xYourLiskUSDCePool", // placeholder – actual pool address
    chainId: SUPPORTED_CHAINS.LISK,
    token:    "0xf242275d3a6527d877f2c927a82d9b057609cc71",
    volume: 654321,
    fees:  321,
    tvl:   210987,
    apr:   9.0,
    type: "stablecoin",
  },
  {
    poolAddress: "0x...xNgnPool",      // placeholder for xNgn pool
    chainId: SUPPORTED_CHAINS.BASE,
    token:    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913",     // TODO: fill in when xNgn is deployed
    volume: 123456,
    fees: 123,
    tvl: 789012,
    apr: 8.5,
    type: "fiat",
  },
  {
    poolAddress: "0x...xNgnPool",      // placeholder for xNgn pool
    chainId: SUPPORTED_CHAINS.LISK,
    token:    "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913",     // TODO: fill in when xNgn is deployed
    volume: 123456,
    fees: 123,
    tvl: 789012,
    apr: 8.5,
    type: "fiat",
  }
]);
