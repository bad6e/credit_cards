var RewardContainer = React.createClass({
  checkIfCardHasEnoughRewards: function (rewards) {
    if (rewards.length > 6) {
      return this.calculateRewardStatistics(rewards);
    } else {
      return <NotEnoughInfo />
    }
  },

  calculateRewardStatistics: function (rewards) {
    const currentReward = this.findCurrentReward(rewards);
    const maxReward = this.calculateMaxReward(rewards);

    const firstDate = this.findOldestRewardDate(rewards);
    const currentDate = this.findCurrentRewardDate(rewards);
    const dateDifference = this.measureDate(currentDate, firstDate);
    return this.determineReward(currentReward, maxReward, dateDifference);
  },

  findCurrentReward: function (rewards) {
    return rewards[0].amount;
  },

  calculateMaxReward: function (rewards) {
    let rewardList = [...rewards];
    rewardList.shift();
    return _.maxBy(rewardList, function (reward) {
      return reward.amount;
    }).amount;
  },

  findOldestRewardDate: function (rewards) {
    const rewardList = [...rewards];
    return rewardList.slice(-1)[0].record_date
  },

  findCurrentRewardDate: function (rewards) {
    return rewards[0].record_date
  },

  measureDate: function (currentDate, firstDate) {
    const date1 = new Date(firstDate);
    const date2 = new Date(currentDate);
    const timeDiff = Math.abs(date2.getTime() - date1.getTime());
    return diffDays = Math.ceil(timeDiff / (1000 * 3600 * 24)/30);
  },

  calculatePercentageChange: function (currentReward, maxReward) {
    const percentage = Math.round(((currentReward - maxReward) / (maxReward)) * 100);
    return Math.abs(percentage);
  },

  determineReward: function (currentReward, maxReward, dateDifference) {
    if (currentReward > maxReward) {
      return (
        <GreatTimeToAppy
          dateDifference={dateDifference}
        />
      )
    } else if (currentReward === maxReward) {
      return (
        <GoodTimeToApply/>
      )
    } else if (currentReward < maxReward) {
      return this.determineHowBad(currentReward, maxReward);
    }
  },

  determineHowBad: function (currentReward, maxReward) {
    const percentage = this.calculatePercentageChange(currentReward, maxReward);
    if (percentage <= 20) {
      return (
        <OkTimeToApply
          percentage={percentage}
        />
      )
    } else {
      return (
        <BadTimeToApply
          percentage={percentage}
        />
      )
    }
  },

  render : function() {
    const rewards = this.props.rewardsArray.rewards;
    return (
      <div>
        {this.checkIfCardHasEnoughRewards(rewards)}
      </div>
    )
  }
});
