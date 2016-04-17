var LoadMoreButton = React.createClass({
  render : function() {
    return (
      <button className ="button btn-large full-width" onClick={this.props.loadMoreCards}>LOAD MORE POSTS</button>
    )
  }
});