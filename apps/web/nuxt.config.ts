// https://nuxt.com/docs/api/configuration/nuxt-config
import pkg from '../../package.json';

export default defineNuxtConfig({
  devtools: { enabled: true },
  future: {
    compatibilityVersion: 4,
  },
  modules: [
    "@nuxt/ui",
    "@nuxtjs/seo",
    "@nuxt/content",
    "@nuxt/eslint",
    "@vueuse/nuxt",
    "@nuxt/image",
    "motion-v/nuxt",
    "@nuxtjs/turnstile",
  ],
  ui: {
    theme: {
      colors: ["primary", "secondary", "success", "info", "warning", "error"],
      transitions: true,
    },
  },

  $development: {
    runtimeConfig: {
      public: {
        offchainworkerApiUrl: "http://127.0.0.1:8787",
      },
    },
  },

  $production: {
    runtimeConfig: {
      public: {
        offchainworkerApiUrl: "https://distatfiapi.workers.dev",
      },
    },
  },
  colorMode: {
    preference: "dark",
    fallback: "dark",
  },

  imports: {
    presets: [
      {
        from: "vue-sonner",
        imports: ["toast"],
      },
    ],
  },
  css: ["~/assets/css/main.css"],
  compatibilityDate: "2025-01-03",
  nitro: {
    prerender: {
      crawlLinks: true,
      routes: ["/", "/sitemap.xml"],
      ignore: ["/notes", "/notes/**"],
    },
  },
});
