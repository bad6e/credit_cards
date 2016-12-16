var Graphs = React.createClass({
  checkWhatTypeOfRewardsArePresent: function (rewards) {
    this.hideNoBonusInfo();
    if (this.allCentValuesAreNull(rewards)) {
      this.showOnlyBonusInformation(rewards);
    } else {
      this.showBonusAndPointInformation(rewards);
    }
  },

  hideNoBonusInfo: function () {
    document.querySelector('.no-bonus-info').style.display = 'none';
  },

  allCentValuesAreNull: function(rewards) {
    return _.every(rewards, ['cent_value', null]);
  },

  showOnlyBonusInformation: function (rewards) {
    document.querySelector(".dollars-container").style.display = null;
    this.drawGraph(rewards, '#dollar-amount-chart', rewards.currency, 'amount', 'record_date')
  },

  showBonusAndPointInformation: function(rewards) {
    const centToDollars = this.formatCents(rewards);
    const graphs = Array.from(document.querySelectorAll(".reward-graph-container"));
    this.removeHiddenDisplay(graphs);

    this.drawMultiGraph(rewards, '#dollar-amount-chart',rewards.currency,'Bonus Value ($)');
    this.drawGraph(centToDollars, '#reward-chart','cpp', 'Cents', 'recordDate');
  },

  removeHiddenDisplay: function (graphs) {
    graphs.map(graph => (graph.style.display = null))
  },

  formatCents: function (rewards) {
    const dollars = _.map(rewards, function(reward) {
    return {recordDate:reward.record_date, Cents: Math.round(reward.cent_value * 100 *100)/100, centValue: reward.cent_value * 100}
    });
    return dollars
  },

  drawGraph: function (rewards, location, y1Label, value, timeValue) {
    var chart = c3.generate({
      bindto: location,
      data: {
        json: rewards,
        keys: {
          x: timeValue,
          value: [value],
        },
        types: {
          Cents: 'area-spline',
          amount: 'area-spline'
        }
      },
      axis: this.axis(y1Label),
      area: {
        zerobased: true
      },
      padding: {
        right: 50
      },
      legend: {
        show: false
      }
    });
    $(location).find('.domain').remove();
  },

  axis: function (y1Label) {
    return {
      x: {
        label : {
          text: 'Date',
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
          text: y1Label,
          position: 'outer-middle'
        }
      }
    }
  },

  drawMultiGraph: function (rewards, location, y1Label, y2Label) {
    var chart = c3.generate({
      bindto: location,
      data: {
        json: rewards,

        keys: {
          x:'record_date',
          value: ['amount','dollar_amount'],
        },
        axes: {
          amount: 'y',
          dollar_amount:'y2'
        },
        names: {
          'amount': y1Label,
          'dollar_amount': y2Label
        },
        type: 'line',

      },
      axis: this.multiYAxis(y1Label, y2Label),
      area: {
        zerobased: true
      },
      padding: {
        right: 75
      }
    });
    // $(location).find('.domain').remove();
  },

  multiYAxis: function (y1Label, y2Label) {
    return {
      x: {
        label : {
          text: 'Date',
          position: 'outer-center'
        },
        type : 'timeseries',
        tick: {
          format: '%b %e, %Y',
          count: 3
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
        min: 0,
        show:true,
        padding: {bottom: 0},
        label: {
          text: y2Label,
          position: 'outer-middle'
        }
      }
    }
  },

  render : function() {
    const rewards = this.props.rewards;
    return (
      <div>
        {this.checkWhatTypeOfRewardsArePresent(rewards)}
      </div>
    )
  }
});