// https://nuxt.com/docs/api/configuration/nuxt-config
export default defineNuxtConfig({
  compatibilityDate: "2025-05-15",
  devtools: { enabled: true },
  modules: ["@nuxt/ui", "@nuxtjs/tailwindcss"],
  css: ["~/assets/css/main.css"],
  ui: {
    colorMode: true,
    theme: {
      transitions: true,
    },
  },
  tailwindcss: {
    configPath: '~/tailwind.config.js',
    exposeConfig: true,
    viewer: true,
  },
});
