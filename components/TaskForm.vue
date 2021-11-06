<template>
  <b-col md='3'>
    <b-form class='mt-4' @submit.prevent='createTask'>
      <GroupedFormElement field-id='name'
                          label='Task Name'
                          field-type='text'
                          :model='name'
                          :field-is-required='true'
                          v-bind:error='errors.name'
                          @inputChanged='handleInputChange'
                          group-id='task_name_group' />
      <b-button type='submit' class='rounded-0' variant='dark'>Create Task</b-button>
    </b-form>
  </b-col>
</template>

<script>
import GroupedFormElement from '~/components/GroupedFormElement'

export default {
  name: 'TaskForm',
  components: { GroupedFormElement },
  data() {
    return {
      errors: {
        general: false,
        name: false
      },
      name: null
    }
  },
  methods: {
    handleInputChange(payload) {
      this.$set(this, payload.field, payload.value)
    },
    async createTask() {
      const url = this.$config.apiBaseURL + '/task'
      const data = {
        name: this.name
      }
      const config = {
        headers: {
          'Authorization': 'Bearer ' + this.$auth.strategy.token.get()
        }
      }

      try {
        const response = await this.$axios.post(url, data, config)
        const task = response.data.data;

        this.$emit('taskCreated', task)
        this.name = null;
        this.errors.name = false;
      } catch (e) {
        const response = e.response
        if (response.status === 422) {
          const errors = response.data.data.errors;
          for (const [field, error] of Object.entries(errors)) {
            this.$set(this.errors, field, error[0])
          }
          this.$set(this.errors, 'general', false)
        } else {
          this.$set(this.errors, 'general', response.message)
        }
      }
    }
  }
}
</script>

<style scoped>

</style>
