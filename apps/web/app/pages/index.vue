<template>
  <div class="pt-[125px] px-4 space-y-8">
    <!-- Heros -->
    <div class="py-6">
      <h1
        class="font-normal main-gradient text-3xl sm:text-4xl lg:text-5xl lg:w-2/5"
      >
        Swap, Deposit Bridge the Distances
      </h1>
      <p class="lg:w-3/5 mt-4 text-muted">
        Execute seamless fiat-to-crypto swaps, deposit tokens or fiat to support
        liquidity pools and earn in fees, and actively participate in
        cross-border financial infrastructure.
      </p>
    </div>

    <!-- Swap template -->
    <div class="mt-10">
      <UCard variant="subtle" class="w-fit mx-auto">
        <template #header>
          <h2>Swap</h2>
        </template>

        <div
          class="min-w-[16rem] lg:min-w-[28rem] space-y-2 flex flex-col items-center"
        >
          <div class="space-y-2 w-full">
            <h2 class="text-xs">From</h2>
            <div
              class="flex w-full bg-default items-center justify-between rounded-lg px-2 py-3"
            >
              <div class="flex items-center gap-2 flex-col">
                <UAvatar size="xs" src="/usdc.png" />
                <span class="text-xs font-mono">USDC</span>
              </div>
              <div class="flex items-center gap-1/2 flex-col">
                <p>0.00</p>
                <span class="text-muted text-xs">~$0.00</span>
              </div>
            </div>
          </div>
          <UButton
            icon="i-lucide-arrow-down"
            size="md"
            color="neutral"
            variant="solid"
            class="mx-auto my-4 rounded-full w-fit"
          />
          <div class="space-y-2 w-full">
            <h2 class="text-xs">To</h2>
            <div
              class="flex w-full bg-default items-center justify-between rounded-lg px-2 py-3"
            >
              <div class="flex items-center gap-2 flex-col">
                <UAvatar size="xs" src="/naira.png" />
                <span class="text-xs font-mono">NGN</span>
              </div>
              <div class="flex items-center gap-1/2 flex-col">
                <p>0.00</p>
                <span class="text-muted text-xs">~$0.00</span>
              </div>
            </div>
          </div>
        </div>
      </UCard>
    </div>

    <!--Features  -->
    <div class="mt-12">
      <div class="flex flex-col items-center mx-auto gap-2">
        <UBadge color="neutral" variant="subtle">Core Features</UBadge>
        <h1 class="text-2xl font-semibold">
          Fiat-to-Stablecoin Conversions Made Simple
        </h1>
        <p class="text-muted text-sm text-center lg:max-w-4/5">
          Distant Finance enables instant conversions between Nigerian Naira,
          Kenyan Shilling, and major stablecoins through our dual-pool system.
          Deposit your fiat or crypto to support conversions and receive
          rewards.
        </p>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4">
        <UCard variant="subtle">
          <template #header>
            <h1>Instant Currency Swaps</h1>
          </template>

          <Placeholder class="h-32" />

          <template #footer>
            <Placeholder class="h-8" />
          </template>
        </UCard>

        <UCard variant="subtle">
          <template #header>
            <h1>Dual-Pool System</h1>
          </template>

          <Placeholder class="h-32" />

          <template #footer>
            <Placeholder class="h-8" />
          </template>
        </UCard>

        <UCard variant="subtle">
          <template #header >
            <h1>Secure Transactions</h1>
          </template>

          <Placeholder class="h-32" />

          <template #footer>
            <Placeholder class="h-8" />
          </template>
        </UCard>

        <UCard variant="subtle">
          <template #header>
            <h1>NFT Marketplace/P2P Lending</h1>
          </template>

          <Placeholder class="h-32" />

          <template #footer>
            <Placeholder class="h-8" />
          </template>
        </UCard>
      </div>
    </div>
  </div>
</template>

<script lang="ts"></script>
