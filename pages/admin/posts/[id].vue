<template>
  <div class="min-h-screen bg-secondary-50">
    <!-- Admin Header -->
    <header class="bg-white border-b border-secondary-200">
      <div class="max-w-7xl mx-auto px-4 sm:px-6 lg:px-8">
        <div class="flex items-center justify-between h-16">
          <div class="flex items-center space-x-4">
            <NuxtLink to="/admin" class="text-secondary-600 hover:text-primary-600">
              ← Back to Dashboard
            </NuxtLink>
            <h1 class="text-xl font-bold text-secondary-900">Edit Post</h1>
          </div>
          
          <div class="flex items-center space-x-4">
            <button
              @click="saveDraft"
              :disabled="saving"
              class="px-4 py-2 border border-secondary-300 text-secondary-700 rounded-lg hover:bg-secondary-50 disabled:opacity-50"
            >
              Save Draft
            </button>
            <button
              @click="updatePost"
              :disabled="saving || !isFormValid"
              class="px-6 py-2 bg-primary-600 text-white rounded-lg hover:bg-primary-700 disabled:opacity-50"
            >
              {{ saving ? 'Updating...' : 'Update' }}
            </button>
          </div>
        </div>
      </div>
    </header>

    <div v-if="post" class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-8">
      <form @submit.prevent="updatePost" class="space-y-8">
        <!-- Basic Information -->
        <div class="bg-white rounded-xl card-shadow p-6">
          <h2 class="text-lg font-bold text-secondary-900 mb-6">Basic Information</h2>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div class="md:col-span-2">
              <label for="title" class="block text-sm font-medium text-secondary-700 mb-2">
                Title *
              </label>
              <input
                id="title"
                v-model="form.title"
                type="text"
                required
                class="w-full px-4 py-3 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
                placeholder="Enter post title"
              />
            </div>

            <div class="md:col-span-2">
              <label for="slug" class="block text-sm font-medium text-secondary-700 mb-2">
                Slug *
              </label>
              <input
                id="slug"
                v-model="form.slug"
                type="text"
                required
                class="w-full px-4 py-3 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
                placeholder="post-url-slug"
              />
            </div>

            <div>
              <label for="category" class="block text-sm font-medium text-secondary-700 mb-2">
                Category *
              </label>
              <select
                id="category"
                v-model="form.category"
                required
                class="w-full px-4 py-3 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
              >
                <option value="">Select category</option>
                <option value="Technology">Technology</option>
                <option value="Design">Design</option>
                <option value="Business">Business</option>
                <option value="Lifestyle">Lifestyle</option>
              </select>
            </div>

            <div>
              <label for="readTime" class="block text-sm font-medium text-secondary-700 mb-2">
                Read Time (minutes)
              </label>
              <input
                id="readTime"
                v-model.number="form.read_time"
                type="number"
                min="1"
                class="w-full px-4 py-3 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
                placeholder="5"
              />
            </div>

            <div class="md:col-span-2">
              <label for="excerpt" class="block text-sm font-medium text-secondary-700 mb-2">
                Excerpt *
              </label>
              <textarea
                id="excerpt"
                v-model="form.excerpt"
                rows="3"
                required
                class="w-full px-4 py-3 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent resize-none"
                placeholder="Brief description of the post"
              ></textarea>
            </div>

            <div class="md:col-span-2">
              <label for="image" class="block text-sm font-medium text-secondary-700 mb-2">
                Featured Image URL
              </label>
              <input
                id="image"
                v-model="form.image"
                type="url"
                class="w-full px-4 py-3 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
                placeholder="https://example.com/image.jpg"
              />
            </div>

            <div class="md:col-span-2">
              <label for="tags" class="block text-sm font-medium text-secondary-700 mb-2">
                Tags (comma-separated)
              </label>
              <input
                id="tags"
                v-model="tagsInput"
                type="text"
                class="w-full px-4 py-3 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
                placeholder="vue, javascript, web development"
              />
            </div>

            <div class="md:col-span-2">
              <label class="flex items-center">
                <input
                  v-model="form.featured"
                  type="checkbox"
                  class="rounded border-secondary-300 text-primary-600 focus:ring-primary-500"
                />
                <span class="ml-2 text-sm text-secondary-700">Featured post</span>
              </label>
            </div>
          </div>
        </div>

        <!-- Author Information -->
        <div class="bg-white rounded-xl card-shadow p-6">
          <h2 class="text-lg font-bold text-secondary-900 mb-6">Author Information</h2>
          
          <div class="grid grid-cols-1 md:grid-cols-2 gap-6">
            <div>
              <label for="authorName" class="block text-sm font-medium text-secondary-700 mb-2">
                Author Name *
              </label>
              <input
                id="authorName"
                v-model="form.author_name"
                type="text"
                required
                class="w-full px-4 py-3 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
                placeholder="John Doe"
              />
            </div>

            <div>
              <label for="authorAvatar" class="block text-sm font-medium text-secondary-700 mb-2">
                Author Avatar URL
              </label>
              <input
                id="authorAvatar"
                v-model="form.author_avatar"
                type="url"
                class="w-full px-4 py-3 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent"
                placeholder="https://example.com/avatar.jpg"
              />
            </div>

            <div class="md:col-span-2">
              <label for="authorBio" class="block text-sm font-medium text-secondary-700 mb-2">
                Author Bio
              </label>
              <textarea
                id="authorBio"
                v-model="form.author_bio"
                rows="2"
                class="w-full px-4 py-3 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent resize-none"
                placeholder="Brief bio about the author"
              ></textarea>
            </div>
          </div>
        </div>

        <!-- Content -->
        <div class="bg-white rounded-xl card-shadow p-6">
          <h2 class="text-lg font-bold text-secondary-900 mb-6">Content</h2>
          
          <div>
            <label for="content" class="block text-sm font-medium text-secondary-700 mb-2">
              Content (Markdown) *
            </label>
            <textarea
              id="content"
              v-model="form.content"
              rows="20"
              required
              class="w-full px-4 py-3 border border-secondary-200 rounded-lg focus:ring-2 focus:ring-primary-500 focus:border-transparent resize-none font-mono text-sm"
              placeholder="# Your Post Title

Write your content in Markdown format..."
            ></textarea>
            <p class="text-sm text-secondary-500 mt-2">
              Use Markdown syntax for formatting. Supports headings, lists, code blocks, and more.
            </p>
          </div>
        </div>
      </form>
    </div>

    <div v-else class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-16 text-center">
      <p class="text-secondary-600">Loading post...</p>
    </div>
  </div>
</template>

<script setup>
definePageMeta({
  middleware: 'auth',
  layout: false
})

const route = useRoute()
const { posts, updatePost: updatePostData } = useBlog()

const post = computed(() => posts.value.find(p => p.id == route.params.id))

const form = ref({
  title: '',
  slug: '',
  excerpt: '',
  content: '',
  category: '',
  tags: [],
  image: '',
  author_name: '',
  author_avatar: '',
  author_bio: '',
  read_time: 5,
  featured: false
})

const tagsInput = ref('')
const saving = ref(false)

const isFormValid = computed(() => {
  return form.value.title && 
         form.value.slug && 
         form.value.excerpt && 
         form.value.content && 
         form.value.category && 
         form.value.author_name
})

// Load post data when available
watch(post, (newPost) => {
  if (newPost) {
    form.value = { ...newPost }
    tagsInput.value = Array.isArray(newPost.tags) ? newPost.tags.join(', ') : ''
  }
}, { immediate: true })

const saveDraft = async () => {
  console.log('Saving draft...', form.value)
}

const updatePost = async () => {
  if (!isFormValid.value || !post.value) return

  saving.value = true

  try {
    // Process tags
    form.value.tags = tagsInput.value
      .split(',')
      .map(tag => tag.trim())
      .filter(tag => tag.length > 0)

    await updatePostData(post.value.id, form.value)
    await navigateTo('/admin')
  } catch (error) {
    console.error('Error updating post:', error)
    alert('Error updating post. Please try again.')
  } finally {
    saving.value = false
  }
}

useHead({
  title: 'Edit Post - Admin'
})
</script>