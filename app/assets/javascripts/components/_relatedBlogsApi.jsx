var RelatedBlogsApi = React.createClass({
  render : function() {
    return (
      <div>
        <LoadRelatedBlogs url={this.props.url} currentUser={this.props.currentUser} />
      </div>
      )
  }
});

var LoadRelatedBlogs = React.createClass({
  getInitialState : function () {
    return { relatedBlogs: [] };
  },

  componentDidMount: function () {
    this.loadRelatedBlogsFromAPI();
  },

  loadRelatedBlogsFromAPI: function () {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (data) {
        this.setState({relatedBlogs : data});
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render : function () {
    return (
      <div>
        <RelatedBlogList relatedBlogs= {this.state.relatedBlogs} />
      </div>
    );
  }
});

var RelatedBlogList = React.createClass({


  renderRelatedBlogs: function(key) {
    return <RelatedBlogs key= {this.props.relatedBlogs[key].id}
                         details= {this.props.relatedBlogs[key]}
           />
  },

  render : function() {
    return (
      <div>
        {Object.keys(this.props.relatedBlogs).map(this.renderRelatedBlogs)}
      </div>
    );
  }
});


