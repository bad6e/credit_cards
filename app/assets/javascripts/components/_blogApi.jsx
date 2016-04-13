var BlogList = React.createClass({
  renderBlogs : function(key) {
    return <Blog key= {this.props.blogs[key].id}
                 details= {this.props.blogs[key]}
                 currentUser={this.props.currentUser} />
  },

  render : function() {
    return (
      <div>
        {Object.keys(this.props.blogs).map(this.renderBlogs)}
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
    return { blogs: [] };
  },

  componentDidMount: function () {
    this.loadBlogsFromAPI();
  },

  loadBlogsFromAPI: function () {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (blogs) {
        this.setState({blogs : blogs});
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render : function () {
    return (
      <div>
        <BlogList blogs= {this.state.blogs}
                  apiUrl={this.props.url}
                  currentUser={this.props.currentUser}/>
      </div>
    );
  }
});
