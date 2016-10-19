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
          transferPartners: this.formatStateIntoGroupsOfThree(transferPartners)
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  renderCardPrograms: function(cardPrograms) {
    return <CardPrograms key= {cardPrograms[0].id}
                         cardPrograms= {cardPrograms}
           />
  },

  formatStateIntoGroupsOfThree: function(transferPartners) {
    return _.chunk(transferPartners, 3);
  },

  render: function() {
    return (
      <div>
        <section id="content" className="gray-area">
          <div className="container shortcode">
            {this.state.transferPartners.map(this.renderCardPrograms)}
          </div>
        </section>
      </div>
    );
  }
});
