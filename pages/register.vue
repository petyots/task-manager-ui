<template>
  <b-row class='justify-content-center'>
    <b-col md='6'>
      <b-card class='rounded-0 mt-4'>
        <b-row>
          <b-col md='12'>
            <b-alert v-if='errors.general !== false' class='rounded-0' show variant='danger'>{{ errors.general }}
            </b-alert>
            <b-form @submit.prevent='register'>
              <GroupedFormElement
                field-id='first_name'
                field-type='text'
                :field-is-required='true'
                field-placeholder='Enter your first name'
                group-id='first_name_group'
                label='First Name'
                v-bind:error='errors.first_name'
                @inputChanged='handleInputChange'
              />
              <GroupedFormElement
                field-id='last_name'
                field-type='text'
                :field-is-required='true'
                field-placeholder='Enter your last name'
                group-id='last_name_group'
                label='Last Name'
                v-bind:error='errors.last_name'
                @inputChanged='handleInputChange'
              />
              <GroupedFormElement
                field-id='email'
                field-type='email'
                :field-is-required='true'
                field-placeholder='Enter your email'
                group-id='email_group'
                label='Email'
                v-bind:error='errors.email'
                @inputChanged='handleInputChange'
              />
              <GroupedFormElement
                field-id='password'
                field-type='password'
                :field-is-required='true'
                field-placeholder='Enter your password'
                group-id='password_group'
                label='Password'
                v-bind:error='errors.password'
                @inputChanged='handleInputChange'
              />
              <GroupedFormElement
                field-id='password_confirmation'
                field-type='password'
                :field-is-required='true'
                field-placeholder='Repeat the password'
                group-id='password_confirmed_group'
                label='Password Confirmation'
                v-bind:error='errors.password_cofirmation'
                @inputChanged='handleInputChange'
              />
              <b-button type='submit' class='rounded-0' variant='light'>Register</b-button>
            </b-form>
          </b-col>
        </b-row>
      </b-card>
    </b-col>
  </b-row>
</template>

<script lang='js'>
import GroupedFormElement from '../components/GroupedFormElement'

export default {
  components: { GroupedFormElement },
  data() {
    return {
      errors: {
        general: false,
        first_name: false,
        last_name: false,
        email: false,
        password: false,
        password_confirmation: false
      },
      first_name: null,
      last_name: null,
      email: null,
      password: null,
      password_confirmation: null
    }
  },
  name: 'login',
  layout: 'default',
  methods: {
    resetFields() {
      const fields = ['first_name', 'last_name', 'email', 'password', 'password_confirmation']
      for (const field of fields) {
        this.$set(this.errors, field, false)
      }
    },
    handleInputChange(event) {
      this.$set(this, event.field, event.value)
    },
    async register() {

      try {
        await this.$axios.post(this.$config.baseURL + '/auth/register', {
          first_name: this.first_name,
          last_name: this.last_name,
          email: this.email,
          password: this.password,
          password_confirmation: this.password_confirmation
        })

        await this.$router.push('/login')
      } catch (e) {
        const response = e.response
        if (response.status === 422) {
          const errors = response.data.data.errors
          for (const [field, error] of Object.entries(errors)) {
            this.$set(this.errors, field, error[0])
          }
          return
        }
        this.resetFields()
        this.$set(this.errors, 'general', response.data.message)
      }

    }
  }
}
</script>

<style scoped>

</style>
