var CardPrograms = React.createClass({
  renderCardProgram: function(cardProgram) {
    return <CardProgram key= {cardProgram.id}
                        cardProgram= {cardProgram}
           />
  },

  render: function() {
    return (
      <div className="block">
        <div className="row">
          {this.props.cardPrograms.map(this.renderCardProgram)}
        </div>
      </div>
    )
  }
});
