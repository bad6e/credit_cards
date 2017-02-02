class Blogs extends React.Component {
  render() {
    const details = this.props.details;
    return (
      <div className="post" key={'blog-' + details.id}>
        <div className="post-content-wrapper">
          <figure className="image-container blog-image">
            <a href={'/blogs/' + details.slug}><img src={details.related_image_url} alt="" /></a>
          </figure>
          <div className="details">
            <h2 className="entry-title" id="blog-title"><a href={'/blogs/' + details.slug}>{details.meta_title}</a></h2>
              <div className="excerpt-container content">
                <p>{details.meta_description}</p>
                <a className='continue-reading' href={'/blogs/' + details.slug}><strong>Continue Reading...</strong></a>
              </div>
              <div className="post-meta">
                <div className="entry-date">
                  <label className="date">{details.day}</label>
                  <label className="month">{details.month}</label>
                </div>
                <div className="entry-author fn">
                  <i></i> Posted By:
                  <a href="/about" className="author"> Bret Doucette</a>
                </div>
              </div>
            </div>
        </div>
      </div>
    )
  }
};
