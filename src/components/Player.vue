<template>
  <div>
    <v-container v-show="!ready" class="videoContainer" fill-height>
        <v-alert color="error" icon="warning" value="true" class="seedVideo" transition="scale-transition" v-model="notFoundVideo">
          This video is not found, if you have the same video, you can bring it back up by seeding it now.
        </v-alert>
        <v-bottom-sheet v-model="sheet">
          <v-btn slot="activator" flat class="newSeedBtn" v-show="notFoundVideo">Seed Video</v-btn>
          <v-list>
            <v-subheader>Upload the video</v-subheader>
            <v-container>
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
              <v-alert outline color="error" icon="warning" value="true" v-model="diffVideo">
                Seeding failed. The video you selected is different from the video you're trying to seed.
              </v-alert>
            </v-container>
          </v-list>
        </v-bottom-sheet>
      <Loader fill-height></Loader>
    </v-container>
    <video v-show="ready" width="100%" controls autoplay></video>
  </div>
</template>

<script>
  import WebTorrent from "../js/webtorrent.min";

  export default {
    props: {
      magnet: '',
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
    data () {
      return {
        ready:false,
        invalid: false, //TODO: Add invalid file handling
        filename: "",
        input:"",
        diffVideo: true, // Show alert on video not found
        notFoundVideo: true // Show Seed button on video not found
      }
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
            //DO SOMETHING
            //this.$emit('fileData', files);
        }
    },
    created () {
      var self = this;
      var client = new WebTorrent();
      client.add(this.magnet, function (torrent) {
        self.ready = true;
        torrent.files.forEach(function (file) {
          if(file.name.endsWith("webm") || file.name.endsWith("mp4") || file.name.endsWith("ogg")){
            file.renderTo('video')
          }else{
            self.invalid = true;
          }
        })
      })
    }
  }
</script>


<style scoped>
.videoContainer {
  min-height: 400px;
}
.layout.row.wrap.align-center.fill-height {
  margin-top: -4px !important;
}
.seedVideo {
  background-color: #db4c4c !important;
  margin: 0px;
  width: 80%;
  position: absolute;
  left: 0px;
  top: 0px;
}
.newSeedBtn {
  background-color: #ce4848 !important;
  color: white;
  border-width: 4px 0 0;
  height: 60px;
  margin: 0px;
  width: 20%;
  position: absolute;
  right: 0px;
  top: 0px;
  border-radius: 0px;
  border-style: solid;
  border-color: rgba(0,0,0,.12)!important;
}
input[type=file] {
    position: absolute;
    left: -99999px;
}
</style>
