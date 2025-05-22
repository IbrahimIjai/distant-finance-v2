// https://tailwindcss.com/docs/configuration
export default {
  content: [
    './components/**/*.{js,vue,ts}',
    './layouts/**/*.vue',
    './pages/**/*.vue',
    './plugins/**/*.{js,ts}',
    './app.vue',
    './error.vue',
  ],
  theme: {
    extend: {},
  },
  plugins: [],
  // Specify Tailwind v4 compatibility
  future: {
    hoverOnlyWhenSupported: true,
  },
}
