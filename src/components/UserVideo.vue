<template>
        <v-flex xs3 key="Favorite road trips">
          <a v-if="video" v-bind:href="url">
            <v-card>
              <v-card-media v-if="!videoData" src="/dist/video-thumbnail.png" height="170px">
              </v-card-media>
              <v-card-media v-if="videoData" height="170px">
                <video width="100%" autoplay loop muted>
                  <source v-bind:src="videoData">
                </video>
              </v-card-media>
              <v-card-title primary-title style="padding: 15px; padding-top: 10px">
                <div>
                  <h3 class="headline">{{video.title}}</h3>
                  <div class="uploader"><v-icon class="date-icon">person</v-icon>{{name}}</div>
                  <div class="date"><v-icon class="date-icon">access_time</v-icon>{{date}}</div>
                </div>
              </v-card-title>
            </v-card>
          </a>
        </v-flex>
</template>

<script>
  import moment from "moment";
  export default {
    props:{
      video:{
        default:function(){
          return {}
        },
        type: Object
      }
    },
    data () {
      return {
        name:"",
        url:"",
        date:"",
        videoData:""
      }
    },
    created () {
        this.url = "/#/v/" + this.video.id;
        var self = this;
        //Get video data
        Decentube.methods.creators(this.video.creator).call(function(error, result){
          if(!error && result.magnet != ""){
              self.name = result.name;
              self.date = moment.unix(self.video.date).startOf('second').fromNow();
              //Get preview
              if(self.$root.client.get(self.video.magnet)){
                self.$root.client.remove(self.video.magnet);
              }
              self.$root.client.add(self.video.magnet, function (torrent) {
                torrent.files.forEach(function (file) {
                  if(file.name.endsWith("webm") || file.name.endsWith("mp4") || file.name.endsWith("ogg")){
                    file.getBlobURL(function (err, url) {
                      self.videoData = url;
                    })
                  }
                })
              })
            }
        })
    },
    beforeDestroy () {
      this.$root.client.remove(this.video.magnet);
    },
    watch: {
      '$route' (to, from) {
        this.$root.client.remove(this.video.magnet);
      }
    }
  }
</script>

<style scoped>
    a:link    {
      /* Applies to all unvisited links */
      text-decoration:  none;
      background-color: #ddd;
      color:            blue;
      }
    a:visited {
      /* Applies to all visited links */
      text-decoration:  none;
      background-color: #ddd;
      color:            #f0f;
      }
    a:hover   {
      /* Applies to links under the pointer */
      text-decoration:  underline;
      background-color: blue;
      color:            #fff;
      }
    a:active  {
      /* Applies to activated links */
      text-decoration:  underline;
      background-color: black;
      color: white;
      }
    .headline {
      font-size: 18px !important;
      font-weight: 400;
      margin: 0;
      padding: 0;
    }
    .uploader {
      font-size: 12px !important;
      margin: 0;
      padding: 0;
      text-align: left;
    }
    .date {
      font-size: 12px !important;
      margin: 0;
      padding: 0;
      text-align: left;
    }
    .date-icon {
      color: black;
      font-size: 17px;
      vertical-align: center;
      line-height: 17px;
      margin-right: 3px;
    }
</style>
