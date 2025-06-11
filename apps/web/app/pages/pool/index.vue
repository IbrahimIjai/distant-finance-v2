<template>
  <div class="min-h-screen ">
    <div class="">
      <!-- Header -->
      <div class="mb-8">
        <h1 class="text-3xl font-bold mb-2">Liquidity Pools</h1>
        <p class="text-muted-foreground text-sm">Stake in pools to earn yield from onramp and offramp transaction fees</p>
      </div>

      <!-- Pool Type Tabs -->
      <div class="mb-6">
        <div class="flex space-x-1 bg-gray-800 p-1 rounded-lg w-fit">
          <button
            @click="activeTab = 'all'"
            :class="[
              'px-4 py-2 rounded-md text-sm font-medium transition-colors',
              activeTab === 'all' 
                ? 'bg-blue-600 text-white' 
                : 'text-gray-400 hover:text-white'
            ]"
          >
            All Pools
          </button>
          <button
            @click="activeTab = 'stablecoins'"
            :class="[
              'px-4 py-2 rounded-md text-sm font-medium transition-colors',
              activeTab === 'stablecoins' 
                ? 'bg-blue-600 text-white' 
                : 'text-gray-400 hover:text-white'
            ]"
          >
            Stablecoins
          </button>
          <button
            @click="activeTab = 'fiat'"
            :class="[
              'px-4 py-2 rounded-md text-sm font-medium transition-colors',
              activeTab === 'fiat' 
                ? 'bg-blue-600 text-white' 
                : 'text-gray-400 hover:text-white'
            ]"
          >
            Fiat
          </button>
        </div>
      </div>

      <!-- Pools Table -->
      <div class="bg-gray-800 rounded-lg overflow-hidden">
        <!-- Table Header -->
        <div class="grid grid-cols-12 gap-4 p-4 border-b border-gray-700 text-sm font-medium text-gray-400 uppercase tracking-wider">
          <div class="col-span-3">Liquidity Pool</div>
          <div class="col-span-2 text-right">Volume</div>
          <div class="col-span-2 text-right">Fees</div>
          <div class="col-span-2 text-right">TVL</div>
          <div class="col-span-2 text-right">APR</div>
          <div class="col-span-1"></div>gii
        </div>

        <!-- Pool Rows -->
        <div v-for="pool in filteredPools" :key="pool.id" class="grid grid-cols-12 gap-4 p-4 border-b border-gray-700 hover:bg-gray-750 transition-colors">
          <!-- Pool Info -->
          <div class="col-span-3 flex items-center space-x-3">
            <div class="flex -space-x-2">
              <img :src="pool.token.logoURI" :alt="pool.token.symbol" class="w-8 h-8 rounded-full border-2 border-gray-800" />
              <div class="w-8 h-8 bg-blue-600 rounded-full border-2 border-gray-800 flex items-center justify-center">
                <span class="text-xs font-bold text-white">LP</span>
              </div>
            </div>
            <div>
              <div class="text-white font-medium">{{ pool.token.symbol }} Pool</div>
              <div class="text-sm text-gray-400">{{ pool.strategy }}</div>
            </div>
          </div>

          <!-- Volume -->
          <div class="col-span-2 text-right">
            <div class="text-white font-medium">${{ formatNumber(pool.volume) }}</div>
            <div class="text-sm text-gray-400">24h</div>
          </div>

          <!-- Fees -->
          <div class="col-span-2 text-right">
            <div class="text-white font-medium">${{ formatNumber(pool.fees) }}</div>
            <div class="text-sm text-gray-400">24h</div>
          </div>

          <!-- TVL -->
          <div class="col-span-2 text-right">
            <div class="text-white font-medium">${{ formatNumber(pool.tvl) }}</div>
            <div class="text-sm text-gray-400">{{ formatTokenAmount(pool.tvlTokens, pool.token.symbol) }}</div>
          </div>

          <!-- APR -->
          <div class="col-span-2 text-right">
            <div class="text-green-400 font-medium">{{ pool.apr }}%</div>
          </div>

          <!-- Action -->
          <div class="col-span-1 text-right">
            <NuxtLink 
              :to="getPoolRoute(pool)"
              class="inline-flex items-center px-3 py-1 bg-blue-600 hover:bg-blue-700 text-white text-sm font-medium rounded-md transition-colors"
            >
              Stake
            </NuxtLink>
          </div>
        </div>
      </div>

      <!-- Empty State -->
      <div v-if="filteredPools.length === 0" class="text-center py-12">
        <div class="text-gray-400 text-lg">No pools found for the selected category</div>
      </div>
    </div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue';
import { NuxtLink } from '#components';

interface Pool {
  id: string
  token: {
    symbol: string
    logoURI: string
  }
  strategy: string
  volume: number
  fees: number
  tvl: number
  tvlTokens: number
  apr: number
  type: 'fiat' | 'stablecoin'
}

type TabType = 'all' | 'stablecoins' | 'fiat'

const activeTab = ref<TabType>('all')

// Mock pool data based on your tokens
const pools = ref<Pool[]>([
  {
    id: 'usdc-base',
    token: {
      symbol: 'USDC',
      logoURI: 'https://cryptologos.cc/logos/usd-coin-usdc-logo.png'
    },
    strategy: 'Base Network',
    volume: 2250000,
    fees: 6750,
    tvl: 8500000,
    tvlTokens: 8500000,
    apr: 12.5,
    type: 'stablecoin'
  },
  {
    id: 'usdt-base',
    token: {
      symbol: 'USDT',
      logoURI: 'https://cryptologos.cc/logos/tether-usdt-logo.png'
    },
    strategy: 'Base Network',
    volume: 1800000,
    fees: 5400,
    tvl: 6200000,
    tvlTokens: 6200000,
    apr: 15.2,
    type: 'stablecoin'
  },
  {
    id: 'usdc-lisk',
    token: {
      symbol: 'USDC',
      logoURI: 'https://cryptologos.cc/logos/usd-coin-usdc-logo.png'
    },
    strategy: 'Lisk Network',
    volume: 450000,
    fees: 1350,
    tvl: 1200000,
    tvlTokens: 1200000,
    apr: 18.7,
    type: 'stablecoin'
  },
  {
    id: 'ngn-fiat',
    token: {
      symbol: 'NGN',
      logoURI: 'https://flagcdn.com/w40/ng.png'
    },
    strategy: 'Nigerian Naira',
    volume: 850000,
    fees: 2550,
    tvl: 3400000,
    tvlTokens: 850000000, // NGN amount
    apr: 22.1,
    type: 'fiat'
  },
  {
    id: 'kes-fiat',
    token: {
      symbol: 'KES',
      logoURI: 'https://flagcdn.com/w40/ke.png'
    },
    strategy: 'Kenyan Shilling',
    volume: 320000,
    fees: 960,
    tvl: 1100000,
    tvlTokens: 143000000, // KES amount
    apr: 19.8,
    type: 'fiat'
  }
])

const filteredPools = computed(() => {
  if (activeTab.value === 'all') return pools.value
  return pools.value.filter(pool => pool.type === activeTab.value)
})

const formatNumber = (num: number): string => {
  if (num >= 1000000) {
    return (num / 1000000).toFixed(2) + 'M'
  }
  if (num >= 1000) {
    return (num / 1000).toFixed(2) + 'K'
  }
  return num.toLocaleString()
}

const formatTokenAmount = (amount: number, symbol: string): string => {
  if (symbol === 'NGN' || symbol === 'KES') {
    return formatNumber(amount) + ' ' + symbol
  }
  return formatNumber(amount) + ' ' + symbol
}

const getPoolRoute = (pool: Pool): string => {
  if (pool.type === 'fiat') {
    return `/pools/fiat/${pool.id}`
  } else {
    return `/pools/stables/${pool.id}`
  }
}
</script>
