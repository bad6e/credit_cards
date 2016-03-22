function hideRewardInformation() {
  $('.apply-center-container').hide();
  $('.points-container').hide();
  $('.sign-up-bonus-title').hide();
  $('#reward-chart').css("opacity", 0.0);
  $(".no-bonus-info").fadeIn(700);
}

function showRewardInformation(response) {
  drawGraph(response, 'dollar_amount', 'Dollars', '#dollar-amount-chart')
  drawGraph(response, 'amount', 'Rewards (Points/Miles)','#reward-chart');
}

function drawGraph(response, value, axisLabel, location) {
  var chart = c3.generate({
    bindto: location,
    data: {
      json: response,
      keys: {
        x: 'record_date',
        value: [value],
      },
      types: {
        amount: 'area-spline'
      }
    },
    axis: axis(axisLabel),
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

  $(location).find('.domain').remove()
}

function axis(axisLabel) {
  return {
    x: {
      label : {
        text: 'date',
        position: 'outer-center'
      },
      type : 'timeseries',
      tick: {
        format: '%b %e, %Y',
        count: 3
      },
    },
    y: {
      label: {
        text: axisLabel,
        position: 'outer-middle'
      }
    }
  }
}

