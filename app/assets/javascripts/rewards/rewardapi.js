$(document).ready(function(){
  $( "#loaderImg" ).fadeIn(700)
  $(".sign-up-bonus-h1-title").hide();
  $(".sign-up-bonus-h1-subtitle").hide();
  grabCardId();
})

function grabCardId() {
  var id = $(".entry-title").attr('id')
  getRewardData(id);
}

function getRewardData(id) {
  $.ajax({
    type: 'GET',
    url: '/api/v1/rewards/' + id,
    success: function(response){
      if (response.length === 0) {
        $('.sign-up-bonus-title').hide();
        $( "#loaderImg" ).hide();
        grayOutReward();
      } else {
        $( "#loaderImg" ).hide();
        checkIfCardHasEnoughRewards(response);
        showReward(response);
      }
    }
  });
}

