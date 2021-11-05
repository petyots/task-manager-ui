<template>
  <div class='row'>
    <TasksList v-bind:freshly-created-task='freshlyCreatedTask'/>
    <TaskForm @taskCreated='taskCreatedListener'/>
  </div>
</template>

<script lang="ts">
import Vue from 'vue'
import TaskForm from '~/components/TaskForm.vue'
import TasksList from '~/components/TasksList.vue'

console.log()
export default Vue.extend({
  components: { TasksList, TaskForm },
  middleware: 'auth',
  data() {
    return {
      freshlyCreatedTask: null
    }
  },
  methods: {
    taskCreatedListener(task: any) {
      this.freshlyCreatedTask = task;
    }
  }
})
</script>
