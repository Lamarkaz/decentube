<template>
  <div>
    <!-- Search Dialog -->
    <v-dialog v-model="dialog" fullscreen transition="dialog-bottom-transition" :overlay="false">
        <v-card color="grey lighten-5" flat>
          <v-toolbar dark color="cyan darken-3">
              <v-btn icon @click.native="dialog = false" dark>
                <v-icon>close</v-icon>
              </v-btn>
              <v-toolbar-title></v-toolbar-title>
              <v-spacer></v-spacer>
              <v-toolbar-items>
              </v-toolbar-items>
            </v-toolbar>
          <v-layout row>
            <v-flex xs8 offset-xs2>
              <v-card class="card--flex-toolbar">
                <v-toolbar card color="white" prominent>
                  <v-text-field id="searchBarId" v-model="query" style="padding: 0px; margin: 0px"
                    color="cyan darken-2"
                  ></v-text-field>
                  <v-btn icon>
                    <v-icon>search</v-icon>
                  </v-btn>
                </v-toolbar>
                <v-divider></v-divider>
                <v-card-text style="min-height: 400px;">
                  <v-card-text>
                    <v-container fluid grid-list-md style="margin-top: 6px">
                        <v-layout row wrap style="padding: 10px">
                          <UserVideo v-for="video in results" v-bind:video="video" :key="video.id" @click.stop="dialog = false"></UserVideo>
                        </v-layout>
                      </v-container>
                  </v-card-text>
                </v-card-text>
              </v-card>
            </v-flex>
          </v-layout>
        </v-card>
    </v-dialog>
    <!-- Search icon button -->
    <v-btn @click.stop="dialog = true" icon>
      <v-icon>search</v-icon>
    </v-btn>
  </div>
</template>


<script>
import Fuse from "fuse.js";
export default {
  data () {
    return {
      dialog: false,
      list: [],
      query:""
    }
  },
  computed: {
    results: function(){
      var options = {
        shouldSort: true,
        threshold: 0.2,
        location: 0,
        distance: 100,
        maxPatternLength: 32,
        minMatchCharLength: 1,
        keys: [
          "title",
          "description"
      ]
      };
      var fuse = new Fuse(this.list, options); // "list" is the item array
      return fuse.search(this.query);
    }
  },
  created () {
    var self = this;
    Decentube.getPastEvents("Upload", {
      fromBlock:0
    }, function(error, event){
      var list = [];
      for (var i = 0; i < event.length; i++){
        list.push(event[i].returnValues);
      }
      console.log(list)
      self.list = list;
    })
  },
  watch: {
    '$route' (to, from) {
      this.dialog = false;
    }
  }
}
</script>



<style>
  .card--flex-toolbar {
    margin-top: -34px;
  }

  input#searchBarId {
    min-height: 90px;
    padding-top: 30px;
    padding-left: 20px;
    font-size: 25px !important;
}
</style>
