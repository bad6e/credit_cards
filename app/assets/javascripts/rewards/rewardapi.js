$(document).ready(function(){
  formatColors();
  $( "#loaderImg" ).fadeIn(700)
  grabCardId();
})

function grabCardId() {
  if (window.location.pathname === "/") {
    checkForTestEnv();
  } else if (window.location.pathname.indexOf("/admin/cards/") == 0) {
    return;
  } else if (window.location.pathname.indexOf("/cards/") > -1) {
    checkForShowTestEnv();
  }
  else {
    return
  }
}

function checkForTestEnv() {
  if (window.location.hostname === "127.0.0.1") {
    return;
  } else {
    var id = $(".top-title").attr('id');
    getRewardData(id);
  }
}

function checkForShowTestEnv() {
  if (window.location.hostname === "127.0.0.1") {
    var id = $(".entry-title").attr('id');
    getRewardData(id);
  } else {
    var id = $(".entry-title").attr('id');
    getRewardData(id);
  }
}

function getRewardData(id) {
  $.ajax({
    type: 'GET',
    url: '/api/v1/rewards/' + id,
    success: function(response){
      $( "#loaderImg" ).hide();
      checkIfResponseIsEmpty(response)
    }
  });
}

function checkIfResponseIsEmpty(response)  {
  if (response.rewards.length === 0) {
    hideAllRewardInformation();
  } else {
    checkWhatTypeOfRewardsArePresent(response);
  }
}

function checkWhatTypeOfRewardsArePresent(response) {
  if (allCentValuesAreNull(response.rewards)) {
    showOnlyBonusInformation(response);
  } else {
    showBonusAndPointInformation(response);
  }
  checkIfCardHasEnoughRewards(response.rewards);
}

function allCentValuesAreNull(response) {
  return _.every(response, ['cent_value', null])
}
