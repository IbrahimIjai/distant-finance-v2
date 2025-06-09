<template>
  <div>
    <UModal
      title="Select Token"

      :close="{
        color: 'primary',
        variant: 'outline',
        class: 'rounded-full',
      }"
    >
      <UButton color="neutral" variant="outline" class="rounded-full">
       <UAvatar src="/usdc.png" size="sm" />
        <span>USDC</span>
        <UIcon name="i-lucide-chevron-down" class="size-5" />
      </UButton>

      <template #body>
        <Placeholder class="h-48" />
      </template>
    </UModal>
  </div>
</template>
