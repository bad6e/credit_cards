var CardPrograms = React.createClass({

  renderCardProgram: function(partner) {
    return <CardProgram key= {partner.id}
                        partner= {partner}
           />
  },

  render: function() {
    return (
      <div className="block">
        <div className="row">
          {this.props.partners.map(this.renderCardProgram)}
        </div>
      </div>
    )
  }
});
