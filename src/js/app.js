import Vue from 'vue';
import VueRouter from "vue-router";
import Vuetify from 'vuetify';
import WebTorrent from "./webtorrent.min";
import '../../node_modules/vuetify/dist/vuetify.min.css';
import '../css/styles.css';
import './contract.js';
import Home from '../components/Home.vue';
import Video from '../components/Video.vue';
import User from '../components/User.vue';
import Loader from '../components/Loader.vue';
import Layout from '../components/Layout.vue';
import Settings from '../components/Settings.vue';
import Inexistent from '../components/Inexistent.vue';
import UserVideo from '../components/UserVideo.vue';
import Uploader from '../components/Uploader.vue';
import SeedElement from '../components/SeedElement.vue';
import SearchBar from '../components/SearchBar.vue';
import './contract.js'

//Extending localStorage
Storage.prototype.setObj = function(key, obj) {
    return this.setItem(key, JSON.stringify(obj))
}
Storage.prototype.getObj = function(key) {
    return JSON.parse(this.getItem(key))
}

//Static files
import '../static/placeholder.png';
import '../static/logo.svg';
import '../static/favicon.ico';
import '../static/people.mp4';
import '../static/people.jpg';
import '../static/video-thumbnail.png';

//Global components
Vue.component('Loader', Loader);
Vue.component('Layout', Layout);
Vue.component('Inexistent', Inexistent);
Vue.component('UserVideo', UserVideo);
Vue.component('SeedElement', SeedElement);
Vue.component('SearchBar', SearchBar);


//Middlewares
Vue.use(VueRouter);
Vue.use(Vuetify);

//Router
const router = new VueRouter({
  routes: [
    {path: '/', component: Home},
    {path: '/settings', component: Settings},
    {path: '/v/:id', component: Video},
    {path: '/u/:name', component: User}
  ]
})

//App Initialization
const app = new Vue({
  router,
  data () {
    return {
      name:"",
      avatar:"",
      bio:"",
      coinhive:"",
      address:"",
      registered:false,
      filename:"",
      data:"",
      client: new WebTorrent()
    }
  },
  methods:{
    fetchUser () {
      var self = this;
      setInterval(function(){
        if(web3.currentProvider.isMetaMask === true){
            web3.eth.getAccounts().then(function(accounts){
              if(accounts[0] != self.address || self.fetchAll === true){
                self.fetchAll = false;
                Decentube.methods.creators(accounts[0]).call(function(error, result){
                  if(!error){
                    self.ready = true;
                    self.name = result.name;
                    self.avatar = result.avatar;
                    self.bio = result.bio;
                    self.coinhive = result.coinhive;
                    self.address = accounts.addr;
                    if(result[1] === ""){
                      self.registered = false;
                    }else{
                      self.registered = true;
                    }
                  }else{
                    console.log(error);
                  }
                })
              }
              return true;
            })
        }else{
          self.ready = true;
          self.Metamask = false;
        }
      },2000)
    }
  },
  created () {
    this.fetchUser();
  }
}).$mount('v-app')
