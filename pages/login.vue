<template>
  <b-row class='justify-content-center'>
    <b-col md='6'>
      <b-card class='rounded-0 mt-4'>
        <b-row>
          <b-col md='12'>
            <b-alert v-if='errors.general !== false' class='rounded-0' show variant='danger'>{{ errors.general }}
            </b-alert>

            <b-form @submit.prevent='login'>
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
              <b-button type='submit' class='rounded-0' variant='light'>Login</b-button>
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
        email: false,
        password: false
      },
      email: 't@t.com',
      password: '123'
    }
  },
  name: 'login',
  layout: 'default',
  methods: {
    resetFields() {
      const fields = ['email', 'password']
      for (const field of fields) {
        this.$set(this.errors, field, false)
      }
    },
    handleInputChange(event) {
      this.$set(this, event.field, event.value)
    },
    async login() {
      try {
        await this.$auth.loginWith('jwt', {
          data: {
            email: this.email,
            password: this.password
          }
        })
      } catch (e) {
        const response = e.response
        if (response.status === 422) {
          const errors = response.data.data.errors
          for (const [field, error] of Object.entries(errors)) {
            this.$set(this.errors, field, error[0])
          }
          this.$set(this.errors, 'general', false)
        } else {
          this.resetFields()
          this.$set(this.errors, 'general', response.data.message)
        }
      }
    }
  }
}
</script>

<style scoped>

</style>
