<template>
  <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
    <!-- Hero Section -->
    <section class="mb-16">
      <div class="text-center max-w-4xl mx-auto">
        <h1 class="text-4xl md:text-6xl font-bold mb-6 animate-fade-in">
          Welcome to <span class="gradient-text">ModernBlog</span>
        </h1>
        <p class="text-xl text-secondary-600 mb-8 animate-slide-up">
          Discover insights, tutorials, and stories about modern web development, design, and technology.
        </p>
        <div class="flex flex-wrap justify-center gap-4 animate-fade-in">
          <button
            v-for="category in categories"
            :key="category"
            @click="selectedCategory = category"
            :class="[
              'px-6 py-3 rounded-full font-medium transition-all duration-200',
              selectedCategory === category
                ? 'bg-primary-600 text-white shadow-lg'
                : 'bg-white text-secondary-700 hover:bg-primary-50 hover:text-primary-600 card-shadow'
            ]"
          >
            {{ category }}
          </button>
        </div>
      </div>
    </section>

    <!-- Featured Posts -->
    <section v-if="featuredPosts.length > 0" class="mb-16">
      <h2 class="text-3xl font-bold text-secondary-900 mb-8 text-center">Featured Posts</h2>
      <div class="grid grid-cols-1 lg:grid-cols-2 gap-8">
        <FeaturedPost 
          v-for="post in featuredPosts" 
          :key="post.id" 
          :post="post" 
        />
      </div>
    </section>

    <!-- Recent Posts -->
    <section>
      <div class="flex items-center justify-between mb-8">
        <h2 class="text-3xl font-bold text-secondary-900">
          {{ selectedCategory === 'All' ? 'Recent Posts' : `${selectedCategory} Posts` }}
        </h2>
        <div class="text-secondary-500">
          {{ filteredPosts.length }} {{ filteredPosts.length === 1 ? 'post' : 'posts' }}
        </div>
      </div>
      
      <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
        <BlogCard 
          v-for="post in filteredPosts" 
          :key="post.id" 
          :post="post" 
        />
      </div>

      <!-- Empty State -->
      <div v-if="filteredPosts.length === 0" class="text-center py-16">
        <div class="text-6xl text-secondary-300 mb-4">📝</div>
        <h3 class="text-xl font-semibold text-secondary-700 mb-2">No posts found</h3>
        <p class="text-secondary-500">Try selecting a different category or check back later for new content.</p>
      </div>
    </section>
  </div>
</template>

<script setup>
const { posts, categories, getFeaturedPosts, getPostsByCategory } = useBlog()

const selectedCategory = ref('All')
const featuredPosts = computed(() => getFeaturedPosts())
const filteredPosts = computed(() => getPostsByCategory(selectedCategory.value))

useHead({
  title: 'ModernBlog - Insights on Web Development & Design',
  meta: [
    {
      name: 'description',
      content: 'Discover insights, tutorials, and stories about modern web development, design, and technology.'
    }
  ]
})
</script>