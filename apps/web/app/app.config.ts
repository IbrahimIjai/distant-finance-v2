export default defineAppConfig({
  ui: {
    colors: {
      primary: "orange",
      neutral: "neutral",
    },
    prose: {
      h1: {
        base: "text-2xl sm:text-3xl font-serif italic font-[500]",
      },
      hr: {
        base: "my-2",
      },
      strong: {
        base: "text-(--ui-text-highlighted) font-[450]",
      },
      icon: {
        base: "text-(--ui-text-highlighted)",
      },
      p: {
        base: "text-(--ui-text-muted)",
      },
      li: {
        base: "text-(--ui-text-muted)",
      },
      a: {
        base: "italic border-b border-(--color-accent) text-(--ui-text-highlighted) font-medium",
      },
    },
  },

  seo: {
    title: "Distant Finance",
    description:
      "Distant Finance",
    url: "https://distant.finance",
    lang: "en",
  },
  socials: {
    github: "https://github.com/ibrahimijai/distantfinancev2",
    twitter: "https://x.com/distantfinance",
  },
});
