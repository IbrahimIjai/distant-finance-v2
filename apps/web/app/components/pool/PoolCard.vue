<template>
  <div class="bg-gray-800 rounded-lg p-6 hover:bg-gray-750 transition-colors">
    <div class="flex items-center justify-between mb-4">
      <div class="flex items-center space-x-3">
        <div class="flex -space-x-2">
          <img
            :src="pool.token.logoURI"
            :alt="pool.token.symbol"
            class="w-10 h-10 rounded-full border-2 border-gray-800"
          />
          <div
            class="w-10 h-10 bg-blue-600 rounded-full border-2 border-gray-800 flex items-center justify-center"
          >
            <span class="text-xs font-bold text-white">LP</span>
          </div>
        </div>
        <div>
          <h3 class="text-white font-semibold">{{ pool.token.symbol }} Pool</h3>
          <p class="text-sm text-gray-400">{{ pool.strategy }}</p>
        </div>
      </div>
      <div class="text-right">
        <div class="text-green-400 font-semibold">{{ pool.apr }}% APR</div>
        <div class="text-sm text-gray-400">Annual Percentage Rate</div>
      </div>
    </div>

    <div class="grid grid-cols-3 gap-4 mb-4">
      <div>
        <div class="text-sm text-gray-400">TVL</div>
        <div class="text-white font-medium">${{ formatNumber(pool.tvl) }}</div>
      </div>
      <div>
        <div class="text-sm text-gray-400">Volume</div>
        <div class="text-white font-medium">
          ${{ formatNumber(pool.volume) }}
        </div>
      </div>
      <div>
        <div class="text-sm text-gray-400">Fees</div>
        <div class="text-white font-medium">${{ formatNumber(pool.fees) }}</div>
      </div>
    </div>

    <NuxtLink
      :to="getPoolRoute(pool)"
      class="w-full bg-blue-600 hover:bg-blue-700 text-white font-medium py-2 px-4 rounded-lg transition-colors text-center block"
    >
      Stake in Pool
    </NuxtLink>
  </div>
</template>

<script setup lang="ts">
interface Pool {
  id: string;
  token: {
    symbol: string;
    logoURI: string;
  };
  strategy: string;
  volume: number;
  fees: number;
  tvl: number;
  tvlTokens: number;
  apr: number;
  type: "fiat" | "stablecoin";
}

defineProps<{
  pool: Pool;
}>();

const formatNumber = (num: number): string => {
  if (num >= 1000000) {
    return (num / 1000000).toFixed(2) + "M";
  }
  if (num >= 1000) {
    return (num / 1000).toFixed(2) + "K";
  }
  return num.toLocaleString();
};

const getPoolRoute = (pool: Pool): string => {
  if (pool.type === "fiat") {
    return `/pools/fiat/${pool.id}`;
  } else {
    return `/pools/stables/${pool.id}`;
  }
};
</script>
