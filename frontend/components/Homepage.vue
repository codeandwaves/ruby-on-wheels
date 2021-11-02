<template>
  <div style="display: flex">
    <div>
      <h1>Cars</h1>
      <card-car :cars="cars" />
    </div>

    <div>
      <h1>Favorites</h1>
      <card-car :cars="cars" />
    </div>
  </div>
</template>


<script>
  export default {
    props: [ 'cars' ],
  }
</script>