<template>
  <v-container>
    <v-flex xs12>
      <v-card color="white darken-2" class="black--text">
        <center>
          <img src="https://nogo10.gitbooks.io/ether-camp-live-studio-primer/content/metamask.png" width="40%"></img>
        </center>
        <v-card-title primary-title>
          <div class="headline mmask">METAMASK IS MISSING!</div>
        </v-card-title>
        <div class="body">Decentube is an Etheruem dApp, this means it's running on the ethereum blockchain. In order to create a profile on decentube you must install <a href="https://metamask.io" style="color:#FF8300">Metamask</a> browser extension.
        </div>
        <div class="what">What is MetaMask?</div>
        <div class="body">
        MetaMask is a bridge for your browser to be able to connect to the ethereum blockchain, it allows you to run Ethereum dApps like Decentube right in your browser without running a full Ethereum node.
        <br />
        <br />
        Notice that Metamask is only availabe as an extension for chrome, this means that if you're using Safari or Firefox you need to download Chrome browser first.
        </div>
        <center class="video_wrapper">
          <iframe width="560" height="315" src="https://www.youtube.com/embed/6Gf_kRE4MJU?rel=0" frameborder="0" allowfullscreen></iframe>
          <v-btn color="cyan darken-2" class="mm-btn" href="https://chrome.google.com/webstore/detail/metamask/nkbihfbeogaeaoehlefnkodbefgpgknn?hl=en">Install MetaMask</v-btn>
        </center>



      </v-card>
    </v-flex>
  </v-container>
</template>

<script>

</script>

<style scoped>
  .mmask {
    display: block;
    font-weight: bold;
    margin-left: auto;
    margin-right: auto;
    color: #FF8300;
    margin-top: -80px;
  }
  .body {
    display: block !important;
    font-size: 15px;
    padding-left: 80px;
    padding-right: 80px;
    padding-top: -5px;
    padding-bottom: 20px;
  }
  .what {
    font-size: 18px;
    color: #FF8300;
    padding-left: 80px;
    padding-bottom: 20px;
    font-weight: 500;
  }
  .video_wrapper {
    display: block;
    margin-left: auto;
    margin-right: auto;
    padding: 30px;
  }
  .mm-btn {
    display: block;
    position: relative;
    width: 200px;
    height: 60px;
    margin-top: 20px;
    background-color: #FF8300;
    color: white
  }



</style>
