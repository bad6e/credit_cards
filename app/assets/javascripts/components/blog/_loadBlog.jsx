var LoadBlog = React.createClass({
  getInitialState : function() {
    return {
      blog: '',
      loaderImg: true
    };
  },

  componentDidMount: function() {
    $.ajax({
      url: this.props.url,
      dataType: 'json',
      success: function (data) {
        setTimeout(function() {
          this.setState(
            {
              blog: data.post,
              loaderImg: false
            }
          )
        }.bind(this), 600);
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  render : function() {
    const loadImg = this.state.loaderImg ?  <LoaderImg object={ "blog" } /> : null
    return (
      <div>
       <MobileSocialIcons />
        <div>
          { loadImg }
          <Blog blog={this.state.blog} />
          }
        </div>
      </div>
    );
  }
});
