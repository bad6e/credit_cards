var Blog = React.createClass({
  render : function() {
    var details = this.props.details

    return (
      <div className="post">
        <div className="post-content-wrapper">
          <figure className="image-container">
            <a href="pages-blog-read.html" className="hover-effect"><img src="http://placehold.it/870x342" alt="" /></a>
          </figure>
          <div className="details">
            <h2 className="entry-title"><a href="pages-blog-read.html">{details.title}</a></h2>
              <div className="excerpt-container">
                <p>{details.content}</p>
              </div>
              <div className="post-meta">
                <div className="entry-date">
                  <label className="date">29</label>
                  <label className="month">Aug</label>
                </div>
                <div className="entry-author fn">
                  <i className="icon soap-icon-user"></i> Posted By:
                  <a href="#" className="author">Jessica Browen</a>
                </div>
                <div className="entry-action">
                  <span className="entry-tags"><i className="soap-icon-features"></i><span><a href="#">Adventure</a>, <a href="#">Romance</a></span></span>
                </div>
              </div>
            </div>
        </div>
      </div>
    )
  }
});