class SortByName extends React.Component {
  constructor() {
    super()

    this.handleBonusChange = this.handleBonusChange.bind(this)
    this.handleCreditScoreChange = this.handleCreditScoreChange.bind(this)
    this.handleBusCardChange = this.handleBusCardChange.bind(this)
  }

  handleBonusChange(event) {
    this.props.onSortBy(event.target.value)
  }

  handleCreditScoreChange(event) {
    this.props.onFilterByCreditScore(event.target.value)
  }

  handleBusCardChange(event) {
    const isChecked = !event.target.checked
    this.props.onSortByBusCard(isChecked)
  }

  render() {
    const isChecked = !this.props.filterByBusCard

    return (
      <div>
        <div className="sort-by-section clearfix box" id="sorter-box">
          <div className="tooltop">
            <span className="tooltoptext">
              <p>To entice customers, credit cards offer signup bonuses, usually in the form of miles or points.</p>
              <p><strong>These miles or points mean free flights!</strong></p>
              <p>Too Many Miles crunches the numbers for you and, and provides card bonuses' approximate value in US dollars.</p>
            </span>
            <h4 className="sort-by-title block-sm question-icon">Order Cards by:</h4>
          </div>
          <select key="input" ref="input" name="sort-buttons" value={this.props.sortBy} onChange={this.handleBonusChange}>
            <option value="bonus-in-dollars">Approx. Bonus Value in Dollars</option>
            <option value="bonus-in-points">Bonus Value in Points</option>
            <option value="card-name">Card Name</option>
          </select>
          <h4 className="sort-by-title sort-by-credit-score block-sm">Filter By Credit Score:</h4>
          <select key="input-credit-score" ref="input" name="sort-buttons-credit-score" value={this.props.filterByCreditScore} onChange={this.handleCreditScoreChange}>
            <option value="all">All Scores</option>
            <option value="excellent">Excellent (720-850)</option>
            <option value="good">Good (690 - 719)</option>
            <option value="average">Average (630 - 689)</option>
            <option value="poor">Poor (350 - 629)</option>
          </select>
          <div className="bus-card-checkbox">
            <label>
              <input
                name="isChecked"
                type="checkbox"
                checked={isChecked}
                value={isChecked}
                onChange={this.handleBusCardChange}
              />
              Show Business Cards?
            </label>
          </div>
        </div>
      </div>
    )
  }
}
