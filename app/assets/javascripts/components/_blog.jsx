var Blog = React.createClass({
  renderHTML: function(content) {
    return { __html: content};
  },

  relatedCards: function(details) {
    var cardNames = _.map(details.categories, function(value, key) {
      return <a key={value.id} href="javaScript:void(0);">{value.title},   </a>
    });
    return cardNames
  },

  render : function() {
    if (this.props.blog !== "") {
      var details = this.props.blog;
      var month = moment(details.date).format("MMM");
      var day = moment(details.date).format("DD");

      return (
        <div>
          <div className="page-title-container">
            <div className="container">
              <div className="page-title pull-left">
                <h2 className="entry-title">{details.title}</h2>
              </div>
              <ul className="breadcrumbs pull-right">
                <li><a href="/">HOME</a></li>
                <li><a href="/blogs">BLOGS</a></li>
                <li className="active">{details.title}</li>
              </ul>
            </div>
          </div>

          <section className="blog-content" id="content">
            <div className="container">
              <div className="row">
                <div id="main" className="col-sm-8 col-md-9">
                  <div className="post">
                    <figure className="image-container">
                      <a href="#"><img src={details.thumbnail} alt="" /></a>
                    </figure>
                    <div className="details">
                      <h1 className="entry-title">{details.title}</h1>
                      <div className="post-content">
                        <div dangerouslySetInnerHTML={this.renderHTML(details.content)}></div>
                      </div>
                      <div className="post-meta">
                        <div className="entry-date">
                          <label className="date">{day}</label>
                          <label className="month">{month}</label>
                        </div>
                        <div className="entry-author fn">
                          <i className="icon soap-icon-user"></i> Posted By:
                          <a href="#" className="author"> {details.author.name}</a>
                        </div>
                        <div className="entry-action">
                          <span className="entry-tags"><i className="soap-icon-features">{this.relatedCards(details)}</i><span></span></span>
                        </div>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          </section>
        </div>
      )
    } else {
      return (
        <div></div>
      )
    }
  }
});

