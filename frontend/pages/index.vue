<template>
  <div>
    <homepage :cars="cars" :favorite_cars="favorite_cars" />
  </div>
</template>

<script>
  export default {
    async asyncData ({ $axios }) {
      const [cars, favorite_cars] = await Promise.all([
        $axios.get('/cars'),
        $axios.get('/cars/favorites'),
      ])

      return {
        cars: cars.data,
        favorite_cars: favorite_cars.data,
      }
    }
  }
</script>
