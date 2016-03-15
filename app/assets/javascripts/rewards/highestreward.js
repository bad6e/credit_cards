function checkIfCardHasEnoughRewards(response) {
  if (response.length > 6) {
    calculateRewardStatistics(response);
  } else {
    hideSpinner();
    notEnoughInformation();
  }
}

function calculateRewardStatistics(response) {
  var currentBonus = findCurrentBonus(response);
  var maxReward = calculateMaxReward(response);

  var firstDate = findFirstdate(response);
  var currentDate = findCurrentDate(response);
  var dateDifference = measureDate(currentDate, firstDate);
  determineReward(currentBonus, maxReward, dateDifference);
}

function calculateMaxReward(response) {
  response.shift();
  return maxReward = _.maxBy(response, function(o){return o.amount;}).amount;
}

function determineReward(currentBonus, maxReward, dateDifference) {
  hideSpinner();
  if (currentBonus > maxReward) {
    greatTimeToApply(dateDifference);
  } else if (currentBonus === maxReward) {
    goodTimeToApply();
  } else if (currentBonus < maxReward) {
    determineHowBad(currentBonus, maxReward);
  }
}

function findCurrentBonus(response) {
  return response[0].amount;
}

function findCurrentDate(response) {
  return response[0].record_date
}

function findFirstdate(response) {
  return response.slice(-1)[0].record_date
}

function measureDate(currentDate, firstDate) {
  var date1 = new Date(firstDate);
  var date2 = new Date(currentDate);
  var timeDiff = Math.abs(date2.getTime() - date1.getTime());
  return diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24)/30);
}

function determineHowBad(currentBonus, maxReward) {
  var percentage = calculatePercentageChange(currentBonus, maxReward);
  if (percentage <= 20) {
    okTimeToApply(percentage);
  } else {
    badTimeToApply(percentage);
  }
}

function calculatePercentageChange(currentBonus, maxReward) {
  var percentage = Math.round(((currentBonus - maxReward) / (maxReward)) * 100);
  return Math.abs(percentage);
}

function hideSpinner(){
  $('#good-time-spinner').hide();
}

function greatTimeToApply(dateDifference) {
  $('#good-time').text("Hell Yes");
  $('.graph-detail').show();
  $('.time-to-apply-title').text("Good Time To Apply: Hell Yes").css({ 'color': 'green'});
  $('.title-to-apply-subtitle').text("This is the Highest Bonus in the Last "
                                     + dateDifference
                                     + " Months");
}

function goodTimeToApply() {
  $('#good-time').text("Yes");
  $('.graph-detail').show();
  $('.time-to-apply-title').text("Good Time To Apply: Yes").css({ 'color': 'green'});
  $('.title-to-apply-subtitle').text("The Current Bonus is EQUAL to its Highest Historical Value");
}

function okTimeToApply(percentage) {
  $('#good-time').text("Sort Of").css({ 'color': '#BB9D40'});
  $('.graph-detail').show();
  $('.time-to-apply-title').text("Good Time To Apply: Sort Of").css({ 'color': '#BB9D40'});
  $('.title-to-apply-subtitle').text("The Current Bonus is only..."
                                      + percentage
                                      + "% Lower than its Highest Historical Value!");
}

function badTimeToApply(percentage) {
  $('#good-time').text("No").css({ 'color': 'red'});
  $('.graph-detail').show();
  $('.time-to-apply-title').text("Good Time To Apply: No").css({ 'color': 'red'});
  $('.title-to-apply-subtitle').text("The Current Bonus is "
                                      + percentage
                                      + "% Lower than its Highest Historical Value!");
}

function notEnoughInformation() {
  $('#good-time').text("N/A").css({'color' : '#2d3e52'});
  $('.time-to-apply-title').text("Good Time To Apply: N/A");
  $('.title-to-apply-subtitle').text("Sorry we are still accumulating data for this card - check back soon!");
}

