<script setup lang="ts">
import { h } from "vue";
import type { TableColumn } from "@nuxt/ui";
import type { Column, Row } from "@tanstack/vue-table";
import { findToken } from "@/utils/tokens";
import type { Pool } from "@/utils/pool";

type FilterId = "all" | "stablecoin" | "fiat";

const UBadge = resolveComponent("UBadge");
const UButton = resolveComponent("UButton");
const UDropdownMenu = resolveComponent("UDropdownMenu");
const UIcon = resolveComponent("UIcon");

// Helper function to render token cell
const renderTokenCell = (pool: Pool) => {
  const token = findToken(pool.token, pool.chainId as number);
  const logoUrl = token?.logoURI || "/defaultpool.png";
  const address = `#${pool.poolAddress.slice(0, 6)}...${pool.poolAddress.slice(-4)}`;

  return h("div", { class: "flex items-center gap-2" }, [
    h("img", {
      src: logoUrl,
      alt: "Token logo",
      class: "h-8 w-8 rounded-full object-cover",
    }),
    h("span", address),
  ]);
};

const filters = [
  { id: "all", label: "All" },
  { id: "stablecoin", label: "Stablecoins" },
  { id: "fiat", label: "Fiat" },
];
const activeFilter = ref<FilterId>("all");

const filteredPools = computed(() => {
  if (activeFilter.value === "all") return pools.value;
  return pools.value.filter((pool) => pool.type === activeFilter.value);
});

const columns: TableColumn<Pool>[] = [
  {
    accessorKey: "poolAddress",
    header: ({ column }) => getHeader(column, "Pool"),
    cell: ({ row }) => renderTokenCell(row.original),
  },
  {
    accessorKey: "volume",
    header: ({ column }) => getHeader(column, "Volume"),
    cell: ({ row }) =>
      new Intl.NumberFormat("en-US").format(row.getValue<number>("volume")),
  },
  {
    accessorKey: "fees",
    header: ({ column }) => getHeader(column, "Fees"),
    cell: ({ row }) =>
      new Intl.NumberFormat("en-US").format(row.getValue<number>("fees")),
  },
  {
    accessorKey: "tvl",
    header: ({ column }) => getHeader(column, "TVL"),
    cell: ({ row }) =>
      new Intl.NumberFormat("en-US", {
        style: "currency",
        currency: "USD",
      }).format(row.getValue<number>("tvl")),
  },
  {
    accessorKey: "apr",
    header: ({ column }) =>
      h("div", { class: "text-right" }, getHeader(column, "APR")),
    cell: ({ row }) =>
      h(
        "div",
        { class: "text-right font-medium" },
        `${row.getValue<number>("apr").toFixed(2)}%`
      ),
  },
];

function getHeader(column: Column<Pool>, label: string) {
  const isSorted = column.getIsSorted();

  return h(
    UDropdownMenu,
    {
      content: {
        align: "start",
      },
      "aria-label": "Actions dropdown",
      items: [
        {
          label: "Asc",
          type: "checkbox",
          icon: "i-lucide-arrow-up-narrow-wide",
          checked: isSorted === "asc",
          onSelect: () => {
            if (isSorted === "asc") {
              column.clearSorting();
            } else {
              column.toggleSorting(false);
            }
          },
        },
        {
          label: "Desc",
          icon: "i-lucide-arrow-down-wide-narrow",
          type: "checkbox",
          checked: isSorted === "desc",
          onSelect: () => {
            if (isSorted === "desc") {
              column.clearSorting();
            } else {
              column.toggleSorting(true);
            }
          },
        },
      ],
    },
    () =>
      h(UButton, {
        color: "neutral",
        variant: "ghost",
        label,
        icon: isSorted
          ? isSorted === "asc"
            ? "i-lucide-arrow-up-narrow-wide"
            : "i-lucide-arrow-down-wide-narrow"
          : "i-lucide-arrow-up-down",
        class: "-mx-2.5 data-[state=open]:bg-elevated",
        "aria-label": `Sort by ${isSorted === "asc" ? "descending" : "ascending"}`,
      })
  );
}

const sorting = ref([
  {
    id: "id",
    desc: false,
  },
]);

const getPoolRoute = (pool: Pool) =>
  pool.type === "fiat" ? `/pools/fiat/${pool.id}` : `/pools/stables/${pool.id}`;

function handleRowClick(pool: Pool) {
  return navigateTo(getPoolRoute(pool));
}
</script>

<template>
  <!-- Pool Type Filters -->
  <div class="mb-6 flex flex-wrap gap-2">
    <UButton
      v-for="filter in filters"
      :key="filter.id"
      variant="outline"
      @click="activeFilter = filter.id as FilterId"
      class="px-6"
    >
      {{ filter.label }}
      <template #trailing>
        <UIcon
          :name="
            activeFilter === filter.id ? 'i-lucide-check' : 'i-lucide-plus'
          "
          class="ml-2"
        />
      </template>
    </UButton>
  </div>
  <UTable
    v-model:sorting="sorting"
     :rows="filteredPools"
    :data="filteredPools"
    :columns="columns"
    class="flex-1"
  >
    <template #default="{ rows }">
      <tbody>
        <tr
          v-for="row in rows"
          :key="row.original.poolAddress"
          class="cursor-pointer hover:bg-muted"
          @click="handleRowClick(row.original)"
        >
          <td
            v-for="cell in row.getVisibleCells()"
            :key="cell.id"
            class="py-3 px-4"
          >
            <component
              :is="cell.column.columnDef.cell"
              :row="row"
              :column="cell.column"
            />
          </td>
        </tr>
      </tbody>
    </template>
  </UTable>
</template>
