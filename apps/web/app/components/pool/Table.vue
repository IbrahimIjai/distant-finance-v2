<script setup lang="ts">
import { h } from "vue";
import type { TableColumn } from "@nuxt/ui";
import type { Column } from "@tanstack/vue-table";
// import { findToken } from "@/utils/tokens";
import { pools, type Pool } from "@/utils/pool";
import { getChainLogo, type SUPPORTED_CHAINS } from "@/utils/reown-config";
// import {pools} from "@utils/poo"
type FilterId = "all" | "stablecoin" | "fiat";

const UAvatar = resolveComponent("UAvatar");
const UButton = resolveComponent("UButton");
const UDropdownMenu = resolveComponent("UDropdownMenu");
const UIcon = resolveComponent("UIcon");

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
		cell: ({ row }) => {
			return h("div", { class: "flex items-center gap-1" }, [
				h("div", { class: "relative" }, [
					h(UAvatar, {
						src: row.original.token.logoURI,
						size: "2xl",
					}),
					h(UAvatar, {
						src: getChainLogo(row.original.token.chainId as SUPPORTED_CHAINS),
						size: "2xs",
						class: "absolute bottom-0 right-0 bg-white",
					}),
				]),

				h("div", undefined, [
					h("p", { class: "text-sm" }, `${row.original.token.name}`),
				]),
			]);
		},
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
				`${row.getValue<number>("apr").toFixed(2)}%`,
			),
	},
	{
		id: "action",
		cell: ({ row }) =>
			h(
				UButton,
				{
					class: "text-right font-medium",
					variant: "solid",
					onClick: () => navigateTo(getPoolRoute(row.original)),
				},
				`Add Liquidity`,
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
			}),
	);
}

const sorting = ref([
	{
		id: "id",
		desc: false,
	},
]);

const getPoolRoute = (pool: Pool) =>
	pool.type === "fiat"
		? `/pool/fiat/${pool.poolAddress}`
		: `/pool/stables/${pool.poolAddress}`;
</script>

<template>
	<!-- Pool Type Filters -->
	<div class="mb-6 flex flex-wrap gap-2">
		<UButton
			v-for="filter in filters"
			:key="filter.id"
			variant="outline"
			class="px-6"
			@click="activeFilter = filter.id as FilterId">
			{{ filter.label }}
			<template #trailing>
				<UIcon
					:name="
						activeFilter === filter.id ? 'i-lucide-check' : 'i-lucide-plus'
					"
					class="ml-2" />
			</template>
		</UButton>
	</div>

	<UTable
		v-model:sorting="sorting"
		:data="filteredPools"
		:columns="columns"
		class="flex-1" />
</template>
