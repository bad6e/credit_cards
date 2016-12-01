var SortByName = React.createClass({
  getInitialState: function () {
    return {
      selectedOption: 'bonus-in-dollars',
      loaderImg: false
    };
  },

  handleChange(event) {
    if (event && event.target.value) {
      this.setState(
        { loaderImg: true }, this.determineSorter(event.target.value))
    }
  },

  determineSorter: function(event) {
    const map = {
      'bonus-in-dollars': this.props.sortCardsByDollarAmount,
      'bonus-in-points': this.props.sortCardsByAmount,
      'card-name': this.props.sortCardsByName,
    }
    map[event]();

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
          <h4 className="sort-by-title block-sm">Sort By:</h4>
          <select key="input" ref="input" name="sort-buttons" value={this.state.value} onChange={this.handleChange}>
            <option value="bonus-in-dollars">Bonus in Dollars</option>
            <option value="bonus-in-points">Bonus in Points</option>
            <option value="card-name">Card Name</option>
          </select>
        </div>
      </div>
    )
  }
})
