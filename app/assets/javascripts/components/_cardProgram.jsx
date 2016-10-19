var CardProgram = React.createClass({

  renderPartner: function(partner) {
    return <Partner key= {partner.id}
                    partners= {partner}
           />
  },

  render: function() {
    const { partner } = this.props;
    const id = partner.id
    const firstformattedId = "acc" + id;
    const secondformattedId = "#acc" + id;

    return (
       <div className="col-md-4">
          <div className="toggle-container with-image box transfer-partner-toggle" id="accordion0">
            <div className="panel style1">
              <img src="https://s3.amazonaws.com/card-facebook-images/logos/UNITED-MILEAGEPLUS-LOGO.jpg" alt="" width="570" height="160" />
              <h4 className="panel-title">
                <a href={secondformattedId} data-toggle="collapse" data-parent="#accordion0">{this.props.partner.name}</a>
              </h4>
              <div className="panel-collapse collapse" id={firstformattedId}>
                <div className="panel-content">
                  {partner.transfer_partners.map(this.renderPartner)}
                </div>
              </div>
            </div>
          </div>
        </div>
    )
  }
});
