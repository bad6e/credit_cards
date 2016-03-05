$(document).ready(function(){
  formatColors();
  $( "#loaderImg" ).fadeIn(700)
  $(".sign-up-bonus-h1-title").hide();
  $(".sign-up-bonus-h1-subtitle").hide();
  grabCardId();
    $('.revolution-slider').revolution(
            {
                dottedOverlay:"none",
                delay:9000,
                startwidth:1200,
                startheight:646,
                onHoverStop:"on",
                hideThumbs:10,
                fullWidth:"on",
                forceFullWidth:"on",
                navigationType:"none",
                shadow:0,
                spinner:"spinner4",
                hideTimerBar:"on",
            });
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
        showReward(response);
        checkIfCardHasEnoughRewards(response);
      }
    }
  });
}

$(document).ready(function() {

        });
