<template>
  <Html :lang="seo.lang">
    <UApp>
      <NuxtLoadingIndicator color="var(--ui-primary)" :height="2" />
      <NuxtLayout>
        <Toaster position="bottom-right" close-button />
        <div class="min-h-[calc(100dvh-150px)]"><NuxtPage /></div>
      </NuxtLayout>
    </UApp>
  </Html>
</template>

<script setup lang="ts">
import { Toaster } from "vue-sonner";

const { seo } = useAppConfig();

import { createAppKit } from "@reown/appkit/vue";
import { WagmiAdapter } from "@reown/appkit-adapter-wagmi";
import { SolanaAdapter } from "@reown/appkit-adapter-solana";
import { type AppKitNetwork } from "@reown/appkit/networks";
import { chains } from "@/utils/reown-config";

const projectId = "5cd2d3b8b3b2053438e35181fe3af516"; //distant-finance DO NOT USE, SIMPLY CREATE YOURS😆😆

const metadata = {
  name: "Distant Finance",
  description: "Distant Finance",
  url: "https://distantfinance.com",
  icons: ["https://avatars.githubusercontent.com/u/179229932"],
};

const networks: [AppKitNetwork, ...AppKitNetwork[]] = chains;

const wagmiAdapter = new WagmiAdapter({
  networks,
  projectId,
});

const solanaWeb3JsAdapter = new SolanaAdapter()

const modal = createAppKit({
  adapters: [wagmiAdapter, solanaWeb3JsAdapter],
  networks,
  projectId,
  metadata,
  features: {
    analytics: true,
  },
});
</script>
