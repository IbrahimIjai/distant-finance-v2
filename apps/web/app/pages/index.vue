<template>
  <div class="pt-[5px] px-4 space-y-8">
    <!-- Hero -->
    <div class="py-3">
      <h1
        class="font-normal main-gradient text-3xl sm:text-4xl lg:text-5xl lg:w-2/5"
      >
        Earn Sustainable APR on Fiat & Stablecoins
      </h1>
      <p class="lg:w-3/5 mt-4 text-muted">
        0xmove is an experimental DeFi-fiat hybrid protocol enabling users to earn 5-10% APR on NGN/KES and 3-7% on stablecoins through bidirectional liquidity pools. Seamlessly onramp and offramp with Paystack integration.
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
                <UAvatar size="xs" src="/tokens/usdc.png" />
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
                <UAvatar size="xs" src="/tokens/nigerian.svg" />
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

    <!-- Features -->
    <div class="mt-16 space-y-6">
      <div class="flex flex-col items-center mx-auto gap-2">
        <UBadge color="primary" variant="subtle">Core Features</UBadge>
        <h1 class="text-2xl font-semibold">
          Yield-Bearing Ramps & Bidirectional Liquidity
        </h1>
        <p class="text-muted text-sm text-center lg:max-w-4/5">
          0xmove enables sustainable yields on both fiat and stablecoins through conservative lending strategies and protocol integrations. Earn APR before, during, and after onramping or offramping.
        </p>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-2 gap-4 my-8">
        <UCard variant="subtle" class="border border-default">
          <template #header>
            <h1 class="text-lg font-semibold">Fiat Pools</h1>
          </template>

          <p class="text-muted text-sm">
            Deposit NGN or KES to earn 5-10% APR through merchant lending and bond investments. Seamless fiat withdrawals with transparent, sustainable yields.
          </p>
        </UCard>

        <UCard variant="subtle" class="border border-default">
          <template #header>
            <h1 class="text-lg font-semibold">Stable Pools</h1>
          </template>

          <p class="text-muted text-sm">
            Mirror 3-7% APR from established protocols like Aave and Compound. Enjoy 1:1 pegged swaps between USDC, USDT, and other stablecoins with consistent yield generation.
          </p>
        </UCard>

        <UCard variant="subtle" class="border border-default">
          <template #header>
            <h1 class="text-lg font-semibold">Bidirectional Flows</h1>
          </template>

          <p class="text-muted text-sm">
            One-click onramp (fiat → stables + yield) or offramp (stables → fiat + yield). Seamless transitions between fiat and crypto while maintaining yield exposure throughout.
          </p>
        </UCard>

        <UCard variant="subtle" class="border border-default">
          <template #header>
            <h1 class="text-lg font-semibold">Conservative Yields</h1>
          </template>

          <p class="text-muted text-sm">
            Sustainable returns backed by reserves and transparent strategies. 0.5% ramp fees support operations while maintaining competitive yields for emerging market users.
          </p>
        </UCard>
      </div>
    </div>

    <!-- Stats -->
    <div class="mt-16">
      <div class="text-center mb-8">
        <div class="flex justify-center mb-4">
          <UBadge color="primary" variant="outline">Fully Open Source</UBadge>
        </div>
        <h1 class="text-3xl font-bold mb-2">Protocol Metrics</h1>
        <p class="text-muted max-w-2xl mx-auto">
          Track real-time performance of 0xmove's yield-bearing pools and ramp volume across emerging markets.
        </p>
      </div>
      <div class="grid grid-cols-2 gap-6 sm:grid-cols-2 lg:grid-cols-4">
        <UCard class="border border-default p-3">
          <div class="flex items-center">
            <div
              class="h-2 w-2 rounded-full bg-primary mr-2 animate-pulse"
            ></div>
            <span class="text-2xl font-bold">$0</span>
          </div>
          <p class="mt-2 text-sm text-muted">Total Value Locked</p>
        </UCard>

        <UCard class="border border-default p-3">
          <div class="flex items-center">
            <div
              class="h-2 w-2 rounded-full bg-primary mr-2 animate-pulse"
            ></div>
            <span class="text-2xl font-bold">7.5%</span>
          </div>
          <p class="mt-2 text-sm text-muted">Avg. Fiat APR</p>
        </UCard>

        <UCard class="border border-default p-3">
          <div class="flex items-center">
            <div
              class="h-2 w-2 rounded-full bg-primary mr-2 animate-pulse"
            ></div>
            <span class="text-2xl font-bold">5%</span>
          </div>
          <p class="mt-2 text-sm text-muted">Avg. Stable APR</p>
        </UCard>

        <UCard class="border border-default p-3">
          <div class="flex items-center">
            <div
              class="h-2 w-2 rounded-full bg-primary mr-2 animate-pulse"
            ></div>
            <span class="text-2xl font-bold">$0</span>
          </div>
          <p class="mt-2 text-sm text-muted">Ramp Volume</p>
        </UCard>
      </div>
    </div>

    <!-- How It Works -->
    <div class="mt-24">
      <div class="text-center mb-12">
        <UBadge color="primary" variant="subtle" class="mb-4">How It Works</UBadge>
        <h1 class="text-3xl font-bold mb-3">Simple Steps to Earn</h1>
        <p class="text-muted max-w-2xl mx-auto">
          Start earning sustainable yields on your fiat and stablecoins in three simple steps.
        </p>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-3 gap-8 max-w-6xl mx-auto">
        <UCard class="text-center">
          <template #header>
            <div class="flex justify-center mb-4">
              <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
                <span class="text-primary font-bold text-lg">1</span>
              </div>
            </div>
            <h3 class="text-xl font-semibold">Choose Your Pool</h3>
          </template>

          <p class="text-muted text-sm">
            Select between fiat pools (NGN/KES) for 5-10% APR or stable pools (USDC/USDT) for 3-7% APR based on your preference and risk tolerance.
          </p>
        </UCard>

        <UCard class="text-center">
          <template #header>
            <div class="flex justify-center mb-4">
              <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
                <span class="text-primary font-bold text-lg">2</span>
              </div>
            </div>
            <h3 class="text-xl font-semibold">Deposit & Earn</h3>
          </template>

          <p class="text-muted text-sm">
            Deposit your funds through Paystack (fiat) or wallet connection (crypto). Start earning immediately with transparent, sustainable yield strategies.
          </p>
        </UCard>

        <UCard class="text-center">
          <template #header>
            <div class="flex justify-center mb-4">
              <div class="w-12 h-12 rounded-full bg-primary/10 flex items-center justify-center">
                <span class="text-primary font-bold text-lg">3</span>
              </div>
            </div>
            <h3 class="text-xl font-semibold">Ramp & Withdraw</h3>
          </template>

          <p class="text-muted text-sm">
            Seamlessly onramp or offramp between fiat and crypto while maintaining yield exposure. Withdraw anytime with competitive rates.
          </p>
        </UCard>
      </div>
    </div>

    <!-- FAQ SECTION -->
    <section class="w-full py-12">
      <div class="container px-4 md:px-6">
        <div
          class="flex flex-col items-center justify-center space-y-4 text-center"
        >
          <div class="space-y-2">
            <UBadge variant="subtle" class="mb-4">FAQ</UBadge>
            <h2 class="text-3xl font-bold tracking-tighter md:text-4xl/tight">
              Frequently Asked Questions
            </h2>
            <p class="mx-auto max-w-[700px] text-muted">
              Find answers to common questions about 0xmove and how our
              yield-bearing ramp protocol works.
            </p>
          </div>
        </div>
        <div class="mx-auto mt-12 max-w-3xl">
          <UAccordion
            :items="faqItems"
            class="w-full"
            :ui="{
              item: 'border-b border-default',
              content: 'text-muted',
            }"
          />
        </div>
      </div>
    </section>
    <!-- <TextField
      v-model="numberValue"
      type="number"
      :max-decimals="2"
      icon="i-heroicons-calculator"
      @value-change="handleValueChange"
    /> -->
  </div>
</template>

<script setup lang="ts">
// // Demo component to showcase TextField usage
// const textValue = ref("");
// const numberValue = ref("");
// const percentValue = ref("");
// const outlineValue = ref("");
// const errorValue = ref("");
// const smallValue = ref("");
// const currencyValue = ref("");

// const handleValueChange = (value: string) => {
//   console.log("Value changed:", value);
// };


const faqItems = [
  {
    label: "What is 0xmove and how does it work?",
    content:
      "0xmove is an experimental DeFi-fiat hybrid protocol that enables users to earn sustainable APR on both fiat currencies (NGN, KES) and stablecoins (USDC, USDT). It features bidirectional liquidity pools where you can onramp (fiat → stables + yield) or offramp (stables → fiat + yield) while earning returns throughout the process.",
    defaultOpen: false,
  },
  {
    label: "What yields can I expect from 0xmove?",
    content:
      "Fiat pools offer 5-10% APR through merchant lending and bond investments, while stable pools mirror 3-7% APR from established protocols like Aave and Compound. All yields are conservative and backed by reserves to ensure sustainability for emerging market users.",
    defaultOpen: false,
  },
  {
    label: "How does the Paystack integration work?",
    content:
      "0xmove integrates with Paystack to enable seamless fiat deposits and withdrawals for NGN and KES. The platform supports sandbox mode for testing and can be toggled to live mode for real transactions. This ensures smooth onramping and offramping experiences.",
    defaultOpen: false,
  },
  {
    label: "What are the fees on 0xmove?",
    content:
      "0xmove charges a 0.5% ramp fee to support operations while maintaining competitive yields. This transparent fee structure helps sustain the protocol while keeping costs minimal for users in emerging markets.",
    defaultOpen: false,
  },
  {
    label: "Is 0xmove secure and audited?",
    content:
      "Yes, 0xmove is built with security as a priority. The protocol features open-source smart contracts that are audited, multi-signature wallets, and transparent operations. Being MIT-licensed, the code is publicly verifiable and community-governed.",
    defaultOpen: false,
  },
  {
    label: "Can I withdraw my funds anytime?",
    content:
      "Yes, 0xmove supports flexible withdrawals. You can withdraw your principal and earned yields at any time, with the bidirectional flow system ensuring you can seamlessly move between fiat and stablecoins as needed.",
    defaultOpen: false,
  },
];
</script>

<script lang="ts"></script>
