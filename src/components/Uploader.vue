<template>
    <div>
        <v-text-field
          prepend-icon="video_library" single-line
          v-model="filename" :label="label"
          @click.native="onFocus"
          :disabled="disabled"
          :rules="[v => !!v || 'Video is required!']"
          color="cyan darken-2"
          ref="fileTextField"
          required
          ></v-text-field>
        <input type="file" :accept="accept" :multiple="false" :disabled="disabled"
               ref="fileInput" @change="onFileChange">
    </div>
</template>


<script>
    export default{
        props: {
            value: {
                type: [Array, String]
            },
            accept: {
                type: String,
                default: ".mp4, .ogg, .webm"
            },
            label: {
                type: String,
                default: "Select a video..."
            },
            required: {
                type: Boolean,
                default: false
            },
            disabled: {
                type: Boolean,
                default: false
            },
            multiple: {
                type: Boolean, // not yet possible because of data
                default: false
            }
        },
        data(){
            return {
                filename: ""
            };
        },
        watch: {
            value(v){
                this.filename = v;
            }
        },
        mounted() {
            this.filename = this.value;
        },

        methods: {
            onFocus(){
                if (!this.disabled) {
                    debugger;
                    this.$refs.fileInput.click();
                }
            },
            onFileChange($event){
                const files = $event.target.files || $event.dataTransfer.files;
                if (files) {
                    if (files.length > 0) {
                        this.filename = [...files].map(file => file.name).join(', ');
                    } else {
                        this.filename = null;
                    }
                } else {
                    this.filename = $event.target.value.split('\\').pop();
                }
                this.$emit('fileData', files);
            }
        }
    };
</script>

<style scoped>
    input[type=file] {
        position: absolute;
        left: -99999px;
    }
</style>
