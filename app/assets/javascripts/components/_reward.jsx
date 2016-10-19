var Reward = React.createClass({
  getInitialState: function () {
    return {
      reward: [],
      currency: '',
      bestOffer: ''
    };
  },

  componentDidMount: function() {
    $.ajax({
      url: '/api/v1/reward/' + this.props.id,
      dataType: 'json',
      success: function (reward) {
        this.setState({
          reward: reward.reward.amount,
          currency: reward.currency,
          bestOffer: reward.best_offer
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  formatEarnings: function() {
    return <h2 className="earnings">Applying for this card will earn you: <strong>{this.state.reward} {this.state.currency}</strong></h2>
  },

  formatBestOffer: function() {
    const result = this.state.bestOffer;
    const green = { color: 'green'}
    const red = { color: 'red'}
    const yellow = {color: '#BB9D40'}

    if (result === "n/a") {
      return false
    }
    if (result === 'yes') {
      return <h3 className="deal">This is a <strong><span style={green}>Good</span></strong> deal.</h3>
    }
    if (result === 'no') {
      return <h3 className="deal">This is a <strong><span style={red}>Bad</span></strong> deal.</h3>
    }
    if (result === 'ok') {
      return <h3 className="deal">This is a <strong><span style={yellow}>Ok</span></strong> deal.</h3>
    }
  },

  render: function() {
    return (
      <div className="apply-info-card">
        {this.formatEarnings()}
        {this.formatBestOffer()}
        <h3 className="transfer-info">You can transfer these points to the following partners below:</h3>
      </div>
    );
  }
});
