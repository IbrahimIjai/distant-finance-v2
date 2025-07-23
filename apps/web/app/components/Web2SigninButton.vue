<script setup lang="ts">
import { useSession, signIn } from "@/lib/auth";
const session = useSession();
const user = computed(() => session.value?.data?.user);

console.log({ user });
</script>

<template>
  <div>
    <p v-if="user">{{ user?.email }}</p>
    <UButton
      icon="i-lucide-google"
      color="primary"
      variant="solid"
      class="w-fit"
      @click="signIn.social({ provider: 'google' })"
    >
      Sign in with Google
    </UButton>
  </div>
</template>
