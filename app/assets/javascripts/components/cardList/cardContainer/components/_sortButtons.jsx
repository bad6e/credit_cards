var SortByName = React.createClass({
  getInitialState: function () {
    return {
      selectedOption: 'bonus-in-dollars',
      loaderImg: false
    };
  },

  handleBonusChange: function (event) {
    this.props.onSortBy(event.target.value);
    this.handleLoaderImg();
  },

  handleCreditScoreChange: function (event) {
    this.props.onFilterByCreditScore(event.target.value);
    this.handleLoaderImg();
  },

  //Move up another level sometime soon
  handleLoaderImg: function (event) {
    this.setState(
      { loaderImg: true }
    )
    setTimeout(function() {
      this.setState( {loaderImg: false});
    }.bind(this), 650);
  },

  render: function() {
    const loadImg = this.state.loaderImg ?  <LoaderImg /> : null
    return (
      <div>
        { loadImg }
        <div className="sort-by-section clearfix box" id="sorter-box">
          <h4 className="sort-by-title block-sm">Sort Bonus</h4>
          <select key="input" ref="input" name="sort-buttons" value={this.props.sortBy} onChange={this.handleBonusChange}>
            <option value="bonus-in-dollars">Bonus in Dollars</option>
            <option value="bonus-in-points">Bonus in Points</option>
            <option value="card-name">Card Name</option>
          </select>
          <h4 className="sort-by-title sort-by-credit-score block-sm">Filter By Credit Score</h4>
          <select key="input-credit-score" ref="input" name="sort-buttons-credit-score" value={this.props.filterByCreditScore} onChange={this.handleCreditScoreChange}>
            <option value="all">All Scores</option>
            <option value="excellent">Excellent (720-850)</option>
            <option value="good">Good (690 - 719)</option>
            <option value="average">Average (630 - 689)</option>
            <option value="poor">Poor (350 - 629)</option>
          </select>
        </div>
      </div>
    )
  }
})
