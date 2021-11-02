<template>
  <div>
    <homepage :cars="cars" />
  </div>
</template>

<script>
  export default {
    async asyncData({ $axios, $config }) {
      const cars = await $axios.$get(`/api/v1/cars`)
      return { cars }
    }
  }
</script>
