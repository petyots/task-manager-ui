<template>
  <b-col md='12'>
    <b-navbar variant='faded' type='light'>
      <b-navbar-brand tag='h1' class='mb-0'>Task Manager</b-navbar-brand>
      <b-collapse id='nav-collapse' is-nav>
        <b-navbar-nav class='ml-auto' v-if='!$auth.loggedIn'>
          <b-nav-item to='login' :active='$route.name === "login"'>Login</b-nav-item>
          <b-nav-item to='register' :active='$route.name === "register"'>Register</b-nav-item>
        </b-navbar-nav>
        <b-navbar-nav class='ml-auto' v-if='$auth.loggedIn'>
          <b-nav-item-dropdown right :text="$auth.user.data.first_name +' ' +$auth.user.data.last_name">
            <b-dropdown-item @click.prevent='() => { $auth.logout()}'>Sign Out</b-dropdown-item>
          </b-nav-item-dropdown>
        </b-navbar-nav>
      </b-collapse>
    </b-navbar>
  </b-col>
</template>
<script>
export default {
  name: 'MyNavBar'
}
</script>
