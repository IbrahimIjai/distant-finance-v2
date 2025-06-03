import { defineContentConfig, defineCollection, z } from "@nuxt/content";

export default defineContentConfig({
	collections: {
		projects: defineCollection({
			type: "page",
			source: "projects/*.md",
			schema: z.object({
				title: z.string().nonempty(),
				description: z.string().nonempty(),
				date: z.string().nonempty(),
			}),
		}),
		articles: defineCollection({
			type: "page",
			source: "articles/*.md",
			schema: z.object({
				title: z.string().nonempty(),
				description: z.string().nonempty(),
				date: z.string().nonempty(),
			}),
		}),
		content: defineCollection({
			type: "page",
			source: "**/*.md",
		}),
	},
});
