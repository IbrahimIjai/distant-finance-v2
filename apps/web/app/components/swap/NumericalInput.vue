<template>
  <div
    class="flex justify-between items-center gap-2 border border-default rounded-lg w-full p-2"
  >
    <div>
      <p>{{ fieldType }}</p>
      <UInput
        color="neutral"
        variant="none"
        type="number"
        class="text-2xl font-medium text-right w-full pr-8"
        placeholder="0"
        :model-value="modelValue"
        @update:model-value="handleInput"
      />
      <p>0.00</p>
    </div>
    <SwapTokenSelector
      :model-value="selectedToken"
      :disabled-tokens="disabledTokens"
      @update:model-value="handleTokenChange"
    />
  </div>
</template>

<script setup lang="ts">
import type { Token } from "~/utils/tokens";

const props = defineProps<{
  modelValue: string;
  fieldType: "from" | "to";
  disabled?: boolean;
  loading?: boolean;
  disabledTokens?: string[];
  selectedToken?: Token;
}>();

const emit = defineEmits<{
  "update:modelValue": [value: string];
  "update:selectedToken": [token: Token | undefined];
  input: [value: string];
}>();


const fiatValue = ref("0.00");

const handleInput = (value: string) => {
  if (!props.disabled) {
    emit("update:modelValue", value);
    emit("input", value);
  }

  // Calculate fiat value (mock implementation)
  if (value && props.selectedToken && !props.loading) {
    const mockUsdRate = props.selectedToken.type === "fiat" ? 0.0012 : 1;
    fiatValue.value = (parseFloat(value) * mockUsdRate).toFixed(2);
  } else {
    fiatValue.value = "0.00";
  }
};

const handleTokenChange = (token: Token | undefined) => {
  emit("update:selectedToken", token);
};

// Watch for external changes
watch(
  () => props.modelValue,
  (newValue) => {
    if (newValue && props.selectedToken && !props.loading) {
      const mockUsdRate = props.selectedToken.type === "fiat" ? 0.0012 : 1;
      fiatValue.value = (parseFloat(newValue) * mockUsdRate).toFixed(2);
    } else {
      fiatValue.value = "0.00";
    }
  }
);

watch(
  () => props.loading,
  (isLoading) => {
    if (isLoading) {
      fiatValue.value = "0.00";
    }
  }
);
</script>
