var RelatedBlogs = React.createClass({
  render : function() {
    var details = this.props.details;

    return (
      <div className="col-sm-4">
        <article className="box">
          <figure>
            <a title="" href={"/blogs/" + details.slug}><img id="related-blogs-images" alt={details.meta_title} src={details.related_image_url}/></a>
            <figcaption>
              <h3 className="caption-title">{details.day}</h3>
              <span>{details.month}</span>
            </figcaption>
          </figure>
          <div className="details details-text-box">
            <div className="icon-box style11">
              <div className="icon-wrapper">
                <i className="soap-icon-plane-right takeoff-effect circle"></i>
              </div>
              <div className="details title-link">
                <h4 className="box-title"><a href={"/blogs/" + details.slug}>{details.meta_title}<small>Posted By: Bret</small></a></h4>
              </div>
            </div>
          </div>
        </article>
      </div>
    )
  }
});
