<template>
  <div class="relative h-96 rounded-2xl overflow-hidden group animate-slide-up">
    <img
      :src="post.image"
      :alt="post.title"
      class="w-full h-full object-cover group-hover:scale-105 transition-transform duration-500"
    />
    <div class="absolute inset-0 bg-gradient-to-t from-black/70 via-black/20 to-transparent"></div>
    
    <div class="absolute inset-0 flex items-end">
      <div class="p-8 text-white">
        <div class="flex items-center space-x-4 mb-4">
          <span class="px-3 py-1 bg-accent-600 text-white text-sm font-medium rounded-full">
            Featured
          </span>
          <span class="px-3 py-1 bg-primary-600 text-white text-sm font-medium rounded-full">
            {{ post.category }}
          </span>
        </div>
        
        <h2 class="text-3xl md:text-4xl font-bold mb-4 leading-tight">
          {{ post.title }}
        </h2>
        
        <p class="text-lg text-white/90 mb-6 max-w-2xl">
          {{ post.excerpt }}
        </p>
        
        <div class="flex items-center justify-between">
          <div class="flex items-center space-x-4">
            <img
              :src="post.author_avatar || post.author?.avatar"
              :alt="post.author_name || post.author?.name"
              class="w-10 h-10 rounded-full border-2 border-white/30"
            />
            <div>
              <p class="font-medium">{{ post.author_name || post.author?.name }}</p>
              <p class="text-sm text-white/70">{{ formatDate(post.created_at || post.date) }} • {{ post.read_time }} min read</p>
            </div>
          </div>
          
          <NuxtLink
            :to="`/blog/${post.slug}`"
            class="inline-flex items-center px-6 py-3 bg-white text-secondary-900 font-medium rounded-lg hover:bg-white/90 transition-colors group"
          >
            Read More
            <ArrowRightIcon class="ml-2 h-4 w-4 group-hover:translate-x-1 transition-transform" />
          </NuxtLink>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import { ArrowRightIcon } from '@heroicons/vue/24/outline'

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