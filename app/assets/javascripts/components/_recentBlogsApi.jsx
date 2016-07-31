var RecentBlogsApi = React.createClass({
  render : function() {
    return (
      <div>
        <LoadRecentBlogs url={this.props.url} currentUser={this.props.currentUser} />
      </div>
      )
  }
});

var LoadRecentBlogs = React.createClass({
  getInitialState : function () {
    return { recentBlogs: [] };
  },

  componentDidMount: function () {
    this.loadRecentBlogsFromAPI();
  },

  loadRecentBlogsFromAPI: function () {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (data) {
        this.setState({recentBlogs : data});
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render : function () {
    if (this.state.recentBlogs.length !== 0) {
      return (
        <div>
          <RecentBlogList recentBlogs= {this.state.recentBlogs} />
        </div>
      );
    } else {
      return (
        <div></div>
      )
    }
  }
});

var RecentBlogList = React.createClass({
  renderRecentBlogs: function(key) {
    return <RecentBlogs key= {this.props.recentBlogs[key].id}
                         details= {this.props.recentBlogs[key]}
           />
  },

  render : function() {
    return (
      <div>
        <div className="recent-blog-posts">
          <h2>Recent Blog Posts</h2>
        </div>
        <div className="image-box style11 block">
          <div className="row">
            {Object.keys(this.props.recentBlogs).map(this.renderRecentBlogs)}
          </div>
        </div>
      </div>
    );
  }
});

