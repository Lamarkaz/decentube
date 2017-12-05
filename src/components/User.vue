<template>
  <div>
  <Inexistent inexistent="user" v-if="inexistent"></Inexistent>
  <v-container class="wrapper" v-else>
    <v-flex xs6 offset-md3>
        <v-layout row wrap>
          <v-flex xs12>
            <center>
              <v-avatar size="150px" style="margin-top: 30px">
                <img v-bind:src="avatar" onerror="this.src = '/dist/placeholder.png'"/>
              </v-avatar>
            </center>
          </v-flex>
          <v-flex xs12>
            <h1 class="username text-xs-center">{{name}}</h1 >
            <h4 class="text-xs-center">{{address}}</h4 >
          </v-flex>
        </v-layout>
    </v-flex>
    <v-tabs fixed centered style="margin-top: 15px">
      <v-tabs-bar class="cyan darken-2" dark>
        <v-tabs-slider class="yellow"></v-tabs-slider>
        <v-tabs-item
          :href="'#tab-' + 0"
        >
          Videos
        </v-tabs-item>
        <v-tabs-item
          :href="'#tab-' + 1"
        >
          About
        </v-tabs-item>
      </v-tabs-bar>
      <v-tabs-items>
        <v-tabs-content
          :id="'tab-' + 0"
        >
          <v-card flat>
            <v-card-text>
              <v-container fluid grid-list-md style="margin-top: 6px">
                  <v-layout row wrap style="padding: 10px">
                    <UserVideo v-if="videos" v-for="video in videos" v-bind:video="video" :key="video.id"></UserVideo>
                  </v-layout>
                </v-container>
            </v-card-text>
          </v-card>
        </v-tabs-content>
      </v-tabs-items>
      <v-tabs-items>
        <v-tabs-content
          :id="'tab-' + 1"
        >
          <v-card flat style="padding: 20px">
            <v-container fluid grid-list-md>
              <v-layout row wrap style>
                <v-flex xs6>
                  <v-card-text class="head">Biography</v-card-text>
                  <v-card-text v-show="bio" class="body">{{bio}}</v-card-text>
                  <v-card-text v-show="!bio" class="body">This creator hasn't added a bio yet.</v-card-text>
                </v-flex>
                <v-flex xs6>
                  <v-flex xs12 offset-xs5>
                    <h2 class="balance">BALANCE</h2>
                    <v-chip color="cyan darken-2" text-color="white" style="width: 175px; padding-left: 40px; margin: 0px; font-weight: bold; font-size: 16px">{{balance}} ETH</v-chip>
                  </v-flex>
                </v-flex>
              </v-layout>
            </v-container>
          </v-card>
        </v-tabs-content>
      </v-tabs-items>
    </v-tabs>
  </v-container>
  </div>
</template>

<script>
export default {
  data () {
    return {
      videos:[],
      avatar:"",
      bio:"",
      name:"",
      balance:0,
      address:"",
      inexistent:false
    }
  },
  created () {
    var self = this;
    Decentube.methods.names(web3.utils.soliditySha3(self.$route.params.name)).call(function(error, namesResult){
      Decentube.methods.creators(namesResult).call(function(error, creatorsResult){
        if(creatorsResult.name != ""){
          self.name = creatorsResult.name;
          self.bio = creatorsResult.bio;
          self.avatar = creatorsResult.avatar;
          self.address = creatorsResult.addr
          web3.eth.getBalance(namesResult, function(error, result){
            self.balance = Math.round(web3.utils.fromWei(result)*1000)/1000;
          })
          Decentube.getPastEvents("Upload", {
            fromBlock:0
          }, function(error, event){
            var videos = [];
            for (var i = 0; i < event.length; i++){
              if(event[i].returnValues.creator === namesResult){
                videos.push(event[i].returnValues);
              }
            }
            self.videos = videos;
          })
        }else{
          self.inexistent = true;
        }
      })
    })
  }
}
</script>

<style scoped>
  .username {
    font-weight: 400;
    font-size: 28px;
    padding-top: 20px;
  }
  .head {
    font-size: 19px;
    font-weight: 400;
    padding-bottom: 4px;
  }
  .body {
    background-color: #fafafa;
    border-radius: 3px;
    margin-left: 13px;
    margin-bottom: 50px;
    max-width: 100%;
    height: 200px;
  }
  .balance {
    color: #0097a7;
    font-size: 38px;
    margin-top: 75px;
  }
</style>
