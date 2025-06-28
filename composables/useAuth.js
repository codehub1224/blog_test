export const useAuth = () => {
  const { $supabase } = useNuxtApp()
  const user = ref(null)
  const loading = ref(true)

  const signIn = async (email, password) => {
    const { data, error } = await $supabase.auth.signInWithPassword({
      email,
      password
    })
    
    if (error) throw error
    user.value = data.user
    return data
  }

  const signOut = async () => {
    const { error } = await $supabase.auth.signOut()
    if (error) throw error
    user.value = null
    await navigateTo('/admin/login')
  }

  const getUser = async () => {
    const { data: { user: currentUser } } = await $supabase.auth.getUser()
    user.value = currentUser
    loading.value = false
    return currentUser
  }

  // Initialize auth state
  onMounted(() => {
    getUser()
    
    // Listen for auth changes
    $supabase.auth.onAuthStateChange((event, session) => {
      user.value = session?.user || null
      loading.value = false
    })
  })

  return {
    user: readonly(user),
    loading: readonly(loading),
    signIn,
    signOut,
    getUser
  }
}