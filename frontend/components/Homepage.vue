<template>
  <div>
    <ul class="list-of-items">
      <list
        v-for="car in cars"
        :name="car.name"
        :brand="car.brand"
        :key="car.id"
      />
    </ul>
  </div>
</template>


<script>
  import List from '~/components/List.vue'

  export default {
    components: {
      List
    },

    async asyncData ({ $axios }) {
      const cars = await $axios.$get('http://localhost:5000/api/v1/cars')
      return {
        cars
      }
    }
  };
</script>