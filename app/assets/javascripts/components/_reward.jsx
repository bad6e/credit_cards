var Reward = React.createClass({
  getInitialState: function () {
    return {
      reward: [],
      currency: ''
    };
  },

  componentDidMount: function() {
    $.ajax({
      url: '/api/v1/reward/' + this.props.id,
      dataType: 'json',
      success: function (reward) {
        this.setState({
          reward: reward.reward.amount,
          currency: reward.currency
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render: function() {
    debugger;
    return (
      <div className="apply-info-card">
        <h2>Applying for this card will earn you: <strong>{this.state.reward} {this.state.currency} Points</strong></h2>
        <h3>You can transfer these points to the following partners below:</h3>
      </div>
    );
  }
});
