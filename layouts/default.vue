<template>
  <div>
    <b-container>
      <b-row class='justify-content-center'>
        <MyNavBar />
        <b-col md='12' class='mt-5'>
          <Nuxt/>
        </b-col>
      </b-row>
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

