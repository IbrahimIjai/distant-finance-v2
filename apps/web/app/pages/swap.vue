<template>
  <div>
    <SwapNumericalInput />
    <SwapNumericalInput />
  </div>
</template>

<script setup lang="ts">
import { toast } from "vue-sonner";
import { findToken, type Token } from "@/utils/tokens";

const swapState = reactive({
  fromAmount: "",
  toAmount: "",
  fromToken: undefined as Token | undefined,
  toToken: undefined as Token | undefined,
  loading: false,
  error: null as string | null,
});


</script>
