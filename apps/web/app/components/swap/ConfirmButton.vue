<!-- Create a swap button that takes in props of swap state and the handleswap function -->
<template>
	<button
		:disabled="loading || disabled"
		class="w-full py-2 px-4 rounded bg-primary text-white"
		@click="onClick">
		<span v-if="loading">Swapping...</span>
		<span v-else>Swap</span>
	</button>
	<div v-if="error" class="text-red-500 mt-2">{{ error }}</div>
	<div v-if="success" class="text-green-500 mt-2">{{ success }}</div>
</template>

<script setup lang="ts">
defineProps<{
	loading: boolean;
	error: string | null;
	success: string | null;
	disabled?: boolean;
	onClick: () => void;
}>();

const handleFromAmountChange = (value: string) => {
	swapState.fromAmount = value;
	swapState.success = null;
	swapState.error = null;
	// ...rest of your code
};
</script>
