var TransferPartners = React.createClass({
  getInitialState: function () {
    return {
      transferPartners: []
    };
  },

  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (transferPartners) {
        this.setState({
          transferPartners: transferPartners
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  renderTransferPartners: function(partner) {
    return <TransferPartner key= {partner.id}
                            name= {partner.name}
                            imageUrl={partner.image_url}
                            id=  {partner.id}
           />
  },

  render: function() {
    return (
      <div className="container">
        <div className="row image-box style1 add-clearfix">
          {this.state.transferPartners.map(this.renderTransferPartners)}
        </div>
      </div>
    );
  }
});
