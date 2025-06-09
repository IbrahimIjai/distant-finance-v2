<template>
  <div>
    <UModal v-model:open="isOpen">
      <UButton
        color="neutral"
        variant="outline"
        class="rounded-full"
        @click="isOpen = true"
      >
        <UAvatar
          v-if="modelValue?.logoURI"
          :src="modelValue.logoURI"
          size="sm"
        />
        <span class="mx-1 whitespace-nowrap">{{
          modelValue?.symbol || "Select Token"
        }}</span>
        <UIcon name="i-lucide-chevron-down" class="size-5" />
      </UButton>

      <template #content>
        <div class="py-4 px-2">
          <div>
            <h3 class="text-lg font-medium">Select Currency/Token</h3>
          </div>
          <UInput
            v-model="searchQuery"
            placeholder="Search name or paste address"
            icon="i-heroicons-magnifying-glass"
            class="mb-4 w-full rounded-lg"
          />

          <div class="max-h-96 overflow-y-auto px-4">
            <div
              v-if="filteredTokens.length === 0"
              class="text-center py-8 text-gray-500"
            >
              No tokens found
            </div>

            <div v-else>
              <div
                v-for="token in filteredTokens"
                :key="token.tokenId"
                class="flex items-center p-2 hover:bg-gray-100 dark:hover:bg-gray-800 rounded-lg cursor-pointer"
                @click="selectToken(token)"
              >
                <UAvatar :src="token.logoURI" size="sm" />
                <div class="ml-3 flex-1">
                  <div class="font-medium">{{ token.symbol }}</div>
                  <div class="text-xs text-gray-500">{{ token.name }}</div>
                </div>
                <div
                  v-if="token.type === 'crypto'"
                  class="text-xs text-gray-400"
                >
                  Chain: {{ getChainName(token.chainId as number) }}
                </div>
              </div>
            </div>
          </div>
        </div>
      </template>
    </UModal>
  </div>
</template>

<script setup lang="ts">
import { ALL_TOKENS, type Token } from "@/utils/tokens";
import { SUPPORTED_CHAINS } from "@/utils/reown-config";
const props = defineProps<{
  modelValue?: Token;
  disabledTokens?: string[];
}>();

const emit = defineEmits<{
  "update:modelValue": [value: Token | undefined];
}>();

const isOpen = ref(false);

const searchQuery = ref("");
console.log({ searchQuery: searchQuery.value });

const filteredTokens = computed(() => {
  let tokens = ALL_TOKENS;

  // Filter out disabled tokens
  if (props.disabledTokens?.length) {
    tokens = tokens.filter((t) => !props.disabledTokens?.includes(t.tokenId));
  }

  // Filter by search query
  if (searchQuery.value) {
    const query = searchQuery.value.toLowerCase();
    tokens = tokens.filter(
      (t) =>
        t.name.toLowerCase().includes(query) ||
        t.symbol.toLowerCase().includes(query) ||
        (typeof t.address === "string" &&
          t.address.toLowerCase().includes(query))
    );
  }

  return tokens;
});

const getChainName = (chainId: number): string => {
  const chainEntry = Object.entries(SUPPORTED_CHAINS).find(
    ([_, id]) => id === chainId
  );
  return chainEntry ? chainEntry[0] : `Chain ${chainId}`;
};

function selectToken(token: Token) {
  emit("update:modelValue", token);
  isOpen.value = false;
  searchQuery.value = "";
}
</script>
