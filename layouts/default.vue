<template>
  <div>
    <b-container>
      <b-row class='justify-content-center'>
        <MyNavBar />
      </b-row>
      <Nuxt />
    </b-container>
  </div>
</template>

<script>
import MyNavBar from '../components/MyNavBar'

export default {
  name: 'default',
  components: { MyNavBar }
}
</script>

<style>
body {
  background-color: #f8f9fa;
}
</style>

