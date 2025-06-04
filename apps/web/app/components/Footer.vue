<script setup lang="ts"></script>

<template>
  <footer>
    <USeparator class="h-px z-20" />
    <div class="container font-mono py-3">
      <div class="flex justify-between items-center">
        <div class="text-xs tracking-tight">
          <span class="text-muted">
            © {{ new Date().getFullYear() }} - Made by
          </span>
          <ULink target="_blank" to="https://ibrahimijai.dev/" class="italic">
            Ibrahim Ijai
          </ULink>
        </div>
        <nav>
          <ul class="flex space-x-4 text-sm">
            <li><a href="#">Roadmap</a></li>
            <li><a href="#">Docs</a></li>
          </ul>
        </nav>
        <div class="flex items-center gap-2">
          <UButton
            icon="i-simple-icons-x"
            color="neutral"
            variant="ghost"
            to="https://x.com/distantfinance"
            target="_blank"
            aria-label="X"
            size="sm"
          />
          <UButton
            icon="i-simple-icons-github"
            color="neutral"
            variant="ghost"
            to="https://github.com/ibrahimijai/distantfinancev2"
            target="_blank"
            aria-label="GitHub"
            size="sm"
          />
          <ThemeToggle size="sm" />
        </div>
      </div>
    </div>
  </footer>
</template>
