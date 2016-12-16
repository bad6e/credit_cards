var OkTimeToApply = React.createClass({
  render : function () {
    const divStyle = {
      color: '#BB9D40'
    }

    return (
      <div className="container apply-center-container">
        <h2 className="time-to-apply-title" style={divStyle}>Good Time to Apply: Sort Of</h2>
        <h3 className="title-to-apply-subtitle">The current bonus is only {this.props.percentage}% lower than its highest historical value!</h3>
      </div>
    )
  }
});
