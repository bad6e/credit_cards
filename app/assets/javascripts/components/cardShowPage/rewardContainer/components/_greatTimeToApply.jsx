var GreatTimeToApply = React.createClass({
  render : function () {
    const divStyle = {
      color: 'green'
    }

    return (
      <div className="container apply-center-container">
        <h2 className="time-to-apply-title" style={divStyle}>Good Time to Apply: Hell Yes</h2>
        <h3 className="title-to-apply-subtitle">This is the highest bonus in the last {this.props.dateDifference} months!</h3>
      </div>
    )
  }
});