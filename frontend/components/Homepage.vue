<!-- Please remove this file from your project -->
<template>
  <div>
    <h1>Cars</h1>
    <ul v-for="car in cars" :key="car.id">
      <li>{{ car.name }}</li>
    </ul>
  </div>
</template>


<script>
export default {
  async asyncData({ $axios }) {
    const cars = await $axios.$get("api/v1/cars");
    console.log(cars);
    return { cars };
  },
};
</script>