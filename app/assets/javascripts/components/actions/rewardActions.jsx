var LoadRewards = React.createClass({
  getInitialState : function () {
    return {
      rewards: []
    };
  },

  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (rewards) {
        this.setState({
          rewards: rewards
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render : function () {
    return (
      <div>
        <Rewards
          rewards={this.state.rewards}
        />
      </div>
    );
  }
});
