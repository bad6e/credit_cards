var LoadMoreButton = React.createClass({
  render : function() {
    return (
      <button className ="button btn-large full-width" style={{display: this.props.removeButton}} onClick={this.props.loadMoreCards}>LOAD 5 MORE POSTS</button>
    )
  }
});