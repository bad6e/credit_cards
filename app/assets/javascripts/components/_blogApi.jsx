var BlogList = React.createClass({
  renderBlogs : function(key) {
    return <Blog key= {this.props.blogs[key].id}
                 details= {this.props.blogs[key]}
                 currentUser={this.props.currentUser}
            />
  },

  getShownBlogPosts : function() {
    var number = this.props.numberOfShownBlogPosts
    return this.props.blogs.slice(0, number)
  },

  render : function() {
    return (
      <div>
        {Object.keys(this.getShownBlogPosts()).map(this.renderBlogs)}
      </div>
    );
  }
});

var BlogApi = React.createClass({
  render : function() {
    return (
      <LoadBlogs url={this.props.url} currentUser={this.props.currentUser} />
    )
  }
});

var LoadBlogs = React.createClass({
  getInitialState : function () {
    return {
      blogs: [],
      numberOfShownBlogPosts: 1
    };
  },

  componentDidMount: function () {
    this.loadBlogsFromAPI();
  },

  loadBlogsFromAPI: function () {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (data) {
        this.setState({
          blogs : data.blogs,
          meta: data.meta
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  removeButton: function(remainingNumberOfBlogPosts) {
    var number = this.state.numberOfShownBlogPosts
    if (remainingNumberOfBlogPosts <= 0) {

      return 'none'
    }
  },

  loadMoreCards: function() {
    var numberOfShownBlogPosts = this.state.numberOfShownBlogPosts
    var remainingNumberOfBlogPosts = this.state.blogs.length - numberOfShownBlogPosts
    this.removeButton(remainingNumberOfBlogPosts);
    this.setState({ numberOfShownBlogPosts: numberOfShownBlogPosts + 1 })
  },

  render : function () {
    return (
      <div>
        <BlogList blogs={this.state.blogs}
                  apiUrl={this.props.url}
                  currentUser={this.props.currentUser}
                  numberOfShownBlogPosts={this.state.numberOfShownBlogPosts} />
        <LoadMoreButton loadMoreCards={this.loadMoreCards}
                        removeButton={this.removeButton} />
      </div>
    );
  }
});
