var BonusInPoints = React.createClass({
  render: function() {
    const { details, applyNowTitle, size } = this.props;
    return (
      <div className={size}>
        <h6 className="apply-now-title">{applyNowTitle}</h6>
        <div id="other-nums">
          {this.props.determinePointRewardStatus(details)}
        </div>
      </div>
    )
  }
})