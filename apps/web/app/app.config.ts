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
  profile: {
    name: "Sunday Ibrahim Ijai",
    job: "# [Frontend Engineer, Smart Contract Developer ]{.text-accent}",
    email: "sundayijai@gmail.com",
    phone: "+234 816 303 3132",
    picture: "https://avatars.githubusercontent.com/u/71938701?v=4",
  },
  seo: {
    title: "Sunday Ibrahim Ijai",
    description:
      "Frontend Engineer, Smart Contract Developer based in Nigeria.",
    url: "https://sundayijai.com",
    lang: "en",
  },
  socials: {
    github: "https://github.com/ibrahimijai",
    twitter: "https://x.com/ibrahimijai",
    linkedin: "https://www.linkedin.com/in/ibrahim-ijai-sunday-987b91185/",
    instagram: "https://www.instagram.com/ibrahimijai/",
    spotify: "https://open.spotify.com/artist/70yqFQVIrj2YjS1rnMRR6O",
  },
});
