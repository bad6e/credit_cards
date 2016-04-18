var Blog = React.createClass({
  render : function() {
    var details = this.props.blog;
    return (
      <div>
        <div className="page-title-container">
          <div className="container">
            <div className="page-title pull-left">
              <h2 className="entry-title">{details.title}</h2>
            </div>
            <ul className="breadcrumbs pull-right">
              <li><a href="#">HOME</a></li>
              <li><a href="#">BLOGS</a></li>
              <li className="active">{details.title}</li>
            </ul>
          </div>
        </div>

        <section id="content">
          <div className="container">
            <div className="row">
              <div id="main" className="col-sm-8 col-md-9">
                <div className="post">
                  <figure className="image-container">
                    <a href="#"><img src="http://placehold.it/870x342" alt="" /></a>
                  </figure>
                  <div className="details">
                    <h1 className="entry-title">Standard single image post</h1>
                    <div className="post-content">
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
            </div>
          </div>
        </section>
      </div>
    )
  }
});

