import { SUPPORTED_CHAINS } from "./reown-config";

export interface Token {
  tokenId: string;
  name: string;
  symbol: string;
  decimals: number | "fiat";
  chainId: number | "fiat";
  address: string;
  logoURI: string;
  type: "crypto" | "fiat";
}

const TOKEN_ADDRESSES = {
  USDC: {
    [SUPPORTED_CHAINS.BASE]: "0x833589fCD6eDb6E08f4c7C32D4f71b54bdA02913",
    [SUPPORTED_CHAINS.LISK]: "0x05D032ac25d322df992303dCa074EE7392C117b9",
    [SUPPORTED_CHAINS.CELO]: "0xcebA9300f2b948710d2653dD7B07f33A8B32118C",
  },
  USDT: {
    [SUPPORTED_CHAINS.BASE]: "0xfde4C96c8593536E31F229EA8f37b2ADa2699bb2",
    [SUPPORTED_CHAINS.LISK]: "0x05D032ac25d322df992303dCa074EE7392C117b9", // Using USDC address as placeholder
    [SUPPORTED_CHAINS.CELO]: "0x48065fbBE25f71C9282ddf5e1cD6D6A887483D5e",
  },
} as const;

// Create tokens for all supported chains
const createCryptoTokens = (): Token[] => {
  const tokens: Token[] = [];

  // USDC tokens
  Object.entries(TOKEN_ADDRESSES.USDC).forEach(([chainId, address]) => {
    const chainIdNum = Number.parseInt(chainId);
    const chainName = Object.keys(SUPPORTED_CHAINS).find(
      (key) =>
        SUPPORTED_CHAINS[key as keyof typeof SUPPORTED_CHAINS] === chainIdNum
    );

    tokens.push({
      tokenId: `${address}:${chainId}`,
      name: "USD Coin",
      symbol: "USDC",
      decimals: 6,
      chainId: chainIdNum,
      address,
      logoURI: "https://cryptologos.cc/logos/usd-coin-usdc-logo.png",
      type: "crypto",
    });
  });

  // USDT tokens
  Object.entries(TOKEN_ADDRESSES.USDT).forEach(([chainId, address]) => {
    const chainIdNum = Number.parseInt(chainId);
    const chainName = Object.keys(SUPPORTED_CHAINS).find(
      (key) =>
        SUPPORTED_CHAINS[key as keyof typeof SUPPORTED_CHAINS] === chainIdNum
    );

    tokens.push({
      tokenId: `${address}:${chainId}`,
      name: "Tether USD",
      symbol: "USDT",
      decimals: 6,
      chainId: chainIdNum,
      address,
      logoURI: "https://cryptologos.cc/logos/tether-usdt-logo.png",
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
    chainId: "fiat",
    address: "fiat",
    logoURI: "https://flagcdn.com/w40/ng.png",
    type: "fiat",
  },
  {
    tokenId: "kes",
    name: "Kenyan Shilling",
    symbol: "KES",
    decimals: "fiat",
    chainId: "fiat",
    address: "fiat",
    logoURI: "https://flagcdn.com/w40/ke.png",
    type: "fiat",
  },
];

export const ALL_TOKENS: Token[] = [...createCryptoTokens(), ...FIAT_TOKENS];

// Utility functions
export const findToken = (
  address: string,
  chainId?: number
): Token | undefined => {
  if (chainId) {
    return ALL_TOKENS.find(
      (token) => token.address === address && token.chainId === chainId
    );
  }
  return ALL_TOKENS.find((token) => token.address === address);
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
