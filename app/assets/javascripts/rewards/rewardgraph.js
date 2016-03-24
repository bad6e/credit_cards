function hideRewardInformation() {
  $('.apply-center-container').hide();
  $('.points-container').hide();
  $('.sign-up-bonus-title').hide();
  $('#reward-chart').css("opacity", 0.0);
  $(".no-bonus-info").fadeIn(700);
}

function showRewardInformation(response) {
  var centToDollars = formatCents(response);
  debugger
  drawMultiGraph(response, '#dollar-amount-chart','Rewards (Points/Miles)','US Dollars');
  drawGraph(centToDollars, '#reward-chart','50000 Points in Dollars');
}

function formatCents(response) {
  var dollars = _.map(response, function(reward) {
    return {record_date:reward.record_date, cent_value:reward.cent_value * 50000}
  });
  return dollars
}

function drawMultiGraph(response, location, y1Label, y2Label) {
  var chart = c3.generate({
    bindto: location,
    data: {
      json: response,
      keys: {
        x:'record_date',
        value: ['amount','dollar_amount'],
      },
      axes: {
        amount: 'y',
        dollar_amount:'y2'
      },
      type: 'line',
      types: {
        amount: 'spline',
        dollar_amount: 'spline'
      }
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

function drawGraph(response, location, y1Label) {
  var chart = c3.generate({
    bindto: location,
    data: {
      json: response,
      keys: {
        x: 'record_date',
        value: ['cent_value'],
      },
      types: {
        cent_value: 'area-spline'
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
        text: 'date',
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

// dollarValue = rewardPoints.map(xxx);
// function xxx(reward) {
//   return {date:reward.date, cent_value:reward.valueInPoints * centsPerPoint(reward.currency);
//   };
// }



