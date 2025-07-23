<template>
  <header>
    <div
      class="container max-w-6xl mx-auto bg-default py-3 px-4 fixed top-0 inset-x-0 border-b border-default"
    >
      <div class="flex justify-between items-center">
        <!-- Logo -->
        <div>
          <svg
            width="26"
            height="26"
            viewBox="0 0 26 26"
            fill="none"
            xmlns="http://www.w3.org/2000/svg"
          >
            <path
              fill-rule="evenodd"
              clip-rule="evenodd"
              d="M11 2C9.9 3.1 9 4.435 9 4.966C9 5.497 6.975 10.061 4.5 15.109C2.025 20.156 0 24.447 0 24.643C0 25.512 15.946 24.896 16.497 24.005C16.835 23.458 18.099 22.528 19.306 21.938C21.196 21.014 21.154 21.149 19 22.911L16.5 24.956L21.25 24.978C23.862 24.99 26 24.7 26 24.334C26 22.799 14.606 0 13.838 0C13.377 0 12.1 0.9 11 2ZM13.19 15.407C10.565 21.016 9.722 22 7.539 22C4.642 22 4.367 23.127 10.657 9.223L13.496 2.946L14.886 5.881C16.168 8.588 16.036 9.325 13.19 15.407ZM19 17.385C19 17.597 17.875 18.507 16.5 19.408C13.661 21.268 13.248 20.895 15.571 18.571C17.006 17.137 19 16.447 19 17.385Z"
              fill="#2DB9D3"
            />
          </svg>
        </div>
        <UNavigationMenu
          :items="items"
          class="w-full justify-center hidden lg:inline-flex"
          color="neutral"
          :ui="{
            viewport: 'sm:w-(--reka-navigation-menu-viewport-width)',
            content: 'sm:w-auto',
            childList: 'sm:w-96',
            childLinkDescription: 'text-balance line-clamp-2',
          }"
        >
          <template #nft-content="{ item }">
            <ul
              class="grid gap-2 p-4 lg:w-[500px] lg:grid-cols-[minmax(0,.75fr)_minmax(0,1fr)]"
            >
              <li class="row-span-3">
                <Placeholder class="size-full min-h-48" />
              </li>

              <li v-for="child in item.children" :key="child.label">
                <ULink
                  class="text-sm text-left rounded-md p-3 transition-colors hover:bg-elevated/50 cursor-pointer"
                >
                  <p class="font-medium text-highlighted">
                    {{ child.label }}
                  </p>
                  <p class="text-muted line-clamp-2">
                    {{ child.description }}
                  </p>
                </ULink>
              </li>
            </ul>
          </template>
        </UNavigationMenu>
        <div class="flex items-center gap-2">
          <UDropdownMenu
            class="lg:hidden"
            :items="dropdownn_items"
            :ui="{
              content: 'w-48',
            }"
          >
            <UButton icon="i-lucide-menu" color="neutral" variant="outline" />
          </UDropdownMenu>
          <ConnectButton />
          <Web2SigninButton />
        </div>
      </div>
    </div>
  </header>
</template>
<script setup lang="ts">
import type { NavigationMenuItem } from "@nuxt/ui";

const items = [
  {
    label: "Swap",
    to: "/swap",
  },
  {
    label: "Pool",
    to: "/pool",
  },
  {
    label: "NFTs",
    slot: "nft" as const,
    children: [
      {
        label: "Marketplace",
        description:
          " Discover, buy, and sell unique digital assets on our NFT marketplace.",
        to: "/nfts",
      },
      {
        label: "P2P Lending",
        description: "Lend or borrow against your NFT assets",
        to: "/nfts",
      },
    ],
  },
] satisfies NavigationMenuItem[];

import type { DropdownMenuItem } from "@nuxt/ui";

const dropdownn_items = ref<DropdownMenuItem[][]>([
  [
    {
      label: "swap",
      type: "label",
      to: "/swap",
    },
    {
      label: "pool",
      type: "label",
      to: "/pool",
    },
  ],
  [
    {
      label: "nft",
    },
    {
      label: "marketplace",
      to: "/nft",
    },
    {
      label: "p2p lending",
      to: "/nft",
    },
  ],
]);
</script>
