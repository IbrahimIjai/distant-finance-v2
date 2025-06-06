<template>
  <div class="p-6 max-w-2xl mx-auto">
    <h1 class="text-2xl font-bold mb-6">Swap</h1>
    
    <div class="bg-gray-100 dark:bg-gray-800 p-4 rounded-lg mb-6">
      <h2 class="text-lg font-semibold mb-2">Test Offchain Worker API</h2>
      <p class="text-sm text-gray-600 dark:text-gray-400 mb-4">
        Current API URL: {{ config.public.offchainworkerApiUrl }}
      </p>
      
      <button 
        @click="testApi"
        :disabled="isLoading"
        class="px-4 py-2 bg-blue-500 text-white rounded hover:bg-blue-600 disabled:opacity-50"
      >
        {{ isLoading ? 'Testing...' : 'Test API' }}
      </button>
      
      <div v-if="apiResponse" class="mt-4 p-3 bg-gray-200 dark:bg-gray-700 rounded overflow-auto max-h-60">
        <pre class="text-xs">{{ apiResponse }}</pre>
      </div>
      
      <div v-if="error" class="mt-4 p-3 bg-red-100 dark:bg-red-900 text-red-800 dark:text-red-200 rounded">
        {{ error }}
      </div>
    </div>
  </div>
</template>

<script setup>
const config = useRuntimeConfig()
const isLoading = ref(false)
const apiResponse = ref(null)
const error = ref(null)

async function testApi() {
  try {
    isLoading.value = true
    error.value = null
    apiResponse.value = null
    
    const response = await fetch(config.public.offchainworkerApiUrl)
    const data = await response.json()
    
    if (!response.ok) {
      throw new Error(data.message || 'API request failed')
    }
    
    apiResponse.value = data
  } catch (err) {
    error.value = `Error: ${err.message}`
    console.error('API Error:', err)
  } finally {
    isLoading.value = false
  }
}
</script>