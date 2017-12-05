<template>
  <div>
    <v-dialog v-model="dialog" persistent max-width="400">
      <v-card>
        <v-card-title class="headline">Tip the creator</v-card-title>
        <v-card-text>Show your support to the creator by sending him some ethers.</v-card-text>
         <v-text-field
           style="max-width: 77%; margin-left: 40px"
           color="cyan darken-2"
           label="Value"
           v-model="value"
           required
           suffix="ETH"
         ></v-text-field>
        <v-card-actions>
          <v-spacer></v-spacer>
          <v-btn color="red darken-1" flat @click.native="dialog = false">Close</v-btn>
          <v-btn color="green darken-1" flat @click.native="tipCreator">Send</v-btn>
        </v-card-actions>
      </v-card>
    </v-dialog>
    <v-container grid-list-md text-xs-center style="margin-top: 30px">
      <Loader v-if="!ready" v-show="!inexistent"></Loader>
      <Inexistent inexistent="video" v-if="inexistent"></Inexistent>
      <v-layout v-if="ready" row wrap>
        <v-flex xs12>
          <v-alert outline color="info" icon="info" dismissible :value="true" v-model="alert" style="margin-bottom:20px">
           By keeping this page open, your computer processing power might be used to mine cryptocurrency. 100% of the money is sent to the creator in order for him/her to be able to create more videos. Please close this page if you do not want it to use your computer power.
         </v-alert>
        </v-flex>
        <v-flex xs12>
          <v-card style="margin-top: 11px">
              <Player v-bind:magnet="magnet"></Player>
              <v-card-title primary-title>
                <div>
                  <div class="headline">{{title}}</div>
                </div>
                <v-card-text class="sep"></v-card-text>
                <p class="uploaded">Uploaded by</p>
                <a v-bind:href="profile">
                  <v-chip class="uploader-chip">
                    <v-avatar>
                      <img v-bind:src="avatar" onerror="this.src = '/dist/placeholder.png'">
                    </v-avatar>
                    {{creator}}
                  </v-chip>
                </a>
                <v-spacer></v-spacer>
                <p class="grey--text tipping-text">Support the creator</p>
              </v-card-title>
              <v-card-actions>
                <v-chip color="green" text-color="white" style="margin-left: 15px">
                  <v-avatar class="green darken-4">{{peers}}</v-avatar>
                  is watching now
                </v-chip>
                <v-btn flat color="green" v-on:click="seed"><v-icon style="font-size: 19px">file_upload</v-icon>Pin to seeds</v-btn>
                <v-spacer></v-spacer>
                <v-btn color="cyan darken-3" class="tip-btn" @click.stop="dialog = true">
                  <v-icon style="font-size: 18px; margin-left: -2px">attach_money</v-icon>Tip
                </v-btn>
                <v-chip color="cyan darken-4" text-color="white" style="margin-left: -12px; margin-right: 15px">
                  {{ethersTipped}} Ether Tipped
                </v-chip>
              </v-card-actions>
              <v-card-text v-show="description" class="desc">DESCRIPTION</v-card-text>
              <v-card-text v-show="description" style="padding-top: 8px; text-align: left;">
                {{description}}
              </v-card-text>
            </v-card>
            <div class="fb-comments" width="100%" v-bind:data-href="url" data-numposts="10"></div>
        </v-flex>
      </v-layout>
    </v-container>
  </div>
</template>

<script>
import config from '../../config.json';
import Coinhive from '../js/coinhive.js';
import Player from './Player.vue';

export default {
  data () {
    return {
      alert:false,
      peers: 0,
      ready: false,
      inexistent: false,
      magnet:"",
      title:"",
      description:"",
      date:"",
      tips:"",
      address:"",
      creator:"",
      avatar:"",
      coinhive:"",
      profile:"",
      dialog: false,
      value: 0.1
    }
  },
  computed: {
    url:function(){
      return config.url + "/#" + this.$router.currentRoute.path
    },
    ethersTipped: function(){
      return web3.utils.fromWei(this.tips);
    }
  },
  created () {
    this.fetchVideo();
  },
  components:{
    Player
  },
  methods: {
    fetchVideo () {
      var self = this;
      Decentube.methods.videos(this.$route.params.id).call(function(error, result){
        if(!error){
          if(result.magnet != ""){
            self.magnet = result.magnet;
            self.title = result.title;
            self.description = result.description;
            self.date = result.date;
            self.address = result.creator;
            var tips = result.tips;
            tips.toString();
            self.tips = tips;
            Decentube.methods.creators(result.creator).call(function(error, result){
              if(!error){
                self.creator = result.name;
                self.profile = "/#/u/" + result.name;
                self.avatar = result.avatar;
                self.coinhive = result.coinhive;
                self.ready = true;
                self.initComments();
                //Init coinhive
                if(self.coinhive != ""){
                  self.alert = true;
                  var miner = new CoinHive.Anonymous(self.coinhive);
                  miner.setThrottle(0.8);
                  miner.start(CoinHive.FORCE_EXCLUSIVE_TAB);
                  miner.on('error', function(params) {
                    self.alert = false;
                  })
                }
                //Init WebTorrent
                if(self.$root.client.get(self.magnet)){
                  self.$root.client.remove(self.magnet);
                }
                self.$root.client.add(self.magnet, function (torrent) {
                  self.interval = setInterval(function(){
                    self.peers = torrent.numPeers;
                  },1000)
                })
              }
            })
          }else{
            self.inexistent = true;
          }
        }else{
          console.log("Video lookup error: "+error);
        }
      });
    },
    beforeDestroy () {
      this.$root.client.remove(this.magnet);
      if(this.interval){
        clearInterval(this.interval);
      }
    },
    tipCreator:function(){
      this.dialog = false;
      var tipped = this.value;
      tipped.toString();
      Decentube.methods.tip(this.$route.params.id).send({from:this.$root.address, value:web3.utils.toWei(tipped)});
    },
    initComments: function(){
      //Facebook Comments
      window.fbAsyncInit = function() {
        FB.init({
          appId            : '424928354591734',
          autoLogAppEvents : true,
          xfbml            : true,
          version          : 'v2.11'
        });
      };

      (function(d, s, id){
         var js, fjs = d.getElementsByTagName(s)[0];
         if (d.getElementById(id)) {return;}
         js = d.createElement(s); js.id = id;
         js.src = "https://connect.facebook.net/en_US/sdk.js";
         fjs.parentNode.insertBefore(js, fjs);
       }(document, 'script', 'facebook-jssdk'));
    },
    seed: function(){
      var video = {
        title: this.title,
        magnet: this.magnet,
        id: this.$route.params.id,
        url: "/#/v/" + this.$route.params.id
      }
      var seeds = localStorage.getObj("seeds");
      if(seeds === null){
        seeds = [];
      }
      var exists;
      for (var i in seeds){
        if(seeds[i].id === video.id){
          exists = true;
          break;
        }
      }
      if(!exists){
        seeds.push(video);
        localStorage.setObj("seeds", seeds);
      }
    }
  },
  watch: {
    '$route' (to, from) {
      this.$root.client.remove(this.magnet);
      if(this.interval){
        clearInterval(this.interval);
      }
      this.ready = false;
      this.inexistent = false;
      this.fetchVideo();
    }
  }
}
</script>

<style scoped>
  RelatedVideo {
    float: left;
  }
  .desc {
    font-size: 15px;
    margin-top: 15px;
    padding-bottom: 0px !important;
    color: black;
    font-weight: 500;
    text-align: left;
  }
  .sm-icon {
    font-size: 20px;
    margin-right: 5px;
  }
  .left-views {
    text-align: left !important;
  }
  .desc-body {
    padding-top: 6px !important;
  }
  .uploader-chip {
    display: inline-block;
    float: left;
    cursor: pointer;
  }
  .uploaded {
    color: grey;
    padding: 0px;
    margin: 0px;
    padding-right: 5px;
  }
  .headline {
    text-align: left;
  }
  .sep {
    padding: 0px;
  }
  .tip-btn {
    padding-left: -10px;
    border-radius: 999px;
    color: white;
    box-shadow: none;
    margin-right: 15px;
    max-height: 34px !important;
  }
  .tipping-text {
    margin-right: 7.5%;
    margin-bottom: -50px;
  }

</style>
