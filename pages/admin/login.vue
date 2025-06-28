<template>
  <div class="min-h-screen bg-gradient-to-br from-secondary-50 to-primary-50 flex items-center justify-center px-4">
    <div class="max-w-md w-full bg-white rounded-2xl card-shadow p-8">
      <div class="text-center mb-8">
        <div class="w-16 h-16 bg-gradient-to-r from-primary-600 to-accent-600 rounded-xl flex items-center justify-center mx-auto mb-4">
          <svg class="w-8 h-8 text-white" fill="currentColor" viewBox="0 0 20 20">
            <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
          </svg>
        </div>
        <h1 class="text-2xl font-bold text-secondary-900">Admin Login</h1>
        <p class="text-secondary-600 mt-2">Sign in to manage your blog</p>
      </div>

      <form @submit.prevent="handleLogin" class="space-y-6">
        <div>
          <label for="email" class="block text-sm font-medium text-secondary-700 mb-2">
            Email
          </label>
          <input
            id="email"
            v-model="form.email"
            type="email"
            required
            class="w-full px-4 py-3 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-colors"
            placeholder="admin@example.com"
          />
        </div>

        <div>
          <label for="password" class="block text-sm font-medium text-secondary-700 mb-2">
            Password
          </label>
          <input
            id="password"
            v-model="form.password"
            type="password"
            required
            class="w-full px-4 py-3 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent transition-colors"
            placeholder="••••••••"
          />
        </div>

        <div v-if="error" class="p-4 bg-red-50 border border-red-200 rounded-lg">
          <p class="text-red-700 text-sm">{{ error }}</p>
        </div>

        <button
          type="submit"
          :disabled="loading"
          class="w-full px-6 py-3 bg-gradient-to-r from-primary-600 to-accent-600 text-white font-medium rounded-lg hover:from-primary-700 hover:to-accent-700 transition-all duration-200 disabled:opacity-50 disabled:cursor-not-allowed"
        >
          <span v-if="!loading">Sign In</span>
          <span v-else class="flex items-center justify-center">
            <svg class="animate-spin -ml-1 mr-3 h-5 w-5 text-white" xmlns="http://www.w3.org/2000/svg" fill="none" viewBox="0 0 24 24">
              <circle class="opacity-25" cx="12" cy="12" r="10" stroke="currentColor" stroke-width="4"></circle>
              <path class="opacity-75" fill="currentColor" d="M4 12a8 8 0 018-8V0C5.373 0 0 5.373 0 12h4zm2 5.291A7.962 7.962 0 014 12H0c0 3.042 1.135 5.824 3 7.938l3-2.647z"></path>
            </svg>
            Signing in...
          </span>
        </button>
      </form>

      <div class="mt-6 text-center">
        <NuxtLink to="/" class="text-primary-600 hover:text-primary-700 text-sm">
          ← Back to Blog
        </NuxtLink>
      </div>
    </div>
  </div>
</template>

<script setup>
definePageMeta({
  layout: false
})

const { signIn } = useAuth()

const form = ref({
  email: '',
  password: ''
})

const loading = ref(false)
const error = ref('')

const handleLogin = async () => {
  loading.value = true
  error.value = ''

  try {
    await signIn(form.value.email, form.value.password)
    await navigateTo('/admin')
  } catch (err) {
    error.value = err.message || 'Login failed. Please check your credentials.'
  } finally {
    loading.value = false
  }
}

useHead({
  title: 'Admin Login - ModernBlog'
})
</script>