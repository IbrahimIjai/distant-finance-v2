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
  // hub: {
  // 	ai: true,
  // 	blob: true,
  // },
  content: {
    build: {
      markdown: {
        highlight: {
          langs: [
            "ts",
            "js",
            "json",
            "vue",
            "dockerfile",
            "docker",
            "yaml",
            "css",
          ],
          theme: {
            light: "github-light",
            dark: "github-dark",
            default: "github-dark",
          },
        },
      },
    },
    preview: {
      api: "https://api.nuxt.studio",
      dev: true,
    },
  },
  mdc: {
    highlight: {
      theme: {
        dark: "github-dark",
        default: "github-dark",
        light: "github-light",
      },
    },
  },

  turnstile: {
    siteKey: process.env.TURNSTILE_SITE_KEY,
  },
  runtimeConfig: {
    turnstile: {
      // This can be overridden at runtime via the NUXT_TURNSTILE_SECRET_KEY
      // environment variable.
      secretKey: process.env.TURNSTILE_SECRET_KEY,
    },
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
