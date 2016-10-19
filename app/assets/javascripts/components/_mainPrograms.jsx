var MainPrograms = React.createClass({
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
          transferPartners: this.formatStateIntoThreeObjects(transferPartners)
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  renderTransferPartners: function(partners) {
    return <CardPrograms key= {partners[0].id}
                         partners= {partners}
           />
  },

  renderTitle: function() {
    if (typeof this.state.transferPartners[0] !== 'undefined') {
      return <h2 className="transfer-partner-title">Transfer Partners</h2>
    }
  },

  formatStateIntoThreeObjects: function(transferPartners) {
    return _.chunk(transferPartners, 3);
  },

  render: function() {
    return (
      <div>
        <section id="content" className="gray-area">
          <div className="container shortcode">
            {this.state.transferPartners.map(this.renderTransferPartners)}
          </div>
        </section>
      </div>
    );
  }
});
