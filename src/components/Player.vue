<template>
  <div>
    <v-container v-show="!ready" class="videoContainer" fill-height>
      <Loader fill-height></Loader>
    </v-container>
    <video v-show="ready" width="100%" controls autoplay></video>
  </div>
</template>

<script>
  import WebTorrent from "../js/webtorrent.min";

  export default {
    props:['magnet'],
    data () {
      return {
        ready:false,
        invalid: false //TODO: Add invalid file handling
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
</style>
