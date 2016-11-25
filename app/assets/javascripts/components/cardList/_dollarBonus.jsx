var DollarBonus = React.createClass({

  render: function() {
    return (
      <div className="col-xs-4">
        <h6 className="apply-now-title">Bonus in Dollars</h6>
        <div id="other-nums">
          {this.props.determineDollarRewardStatus(this.props.details)}
        </div>
      </div>
    )
  }
})