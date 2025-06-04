export const shortenAddress = (address: string | undefined): string => {
  if (!address) return ''
  
  // For EVM addresses (0x prefix)
  if (address.startsWith('0x') && address.length === 42) {
    return `${address.slice(0, 6)}...${address.slice(-4)}`
  }
  
  // For Solana addresses (51 characters)
  if (address.length === 44) {
    return `${address.slice(0, 5)}...${address.slice(-4)}`
  }
  
  return address
}
