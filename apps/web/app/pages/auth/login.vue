<script setup lang="ts">

</script>
<template>
  <div>
    <button @click="signInWithOtp">
      Sign In with E-Mail
    </button>
    <input
      v-model="email"
      type="email"
    />
  </div>
</template>
