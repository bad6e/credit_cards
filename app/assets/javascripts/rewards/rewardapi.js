$(document).ready(function(){
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
        grayOutReward(response);
      } else {
        showReward(response);
      }
    }
  });
}

