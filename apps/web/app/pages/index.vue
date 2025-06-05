<template>
  <div class="pt-[95px] px-4">
    <div>
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

    <div class="mt-4">
      <UCard variant="subtle" class="w-fit mx-auto">
        <template #header>
          <!-- <Placeholder class="h-8" /> -->
          <h2>Swap</h2>
        </template>

        <!-- <Placeholder class="h-32" /> -->
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
  </div>
</template>

<script lang="ts"></script>
