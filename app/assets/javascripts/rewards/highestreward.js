function checkIfCardHasRewards(response) {
  if (response.length > 6) {
    calculateHighestReward(response);
  } else {
    $('#good-time').replaceWith("N/A");
  }
}

function calculateHighestReward(response) {
  var currentBonus = response[0].amount
  var maxReward = _.maxBy(response, function(o){return o.amount;}).amount;
  debugger
  if (maxReward === currentBonus) {
    $('#good-time').text("Yes");
  } else {
    $('#good-time').text("No").css({ 'color': 'red'});
  }
}

