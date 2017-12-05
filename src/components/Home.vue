<template>
  <div class="contain">
    <video playsinline autoplay muted loop poster="/dist/people.jpg" id="bgvid">
        <source src="/dist/people.mp4" type="video/mp4">
    </video>
    <center>
      <div class="overlay">
          <img src="/dist/logo.svg" width="180px"></img>
          <h1 class="MainTitle" style="margin-bottom: 40px; font-weight: 700">decentube.</h1>
          <h1 class="MainTitle">The free, ad-free, video freedom platform</h1>
      </div>
      <div class="mechanism-title">
        <h1 style="font-weight: 100">Features</h1>
      </div>
      <div class="mechanism">
        <v-layout row wrap style="padding-top: 90px; padding-left: 30px; padding-right: 30px">
          <v-flex xs3>
            <v-card dark color="transparent" class="mech-card">
              <v-icon class="mech-icon" style="font-size: 80px">grain</v-icon>
              <v-card-text class="mech-text" style="margin-top: -9px">Decentralized</v-card-text>
              <v-card-text>Decentube is a fully decentralized video streaming system that has no server, no operator and no single point of control or failure.</v-card-text>
            </v-card>
          </v-flex>
          <v-flex xs3>
            <v-card dark color="transparent" class="mech-card">
              <v-icon class="mech-icon">event_seat</v-icon>
              <v-card-text class="mech-text">Fully Sovereign</v-card-text>
              <v-card-text>You own your content. Decentube is bound by the rules of the blockchain in which no one can interfere in what you own. You are sovereign!</v-card-text>
            </v-card>
          </v-flex>
          <v-flex xs3>
            <v-card dark color="transparent" class="mech-card">
              <v-icon class="mech-icon">loyalty</v-icon>
              <v-card-text class="mech-text">Ad-free Monetization</v-card-text>
              <v-card-text>Decentube takes advantage of state of the art browser mining technology to allow you to monetize your content without degrading your users' experience using ads.</v-card-text>
            </v-card>
          </v-flex>
          <v-flex xs3>
            <v-card dark color="transparent" class="mech-card">
              <v-icon class="mech-icon">money_off</v-icon>
              <v-card-text class="mech-text">0% Fee</v-card-text>
              <v-card-text>Creators take 100% of the profit. We do not (and will not) enforce fees on anyone. You get paid exactly what you deserve for delivering quality content.</v-card-text>
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

        <div class="footer">
          <p class="dev">DEVELOPED BY</p>
          <a href="https://lamarkaz.com" target="_blank">
            <img src="https://lamarkaz.com/assets/img/lamarkazlogo.svg" width="60px" style="padding-top: 25px"></img>
          </a>
        </div>
      </div>
    </center>
  </div>
</template>

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
    top:0;
    position: fixed;
    left:0;
    z-index:1;
    padding-top: 300px;
  }
  .MainTitle {
    color: white;
    position: relative;
    font-size: 40px;
    font-weight: 100;
  }
  .mechanism-title {
    color: #0097a7;
    display: block;
    position: relative;
    min-height: 110px;
    max-height: 110px;
    z-index: 2;
    background-color: white;
    padding: 30px;
    font-size: 17px;
    background-color: #ffffff;
    background-image: url("https://www.transparenttextures.com/patterns/cubes.png");
    background-repeat: repeat;
  }
  .mechanism {
    position: relative;
    min-height: 921px;
    max-height: 921px;
    background-color: #0097a7;
    z-index: 3;
    background-image: url("https://www.transparenttextures.com/patterns/cubes.png");
    background-repeat: repeat;
  }
  .footer {
    padding: 0px;
    min-height: 180px;
    max-height: 180px;
    max-width: 190px;
    z-index: 2;
    position: relative;
    display: block;
    background-color: white;
    padding-bottom: 30px;
    transform: translateY(88%);
    opacity: 0.5;
    transition: all 0.5s ease-in-out;
    cursor: pointer;
  }
  .footer:hover {
    opacity: 1;
  }
  .dev {
    color: black;
    font-weight: 100;
    padding-top: 25px;
    margin-right: auto;
    margin-left: auto;
    font-size: 16px;
    background-color: white;
    margin-bottom: 0px;
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
  .application .theme--light.stepper .stepper__label, .theme--light .stepper .stepper__label [data-v-8dc7cce2]{
    color: white !important;
    font-weight: 400 !important;
  }
</style>
