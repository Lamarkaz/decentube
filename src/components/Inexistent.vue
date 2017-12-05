<template>
  <v-container fill-height>
    <v-layout row wrap align-center>
      <v-flex class="text-xs-center">
        <div class="text-wrapper">
            <div class="title" data-content="404">
                404
            </div>

            <div class="subtitle" data-content="Oops, the page you're looking for doesn't exist">
                Oops, the {{inexistent}} you're looking for doesn't exist.
            </div>

            <v-btn href="/" color="cyan darken-2" style="color: white; width: 150px; height: 50px; margin-top: 50px">
              <v-icon style="font-size: 19px; margin-right: 5px">dashboard</v-icon>
              Go to Home
            </v-btn>
        </div>
      </v-flex>
    </v-layout>
  </v-container>
</template>

<script>
  export default {
    props: ["inexistent"]
  }

</script>




<style scoped>
  body {
  background: url(https://i.imgur.com/CZdBKjO.gif) no-repeat center center fixed;
  background-size: cover;
  background-color: #fafafa;
  height: 100%;
  }

  .text-wrapper {
  height: 80vh;
  display: -webkit-box;
  display: -ms-flexbox;
  display: flex;
  -webkit-box-orient: vertical;
  -webkit-box-direction: normal;
      -ms-flex-direction: column;
          flex-direction: column;
  -webkit-box-align: center;
      -ms-flex-align: center;
          align-items: center;
  -webkit-box-pack: center;
      -ms-flex-pack: center;
          justify-content: center;
  }

  .title {
  font-size: 9rem !important;
  font-weight: 700;
  color: #0097a7;
  position: relative;
  }

  .subtitle {
  font-size: 30px;
  font-weight: 700;
  color: #0097a7;
  position: relative;
  }


  @-webkit-keyframes noise-anim {
  0% {
    clip: rect(177px, 9999px, 11px, 0);
  }
  5% {
    clip: rect(38px, 9999px, 15px, 0);
  }
  10% {
    clip: rect(106px, 9999px, 122px, 0);
  }
  15% {
    clip: rect(38px, 9999px, 175px, 0);
  }
  20% {
    clip: rect(50px, 9999px, 39px, 0);
  }
  25% {
    clip: rect(24px, 9999px, 129px, 0);
  }
  30% {
    clip: rect(150px, 9999px, 26px, 0);
  }
  35% {
    clip: rect(42px, 9999px, 132px, 0);
  }
  40% {
    clip: rect(65px, 9999px, 105px, 0);
  }
  45% {
    clip: rect(84px, 9999px, 133px, 0);
  }
  50% {
    clip: rect(105px, 9999px, 158px, 0);
  }
  55% {
    clip: rect(179px, 9999px, 152px, 0);
  }
  60% {
    clip: rect(154px, 9999px, 48px, 0);
  }
  65% {
    clip: rect(117px, 9999px, 29px, 0);
  }
  70% {
    clip: rect(7px, 9999px, 127px, 0);
  }
  75% {
    clip: rect(1px, 9999px, 194px, 0);
  }
  80% {
    clip: rect(7px, 9999px, 61px, 0);
  }
  85% {
    clip: rect(131px, 9999px, 87px, 0);
  }
  90% {
    clip: rect(103px, 9999px, 144px, 0);
  }
  95% {
    clip: rect(166px, 9999px, 133px, 0);
  }
  100% {
    clip: rect(54px, 9999px, 131px, 0);
  }
  }

  @keyframes noise-anim {
  0% {
    clip: rect(177px, 9999px, 11px, 0);
  }
  5% {
    clip: rect(38px, 9999px, 15px, 0);
  }
  10% {
    clip: rect(106px, 9999px, 122px, 0);
  }
  15% {
    clip: rect(38px, 9999px, 175px, 0);
  }
  20% {
    clip: rect(50px, 9999px, 39px, 0);
  }
  25% {
    clip: rect(24px, 9999px, 129px, 0);
  }
  30% {
    clip: rect(150px, 9999px, 26px, 0);
  }
  35% {
    clip: rect(42px, 9999px, 132px, 0);
  }
  40% {
    clip: rect(65px, 9999px, 105px, 0);
  }
  45% {
    clip: rect(84px, 9999px, 133px, 0);
  }
  50% {
    clip: rect(105px, 9999px, 158px, 0);
  }
  55% {
    clip: rect(179px, 9999px, 152px, 0);
  }
  60% {
    clip: rect(154px, 9999px, 48px, 0);
  }
  65% {
    clip: rect(117px, 9999px, 29px, 0);
  }
  70% {
    clip: rect(7px, 9999px, 127px, 0);
  }
  75% {
    clip: rect(1px, 9999px, 194px, 0);
  }
  80% {
    clip: rect(7px, 9999px, 61px, 0);
  }
  85% {
    clip: rect(131px, 9999px, 87px, 0);
  }
  90% {
    clip: rect(103px, 9999px, 144px, 0);
  }
  95% {
    clip: rect(166px, 9999px, 133px, 0);
  }
  100% {
    clip: rect(54px, 9999px, 131px, 0);
  }
  }
   .title:after {
  content: attr(data-content);
  position: absolute;
  left: 2px;
  text-shadow: -1px 0 red;
  top: 0;
  color: #0097a7;
  overflow: hidden;
  clip: rect(0, 900px, 0, 0);
  -webkit-animation: noise-anim 2s infinite linear alternate-reverse;
          animation: noise-anim 2s infinite linear alternate-reverse;
  }

  @-webkit-keyframes noise-anim-2 {
  0% {
    clip: rect(101px, 9999px, 176px, 0);
  }
  5% {
    clip: rect(34px, 9999px, 84px, 0);
  }
  10% {
    clip: rect(34px, 9999px, 133px, 0);
  }
  15% {
    clip: rect(159px, 9999px, 126px, 0);
  }
  20% {
    clip: rect(169px, 9999px, 129px, 0);
  }
  25% {
    clip: rect(121px, 9999px, 191px, 0);
  }
  30% {
    clip: rect(120px, 9999px, 24px, 0);
  }
  35% {
    clip: rect(13px, 9999px, 177px, 0);
  }
  40% {
    clip: rect(185px, 9999px, 57px, 0);
  }
  45% {
    clip: rect(162px, 9999px, 84px, 0);
  }
  50% {
    clip: rect(102px, 9999px, 68px, 0);
  }
  55% {
    clip: rect(66px, 9999px, 9px, 0);
  }
  60% {
    clip: rect(21px, 9999px, 145px, 0);
  }
  65% {
    clip: rect(162px, 9999px, 9px, 0);
  }
  70% {
    clip: rect(9px, 9999px, 140px, 0);
  }
  75% {
    clip: rect(140px, 9999px, 64px, 0);
  }
  80% {
    clip: rect(77px, 9999px, 199px, 0);
  }
  85% {
    clip: rect(132px, 9999px, 194px, 0);
  }
  90% {
    clip: rect(64px, 9999px, 72px, 0);
  }
  95% {
    clip: rect(152px, 9999px, 94px, 0);
  }
  100% {
    clip: rect(100px, 9999px, 122px, 0);
  }
  }

  @keyframes noise-anim-2 {
  0% {
    clip: rect(101px, 9999px, 176px, 0);
  }
  5% {
    clip: rect(34px, 9999px, 84px, 0);
  }
  10% {
    clip: rect(34px, 9999px, 133px, 0);
  }
  15% {
    clip: rect(159px, 9999px, 126px, 0);
  }
  20% {
    clip: rect(169px, 9999px, 129px, 0);
  }
  25% {
    clip: rect(121px, 9999px, 191px, 0);
  }
  30% {
    clip: rect(120px, 9999px, 24px, 0);
  }
  35% {
    clip: rect(13px, 9999px, 177px, 0);
  }
  40% {
    clip: rect(185px, 9999px, 57px, 0);
  }
  45% {
    clip: rect(162px, 9999px, 84px, 0);
  }
  50% {
    clip: rect(102px, 9999px, 68px, 0);
  }
  55% {
    clip: rect(66px, 9999px, 9px, 0);
  }
  60% {
    clip: rect(21px, 9999px, 145px, 0);
  }
  65% {
    clip: rect(162px, 9999px, 9px, 0);
  }
  70% {
    clip: rect(9px, 9999px, 140px, 0);
  }
  75% {
    clip: rect(140px, 9999px, 64px, 0);
  }
  80% {
    clip: rect(77px, 9999px, 199px, 0);
  }
  85% {
    clip: rect(132px, 9999px, 194px, 0);
  }
  90% {
    clip: rect(64px, 9999px, 72px, 0);
  }
  95% {
    clip: rect(152px, 9999px, 94px, 0);
  }
  100% {
    clip: rect(100px, 9999px, 122px, 0);
  }
  }
  .title:before {
  content: attr(data-content);
  position: absolute;
  left: -2px;
  text-shadow: 1px 0 blue;
  top: 0;
  color: #0097a7;
  overflow: hidden;
  clip: rect(0, 900px, 0, 0);
  -webkit-animation: noise-anim-2 3s infinite linear alternate-reverse;
          animation: noise-anim-2 3s infinite linear alternate-reverse;
  }

</style>
