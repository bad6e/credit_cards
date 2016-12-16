var Rewards = React.createClass({

  checkIfCardHasRewards: function (rewards) {
    if (rewards.length === 0 || rewards.rewards.length === 0) {
      return (
        <NoBonusInfo/>
      )
      //hideAllRewardInformation();
    } else {
      return (
        <div>
          <RewardContainer rewardsArray={this.props.rewards} />
          <GraphContainer rewardsArray={this.props.rewards} />
        </div>
      )
    }
  },

  render : function () {
    return (
      <div>
        {this.checkIfCardHasRewards(this.props.rewards)}
      </div>
    );
  }
});
