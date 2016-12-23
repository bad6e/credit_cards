var NoBonusInfo = React.createClass({

  formatRewardChart: function () {
    const rewardChart = document.querySelector('.dollars-container');
    document.querySelector('.sign-up-bonus-title').style.display = 'none';
    rewardChart.style.display = null;
    document.querySelector('.no-bonus-info').style.display = null;
  },

  render : function () {
    this.formatRewardChart();
    const divStyle = {
      color: '#2d3e52'
    }

    return (
      <div>
        {this.formatRewardChart}
      </div>
    )
  }
});
