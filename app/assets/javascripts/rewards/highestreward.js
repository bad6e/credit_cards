function checkIfCardHasEnoughRewards(response) {
  if (response.length > 6) {
    calculateHighestReward(response);
  } else {
    hideSpinner();
    $('#good-time').replaceWith("N/A");
  }
}

function calculateHighestReward(response) {
  var currentBonus = response[0].amount
  var maxReward = _.maxBy(response, function(o){return o.amount;}).amount;
  if (currentBonus >= maxReward) {
    hideSpinner();
    goodTimeToApply(response.length);
  } else if (currentBonus < maxReward) {
    var percentage = calculatePercentageChange(currentBonus, maxReward);
    hideSpinner();
    badTimeToApply(percentage);
  }
}

function calculatePercentageChange(currentBonus, maxRewards) {
  var percentage = Math.round(((currentBonus - maxRewards) / (maxRewards)) * 100);
  return Math.abs(percentage);
}

function hideSpinner(){
  $('#good-time-spinner').hide();
}

function goodTimeToApply(months) {
  $('#good-time').text("Yes");
  $('.time-to-apply-title').text("Good Time To Apply: Yes").css({ 'color': 'green'});
  $('.title-to-apply-subtitle').text("Current Bonus Highest or Equal to the Highest Bonus in the last "
                                     + months
                                     + " months");
}

function badTimeToApply(percentage) {
  $('#good-time').text("No").css({ 'color': 'red'});
  $('.time-to-apply-title').text("Good Time To Apply: No").css({ 'color': 'red'});
  $('.title-to-apply-subtitle').text("The current bonus is "
                                      + percentage
                                      + "% lower than its highest historical value!");
}

function notEnoughInformation() {
  $('#good-time').replaceWith("N/A");
  $('.time-to-apply-title').text("Good Time To Apply: N/A").css({ 'color': 'yellow'});
  $('.title-to-apply-subtitle').text("Not Enough Historical Information");
}

