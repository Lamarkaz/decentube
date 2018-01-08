<template>
  <div>
    <v-dialog v-model="dialog" fullscreen transition="dialog-bottom-transition" :overlay="false">
      <v-toolbar dark color="cyan darken-3">
          <v-btn icon @click.native="dialog = false" dark>
            <v-icon>close</v-icon>
          </v-btn>
          <v-toolbar-title>Upload a new video</v-toolbar-title>
          <v-spacer></v-spacer>
          <v-toolbar-items>
          </v-toolbar-items>
        </v-toolbar>
      <v-card>
        <v-flex v-if="ready" xs8 offset-xs2 style="padding-top: 50px">
          <v-alert v-show="success" outline color="success" icon="check_circle" :value="true">
            Done! Your video can be accessible <a v-bind:href="url" target="_blank">here</a>. But please keep the current page open to keep seeding your video.
          </v-alert>
          <v-alert v-show="error" outline color="error" icon="warning" :value="true">
            Error! Something went wrong. Please try again.
          </v-alert>
          <v-form v-model="valid" ref="form" lazy-validation>
            <Uploader v-on:fileData="fileAdded"></Uploader>
            <v-text-field
              v-show="magnet"
              v-model="title"
              label="Video title"
              :rules="[v => !!v || 'Video name is required!']"
              color="cyan darken-2"
              prepend-icon="title"
              required
            ></v-text-field>
            <v-text-field
              v-show="magnet"
              v-model="desc"
              label="Description"
              color="cyan darken-2"
              prepend-icon="video_label"
              multi-line
            ></v-text-field>

            <v-btn
              style="margin: 0px; color: white"
              v-show="magnet"
              :disabled="!valid"
              color="cyan darken-2"
              v-on:click="startUpload"
            >
              upload
            </v-btn>
          </v-form>
        </v-flex>
        <v-flex v-else-if="!ready" xs8 offset-xs2 style="padding-top: 50px">
          <Loader></Loader>
        </v-flex>
      </v-card>
    </v-dialog>
  <v-navigation-drawer temporary v-model="drawer" light absolute>
    <v-list v-if="$root.registered" class="pa-1" >
      <v-list-tile avatar v-bind:href="profileURL">
        <v-list-tile-avatar>
          <img v-bind:src="$root.avatar" onerror="this.src = '/dist/placeholder.png'"/>
        </v-list-tile-avatar>
        <v-list-tile-content>
          <v-list-tile-title>{{$root.name}}</v-list-tile-title>
        </v-list-tile-content>
        </v-list-tile-action>
      </v-list-tile>
    </v-list>
    <v-divider></v-divider>
    <v-list class="pt-0" dense>
      <v-list-tile href="/">
        <v-list-tile-action>
          <v-icon>dashboard</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title>Home</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
      <v-list-tile v-if="$root.registered" @click.stop="dialog = true">
        <v-list-tile-action>
          <v-icon>file_upload</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title>Upload</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
      <v-list-tile href="/#/settings">
        <v-list-tile-action>
          <v-icon>settings</v-icon>
        </v-list-tile-action>
        <v-list-tile-content>
          <v-list-tile-title>Settings</v-list-tile-title>
        </v-list-tile-content>
      </v-list-tile>
    </v-list>
    <v-divider></v-divider>
    <center style="margin-top: 15px">
      <label color="cyan darken-2">
          <v-icon style="font-size: 18px; margin-left: -15px; margin-top: -2px">settings_backup_restore</v-icon>
        Seeds
      </label>
      <v-flex md-12 style="margin-top: 15px">
        <SeedElement v-for="seed in seeds" :key="seed.id" :id="seed.id"></SeedElement>
      </v-flex>
    </center>
  </v-navigation-drawer>
  <v-toolbar app dark color="cyan darken-2">
    <v-toolbar-side-icon @click.stop="drawer = !drawer"></v-toolbar-side-icon>
    <img src="dist/logo.svg" height="28px" style="margin-right: -10px; margin-left: 15px; cursor: pointer"></img>
    <v-toolbar-title class="white--text" v-on:click="$router.push('/')">decentube</v-toolbar-title>
    <v-spacer></v-spacer>
    <v-btn flat v-if="$root.registered" @click.stop="dialog = true">UPLOAD</v-btn>
    <SearchBar></SearchBar>
    <v-tooltip v-show="$root.registered" bottom>
      <v-btn icon v-bind:href="profileURL" slot="activator">
        <v-icon>account_circle</v-icon>
      </v-btn>
      <span>Profile</span>
    </v-tooltip>
    <v-tooltip bottom>
      <v-btn v-if="$root.registered"  icon href="/#/settings" slot="activator">
        <v-icon>settings</v-icon>
      </v-btn>
      <span>Settings</span>
    </v-tooltip>
    <v-btn flat v-if="!$root.registered" href="/#/settings">REGISTER</v-btn>

  </v-toolbar>
  <v-content>
      <transition name="fade">
        <router-view></router-view>
      </transition>
  </v-content>
</div>
</template>

<script>
import Uploader from "./Uploader.vue"
export default {
  data () {
    return {
      "$root.name":"",
      "$root.avatar":"",
      "$root.bio":"",
      "$root.coinhive":"",
      "$root.registered":"",
      drawer:null,
      dialog: false,
      valid: false,
      desc:"",
      title:"",
      magnet:"",
      ready:true,
      error: false,
      success:false,
      id:"",
      url:"",
      seeds: localStorage.getObj("seeds")
    }
  },
  computed:{
    profileURL:function(){
      return "/#/u/" + this.$root.name
    }
  },
  created () {
    var self = this;
    setInterval(function(){
      if(self.seeds != localStorage.getObj("seeds")){
        self.seeds = localStorage.getObj("seeds")
      }
    },500)
  },
  methods: {
    fileAdded: function (file) {
      var self = this;
      this.$root.client.seed(file, function onseed (torrent) {
        self.magnet = torrent.magnetURI;
      })
    },
    startUpload: function () {
      var self = this;
      self.ready = false;
      web3.eth.getAccounts().then(function(accounts){
        Decentube.methods.create(self.magnet, self.title, self.desc).send({from:accounts[0]})
        .on('transactionHash', function(hash){
          self.ready = false;
        })
        .on('receipt', function(receipt){
          self.url = "/#/v/"+receipt.events.Upload.returnValues.id;
          self.ready = true;
          self.success = true;
          self.error = false;
        })
        .on('error', function(error){
          self.ready = true;
          self.success = false;
          self.error = true;
        })
        return true;
      })
    }
  },
  components:{
    Uploader
  }
}
</script>

<style scoped>
  @import url('https://fonts.googleapis.com/css?family=Muli:300');
  .toolbar__title.white--text {
    font-family: 'Muli', cursive !important;
    cursor: pointer;
    font-size: 27px;
    font-weight: 300;
    margin-top: -2px;
    margin-left: 18px;
  }
  .custom-loader {
    animation: loader 1s infinite;
    display: flex;
  }
  @-moz-keyframes loader {
    from {
      transform: rotate(0);
    }
    to {
      transform: rotate(360deg);
    }
  }
  @-webkit-keyframes loader {
    from {
      transform: rotate(0);
    }
    to {
      transform: rotate(360deg);
    }
  }
  @-o-keyframes loader {
    from {
      transform: rotate(0);
    }
    to {
      transform: rotate(360deg);
    }
  }
  @keyframes loader {
    from {
      transform: rotate(0);
    }
    to {
      transform: rotate(360deg);
    }
  }
</style>
