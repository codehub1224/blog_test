<template>
  <article class="bg-white rounded-xl card-shadow hover:card-shadow-hover transition-all duration-300 overflow-hidden group animate-fade-in">
    <NuxtLink :to="`/blog/${post.slug}`" class="block">
      <!-- Featured Image -->
      <div class="relative h-48 overflow-hidden">
        <img
          :src="post.image"
          :alt="post.title"
          class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-300"
        />
        <div class="absolute inset-0 bg-gradient-to-t from-black/20 to-transparent"></div>
        <div class="absolute top-4 left-4">
          <span class="px-3 py-1 bg-primary-600 text-white text-sm font-medium rounded-full">
            {{ post.category }}
          </span>
        </div>
      </div>

      <!-- Content -->
      <div class="p-6">
        <div class="flex items-center text-sm text-secondary-500 mb-3">
          <time :datetime="post.created_at || post.date">
            {{ formatDate(post.created_at || post.date) }}
          </time>
          <span class="mx-2">•</span>
          <span>{{ post.read_time }} min read</span>
        </div>

        <h3 class="text-xl font-bold text-secondary-900 mb-3 group-hover:text-primary-600 transition-colors">
          {{ post.title }}
        </h3>

        <p class="text-secondary-600 mb-4 line-clamp-3">
          {{ post.excerpt }}
        </p>

        <div class="flex items-center justify-between">
          <div class="flex items-center space-x-2">
            <img
              :src="post.author_avatar || post.author?.avatar"
              :alt="post.author_name || post.author?.name"
              class="w-8 h-8 rounded-full"
            />
            <span class="text-sm font-medium text-secondary-700">
              {{ post.author_name || post.author?.name }}
            </span>
          </div>

          <div class="flex flex-wrap gap-2">
            <span
              v-for="tag in (post.tags || []).slice(0, 2)"
              :key="tag"
              class="px-2 py-1 bg-secondary-100 text-secondary-600 text-xs rounded-full"
            >
              {{ tag }}
            </span>
          </div>
        </div>
      </div>
    </NuxtLink>
  </article>
</template>

<script setup>
defineProps({
  post: {
    type: Object,
    required: true
  }
})

const formatDate = (date) => {
  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}
</script>

<style scoped>
.line-clamp-3 {
  display: -webkit-box;
  -webkit-line-clamp: 3;
  -webkit-box-orient: vertical;
  overflow: hidden;
}
</style>