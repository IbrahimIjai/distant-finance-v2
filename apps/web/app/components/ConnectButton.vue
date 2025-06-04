<script setup lang="ts">
import { computed, toRef } from "vue";
import { useAppKit } from "@reown/appkit/vue";
import { useAppKitAccount } from "@reown/appkit/vue";

const accountData = useAppKitAccount();
const isConnected = computed(
  () => toRef(accountData.value, "isConnected").value || false
);

const address = computed(() => toRef(accountData.value, "address").value);
const openConnection = () => {
  useAppKit().open();
};

const shortenAddress = (address: string | undefined): string => {
  if (!address) return "";
  return `${address.slice(0, 6)}...${address.slice(-4)}`;
};
</script>

<template>
  <UButton
    class="connect-button"
    @click="openConnection"
    :variant="isConnected  ? 'outline' : 'solid'"
    :loading="isConnected && !address"
  >
    <template v-if="isConnected">
     {{   address ? shortenAddress(address) : "Loading..." }}
    </template>
    <template v-else> Connect </template>
  </UButton>
</template>
