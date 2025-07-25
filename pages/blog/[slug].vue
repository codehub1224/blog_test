<template>
  <div v-if="post" class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <!-- Article Header -->
    <article class="animate-fade-in">
      <header class="mb-8">
        <div class="flex items-center space-x-4 mb-6">
          <span class="px-3 py-1 bg-primary-600 text-white text-sm font-medium rounded-full">
            {{ post.category }}
          </span>
          <time :datetime="post.created_at" class="text-secondary-500">
            {{ formatDate(post.created_at) }}
          </time>
          <span class="text-secondary-500">{{ post.read_time }} min read</span>
        </div>
        
        <h1 class="text-4xl md:text-5xl font-bold text-secondary-900 mb-6 leading-tight">
          {{ post.title }}
        </h1>
        
        <p class="text-xl text-secondary-600 mb-8">
          {{ post.excerpt }}
        </p>
        
        <div class="flex items-center space-x-4 pb-8 border-b border-secondary-200">
          <img
            :src="post.author_avatar"
            :alt="post.author_name"
            class="w-12 h-12 rounded-full"
          />
          <div>
            <p class="font-semibold text-secondary-900">{{ post.author_name }}</p>
            <p class="text-secondary-600">{{ post.author_bio }}</p>
          </div>
        </div>
      </header>

      <!-- Featured Image -->
      <div class="mb-8">
        <img
          :src="post.image"
          :alt="post.title"
          class="w-full h-96 object-cover rounded-xl card-shadow"
        />
      </div>

      <!-- Article Content -->
      <div class="prose prose-lg max-w-none">
        <div v-html="renderedContent" class="article-content"></div>
      </div>

      <!-- Tags -->
      <div class="mt-8 pt-8 border-t border-secondary-200">
        <h3 class="text-lg font-semibold text-secondary-900 mb-4">Tags</h3>
        <div class="flex flex-wrap gap-2">
          <span
            v-for="tag in post.tags"
            :key="tag"
            class="px-3 py-1 bg-secondary-100 text-secondary-700 text-sm rounded-full hover:bg-primary-100 hover:text-primary-700 transition-colors cursor-pointer"
          >
            {{ tag }}
          </span>
        </div>
      </div>

      <!-- Share Buttons -->
      <div class="mt-8 pt-8 border-t border-secondary-200">
        <h3 class="text-lg font-semibold text-secondary-900 mb-4">Share this article</h3>
        <div class="flex space-x-4">
          <button class="share-button bg-blue-600 hover:bg-blue-700">
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
              <path d="M24 4.557c-.883.392-1.832.656-2.828.775 1.017-.609 1.798-1.574 2.165-2.724-.951.564-2.005.974-3.127 1.195-.897-.957-2.178-1.555-3.594-1.555-3.179 0-5.515 2.966-4.797 6.045-4.091-.205-7.719-2.165-10.148-5.144-1.29 2.213-.669 5.108 1.523 6.574-.806-.026-1.566-.247-2.229-.616-.054 2.281 1.581 4.415 3.949 4.89-.693.188-1.452.232-2.224.084.626 1.956 2.444 3.379 4.6 3.419-2.07 1.623-4.678 2.348-7.29 2.04 2.179 1.397 4.768 2.212 7.548 2.212 9.142 0 14.307-7.721 13.995-14.646.962-.695 1.797-1.562 2.457-2.549z"/>
            </svg>
          </button>
          <button class="share-button bg-blue-800 hover:bg-blue-900">
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
              <path d="M20.447 20.452h-3.554v-5.569c0-1.328-.027-3.037-1.852-3.037-1.853 0-2.136 1.445-2.136 2.939v5.667H9.351V9h3.414v1.561h.046c.477-.9 1.637-1.85 3.37-1.85 3.601 0 4.267 2.37 4.267 5.455v6.286zM5.337 7.433c-1.144 0-2.063-.926-2.063-2.065 0-1.138.92-2.063 2.063-2.063 1.14 0 2.064.925 2.064 2.063 0 1.139-.925 2.065-2.064 2.065zm1.782 13.019H3.555V9h3.564v11.452zM22.225 0H1.771C.792 0 0 .774 0 1.729v20.542C0 23.227.792 24 1.771 24h20.451C23.2 24 24 23.227 24 22.271V1.729C24 .774 23.2 0 22.222 0h.003z"/>
            </svg>
          </button>
          <button class="share-button bg-green-600 hover:bg-green-700">
            <svg class="w-5 h-5" fill="currentColor" viewBox="0 0 24 24">
              <path d="M17.472 14.382c-.297-.149-1.758-.867-2.03-.967-.273-.099-.471-.148-.67.15-.197.297-.767.966-.94 1.164-.173.199-.347.223-.644.075-.297-.15-1.255-.463-2.39-1.475-.883-.788-1.48-1.761-1.653-2.059-.173-.297-.018-.458.13-.606.134-.133.298-.347.446-.52.149-.174.198-.298.298-.497.099-.198.05-.371-.025-.52-.075-.149-.669-1.612-.916-2.207-.242-.579-.487-.5-.669-.51-.173-.008-.371-.01-.57-.01-.198 0-.52.074-.792.372-.272.297-1.04 1.016-1.04 2.479 0 1.462 1.065 2.875 1.213 3.074.149.198 2.096 3.2 5.077 4.487.709.306 1.262.489 1.694.625.712.227 1.36.195 1.871.118.571-.085 1.758-.719 2.006-1.413.248-.694.248-1.289.173-1.413-.074-.124-.272-.198-.57-.347m-5.421 7.403h-.004a9.87 9.87 0 01-5.031-1.378l-.361-.214-3.741.982.998-3.648-.235-.374a9.86 9.86 0 01-1.51-5.26c.001-5.45 4.436-9.884 9.888-9.884 2.64 0 5.122 1.03 6.988 2.898a9.825 9.825 0 012.893 6.994c-.003 5.45-4.437 9.884-9.885 9.884m8.413-18.297A11.815 11.815 0 0012.05 0C5.495 0 .16 5.335.157 11.892c0 2.096.547 4.142 1.588 5.945L.057 24l6.305-1.654a11.882 11.882 0 005.683 1.448h.005c6.554 0 11.89-5.335 11.893-11.893A11.821 11.821 0 0020.885 3.488"/>
            </svg>
          </button>
        </div>
      </div>
    </article>

    <!-- Related Posts -->
    <section class="mt-16">
      <h2 class="text-2xl font-bold text-secondary-900 mb-8">Related Posts</h2>
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-6">
        <BlogCard 
          v-for="relatedPost in relatedPosts" 
          :key="relatedPost.id" 
          :post="relatedPost" 
        />
      </div>
    </section>
  </div>

  <!-- 404 State -->
  <div v-else class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-16 text-center">
    <div class="text-6xl text-secondary-300 mb-4">😔</div>
    <h1 class="text-3xl font-bold text-secondary-900 mb-4">Post Not Found</h1>
    <p class="text-secondary-600 mb-8">The blog post you're looking for doesn't exist or has been moved.</p>
    <NuxtLink
      to="/"
      class="inline-flex items-center px-6 py-3 bg-primary-600 text-white font-medium rounded-lg hover:bg-primary-700 transition-colors"
    >
      Back to Home
    </NuxtLink>
  </div>
</template>

<script setup>
import { marked } from 'marked'

const route = useRoute()
const { getPostBySlug, posts } = useBlog()

const post = computed(() => getPostBySlug(route.params.slug))

const relatedPosts = computed(() => {
  if (!post.value) return []
  return posts.value
    .filter(p => p.id !== post.value.id && p.category === post.value.category)
    .slice(0, 3)
})

const renderedContent = computed(() => {
  if (!post.value?.content) return ''
  
  // Configure marked options
  marked.setOptions({
    breaks: true,
    gfm: true
  })
  
  return marked(post.value.content)
})

const formatDate = (date) => {
  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'long',
    day: 'numeric'
  })
}

useHead({
  title: () => post.value ? `${post.value.title} - ModernBlog` : 'Post Not Found - ModernBlog',
  meta: [
    {
      name: 'description',
      content: () => post.value ? post.value.excerpt : 'The blog post you\'re looking for doesn\'t exist.'
    }
  ]
})
</script>

<style scoped>
.share-button {
  @apply p-3 text-white rounded-lg transition-colors duration-200 flex items-center justify-center;
}

.article-content {
  @apply text-secondary-700 leading-relaxed;
}

.article-content :deep(h1),
.article-content :deep(h2),
.article-content :deep(h3) {
  @apply text-secondary-900 font-bold mt-8 mb-4;
}

.article-content :deep(h1) {
  @apply text-3xl;
}

.article-content :deep(h2) {
  @apply text-2xl;
}

.article-content :deep(h3) {
  @apply text-xl;
}

.article-content :deep(p) {
  @apply mb-4;
}

.article-content :deep(ul),
.article-content :deep(ol) {
  @apply mb-4 ml-6;
}

.article-content :deep(ul) {
  @apply list-disc;
}

.article-content :deep(ol) {
  @apply list-decimal;
}

.article-content :deep(li) {
  @apply mb-2;
}

.article-content :deep(pre) {
  @apply bg-secondary-900 text-white p-4 rounded-lg overflow-x-auto my-4;
}

.article-content :deep(code) {
  @apply bg-secondary-100 px-2 py-1 rounded text-sm;
}

.article-content :deep(pre code) {
  @apply bg-transparent px-0 py-0;
}

.article-content :deep(blockquote) {
  @apply border-l-4 border-primary-500 pl-4 italic my-4;
}
</style>