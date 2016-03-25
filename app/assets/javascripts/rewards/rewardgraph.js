function hideAllRewardInformation() {
  $('.apply-center-container').hide();
  $('.points-container').hide();
  $('.sign-up-bonus-title').hide();
  $('#reward-chart').css("opacity", 0.0);
  $(".no-bonus-info").fadeIn(700);
}

function showOnlyBonusInformation(response) {
  $('.points-container').hide();
  $('.sign-up-bonus-title').text("Bonus Amount")
  drawGraph(response, '#dollar-amount-chart', 'Rewards (Points/Miles)', 'amount', 'record_date')
}

function showBonusAndPointInformation(response) {
  var centToDollars = formatCents(response);
  var names = formatNames(response);
  drawMultiGraph(names, '#dollar-amount-chart','Rewards (Points/Miles)','Sign Up Bonus Valued in US Dollars');
  drawGraph(centToDollars, '#reward-chart','Cents', 'Cents', 'recordDate');
}

function formatCents(response) {
  var dollars = _.map(response, function(reward) {
    return {recordDate:reward.record_date, Cents:reward.cent_value * 100, centValue: reward.cent_value * 100}
  });
  return dollars
}

function formatNames(response) {
  var names = _.map(response, function(reward) {
    return {Bonus:reward.amount, Dollars:reward.dollar_amount, recordDate: reward.record_date}
  });
  return names
}

function drawGraph(response, location, y1Label, value, timeValue) {
  var chart = c3.generate({
    bindto: location,
    data: {
      json: response,
      keys: {
        x: timeValue,
        value: [value],
      },
      types: {
        Cents: 'area-spline',
        amount: 'area-spline'
      }
    },
    axis: axis(y1Label),
    area: {
      zerobased: true
    },
    legend: {
      hide: true
    },
    padding: {
      right: 50
    }
  });

  $(location).find('.domain').remove();
}

function axis(y1Label) {
  return {
    x: {
      label : {
        text: 'Date',
        position: 'outer-center'
      },
      type : 'timeseries',
      tick: {
        format: '%b %e, %Y',
        count: 4
      },
    },
    y: {
      label: {
        text: y1Label,
        position: 'outer-middle'
      }
    }
  }
}

function drawMultiGraph(response, location, y1Label, y2Label) {
  var chart = c3.generate({
    bindto: location,
    data: {
      json: response,
      keys: {
        x:'recordDate',
        value: ['Bonus','Dollars'],
      },
      axes: {
        Amount: 'y',
        Dollars:'y2'
      },
      type: 'line',

    },
    axis: multiYAxis(y1Label, y2Label),
    area: {
      zerobased: true
    },
    legend: {
      hide: true
    },
    padding: {
      right: 50
    }
  });
  $(location).find('.domain').remove();
}

function multiYAxis(y1Label, y2Label) {
  return {
    x: {
      label : {
        text: 'Date',
        position: 'outer-center'
      },
      type : 'timeseries',
      tick: {
        format: '%b %e, %Y',
        count: 4
      },
    },
    y: {
      min: 0,
      padding: {bottom: 0},
      label: {
        text: y1Label,
        position: 'outer-middle'
      }
    },
    y2: {
      show:true,
      label: {
        text: y2Label,
        position: 'outer-middle'
      }
    }
  }
}

