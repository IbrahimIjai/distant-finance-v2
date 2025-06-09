<template>
  <div>
    <div
      class="max-w-md mx-auto mt-10 space-y-4 border border-default rounded-xl p-2.5"
    >
      <div>
        <h1 class="text-xl font-bold text-left">Swap</h1>
      </div>
      <SwapSelectPanel
        v-model="swapState.fromAmount"
        :field-type="'from'"
        :selected-token="swapState.fromToken"
        :disabled-tokens="getDisabledTokens('from')"
        :loading="swapState.loading"
        @update:selected-token="handleFromTokenChange"
        @input="handleFromAmountChange"
      />
      <!-- Swap Direction Toggle -->
      <div
        class="flex justify-center items-center border border-default w-fit mx-auto rounded-full p-1.5 cursor-pointer hover:bg-muted/70"
      >
        <UIcon
          name="i-lucide-chevron-down"
          class="size-7"
          color="primary"
          @click="swapTokens"
        />
      </div>
      <SwapSelectPanel
        v-model="swapState.toAmount"
        :field-type="'to'"
        :selected-token="swapState.toToken"
        :disabled-tokens="getDisabledTokens('to')"
        :loading="swapState.loading"
        :disabled="true"
        @update:selected-token="handleToTokenChange"
      />
    </div>
 
  </div>
</template>

<script setup lang="ts">
import { toast } from "vue-sonner";
import { useDebounceFn } from "@vueuse/core";
import { findToken, type Token } from "@/utils/tokens";

const swapState = reactive({
  fromAmount: "",
  toAmount: "",
  fromToken: undefined as Token | undefined,
  toToken: undefined as Token | undefined,
  loading: false,
  error: null as string | null,
});

// Get disabled tokens for each field
const getDisabledTokens = (fieldType: "from" | "to"): string[] => {
  const otherToken =
    fieldType === "from" ? swapState.toToken : swapState.fromToken;
  return otherToken ? [otherToken.tokenId] : [];
};

// Computed properties
const isValidSwap = computed(() => {
  return (
    parseFloat(swapState.fromAmount) > 0 &&
    parseFloat(swapState.toAmount) > 0 &&
    swapState.fromToken &&
    swapState.toToken &&
    !swapState.loading
  );
});

const exchangeRate = computed(() => {
  if (!swapState.fromAmount || !swapState.toAmount) return "0";
  const rate =
    parseFloat(swapState.toAmount) / parseFloat(swapState.fromAmount);
  return rate.toFixed(6);
});

// Debounced function to fetch exchange rate
const fetchExchangeRate = useDebounceFn(
  async (amount: string, fromToken: Token, toToken: Token) => {
    if (!amount || parseFloat(amount) <= 0) {
      swapState.toAmount = "";
      return;
    }

    swapState.loading = true;
    swapState.error = null;

    try {
      // Simulate API call - replace with actual exchange rate API
      await new Promise((resolve) => setTimeout(resolve, 1000));

      // Mock exchange rate calculation
      const mockRate =
        fromToken.type === "fiat" && toToken.type === "crypto"
          ? 0.0012
          : fromToken.type === "crypto" && toToken.type === "fiat"
            ? 800
            : 1; // crypto to crypto or fiat to fiat

      const outputAmount = parseFloat(amount) * mockRate;
      swapState.toAmount = outputAmount.toFixed(6);
    } catch (error) {
      swapState.error = "Failed to fetch exchange rate";
      toast.error("An error occurred while fetching exchange rate");
      swapState.toAmount = "";
    } finally {
      swapState.loading = false;
    }
  },
  2000
);

// Event handlers
const handleFromTokenChange = (token: Token | undefined) => {
  if (!token) return;
  if (token.tokenId === swapState.toToken?.tokenId) {
    toast.error("Invalid Selection", {
      description: "Cannot select same token for both fields",
    });
    return;
  }

  swapState.fromToken = token;

  // Recalculate if we have an amount
  if (swapState.fromAmount && swapState.toToken) {
    fetchExchangeRate(swapState.fromAmount, token, swapState.toToken);
  }
};

const handleToTokenChange = (token: Token | undefined) => {
  if (!token) return;
  if (token.tokenId === swapState.fromToken?.tokenId) {
    toast.error("Invalid Selection", {
      description: "Cannot select same token for both fields",
    });
    return;
  }

  swapState.toToken = token;

  // Recalculate if we have an amount
  if (swapState.fromAmount && swapState.fromToken) {
    fetchExchangeRate(swapState.fromAmount, swapState.fromToken, token);
  }
};

const handleFromAmountChange = (value: string) => {
  swapState.fromAmount = value;

  if (value && swapState.fromToken && swapState.toToken) {
    fetchExchangeRate(value, swapState.fromToken, swapState.toToken);
  } else {
    swapState.toAmount = "";
  }
};

const swapTokens = () => {
  const tempToken = swapState.fromToken;
  const tempAmount = swapState.fromAmount;

  swapState.fromToken = swapState.toToken;
  swapState.toToken = tempToken;

  swapState.fromAmount = swapState.toAmount;
  swapState.toAmount = tempAmount;

  // Recalculate with swapped values
  if (swapState.fromAmount && swapState.fromToken && swapState.toToken) {
    fetchExchangeRate(
      swapState.fromAmount,
      swapState.fromToken,
      swapState.toToken
    );
  }
};

const handleSwap = () => {
  if (!isValidSwap.value) return;

  console.log("Swapping", {
    from: {
      token: swapState.fromToken,
      amount: swapState.fromAmount,
    },
    to: {
      token: swapState.toToken,
      amount: swapState.toAmount,
    },
  });

  toast.success("Swap initiated", {
    description: `Swapping ${swapState.fromAmount} ${swapState.fromToken?.symbol} to ${swapState.toAmount} ${swapState.toToken?.symbol}`,
  });
};
</script>
