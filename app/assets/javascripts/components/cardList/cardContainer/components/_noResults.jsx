var NoResults = React.createClass({

  handleReset: function () {
    this.props.resetFilters();
    this.props.handleLoaderImg();
  },
  render: function () {
    return (
      <div className="no-cards-found">
        <img src="https://s3.amazonaws.com/toomanymiles-svgs/credit-card.svg"/>
        <h2>It looks like we don't have any cards that match your filters.</h2>
        <button className="button btn-large sky-blue1" onClick={this.handleReset}>Clear Filters</button>
      </div>
    )
  }
})