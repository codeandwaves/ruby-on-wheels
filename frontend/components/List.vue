<template>
  <div>
  <li v-for="car in cars" :key="car.id">
   {{ car.name }} - {{ car.brand }}
  </li>
  </div>
</template>

<script>
  export default {
    props: {
      name: String,
      id: String,
      brand: String,
      cars: Array
    }
  }
</script>