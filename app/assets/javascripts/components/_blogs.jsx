var Blogs = React.createClass({

  renderHTML: function() {
    return { __html: this.truncateText(this.props.details.content)};
  },

  findImage: function(details){
    return details && details.thumbnail ? details.thumbnail : "http://www.hotel.is/assets/img/skogarfoss.jpg"
  },

  relatedCards: function(details) {
    var cardNames = _.map(details.categories, function(value, key) {
      return <a key={value.id} href="javaScript:void(0);">{value.title} ,</a>
    });
    return cardNames
  },

  truncateText: function(text) {
    var stringToBeCut = text;
    var maxCharLength = 260;
    var trimmedString = stringToBeCut.substr(0, maxCharLength);
    return trimmedString = trimmedString.substr(0, Math.min(trimmedString.length, trimmedString.lastIndexOf(" ")))
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
            <h2 className="entry-title"><a href={'/blogs/' + details.slug}>{details.title}</a></h2>
              <div className="excerpt-container">
                <div dangerouslySetInnerHTML={this.renderHTML()}></div> <a className='active' href={'/blogs/' + details.slug}><h5>Continue Reading</h5></a>
              </div>
              <div className="post-meta">
                <div className="entry-date">
                  <label className="date">{day}</label>
                  <label className="month">{month}</label>
                </div>
                <div className="entry-author fn">
                  <i className="icon soap-icon-user"></i> Posted By:
                  <a href="#" className="author">{details.author.name}</a>
                </div>
                <div className="entry-action">
                  <span className="entry-tags"><i className="soap-icon-features"></i><span>{this.relatedCards(details)}</span></span>
                </div>
              </div>
            </div>
        </div>
      </div>
    )
  }
});