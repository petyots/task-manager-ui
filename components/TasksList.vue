<template>
<b-col cols='9' class='mt-4'>
  <b-table
    caption-top
    :borderless="true"
    :fields='fields'
    :items='items'
    :busy="isBusy"
  >
    <template #empty>
      No Tasks
    </template>
    <template #table-busy>
      <div class="text-center text-danger my-2">
        <b-spinner class="align-middle"></b-spinner>
        <strong>Loading...</strong>
      </div>
    </template>
    <template #cell(actions)="row">
      <b-button v-if='row.item.status === "WAITING"' variant="primary" size="sm" class="mr-1" @click='changeTaskStatus(row, "DONE")'>
        Done
      </b-button>
      <b-button v-else-if='row.item.status === "DONE"' variant="dark" size="sm" class="mr-1" @click='changeTaskStatus(row, "WAITING")'>
        Not Done
      </b-button>
    </template>
  </b-table>
  <b-pagination
    class='pt-2'
    v-model="page"
    :key='totalResults'
    :total-rows="totalResults"
    :hide-ellipsis='true'
    :per-page="perPage"
    @change='(clickedPage) => this.page = clickedPage'
    align='center'
  />
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
      isBusy: false,
      totalResults: null,
      page: 1,
      perPage: 10,
      paginationResponse: null,
      fields: [
        { key: 'name', label: 'Task Name' },
        { key: 'status', label: 'Done', formatter: (value, key, item) => {
          return value === 'DONE' ? 'Yes' : 'No'
          }},
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
    },
    page: function(val) {
      this.fetchTasks()
    }
  },
  methods: {
    async changeTaskStatus(row, toStatus) {
      try {
        const url = this.$config.apiBaseURL + '/task/change-status/' + row.item.uuid;

        await this.$axios.post(url, {status: toStatus}, {
          headers: {
            'Authorization': 'Bearer ' + this.$auth.strategy.token.get()
          }
        })
        row.item.status = toStatus;
      } catch (e) {
        console.log(e)
      }
    },
    changePage(data) {
      console.log(data)
    },
    handleTaskCreated(task) {
      this.items.unshift(task);
      if (this.page === 1) {
        this.fetchTasks()
      }
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
        this.paginationResponse = {meta: response.data.meta, links: response.data.links}
      } catch (e) {
        console.log(e)
      }
      this.isBusy = false;
    }
  }
}
</script>

<style scoped>

</style>
