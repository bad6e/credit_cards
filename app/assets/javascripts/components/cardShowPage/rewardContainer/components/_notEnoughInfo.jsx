var NotEnoughInfo = React.createClass({
  render : function () {
    const divStyle = {
      color: '#2d3e52'
    }

    return (
      <div className="container apply-center-container">
        <h2 style={divStyle}>Good Time to Apply: N/A</h2>
        <h3>Sorry we are still accumulating data for this card - check back soon!</h3>
      </div>
    )
  }
});
