<template>
  <div style="display: flex">
    <div>
      <h1>Cars</h1>
      <list-car :cars="cars" />
    </div>

    <div>
      <h1>Favorites</h1>
      <list-car :cars="favorite_cars" />
    </div>
  </div>
</template>


<script>
  export default {
    props: [ 'cars', 'favorite_cars' ],
  }
</script>