<template>
  <div class="max-w-4xl mx-auto px-4 sm:px-6 lg:px-8 py-16">
    <div class="animate-fade-in">
      <!-- Header -->
      <div class="text-center mb-16">
        <h1 class="text-4xl md:text-5xl font-bold text-secondary-900 mb-6">
          About <span class="gradient-text">ModernBlog</span>
        </h1>
        <p class="text-xl text-secondary-600 max-w-2xl mx-auto">
          We're passionate about sharing knowledge and insights about modern web development, design, and technology.
        </p>
      </div>

      <!-- Mission -->
      <section class="mb-16">
        <div class="bg-white rounded-2xl card-shadow p-8 md:p-12">
          <h2 class="text-3xl font-bold text-secondary-900 mb-6">Our Mission</h2>
          <p class="text-lg text-secondary-700 leading-relaxed mb-6">
            ModernBlog was created to bridge the gap between complex technical concepts and practical implementation. 
            We believe that everyone should have access to high-quality, up-to-date information about web development 
            and design, regardless of their experience level.
          </p>
          <p class="text-lg text-secondary-700 leading-relaxed">
            Our team of experienced developers and designers work together to create content that's both informative 
            and actionable, helping you stay ahead in the rapidly evolving world of technology.
          </p>
        </div>
      </section>

      <!-- Team -->
      <section class="mb-16">
        <h2 class="text-3xl font-bold text-secondary-900 mb-8 text-center">Meet Our Team</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 lg:grid-cols-3 gap-8">
          <div
            v-for="member in team"
            :key="member.id"
            class="bg-white rounded-xl card-shadow hover:card-shadow-hover transition-all duration-300 p-6 text-center group"
          >
            <img
              :src="member.avatar"
              :alt="member.name"
              class="w-24 h-24 rounded-full mx-auto mb-4 group-hover:scale-105 transition-transform duration-300"
            />
            <h3 class="text-xl font-bold text-secondary-900 mb-2">{{ member.name }}</h3>
            <p class="text-primary-600 font-medium mb-3">{{ member.role }}</p>
            <p class="text-secondary-600">{{ member.bio }}</p>
          </div>
        </div>
      </section>

      <!-- Values -->
      <section class="mb-16">
        <h2 class="text-3xl font-bold text-secondary-900 mb-8 text-center">Our Values</h2>
        <div class="grid grid-cols-1 md:grid-cols-2 gap-8">
          <div
            v-for="value in values"
            :key="value.id"
            class="bg-white rounded-xl card-shadow p-8 hover:card-shadow-hover transition-all duration-300"
          >
            <div class="w-12 h-12 bg-gradient-to-r from-primary-600 to-accent-600 rounded-lg flex items-center justify-center mb-4">
              <component :is="value.icon" class="w-6 h-6 text-white" />
            </div>
            <h3 class="text-xl font-bold text-secondary-900 mb-3">{{ value.title }}</h3>
            <p class="text-secondary-700">{{ value.description }}</p>
          </div>
        </div>
      </section>

      <!-- Contact -->
      <section class="text-center">
        <div class="bg-gradient-to-r from-primary-600 to-accent-600 rounded-2xl p-8 md:p-12 text-white">
          <h2 class="text-3xl font-bold mb-4">Get In Touch</h2>
          <p class="text-lg mb-8 opacity-90">
            Have a question or want to contribute? We'd love to hear from you!
          </p>
          <NuxtLink
            to="/contact"
            class="inline-flex items-center px-8 py-4 bg-white text-primary-600 font-bold rounded-lg hover:bg-gray-100 transition-colors"
          >
            Contact Us
          </NuxtLink>
        </div>
      </section>
    </div>
  </div>
</template>

<script setup>
import { 
  AcademicCapIcon, 
  LightBulbIcon, 
  UsersIcon, 
  HeartIcon 
} from '@heroicons/vue/24/outline'

const team = [
  {
    id: 1,
    name: 'Sarah Johnson',
    role: 'Lead Developer',
    bio: 'Full-stack developer with expertise in Vue.js and Node.js',
    avatar: 'https://images.pexels.com/photos/774909/pexels-photo-774909.jpeg?auto=compress&cs=tinysrgb&w=200'
  },
  {
    id: 2,
    name: 'Michael Chen',
    role: 'UI/UX Designer',
    bio: 'Passionate about creating beautiful and intuitive user experiences',
    avatar: 'https://images.pexels.com/photos/1222271/pexels-photo-1222271.jpeg?auto=compress&cs=tinysrgb&w=200'
  },
  {
    id: 3,
    name: 'David Rodriguez',
    role: 'Senior Architect',
    bio: 'Software architect with 10+ years of experience in scalable systems',
    avatar: 'https://images.pexels.com/photos/1043471/pexels-photo-1043471.jpeg?auto=compress&cs=tinysrgb&w=200'
  }
]

const values = [
  {
    id: 1,
    title: 'Quality Content',
    description: 'We prioritize creating high-quality, well-researched content that provides real value to our readers.',
    icon: AcademicCapIcon
  },
  {
    id: 2,
    title: 'Innovation',
    description: 'We stay at the forefront of technology trends and share the latest innovations in web development.',
    icon: LightBulbIcon
  },
  {
    id: 3,
    title: 'Community',
    description: 'We believe in building a strong community of developers who learn and grow together.',
    icon: UsersIcon
  },
  {
    id: 4,
    title: 'Accessibility',
    description: 'We make sure our content is accessible to everyone, regardless of their technical background.',
    icon: HeartIcon
  }
]

useHead({
  title: 'About Us - ModernBlog',
  meta: [
    {
      name: 'description',
      content: 'Learn about ModernBlog, our mission, team, and commitment to sharing knowledge about web development and design.'
    }
  ]
})
</script>