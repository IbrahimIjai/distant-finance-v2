<template>
  <Html :lang="seo.lang">
    <UApp>
      <NuxtLoadingIndicator color="var(--ui-primary)" :height="2" />
      <NuxtLayout>
        <Toaster position="bottom-right" close-button />
        <SiteHeader />
        <div class="min-h-[calc(100dvh-150px)] pt-[120px]"><NuxtPage /></div>
          <Footer />
      </NuxtLayout>
    </UApp>
  </Html>
</template>

<script setup lang="ts">
import { Toaster } from "vue-sonner";
const colorMode = useColorMode();

const color = computed(() =>
  colorMode.value === "dark" ? "#020618" : "white"
);

const { seo } = useAppConfig();

useHead({
  meta: [
    { charset: "utf-8" },
    { name: "viewport", content: "width=device-width, initial-scale=1" },
    { key: "theme-color", name: "theme-color", content: color },
  ],
  link: [{ rel: "icon", href: "/favicon.png" }],
  htmlAttrs: {
    lang: "en",
  },
});

useSeoMeta({
  titleTemplate: "Distant Finance",
  ogImage:
    "https://assets.hub.nuxt.com/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJodHRwczovL3BvcnRmb2xpby10ZW1wbGF0ZS5udXh0LmRldiIsImlhdCI6MTc0NTkzNDczMX0.XDWnQoyVy3XVtKQD6PLQ8RFUwr4yr1QnVwPxRrjCrro.jpg?theme=light",
  twitterImage:
    "https://assets.hub.nuxt.com/eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJ1cmwiOiJodHRwczovL3BvcnRmb2xpby10ZW1wbGF0ZS5udXh0LmRldiIsImlhdCI6MTc0NTkzNDczMX0.XDWnQoyVy3XVtKQD6PLQ8RFUwr4yr1QnVwPxRrjCrro.jpg?theme=light",
  twitterCard: "summary_large_image",
});
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

const solanaWeb3JsAdapter = new SolanaAdapter();

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
