// https://nuxt.com/docs/api/configuration/nuxt-config

export default defineNuxtConfig({
  devtools: { enabled: true },
  future: {
    compatibilityVersion: 4,
  },
  modules: [
    "@nuxt/ui",
    "@nuxtjs/seo",
    "@nuxt/eslint",
    "@vueuse/nuxt",
    "@nuxt/image",
    "motion-v/nuxt"
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
        offchainworkerApiUrl: "https://micro-built.onrender.com",
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
  site: {
    url: "https://distant.finance",
  },
  css: ["~/assets/css/main.css"],
  compatibilityDate: "2025-01-03",
  nitro: {
    prerender: {
      crawlLinks: false,
      routes: ["/", "/sitemap.xml"],
      failOnError: false, // Don't fail build on prerender errors
    },
    logLevel: 'verbose', // Enable verbose logging
  },
});
