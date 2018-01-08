<template>
  <div class="contain">
    <video playsinline autoplay muted loop poster="/dist/people.jpg" id="bgvid">
        <source src="/dist/people.mp4" type="video/mp4">
    </video>
    <center>
      <div class="overlay">
          <img src="/dist/logo.svg" width="150px"></img>
          <h1 class="MainTitle" style="margin-bottom: 50px; font-weight: 700">decentube.</h1>
          <h1 class="MainTitle">The free, ad-free, video freedom platform</h1>
      </div>
      <div class="mechanism-title">
        <h1 style="font-weight: 400; font-family: Lato !important">Features</h1>
      </div>
      <div class="mechanism">
        <v-layout row wrap style="padding-top: 90px; padding-left: 30px; padding-right: 30px">
          <v-flex xs3>
            <v-card dark color="transparent" class="mech-card">
              <v-icon class="mech-icon" style="font-size: 80px">grain</v-icon>
              <v-card-text class="mech-text" style="margin-top: -9px">Decentralized</v-card-text>
              <v-card-text class="Body-Text">Decentube is a fully decentralized video streaming system that has no server, no operator and no single point of control or failure.</v-card-text>
            </v-card>
          </v-flex>
          <v-flex xs3>
            <v-card dark color="transparent" class="mech-card">
              <v-icon class="mech-icon">event_seat</v-icon>
              <v-card-text class="mech-text">Fully Sovereign</v-card-text>
              <v-card-text class="Body-Text">You own your content. Decentube is bound by the rules of the blockchain in which no one can interfere in what you own. You are sovereign!</v-card-text>
            </v-card>
          </v-flex>
          <v-flex xs3>
            <v-card dark color="transparent" class="mech-card">
              <v-icon class="mech-icon">loyalty</v-icon>
              <v-card-text class="mech-text">Ad-free Monetization</v-card-text>
              <v-card-text class="Body-Text">Decentube takes advantage of state of the art browser mining technology to allow you to monetize your content without degrading your users' experience using ads.</v-card-text>
            </v-card>
          </v-flex>
          <v-flex xs3>
            <v-card dark color="transparent" class="mech-card">
              <v-icon class="mech-icon">money_off</v-icon>
              <v-card-text class="mech-text">0% Fee</v-card-text>
              <v-card-text class="Body-Text">Creators take 100% of the profit. We do not (and will not) enforce fees on anyone. You get paid exactly what you deserve for delivering quality content.</v-card-text>
            </v-card>
          </v-flex>
        </v-layout>
        <v-stepper value="4" class="step" style="margin-top: 50px">
          <v-stepper-header>
            <v-stepper-step step="1">
              <strong style="font-weight: 900 !important"><a href="/#/settings">Sign up</a> as a creator</strong>
              <small>using the Metamask chrome plugin</small>
            </v-stepper-step>
            <v-divider></v-divider>
            <v-stepper-step step="2">

              <strong style="font-weight: 900 !important">Upload a video</strong>
              <small>to seed it to the global peer-to-peer network</small>
            </v-stepper-step>
            <v-divider></v-divider>
            <v-stepper-step step="3">
              <strong style="font-weight: 900 !important">Share your video</strong>
              <small>with your peers</small>
            </v-stepper-step>
            <v-divider></v-divider>
            <v-stepper-step step="3">
              <strong style="font-weight: 900 !important">Earn crypto</strong>
            <small>through coinhive browser mining</small>
            </v-stepper-step>
          </v-stepper-header>
        </v-stepper>
      </div>
    </center>
  </div>
</template>

<script>
export default {
  beforeCreate: function() {
      document.body.className = 'home';
  }
}
</script>

<style scoped>
  .contain {
    position:relative;
    margin: 0px;
    padding: 0px;
  }
  .contain video {
    position:relative;
    z-index:0;
    width: 100%;
    max-height: 95%;
  }
  .overlay {
    background-color: rgba(0,0,0,.75);
    position:absolute;
    top:0;
    left:0;
    z-index:1;
    padding-top: 200px;
  }
  .MainTitle {
    font-family: Lato !important;
    color: white;
    position: relative;
    font-size: 34px;
    font-weight: 100;
  }
  .mechanism-title {
    color: #0097a7;
    display: block;
    position: relative;
    height: 85px;
    z-index: 2;
    background-color: white;
    padding: 20px;
    font-size: 14px;
    background-color: #ffffff;
    background-image: url("https://www.transparenttextures.com/patterns/cubes.png");
    background-repeat: repeat;
  }
  .mechanism {
    position: relative;
    height: auto;
    background-color: #0097a7;
    z-index: 3;
    background-image: url("https://www.transparenttextures.com/patterns/cubes.png");
    background-repeat: repeat;
    padding-bottom: 120px;
    padding-top: 50px;
  }
  .mech-card {
    min-height: 350px;
    padding-top: 30px;
    padding-bottom: 30px;
    padding-right: 20px;
    padding-left: 20px;
    box-shadow: none;
    background-color: #0097a7 !important;
    margin-right: 25px;
    margin-left: 25px;
    border: 1px solid rgba(255,255,255,.2) !important;
  }
  .mech-icon {
    font-size: 70px;
  }
  .mech-text {
    font-family: Lato !important;
    font-size: 21px;
    font-weight: 900;

  }
  .step {
    max-width: 92%;
    background-color: #0097a7 !important;
    color: white;
    box-shadow: none;
    border: 1px solid rgba(255,255,255,.2) !important;
  }
  .Body-Text {
    font-family: Open Sans !important;
    font-size: 14px;
  }
</style>
