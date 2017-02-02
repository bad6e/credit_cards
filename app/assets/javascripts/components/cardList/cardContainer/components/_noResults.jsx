var NoResults = React.createClass({
  handleReset: function () {
    this.props.resetFilters();
    this.props.handleLoaderImg();
  },

  checkForSearchTerm: function () {
    let searchTerm = this.props.searchTerm;
    const map = {
      '' : this.initialRender(),
      null : this.noFilteredResultsFound(),
      'fav': this.noFavoriteCards(),
      'blank': this.didNotSearchAnything()
    }
    return map[searchTerm] || this.noSearchFound();
  },

  noSearchFound: function () {
    return (
      <div className="no-cards-found">
        <img src="https://s3.amazonaws.com/toomanymiles-svgs/cancel.svg"/>
        {this.searchNull()}
        <h2>Please search again!</h2>
      </div>
    )
  },

  searchNull: function () {
    if (this.props.searchTerm) {
      return (<h2>Sorry your search for <strong>'{this.props.searchTerm}'</strong> did not match any cards.</h2>)
    }
  },

  didNotSearchAnything: function () {
    return (
      <div className="no-cards-found">
        <img src="https://s3.amazonaws.com/toomanymiles-svgs/cancel.svg"/>
        <h2>Dude Bro - You have to search for something...</h2>
        <h2>Please search again!</h2>
      </div>
    )
  },

  noFilteredResultsFound: function () {
    return (
      <div className="no-cards-found">
        <img src="https://s3.amazonaws.com/toomanymiles-svgs/credit-card.svg"/>
        <h2>Sorry it appears that we don't have any cards that match your filters.</h2>
        <button className="button btn-large sky-blue1" onClick={this.handleReset}>Clear Filters</button>
      </div>
    )
  },

  noFavoriteCards: function () {
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