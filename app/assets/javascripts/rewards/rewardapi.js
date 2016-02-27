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

var dummyData = [
  {amount: 50000, record_date: "2016-02-18"},
  {amount: 50000, record_date: "2016-02-11"},
  {amount: 50000, record_date: "2016-02-04"},
  {amount: 50000, record_date: "2016-01-28"},
  {amount: 50000, record_date: "2016-01-21"},
  {amount: 45000, record_date: "2016-01-14"},
  {amount: 45000, record_date: "2016-01-07"},
  {amount: 45000, record_date: "2015-12-31"},
  {amount: 45000, record_date: "2015-12-24"},
  {amount: 45000, record_date: "2015-12-17"},
]

function getRewardData(id) {
  $.ajax({
    type: 'GET',
    url: '/api/v1/rewards/' + id,
    success: function(response){
      if (response.length === 0) {
        $('.sign-up-bonus-title').hide();
        $( "#loaderImg" ).hide();
        grayOutReward(dummyData);
      } else {
        $( "#loaderImg" ).hide();
        showReward(response);
      }
    }
  });
}

