var GraphContainer = React.createClass({
  render : function() {
    const rewards = this.props.rewardsArray.rewards;
    const divStyle={height: '300px'};
    return (
      <div>
        <Graphs rewards={rewards}/>
      </div>
    )
  }
});
