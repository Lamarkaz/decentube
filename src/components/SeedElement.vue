<template>
  <div>
    <v-flex md12>
        <div class="text-xs-center">
          <v-chip color="green" text-color="white" style="width: 280px !important;">
            <v-avatar>
                <v-icon style="color: white !important; opacity: 1 !important">settings_backup_restore</v-icon>
            </v-avatar>
            {{title}}
            <v-avatar>
                <v-icon class="closeIcon" @click="remove">close</v-icon>
            </v-avatar>
          </v-chip>
        </div>
      </v-flex>
  </div>
</template>

<script>

  export default {
    props:["id"],
    data () {
      return {
        title:"",
      }
    },
    created () {
      var self = this;
      Decentube.methods.videos(this.id).call(function(error, result){
        if(error) console.log(error);
        self.title = result.title;
        if(self.title.length > 28){
          self.title = self.title.slice(0, 28) + "..."
        }
        self.$root.client.add(result.magnet);
      })
    },
    methods:{
      remove:function(){
        var seeds = localStorage.getObj('seeds');
        for (var i = 0; i < seeds.length; i++){
          if(seeds[i].id == this.id){
            seeds.splice(i, 1);
          }
        }
        localStorage.setObj('seeds', seeds);
      }
    }
  }
</script>

<style scoped>
   v-chip {
     max-width: 300px;
   }
   .closeIcon {
    color: white !important;
    opacity: 1 !important;
    margin-left: 35px;
    font-size: 21px;
    padding-left: 5px;
    opacity: 0.7 !important;
    cursor: pointer;
    position: absolute;
    right: 6px;
    transition: all 0.5s ease-in !important;
   }
   .closeIcon:hover {
     opacity: 1 !important;
   }
</style>
