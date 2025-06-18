<template>
  <div class="min-h-screen">
    <div class="px-4 py-8">
      <!-- Header -->
      <div class="mb-8">
        <h1 class="text-3xl font-bold mb-2">Liquidity Pools</h1>
        <p class="text-muted-foreground text-sm">
          Stake in pools to earn yield from onramp and offramp transaction fees
        </p>
      </div>

   
      <PoolTable />

    
   
    </div>
  </div>
</template>

<script setup lang="ts">
const formatNumber = (num: number): string => {
  if (num >= 1000000) {
    return (num / 1000000).toFixed(2) + "M";
  }
  if (num >= 1000) {
    return (num / 1000).toFixed(2) + "K";
  }
  return num.toLocaleString();
};

const formatTokenAmount = (amount: number, symbol: string): string => {
  if (symbol === "NGN" || symbol === "KES") {
    return formatNumber(amount) + " " + symbol;
  }
  return formatNumber(amount) + " " + symbol;
};
</script>
