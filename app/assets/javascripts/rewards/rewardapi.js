$(document).ready(function(){
  formatColors();
  $( "#loaderImg" ).fadeIn(700)
  grabCardId();
})

function grabCardId() {
  var id = $(".entry-title").attr('id')
  if (id === undefined) {
    var id = $(".top-title").attr('id')
  }
  getRewardData(id);
}

function getRewardData(id) {
  $.ajax({
    type: 'GET',
    url: '/api/v1/rewards/' + id,
    success: function(response){
      $( "#loaderImg" ).hide();
      checkResponseLength(response)
    }
  });
}

function checkResponseLength(response) {
  if (response.length === 0) {
    hideRewardInformation();
  } else {
    showRewardInformation(response);
    checkIfCardHasEnoughRewards(response);
  }
}
