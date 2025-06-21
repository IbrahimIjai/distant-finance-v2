<template>
  <div class="pt-[5px] px-4 space-y-8">
    <!-- Heros -->
    <div class="py-3">
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

    <!--Features  -->
    <div class="mt-16 space-y-6">
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

      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-4 my-8">
        <UCard variant="subtle" class="border border-default">
          <template #header>
            <h1 class="text-lg font-semibold">Instant Currency Swaps</h1>
          </template>

          <p class="text-muted text-sm">
            Convert NGN, KES, and other African currencies to USDC, USDT, and
            DAI at live market rates. Real-time exchange rates with minimal
            fees. Support for all Paystack-supported currencies and major
            stablecoins.
          </p>
        </UCard>

        <UCard variant="subtle" class="border border-default">
          <template #header>
            <h1 class="text-lg font-semibold">Dual-Pool System</h1>
          </template>

          <p class="text-muted text-sm">
            Deposit to off-chain fiat pools or on-chain stablecoin pools to
            facilitate conversions for other users. NGN pool holders support
            off-ramping, USDC pool holders support on-ramping. Both receive
            transaction fees automatically.
          </p>

          <template #footer>
            <Placeholder class="h-8" />
          </template>
        </UCard>

        <UCard variant="subtle" class="border border-default">
          <template #header>
            <h1>Secure Transactions</h1>
          </template>

          <p class="text-muted text-sm">
            Off-chain fiat held in regulated escrow, on-chain assets secured by
            audited smart contracts. Bank-grade security for fiat deposits,
            blockchain security for crypto assets. Full transparency and audit
            trails.
          </p>

          <template #footer>
            <Placeholder class="h-8" />
          </template>
        </UCard>

        <UCard variant="subtle" class="border border-default">
          <template #header>
            <h1>NFT Marketplace/P2P Lending</h1>
          </template>

          <p class="text-muted text-sm">
            Complete NFT marketplace with integrated P2P lending, all connected
            to our fiat-crypto conversion system. Buy NFTs with NGN, borrow
            against your collection, or lend to others. Seamless integration
            with our currency pools for instant settlements in any supported
            currency.
          </p>
        </UCard>

        <UCard variant="subtle" class="border border-default">
          <template #header>
            <h1>Multi-Currency Wallets</h1>
          </template>

          <p class="text-muted text-sm">
            Hold NGN, KES, USDC, USDT, and other currencies in one unified
            account interface. Single dashboard for all your fiat and crypto
            balances. Easy transfers between currencies and instant conversion
            access.
          </p>
        </UCard>
      </div>
    </div>

    <!-- Stats -->
    <div class="mt-16">
      <div class="text-center mb-8">
        <h1 class="text-3xl font-bold mb-2">Borderless Financial Ecosystem</h1>
        <p class="text-muted max-w-2xl mx-auto">
          Witness the power of decentralized finance with real-time metrics
          showcasing our growing impact across Africa's financial landscape.
        </p>
      </div>
      <div class="grid grid-cols-2 gap-6 sm:grid-cols-2 lg:grid-cols-6">
        <UCard class="border border-default p-3">
          <div class="flex items-center">
            <div
              class="h-2 w-2 rounded-full bg-primary mr-2 animate-pulse"
            ></div>
            <span class="text-2xl font-bold">∞</span>
          </div>
          <p class="mt-2 text-sm text-muted">Total Value Locked</p>
        </UCard>

        <UCard class="border border-default p-3">
          <div class="flex items-center">
            <div
              class="h-2 w-2 rounded-full bg-primary mr-2 animate-pulse"
            ></div>
            <span class="text-2xl font-bold">∞</span>
          </div>
          <p class="mt-2 text-sm text-muted">Active Users</p>
        </UCard>

        <UCard class="border border-default p-3">
          <div class="flex items-cent er">
            <div
              class="h-2 w-2 rounded-full bg-primary mr-2 animate-pulse"
            ></div>
            <span class="text-2xl font-bold">∞</span>
          </div>
          <p class="mt-2 text-sm text-muted">Supported Currencies</p>
        </UCard>

        <UCard class="border border-default p-3">
          <div class="flex items-center">
            <div
              class="h-2 w-2 rounded-full bg-primary mr-2 animate-pulse"
            ></div>
            <span class="text-2xl font-bold">∞</span>
          </div>
          <p class="mt-2 text-sm text-muted">Transactions</p>
        </UCard>

        <UCard class="border border-default p-3">
          <div class="flex items-center">
            <div
              class="h-2 w-2 rounded-full bg-primary mr-2 animate-pulse"
            ></div>
            <span class="text-2xl font-bold">∞</span>
          </div>
          <p class="mt-2 text-sm text-muted">Volume Processed</p>
        </UCard>

        <UCard class="border border-default p-3">
          <div class="flex items-center">
            <div
              class="h-2 w-2 rounded-full bg-primary mr-2 animate-pulse"
            ></div>
            <span class="text-2xl font-bold">∞</span>
          </div>
          <p class="mt-2 text-sm text-muted">Avg. Settlement Time</p>
        </UCard>
      </div>
    </div>

    <!-- NFT ECOSYSTEM -->
    <div class="mt-24">
      <div class="text-center mb-12">
        <UBadge variant="subtle" class="mb-4">NFT Ecosystem</UBadge>
        <h1 class="text-3xl font-bold mb-3">NFT Marketplace & P2P Lending</h1>
        <p class="text-muted max-w-2xl mx-auto">
          Trade unique digital assets or leverage them as collateral in our
          integrated NFT ecosystem.
        </p>
      </div>

      <div class="grid grid-cols-1 md:grid-cols-2 gap-8 max-w-6xl mx-auto">
        <!-- NFT Marketplace Card -->
        <UCard class="h-full hover:shadow-lg transition-shadow duration-300">
          <template #header>
            <div class="flex items-center gap-3">
              <UIcon
                name="i-heroicons-shopping-bag"
                class="w-6 h-6 text-primary"
              />
              <h3 class="text-xl font-semibold">NFT Marketplace</h3>
            </div>
          </template>

          <div class="space-y-4">
            <div class="grid grid-cols-2 gap-3">
              <div
                v-for="(nft, index) in nftListings"
                :key="index"
                class="group cursor-pointer"
              >
                <div
                  class="aspect-square bg-gray-100 dark:bg-gray-800 rounded-lg overflow-hidden mb-1.5"
                >
                  <div
                    class="w-full h-full flex items-center justify-center text-muted"
                  >
                    <UIcon name="i-heroicons-photo" class="w-10 h-10" />
                  </div>
                </div>
                <p class="text-sm font-medium truncate">{{ nft.name }}</p>
                <p class="text-xs text-muted">{{ nft.price }} ETH</p>
              </div>
            </div>

            <div
              class="flex justify-between text-sm pt-2 border-t border-gray-100 dark:border-gray-800"
            >
              <span class="text-muted">Total Volume</span>
              <span class="font-medium">3.6 ETH</span>
            </div>

            <UButton block class="mt-4">
              Explore Marketplace
              <UIcon name="i-heroicons-arrow-right" class="w-4 h-4 ml-2" />
            </UButton>
          </div>
        </UCard>

        <!-- P2P Lending Card -->
        <UCard class="h-full hover:shadow-lg transition-shadow duration-300">
          <template #header>
            <div class="flex items-center gap-3">
              <UIcon
                name="i-heroicons-banknotes"
                class="w-6 h-6 text-primary"
              />
              <h3 class="text-xl font-semibold">P2P Lending</h3>
            </div>
          </template>

          <div class="flex flex-col h-full min-h-0">
            <div class="flex-1 overflow-auto space-y-4">
              <div
                v-for="(loan, index) in lendingListings"
                :key="index"
                class="p-3 border border-default rounded-lg"
              >
                <div class="flex items-center gap-3 mb-2">
                  <div
                    class="w-10 h-10 rounded-full bg-neutral flex items-center justify-center text-muted"
                  >
                    <UIcon name="i-heroicons-photo" class="w-5 h-5" />
                  </div>
                  <div class="flex-1">
                    <p class="text-sm font-medium">{{ loan.name }}</p>
                    <p class="text-xs text-muted">
                      Collateral: {{ loan.collateral }} ETH
                    </p>
                  </div>
                  <div class="text-right">
                    <p class="text-sm font-medium">{{ loan.apy }}% APY</p>
                    <p class="text-xs text-muted">{{ loan.duration }} days</p>
                  </div>
                </div>
              </div>

              <div
                class="flex justify-between text-sm pt-2 border-t border-default"
              >
                <span class="text-muted">Total Volume</span>
                <span class="font-medium">5.5 ETH</span>
              </div>
            </div>
            <div class="pt-4">
              <UButton block variant="outline">
                Explore Lending
                <UIcon name="i-heroicons-arrow-right" class="w-4 h-4 ml-2" />
              </UButton>
            </div>
          </div>
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
              Find answers to common questions about Distant Finance and how our
              platform works.
            </p>
          </div>
        </div>
        <div class="mx-auto mt-12 max-w-3xl">
          <UAccordion
            :items="faqItems"
            class="w-full"
            :ui="{
              item: 'border-b border-gray-200 dark:border-gray-800',
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
// Sample data
const nftListings = [
  { name: "CryptoPunk #1234", price: "1.2" },
  { name: "Bored Ape #5678", price: "0.8" },
  { name: "Doodles #9012", price: "0.5" },
  { name: "Azuki #3456", price: "1.1" },
];

const lendingListings = [
  { name: "CryptoPunk #1234", collateral: "2.5", apy: "15", duration: "30" },
  { name: "Bored Ape #5678", collateral: "1.8", apy: "22", duration: "60" },
  { name: "Azuki #3456", collateral: "1.2", apy: "18", duration: "45" },
];

const faqItems = [
  {
    label: "How does the fiat-to-stablecoin conversion work?",
    content:
      "Our platform facilitates conversions between fiat currencies and stablecoins using liquidity pools. When you initiate a conversion, the system sources the best rates from our pools, ensuring minimal slippage and competitive exchange rates. The process is automated and typically completes within minutes, depending on the blockchain network congestion.",
    defaultOpen: false,
  },
  {
    label: "What currencies are supported on Distant Finance?",
    content:
      "We support a wide range of fiat currencies, including Nigerian Naira (NGN), Kenyan Shilling (KES), and all Paystack-supported currencies. For stablecoins, we support USDC, USDT, DAI, BUSD, and several others. We're continuously expanding our supported currencies based on user demand and market conditions.",
    defaultOpen: false,
  },
  {
    label: "How do I earn from providing liquidity?",
    content:
      "When you provide liquidity to our pools, you earn a portion of the transaction fees generated from currency conversions. The fee distribution is proportional to your share of the pool. Additionally, we offer incentive programs for liquidity providers, which can boost your returns. You can track your earnings in real-time through your dashboard.",
    defaultOpen: false,
  },
  {
    label: "What are the fees for using Distant Finance?",
    content:
      "Our fee structure is designed to be transparent and competitive. For currency conversions, we charge a 0.3% fee, which is distributed to liquidity providers. NFT marketplace transactions have a 2.5% fee. P2P lending fees vary based on the loan terms but typically range from 0.5% to 1%. There are no hidden fees or charges on our platform.",
    defaultOpen: false,
  },
  {
    label: "How does P2P NFT lending work?",
    content:
      "Our P2P NFT lending feature allows you to use your NFTs as collateral for loans or earn interest by lending to others. As a borrower, you can set your desired loan terms or browse available offers. As a lender, you can create loan offers specifying the interest rate and duration. All transactions are secured by smart contracts, ensuring that NFTs are returned upon loan repayment or transferred to the lender in case of default.",
    defaultOpen: false,
  },
  {
    label: "Is Distant Finance secure?",
    content:
      "Security is our top priority. We employ industry-leading security measures, including multi-signature wallets, regular security audits, and insurance coverage for funds held on the platform. Our smart contracts have been audited by reputable security firms, and we maintain a bug bounty program to continuously improve our security posture. Additionally, we offer various account security features, including two-factor authentication and withdrawal address whitelisting.",
    defaultOpen: false,
  },
];
</script>

<script lang="ts"></script>
