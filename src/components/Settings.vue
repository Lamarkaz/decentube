<template>
    <v-container class="wrapper">
      <Loader v-show="!ready"></Loader>
      <Metamask v-show="ready && !Metamask"></Metamask>
      <v-flex v-if="ready && Metamask" xs6 offset-md3>
        <v-alert v-show="success" outline color="success" icon="check_circle" :value="true">
          Success! You're all good.
        </v-alert>
        <v-alert v-show="error" outline color="error" icon="warning" :value="true">
          Error! Something went wrong. Please try again.
        </v-alert>
        <v-form v-model="valid" ref="form" lazy-validation>
          <v-layout row wrap>
            <v-flex xs12 offset-md4>
              <v-avatar v-show="!avatar" size="150px">
                <img src="/dist/placeholder.png">
              </v-avatar>
            <v-avatar v-show="avatar" size="150px">
              <img v-bind:src="avatar" onerror="this.src = '/dist/placeholder.png'">
            </v-avatar>
            </v-flex>
            <v-flex xs12>
              <v-flex xs7 offset-md2 style="margin-bottom: 35px">
                <v-text-field
                  color ="cyan darken-2"
                  label="Avatar URL"
                  v-model="avatar"
                  prepend-icon="insert_photo"
                ></v-text-field>
              </v-flex>
            </v-flex>
            <v-flex xs4>
              <v-subheader>Username</v-subheader>
            </v-flex>
            <v-flex xs12 sm8>
              <v-text-field
                color="cyan darken-2"
                v-model="name"
                :rules="nameRules"
                :counter="15"
                required
                prepend-icon="person"
              ></v-text-field>
            </v-flex>
            <v-flex xs4>
              <v-subheader>Bio</v-subheader>
            </v-flex>
            <v-flex xs12 sm8>
              <v-text-field
                color="cyan darken-2"
                v-model="bio"
                :rules="bioRules"
                :counter="400"
                multi-line
                prepend-icon="subject"
              ></v-text-field>
            </v-flex>
            <v-flex xs4>
              <v-subheader>Coinhive sitekey</v-subheader>
            </v-flex>
            <v-flex xs12 sm8>
              <v-text-field
                v-model="coinhive"
                color="cyan darken-2"
                name="input-1-3"
                single-line
                prepend-icon="monetization_on"
              ></v-text-field>
            </v-flex>
          </v-layout>
          <v-flex xs12 offset-md4>
            <v-btn color="cyan darken-2" style="color: white; width: 100px; margin-left: 35px"
              @click="submit"
              :disabled="!valid"
            >
              submit
            </v-btn>
          </v-flex>
        </v-form>
      </v-flex>
    </v-container>
</template>

<script>
import Metamask from './Metamask.vue';
export default {
  data () {
    return {
      success: false,
      error: false,
      Metamask: true,
      ready: true,
      name: this.$root.name,
      coinhive: this.$root.coinhive,
      avatar: this.$root.avatar,
      valid: true,
      bio: this.$root.bio,
      registered: this.$root.registered,
      nameRules: [
        (v) => !!v || 'Username is required',
        (v) => v && v.length <= 15 || 'Username must be less than 15 characters'
      ],
      bioRules: [
        (v) => v.length <= 400 || 'Bio must be less than 400 characters'
      ]
    }
  },
  watch: {
    '$root.name': function(){this.name = this.$root.name},
    '$root.avatar': function(){this.avatar = this.$root.avatar},
    '$root.bio': function(){this.bio = this.$root.bio},
    '$root.coinhive': function(){this.coinhive = this.$root.coinhive},
    '$root.registered': function(){this.registered = this.$root.registered}
  },
  methods: {
    submit: function(){
      var self = this;
      web3.eth.getAccounts().then(function(accounts){
        Decentube.methods.profile(self.name, self.avatar, self.bio, self.coinhive).send({from:accounts[0]})
        .on('transactionHash', function(hash){
          self.ready = false;
        })
        .on('receipt', function(receipt){
          self.ready = true;
          self.$root.fetchAll = true; //Force fetch to retrieve user data
          self.success = true;
          self.error = false;
        })
        .on('error', function(error){
          self.ready = true;
          self.success = false;
          self.error = true;
          console.log(error);
        })
        return true;
      })
    }
  },
  created () {
    if(!web3.currentProvider.isMetaMask){
      this.Metamask = false
    }
  },
  components:{
    Metamask
  }
}
</script>

<style scoped>
  .wrapper {
    margin-top: 50px;
  }
  .alert {
    margin-bottom: 20px;
  }
</style>
