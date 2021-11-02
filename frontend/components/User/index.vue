<template>
  <div>
    Hi <b style="color:red">{{ getUserInfo.email }}</b>!
    <br /><br />
    <table class="table">
      <thead>
        <tr>
          <th scope="col">ID</th>
          <th scope="col">Email</th>
        </tr>
      </thead>
      <tbody>
        <tr>
          <td>{{ getUserInfo.id }}</td>
          <td>{{ getUserInfo.email }}</td>
        </tr>
      </tbody>
    </table>
  </div>
</template>

<script>
  export default {
    computed: {
      getUserInfo() {
        return this.$store.getters.getUserInfo;
      }
    }
  };
</script>
