<template>
  <footer class="bg-secondary-900 text-white">
    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-12">
      <div class="grid grid-cols-1 md:grid-cols-4 gap-8">
        <!-- Brand -->
        <div class="col-span-1 md:col-span-2">
          <div class="flex items-center space-x-2 mb-4">
            <div class="w-8 h-8 bg-gradient-to-r from-primary-600 to-accent-600 rounded-lg flex items-center justify-center">
              <svg class="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
            <span class="text-xl font-bold">ModernBlog</span>
          </div>
          <p class="text-secondary-300 max-w-md">
            A modern blog platform built with Nuxt 3, featuring clean design and excellent user experience.
          </p>
        </div>

        <!-- Quick Links -->
        <div>
          <h3 class="text-lg font-semibold mb-4">Quick Links</h3>
          <div class="space-y-2">
            <NuxtLink to="/" class="footer-link">Home</NuxtLink>
            <NuxtLink to="/about" class="footer-link">About</NuxtLink>
            <NuxtLink to="/contact" class="footer-link">Contact</NuxtLink>
          </div>
        </div>

        <!-- Categories -->
        <div>
          <h3 class="text-lg font-semibold mb-4">Categories</h3>
          <div class="space-y-2">
            <a href="#" class="footer-link">Technology</a>
            <a href="#" class="footer-link">Design</a>
            <a href="#" class="footer-link">Business</a>
            <a href="#" class="footer-link">Lifestyle</a>
          </div>
        </div>
      </div>

      <div class="mt-8 pt-8 border-t border-secondary-800 text-center text-secondary-400">
        <p>&copy; {{ new Date().getFullYear() }} ModernBlog. All rights reserved.</p>
      </div>
    </div>
  </footer>
</template>

<style scoped>
.footer-link {
  @apply block text-secondary-300 hover:text-white transition-colors duration-200;
}
</style>