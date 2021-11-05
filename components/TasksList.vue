<template>
<b-col cols='9' class='mt-4'>
  <b-table
    :borderless="true"
    :fields='fields'
    :items='items'
  ></b-table>
  <b-pagination
    v-model="page"
    :total-rows="rows"
    :per-page="perPage"
    aria-controls="my-table"
  ></b-pagination>
</b-col>
</template>

<script>
export default {
  name: 'TasksList',
  async mounted() {
    await this.fetchTasks()
  },
  data() {
    return {
      totalResults: null,
      page: 1,
      perPage: 10,
      fields: [
        { key: 'name', label: 'Task Name' },
        { key: 'status', label: 'Done'},
        { key: 'modified_at', label: 'Modified'},
        'Actions'
      ],
      items: []
    }
  },
  props: {
    freshlyCreatedTask: {
      required: false,
      type: Object|null
    }
  },
  watch: {
    freshlyCreatedTask: function(newVal) {
      this.handleTaskCreated(newVal);
    }
  },
  methods: {
    handleTaskCreated(task) {
      this.items.unshift(task);
      this.totalResults += 1;
    },
    async fetchTasks() {

      const url = this.$config.apiBaseURL + '/task';
      const query = new URLSearchParams();
      query.append('page', this.page)
      query.append('perPage', this.perPage)

      try {
        const response = await this.$axios.get(url + '?' + query.toString(), {
          headers: {
            'Authorization': 'Bearer ' + this.$auth.strategy.token.get()
          }
        })
        this.$set(this, 'items', response.data.data.tasks)
        this.$set(this, 'totalResults', response.data.meta.total)
      } catch (e) {
        console.log(e)
      }
    }
  }
}
</script>

<style scoped>

</style>
