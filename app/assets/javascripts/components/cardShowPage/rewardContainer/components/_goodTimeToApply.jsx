var GoodTimeToApply = React.createClass({
  render : function () {
    const divStyle = {
      color: 'green'
    }

    return (
      <div className="container apply-center-container">
        <h2 className="time-to-apply-title" style={divStyle}>Good Time to Apply: Yes</h2>
        <h3 className="title-to-apply-subtitle">The current bonus is EQUAL to its highest historical value!</h3>
      </div>
    )
  }
});
