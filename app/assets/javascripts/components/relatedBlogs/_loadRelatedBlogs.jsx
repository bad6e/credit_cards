var LoadRelatedBlogs = React.createClass({
  getInitialState : function () {
    return { relatedBlogs: [] };
  },

  componentDidMount: function () {
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
    if (this.state.relatedBlogs.length !== 0) {
      return (
        <div>
          <RelatedBlogList relatedBlogs= {this.state.relatedBlogs} />
        </div>
      );
    } else {
      return (
        <div></div>
      )
    }
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
        <h2>Related Blog Posts</h2>
        <div className="image-box style11 block">
          <div className="row">
            {Object.keys(this.props.relatedBlogs).map(this.renderRelatedBlogs)}
          </div>
        </div>
      </div>
    );
  }
});
