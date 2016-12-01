var AnnualFee = React.createClass({
  render: function() {
    const { details } = this.props;
    return (
      <div className="col-xs-4">
        <h6 className="apply-now-title">Annual Fee</h6>
          <div id="other-nums">
            {details.annual_fee}
          </div>
      </div>
    )
  }
})
