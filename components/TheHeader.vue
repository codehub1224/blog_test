<template>
  <header class="fixed top-0 w-full z-50 glass-effect">
    <nav class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
      <div class="flex items-center justify-between h-16">
        <!-- Logo -->
        <NuxtLink to="/" class="flex items-center space-x-2 group">
          <div class="w-8 h-8 bg-gradient-to-r from-primary-600 to-accent-600 rounded-lg flex items-center justify-center transform group-hover:scale-105 transition-transform">
            <svg class="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 20 20">
              <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
            </svg>
          </div>
          <span class="text-xl font-bold gradient-text">ModernBlog</span>
        </NuxtLink>

        <!-- Desktop Navigation -->
        <div class="hidden md:flex items-center space-x-8">
          <NuxtLink to="/" class="nav-link">Home</NuxtLink>
          <NuxtLink to="/about" class="nav-link">About</NuxtLink>
          <NuxtLink to="/contact" class="nav-link">Contact</NuxtLink>
        </div>

        <!-- Search -->
        <div class="hidden sm:flex items-center">
          <div class="relative">
            <input
              v-model="searchQuery"
              type="text"
              placeholder="Search posts..."
              class="w-64 pl-10 pr-4 py-2 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent bg-white/80 backdrop-blur-sm"
            />
            <MagnifyingGlassIcon class="absolute left-3 top-2.5 h-5 w-5 text-secondary-400" />
          </div>
        </div>

        <!-- Mobile menu button -->
        <div class="md:hidden">
          <button
            @click="mobileMenuOpen = !mobileMenuOpen"
            class="p-2 rounded-md text-secondary-600 hover:text-primary-600 hover:bg-white/50 transition-colors"
          >
            <Bars3Icon v-if="!mobileMenuOpen" class="h-6 w-6" />
            <XMarkIcon v-else class="h-6 w-6" />
          </button>
        </div>
      </div>

      <!-- Mobile Navigation -->
      <div v-if="mobileMenuOpen" class="md:hidden border-t border-secondary-200">
        <div class="px-2 pt-2 pb-3 space-y-1">
          <NuxtLink to="/" class="mobile-nav-link">Home</NuxtLink>
          <NuxtLink to="/about" class="mobile-nav-link">About</NuxtLink>
          <NuxtLink to="/contact" class="mobile-nav-link">Contact</NuxtLink>
        </div>
      </div>
    </nav>
  </header>
</template>

<script setup>
import { MagnifyingGlassIcon, Bars3Icon, XMarkIcon } from '@heroicons/vue/24/outline'

const searchQuery = ref('')
const mobileMenuOpen = ref(false)
</script>

<style scoped>
.nav-link {
  @apply text-secondary-700 hover:text-primary-600 font-medium transition-colors duration-200 relative;
}

.nav-link::after {
  content: '';
  @apply absolute bottom-0 left-0 w-0 h-0.5 bg-gradient-to-r from-primary-600 to-accent-600 transition-all duration-300;
}

.nav-link:hover::after {
  @apply w-full;
}

.mobile-nav-link {
  @apply block px-3 py-2 text-base font-medium text-secondary-700 hover:text-primary-600 hover:bg-white/50 rounded-md transition-colors;
}
</style>