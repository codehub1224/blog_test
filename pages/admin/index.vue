<template>
  <div class="min-h-screen bg-secondary-50">
    <!-- Admin Header -->
    <header class="bg-white border-b border-secondary-200">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
          <div class="flex items-center space-x-4">
            <div class="w-8 h-8 bg-gradient-to-r from-primary-600 to-accent-600 rounded-lg flex items-center justify-center">
              <svg class="w-5 h-5 text-white" fill="currentColor" viewBox="0 0 20 20">
                <path d="M9 12l2 2 4-4m6 2a9 9 0 11-18 0 9 9 0 0118 0z"/>
              </svg>
            </div>
            <h1 class="text-xl font-bold text-secondary-900">Admin Dashboard</h1>
          </div>
          
          <div class="flex items-center space-x-4">
            <NuxtLink to="/" class="text-secondary-600 hover:text-primary-600 transition-colors">
              View Blog
            </NuxtLink>
            <button
              @click="handleSignOut"
              class="px-4 py-2 text-secondary-600 hover:text-red-600 transition-colors"
            >
              Sign Out
            </button>
          </div>
        </div>
      </div>
    </header>

    <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <!-- Stats -->
      <div class="grid grid-cols-1 md:grid-cols-4 gap-6 mb-8">
        <div class="bg-white rounded-xl card-shadow p-6">
          <div class="flex items-center">
            <div class="w-12 h-12 bg-primary-100 rounded-lg flex items-center justify-center">
              <DocumentTextIcon class="w-6 h-6 text-primary-600" />
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-secondary-600">Total Posts</p>
              <p class="text-2xl font-bold text-secondary-900">{{ posts.length }}</p>
            </div>
          </div>
        </div>

        <div class="bg-white rounded-xl card-shadow p-6">
          <div class="flex items-center">
            <div class="w-12 h-12 bg-accent-100 rounded-lg flex items-center justify-center">
              <StarIcon class="w-6 h-6 text-accent-600" />
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-secondary-600">Featured</p>
              <p class="text-2xl font-bold text-secondary-900">{{ featuredCount }}</p>
            </div>
          </div>
        </div>

        <div class="bg-white rounded-xl card-shadow p-6">
          <div class="flex items-center">
            <div class="w-12 h-12 bg-blue-100 rounded-lg flex items-center justify-center">
              <FolderIcon class="w-6 h-6 text-blue-600" />
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-secondary-600">Categories</p>
              <p class="text-2xl font-bold text-secondary-900">{{ categoriesCount }}</p>
            </div>
          </div>
        </div>

        <div class="bg-white rounded-xl card-shadow p-6">
          <div class="flex items-center">
            <div class="w-12 h-12 bg-green-100 rounded-lg flex items-center justify-center">
              <ClockIcon class="w-6 h-6 text-green-600" />
            </div>
            <div class="ml-4">
              <p class="text-sm font-medium text-secondary-600">This Month</p>
              <p class="text-2xl font-bold text-secondary-900">{{ thisMonthCount }}</p>
            </div>
          </div>
        </div>
      </div>

      <!-- Actions -->
      <div class="flex items-center justify-between mb-8">
        <h2 class="text-2xl font-bold text-secondary-900">Blog Posts</h2>
        <div class="flex space-x-4">
          <button
            @click="generateSite"
            :disabled="generating"
            class="px-6 py-3 bg-green-600 text-white font-medium rounded-lg hover:bg-green-700 transition-colors disabled:opacity-50"
          >
            <span v-if="!generating">Generate Static Site</span>
            <span v-else>Generating...</span>
          </button>
          <NuxtLink
            to="/admin/posts/new"
            class="px-6 py-3 bg-primary-600 text-white font-medium rounded-lg hover:bg-primary-700 transition-colors"
          >
            New Post
          </NuxtLink>
        </div>
      </div>

      <!-- Posts Table -->
      <div class="bg-white rounded-xl card-shadow overflow-hidden">
        <div class="overflow-x-auto">
          <table class="min-w-full divide-y divide-secondary-200">
            <thead class="bg-secondary-50">
              <tr>
                <th class="px-6 py-3 text-left text-xs font-medium text-secondary-500 uppercase tracking-wider">
                  Post
                </th>
                <th class="px-6 py-3 text-left text-xs font-medium text-secondary-500 uppercase tracking-wider">
                  Category
                </th>
                <th class="px-6 py-3 text-left text-xs font-medium text-secondary-500 uppercase tracking-wider">
                  Status
                </th>
                <th class="px-6 py-3 text-left text-xs font-medium text-secondary-500 uppercase tracking-wider">
                  Date
                </th>
                <th class="px-6 py-3 text-right text-xs font-medium text-secondary-500 uppercase tracking-wider">
                  Actions
                </th>
              </tr>
            </thead>
            <tbody class="bg-white divide-y divide-secondary-200">
              <tr v-for="post in posts" :key="post.id" class="hover:bg-secondary-50">
                <td class="px-6 py-4 whitespace-nowrap">
                  <div class="flex items-center">
                    <img
                      :src="post.image"
                      :alt="post.title"
                      class="w-12 h-12 rounded-lg object-cover"
                    />
                    <div class="ml-4">
                      <div class="text-sm font-medium text-secondary-900">{{ post.title }}</div>
                      <div class="text-sm text-secondary-500">{{ post.slug }}</div>
                    </div>
                  </div>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <span class="px-2 py-1 text-xs font-medium bg-primary-100 text-primary-800 rounded-full">
                    {{ post.category }}
                  </span>
                </td>
                <td class="px-6 py-4 whitespace-nowrap">
                  <span
                    :class="[
                      'px-2 py-1 text-xs font-medium rounded-full',
                      post.featured
                        ? 'bg-yellow-100 text-yellow-800'
                        : 'bg-gray-100 text-gray-800'
                    ]"
                  >
                    {{ post.featured ? 'Featured' : 'Published' }}
                  </span>
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-sm text-secondary-500">
                  {{ formatDate(post.created_at) }}
                </td>
                <td class="px-6 py-4 whitespace-nowrap text-right text-sm font-medium">
                  <div class="flex items-center justify-end space-x-2">
                    <NuxtLink
                      :to="`/blog/${post.slug}`"
                      class="text-primary-600 hover:text-primary-900"
                    >
                      View
                    </NuxtLink>
                    <NuxtLink
                      :to="`/admin/posts/${post.id}`"
                      class="text-secondary-600 hover:text-secondary-900"
                    >
                      Edit
                    </NuxtLink>
                    <button
                      @click="confirmDelete(post)"
                      class="text-red-600 hover:text-red-900"
                    >
                      Delete
                    </button>
                  </div>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>

    <!-- Delete Confirmation Modal -->
    <div
      v-if="showDeleteModal"
      class="fixed inset-0 bg-black bg-opacity-50 flex items-center justify-center z-50"
    >
      <div class="bg-white rounded-xl p-6 max-w-md w-full mx-4">
        <h3 class="text-lg font-bold text-secondary-900 mb-4">Delete Post</h3>
        <p class="text-secondary-600 mb-6">
          Are you sure you want to delete "{{ postToDelete?.title }}"? This action cannot be undone.
        </p>
        <div class="flex space-x-4">
          <button
            @click="showDeleteModal = false"
            class="flex-1 px-4 py-2 border border-secondary-300 text-secondary-700 rounded-lg hover:bg-secondary-50"
          >
            Cancel
          </button>
          <button
            @click="handleDelete"
            class="flex-1 px-4 py-2 bg-red-600 text-white rounded-lg hover:bg-red-700"
          >
            Delete
          </button>
        </div>
      </div>
    </div>
  </div>
</template>

<script setup>
import {
  DocumentTextIcon,
  StarIcon,
  FolderIcon,
  ClockIcon
} from '@heroicons/vue/24/outline'

definePageMeta({
  middleware: 'auth',
  layout: false
})

const { signOut } = useAuth()
const { posts, deletePost, fetchPosts } = useBlog()

const showDeleteModal = ref(false)
const postToDelete = ref(null)
const generating = ref(false)

const featuredCount = computed(() => posts.value.filter(post => post.featured).length)
const categoriesCount = computed(() => {
  const categories = new Set(posts.value.map(post => post.category))
  return categories.size
})
const thisMonthCount = computed(() => {
  const thisMonth = new Date().getMonth()
  const thisYear = new Date().getFullYear()
  return posts.value.filter(post => {
    const postDate = new Date(post.created_at)
    return postDate.getMonth() === thisMonth && postDate.getFullYear() === thisYear
  }).length
})

const formatDate = (date) => {
  return new Date(date).toLocaleDateString('en-US', {
    year: 'numeric',
    month: 'short',
    day: 'numeric'
  })
}

const handleSignOut = async () => {
  await signOut()
}

const confirmDelete = (post) => {
  postToDelete.value = post
  showDeleteModal.value = true
}

const handleDelete = async () => {
  if (postToDelete.value) {
    try {
      await deletePost(postToDelete.value.id)
      showDeleteModal.value = false
      postToDelete.value = null
    } catch (error) {
      console.error('Error deleting post:', error)
      alert('Error deleting post. Please try again.')
    }
  }
}

const generateSite = async () => {
  generating.value = true
  try {
    // In a real implementation, this would trigger a build process
    // For now, we'll simulate it
    await new Promise(resolve => setTimeout(resolve, 2000))
    alert('Static site generated successfully! Deploy the /dist folder to your hosting provider.')
  } catch (error) {
    alert('Error generating site. Please try again.')
  } finally {
    generating.value = false
  }
}

// Fetch posts on mount
onMounted(() => {
  fetchPosts()
})

useHead({
  title: 'Admin Dashboard - ModernBlog'
})
</script>