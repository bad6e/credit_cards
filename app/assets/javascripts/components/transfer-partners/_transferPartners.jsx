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
    const transferPartners = this.state.transferPartners
    if (transferPartners.length === 0) {
      return false;
    }

    return (
      <div>
        <section id="content" className="gray-area">
          <Reward id={this.props.cardId}/>
          <div className="container shortcode">
            {transferPartners.map(this.renderCardPrograms)}
          </div>
        </section>
      </div>
    );
  }
});
