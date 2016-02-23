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
      //Call Function that draws graph and passs in response
    }
      //Need Error for Non-Favorite Cards
  })
}

