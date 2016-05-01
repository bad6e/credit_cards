var BlogList = React.createClass({
  renderBlogs : function(key) {
    return <Blogs key= {this.props.blogs[key].id}
                  details= {this.props.blogs[key]}
                  currentUser={this.props.currentUser}
            />
  },

  getShownBlogPosts : function() {
    return this.props.blogs.slice(0, this.props.numberOfShownBlogPosts)
  },

  render : function() {
    return (
      <div>
        {Object.keys(this.getShownBlogPosts()).map(this.renderBlogs)}
      </div>
    );
  }
});

var BlogsApi = React.createClass({
  render : function() {
    return (
      <LoadBlogs url={this.props.url} currentUser={this.props.currentUser} />
    )
  }
});

var LoadBlogs = React.createClass({
  getInitialState : function() {
    return {
      blogs: [],
      numberOfShownBlogPosts: 1,
      showLoadMoreButton: true,
      additionalPostsNumber: 3
    };
  },

  componentDidMount: function() {
    this.loadBlogsFromAPI();
  },

  loadBlogsFromAPI: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (data) {
        var filterCards = _.filter(data.posts, function(post, key) {
          return post.tags.length === 0;
        });
        this.setState({
          blogs : filterCards
        });
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  loadMoreCards: function() {
    var nextNumberOfShownBlogPosts = this.state.numberOfShownBlogPosts + this.state.additionalPostsNumber;
    var isLoadMoreButtonShown = nextNumberOfShownBlogPosts < this.state.blogs.length;

    this.setState({
      numberOfShownBlogPosts: nextNumberOfShownBlogPosts,
      showLoadMoreButton: isLoadMoreButtonShown
    })
  },

  render : function() {
    return (
      <div>
        <BlogList blogs= {this.state.blogs}
                  apiUrl= {this.props.url}
                  currentUser= {this.props.currentUser}
                  numberOfShownBlogPosts= {this.state.numberOfShownBlogPosts} />
        {
          this.state.showLoadMoreButton &&
          <LoadMoreButton loadMoreCards={this.loadMoreCards} />
        }
      </div>
    );
  }
});
