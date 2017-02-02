var BonusInDollars = React.createClass({
  render: function() {
    const { details, applyNowTitle, size } = this.props;
    return (
      <div className={size}>
        <div className="tooltop-apply-now" id="tooltop-apply-now-bonus-dollar">
          <span className="tooltop-apply-now-text" id="tooltop-apply-now-text-bonus-dollar">
            <p>This is the <strong>approximate value of the bonus in US dollars.</strong></p>
            <p>To obtain this valuation we take the current bonus and multiple it by the our estimated point value.</p>
          </span>
          <h6 className="apply-now-title question-icon">{applyNowTitle}</h6>
        </div>
        <div id="other-nums">
          {this.props.determineDollarRewardStatus(details)}
        </div>
      </div>
    )
  }
})
