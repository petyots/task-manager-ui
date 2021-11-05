<template>
  <b-form-group
    :id='groupId'
    :label='label'
    :label-for='fieldId'
  >
    <b-form-input
      class='rounded-0'
      :id=fieldId
      v-model='modelH'
      @input='handleInput'
      :type='fieldType'
      :placeholder='fieldPlaceholder'
      :required='fieldIsRequired'
    ></b-form-input>
    <b-form-invalid-feedback v-if='error'
                             :state='false'>
      {{ error }}
    </b-form-invalid-feedback>
  </b-form-group>
</template>

<script>
export default {
  name: 'grouped-form-element',
  data() {
    return {
      modelH:null
    }
  },
  watch: {
    model: function (val) {
      this.modelH = val
    }
  },
  props: {
    model: {
      required: false,
    },
    groupId: {
      required: true,
      type: String
    },
    error: {
      required: false,
      default: false,
    },
    fieldId: {
      required: true,
      type: String
    },
    fieldType: {
      required: true,
      type: String
    },
    fieldPlaceholder: {
      required: false,
      type: String
    },
    label: {
      required: true,
      type: String
    },
    fieldIsRequired: {
      required: false,
      type: Boolean,
      default: false
    }
  },
  methods: {
   handleInput(ev) {
     this.$emit('inputChanged', {
       field: this.fieldId,
       value: ev
     })
   }
  }
}
</script>

<style scoped>

</style>
