var SortByName = React.createClass({
  render: function() {
    return (
      <div className="sort-by-section clearfix box" id="sorter-box">
        <h4 className="sort-by-title block-sm">Sort Results By:</h4>
        <button className="button btn-small" id="sort-button" onClick={this.props.sortCardsByName}>Card Name</button>
        <button className="button btn-small" id="sort-button" onClick={this.props.sortCardsByAmount}>Current Bonus - Points</button>
        <button className="button btn-small" id="sort-button" onClick={this.props.sortCardsByDollarAmount}>Current Bonus - Dollars</button>
      </div>
    )
  }
})