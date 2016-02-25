
function grayOutReward(response) {
  $('.sign-up-bonus-title').hide();
  $('#reward-chart').css("opacity", 0.3);
  mergeObjects(response);
}

function showReward(response) {
  $(".sign-up-bonus-h1-title").hide();
  drawGraph(response);
}

function drawGraph(response) {
  
  //chart can be used later to do dynamic things to the chart
  var chart = c3.generate({
    bindto: '#reward-chart',
    data: {
      json: response,
      keys: {
        x: 'record_date',
        value: ['amount'],
      },
      types: {
        amount: 'area-spline'
      }
    },
    axis: axis(),
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
  
  //remove the axes, leave the ticks
  $('#reward-chart').find('.domain').remove()
}

function axis() {
  return {
    x: {
      type : 'timeseries',
      tick: {
        format: '%b %e, %Y',
        count: 2
      }
    },
    y: {
      label: {
        text: 'points',
        position: 'outer-middle'
      }
    }
  }
}