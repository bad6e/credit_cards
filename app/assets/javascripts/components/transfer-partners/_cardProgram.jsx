var CardProgram = React.createClass({
  renderPartner: function(partner) {
    return <Partner key= {partner.id}
                    partners= {partner}
           />
  },

  render: function() {
    const { cardProgram } = this.props;
    const id = cardProgram.id
    const firstformattedId = "acc" + id;
    const secondformattedId = "#acc" + id;

    return (
      <div className="col-md-4">
        <div className="toggle-container with-image box transfer-partner-toggle" id="accordion0">
          <div className="panel style1">
            <img src={cardProgram.image_url} alt="" width="570" height="160" />
            <h4 className="panel-title">
              <a href={secondformattedId} data-toggle="collapse" data-parent="#accordion0">{cardProgram.name}</a>
            </h4>
            <div className="panel-collapse collapse" id={firstformattedId}>
              <div className="panel-content">
                {cardProgram.transfer_partners.map(this.renderPartner)}
              </div>
            </div>
          </div>
        </div>
      </div>
    )
  }
});
