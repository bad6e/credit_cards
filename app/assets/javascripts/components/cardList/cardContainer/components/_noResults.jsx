var NoResults = React.createClass({

  handleReset: function () {
    this.props.resetFilters();
    this.props.handleLoaderImg();
  },

  checkForSearchTerm: function () {
    let searchTerm = this.props.searchTerm;

    const map = {
      '' : this.initialRender(),
      null : this.noResultsFound(),
      'fav': this.goSearchForCards()
    }
    return map[searchTerm] || this.noSearchFound();
  },

  noSearchFound: function () {
    return (
      <div className="no-cards-found">
        <img src="https://s3.amazonaws.com/toomanymiles-svgs/cancel.svg"/>
        <h2>Sorry your search for <strong>'{this.props.searchTerm}'</strong> did not match any cards!</h2>
        <h2>Please search again!</h2>
      </div>
    )
  },

  noResultsFound: function () {
    return (
      <div className="no-cards-found">
        <img src="https://s3.amazonaws.com/toomanymiles-svgs/credit-card.svg"/>
        <h2>Sorry it appears that we don't have any cards that match your filters.</h2>
        <button className="button btn-large sky-blue1" onClick={this.handleReset}>Clear Filters</button>
      </div>
    )
  },

  goSearchForCards: function () {
    return (
      <div className="no-cards-found">
        <img src="https://s3.amazonaws.com/toomanymiles-svgs/credit-card.svg"/>
        <h2>Sorry it appears that you haven't favorited any cards!.</h2>
      </div>
    )
  },

  initialRender: function () {
    return (
      <div className="no-cards-found">
      </div>
    )
  },

  render: function () {
    return (
      <div>
        {this.checkForSearchTerm()}
      </div>
    )
  }
});