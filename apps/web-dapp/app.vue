<template>
  <UApp>
    <NuxtPage />
  </UApp>
</template>

<script setup lang="ts">
import { createAppKit } from "@reown/appkit/vue";
import { wagmiAdapter, networks, projectId } from "./config/index";

import ActionButtonList from "./components/ActionButton.vue";
import InfoList from "./components/InfoList.vue";

// Initialize AppKit
const appkit = createAppKit({
  adapters: [wagmiAdapter],
  networks,
  projectId,
  themeMode: "light",
  features: {
    connectMethodsOrder: ["email", "social", "wallet"],
    analytics: true, // Optional - defaults to your Cloud configuration
  },
  metadata: {
    name: "AppKit Vue Example",
    description: "AppKit Vue Example",
    url: "https://reown.com/appkit",
    icons: ["https://avatars.githubusercontent.com/u/179229932?s=200&v=4"],
  },
  themeVariables: {
    "--w3m-accent": "#000000",
  },
});

export default {
  name: "App",
  components: {
    ActionButtonList,
    InfoList,
  },
};
</script>
