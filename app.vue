<template>
  <div class="min-h-screen bg-gradient-to-br from-secondary-50 to-primary-50">
    <TheHeader />
    <main class="pt-20">
      <NuxtPage />
    </main>
    <TheFooter />
  </div>
</template>

<script setup>
useHead({
  htmlAttrs: {
    lang: 'en'
  }
})
</script>