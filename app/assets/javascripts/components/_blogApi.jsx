
var BlogApi = React.createClass({
  render : function() {
    return (
      <LoadBlog url={this.props.url} currentUser={this.props.currentUser} />
    )
  }
});

var LoadBlog = React.createClass({
  getInitialState : function () {
    return {
      blog: [],
    };
  },

  componentDidMount: function () {
    this.loadBlogFromAPI();
  },

  loadBlogFromAPI: function () {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (data) {
        this.setState({
          blog : data.post
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
        <Blog blog={this.state.blog} />
      </div>
    );
  }
});
