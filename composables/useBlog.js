export const useBlog = () => {
  const { $supabase } = useNuxtApp()

  // Fallback data for development/demo
  const fallbackPosts = [
    {
      id: 1,
      slug: 'introduction-to-nuxt-3',
      title: 'Introduction to Nuxt 3: The Future of Vue.js Development',
      excerpt: 'Discover the power of Nuxt 3 and how it revolutionizes Vue.js development with its new architecture, improved performance, and developer experience.',
      content: `# Introduction to Nuxt 3

Nuxt 3 represents a significant leap forward in Vue.js development, offering a modern, performant, and developer-friendly framework for building web applications.

## Key Features

### Auto-imports
Nuxt 3 automatically imports Vue components, composables, and utilities, reducing boilerplate code and improving developer experience.

### Server-Side Rendering
Built-in SSR support provides better SEO and faster initial page loads.

### TypeScript Support
First-class TypeScript support with zero configuration required.

## Getting Started

\`\`\`bash
npx nuxi@latest init my-app
cd my-app
npm install
npm run dev
\`\`\`

## Conclusion

Nuxt 3 is a powerful framework that makes Vue.js development more enjoyable and productive.`,
      category: 'Technology',
      tags: ['Vue.js', 'Nuxt', 'JavaScript', 'Web Development'],
      created_at: '2024-01-15',
      read_time: 8,
      image: 'https://images.pexels.com/photos/11035380/pexels-photo-11035380.jpeg?auto=compress&cs=tinysrgb&w=800',
      author_name: 'Sarah Johnson',
      author_avatar: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=100',
      author_bio: 'Full-stack developer with expertise in Vue.js and Node.js',
      featured: true
    }
  ]

  const posts = ref([])
  const loading = ref(false)
  const error = ref(null)

  const categories = ref([
    'All',
    'Technology',
    'Design',
    'Business',
    'Lifestyle'
  ])

  const fetchPosts = async () => {
    loading.value = true
    error.value = null
    
    try {
      const { data, error: fetchError } = await $supabase
        .from('posts')
        .select('*')
        .order('created_at', { ascending: false })

      if (fetchError) {
        console.warn('Supabase fetch error, using fallback data:', fetchError)
        posts.value = fallbackPosts
      } else {
        posts.value = data || fallbackPosts
      }
    } catch (err) {
      console.warn('Error fetching posts, using fallback data:', err)
      posts.value = fallbackPosts
      error.value = err
    } finally {
      loading.value = false
    }
  }

  const createPost = async (postData) => {
    const { data, error } = await $supabase
      .from('posts')
      .insert([postData])
      .select()
      .single()

    if (error) throw error
    
    // Refresh posts
    await fetchPosts()
    return data
  }

  const updatePost = async (id, postData) => {
    const { data, error } = await $supabase
      .from('posts')
      .update(postData)
      .eq('id', id)
      .select()
      .single()

    if (error) throw error
    
    // Refresh posts
    await fetchPosts()
    return data
  }

  const deletePost = async (id) => {
    const { error } = await $supabase
      .from('posts')
      .delete()
      .eq('id', id)

    if (error) throw error
    
    // Refresh posts
    await fetchPosts()
  }

  const getFeaturedPosts = () => {
    return posts.value.filter(post => post.featured)
  }

  const getRecentPosts = (limit = 6) => {
    return posts.value
      .sort((a, b) => new Date(b.created_at) - new Date(a.created_at))
      .slice(0, limit)
  }

  const getPostBySlug = (slug) => {
    return posts.value.find(post => post.slug === slug)
  }

  const getPostsByCategory = (category) => {
    if (category === 'All') return posts.value
    return posts.value.filter(post => post.category === category)
  }

  const searchPosts = (query) => {
    if (!query) return posts.value
    return posts.value.filter(post => 
      post.title.toLowerCase().includes(query.toLowerCase()) ||
      post.excerpt.toLowerCase().includes(query.toLowerCase()) ||
      (post.tags && post.tags.some(tag => tag.toLowerCase().includes(query.toLowerCase())))
    )
  }

  // Auto-fetch posts on composable initialization
  onMounted(() => {
    fetchPosts()
  })

  return {
    posts: readonly(posts),
    loading: readonly(loading),
    error: readonly(error),
    categories,
    fetchPosts,
    createPost,
    updatePost,
    deletePost,
    getFeaturedPosts,
    getRecentPosts,
    getPostBySlug,
    getPostsByCategory,
    searchPosts
  }
}