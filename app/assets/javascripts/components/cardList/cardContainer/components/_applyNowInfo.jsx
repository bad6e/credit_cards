var ApplyNowInfo = React.createClass({
  determineDealStatus: function (offerStatus) {
    if(offerStatus === 'yes') {
      return 'Good'
    } else if (offerStatus === 'ok') {
      return 'OK'
    } else if (offerStatus === 'no') {
      return 'Bad'
    }
  },

  determineBonusDisplayInfo: function (reward, details) {
    if(reward > 0) {
      return this.displayBonusInfo(reward, details);
    } else if(reward === 0) {
      return this.checkifNoBonus(reward, details);
    } else {
      return this.displayNoBonusInfo(reward, details);
    }
  },

  checkifNoBonus: function(reward, details) {
    if(reward === 0 && this.all_bonuses_are_zero(details.rewards)) {
      return this.displayDoesNotHaveBonus(reward, details);
    } else {
      return this.displayRemovedBonusInfo(reward, details);
    }
  },

  all_bonuses_are_zero: function(rewards) {
    return rewards.filter(reward => (reward.amount > 0)).length === 0;
  },


  displayBonusInfo: function (reward, details) {
    if(details.rewards.length < 6) {
      return this.displayNewBonusInfo(reward, details);
    } else {
      return this.displayNormalBonusInfo(reward, details);
    }
  },

  displayNewBonusInfo: function (reward, details) {
    return (
      <div className="tooltop-apply-now">
        <span className="tooltop-apply-now-text">
          <p>We recently added this card to our <strong>Bonus Tracker Database</strong>.</p>
          <p>We haven't compiled enough past bonuses to determine if the current bonus is a good deal.</p>
          <p><strong>Stay Tuned!</strong></p>
        </span>
        <h6 className="apply-now-title question-icon">Apply Now</h6>
      </div>
    )
  },

  displayNormalBonusInfo: function (reward, details) {
    return (
      <div className="tooltop-apply-now">
        <span className="tooltop-apply-now-text">
          <p>This card's current bonus is <strong>{this.props.numberWithCommas(reward)} {details.point_type}.</strong></p>
          <p>Based on this card's past bonuses, we believe this card's <strong>current</strong> bonus is a <strong><span style={this.props.determineBestOfferColor(details.best_offer)}>{this.determineDealStatus(details.best_offer)}</span></strong> deal.</p>
        </span>
        <h6 className="apply-now-title question-icon">Apply Now</h6>
      </div>
    )
  },

  displayRemovedBonusInfo: function (reward, details) {
    return(
      <div className="tooltop-apply-now">
        <span className="tooltop-apply-now-text">
          <p>This card <strong>use to have a bonus</strong> but they got rid of it. Applying for this card will earn you <strong>{this.props.numberWithCommas(reward)} {details.point_type}.</strong></p>
          <p>Obviously applying for this card now is a <strong><span style={this.props.determineBestOfferColor(details.best_offer)}>{this.determineDealStatus(details.best_offer)}</span></strong> deal.</p>
        </span>
        <h6 className="apply-now-title question-icon">Apply Now</h6>
      </div>
    )
  },

  displayDoesNotHaveBonus: function (reward, details) {
    return(
      <div className="tooltop-apply-now">
        <span className="tooltop-apply-now-text">
          <p>This card <strong>does not have a bonus.</strong></p>
          <p>Obviously applying for this card now is <strong><span style={this.props.determineBestOfferColor('no')}>Bad</span></strong> deal.</p>
        </span>
        <h6 className="apply-now-title question-icon">Apply Now</h6>
      </div>
    )
  },

  displayNoBonusInfo: function (reward, details) {
    return (
      <div className="tooltop-apply-now">
        <span className="tooltop-apply-now-text">
          <p>We are working hard at Too Many Miles - constantly adding new cards to our <strong>Bonus Tracker Database</strong></p>
          <p>Unfortunately we haven't added this card yet... but stay tuned for future additions!</p>
        </span>
        <h6 className="apply-now-title question-icon">Apply Now</h6>
      </div>
    )
  },

  render : function() {
    const details = this.props.details;
    const reward = details.rewards
                    && details.rewards.length >= 1 ? details.rewards[0].amount : false;

    return(
      <div>
        {this.determineBonusDisplayInfo(reward, details)}
      </div>
    )
  }
});
