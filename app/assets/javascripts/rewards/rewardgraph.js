function mergeObjects(response) {
  var result = {};
  for (var i=0; i<response.length; i++) {
    result[response[i].record_date] = response[i].amount;
  }
  drawGraph(result);
}

function drawGraph(result) {
  new Chartkick.AreaChart("reward-chart", result, {"xtitle": "Time", "ytitle": "Bonus - Points/Miles"});
}

function grayOutReward(response) {
  $('#sign-up-bonus-title').hide();
  $('#reward-chart').css("opacity", 0.4);
  mergeObjects(response);
}

function showReward(response) {
  $("#sign-up-bonus-h1-title").hide();
  mergeObjects(response);
}
