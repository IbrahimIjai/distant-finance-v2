<template>
  <div class="w-full space-y-2">
    <UButton
      :loading="props.loading"
      :disabled="props.disabled || props.loading"
      block
      size="lg"
      color="primary"
      :icon="loading ? 'i-lucide-loader-2' : 'i-lucide-swap'"
      :loading-icon="'i-lucide-loader-2'"
      :loading-aria-label="'Swapping'"
      class="transition-colors"
      @click="props.onClick"
    >
      {{ loading ? 'Swapping...' : 'Swap' }}
    </UButton>
    
    <div v-if="props.error" class="text-xs text-red-500 dark:text-red-400 text-center">
      <UIcon name="i-lucide-alert-circle" class="mr-1" />
      {{ error }}
    </div>
    
    <div v-if="props.success" class="text-xs text-green-500 dark:text-green-400 text-center">
      <UIcon name="i-lucide-check-circle" class="mr-1" />
      {{ success }}
    </div>
  </div>
</template>

<script setup lang="ts">
const props = defineProps<{
  loading: boolean;
  error: string | null;
  success: string | null;
  disabled?: boolean;
  onClick: () => void;
}>();
</script>
