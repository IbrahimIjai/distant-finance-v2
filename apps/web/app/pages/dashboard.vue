<template>
	<div>
		<ConnectButton />
	</div>
</template>
<script setup lang="ts">
import { useAccount } from "@wagmi/vue";
const account = useAccount();

console.log({connected: account.isConnected})
</script>
