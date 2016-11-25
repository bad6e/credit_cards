var Blogs = React.createClass({
  findImage: function(details){
    return details && details.related_image_url ? details.related_image_url : "http://www.hotel.is/assets/img/skogarfoss.jpg"
  },

  relatedCards: function(details) {
    var cardNames = _.map(details.categories, function(value, key) {
      return <a className="related-cards-links" key={value.id} href="javaScript:void(0);">{value.title}</a>
    });
    return cardNames
  },

  render : function() {
    var details = this.props.details;
    var month = moment(details.date).format("MMM");
    var day = moment(details.date).format("DD");

    return (
      <div className="post" key={'blog-' + details.id}>
        <div className="post-content-wrapper">
          <figure className="image-container">
            <a href={'/blogs/' + details.slug} className="hover-effect"><img src={this.findImage(details)} alt="" /></a>
          </figure>
          <div className="details">
            <h2 className="entry-title" id="blog-title"><a href={'/blogs/' + details.slug}>{details.meta_title}</a></h2>
              <div className="excerpt-container content">
                <p>{details.meta_description}</p>
                <a className='continue-reading' href={'/blogs/' + details.slug}>Continue Reading...</a>
              </div>
              <div className="post-meta">
                <div className="entry-date">
                  <label className="date">{day}</label>
                  <label className="month">{month}</label>
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
});