var SortByName = React.createClass({
  render : function() {
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

var Card = React.createClass({
  determinePointRewardStatus : function(details) {
    return  details && details.rewards && details.rewards.length
                        ? details.rewards[0].amount : "NO INFO FOR THIS CARD"
  },

  determineDollarRewardStatus : function(details) {
    return  details && details.rewards && details.rewards.length && details.rewards[0].dollar_amount
                        ? details.rewards[0].dollar_amount : "NO INFO FOR THIS CARD"
  },

  determineBestOfferColor : function(bestOffer) {
    if (bestOffer === "yes") {
      return {color: 'green'}
    } else if (bestOffer === "no") {
      return {color: 'red'}
    } else if (bestOffer === "ok") {
      return {color: '#BB9D40'}
    } else {
      return {color: 'black'}
    }
  },

  render : function() {
    var details = this.props.details

    return (
      <article className="box" id={'card-' + details.id}>
        <div className="details col-xs-12">
          <a href={'/cards/' + details.id}><img className="card-image-cat" src={details.image_link} alt={details.name}/></a>
          <div className="details-wrapper">
            <div className="first-row">
              <h4 id="cat-card-title">{details.name}</h4>
            </div>
            <div>
              <span className="price" id="apply-now-color">
                <h6 id="apply-now-title">Apply Now?</h6>
                <div className="best-offer-color" style={this.determineBestOfferColor(details.best_offer)}>{details.best_offer}<br/></div>
              </span>
            </div>

            <div className="second-row">
              <div className="action">
                <a className="button btn-small active">Favorite Card</a><hr/>
              </div>
            </div>

            <div className="third-row">
              <div className="time">

                <div className="total-time col-sm-3">
                  <div className="icon"><i className="soap-icon-party yellow-color"></i></div>
                  <div>
                    <span className="skin-color">Current Bonus - Points</span><br/>{this.determinePointRewardStatus(details)}
                  </div>
                </div>

                <div className="total-time col-sm-3">
                  <div className="icon"><i className="soap-icon-features yellow-color"></i></div>
                  <div>
                    <span className="skin-color">Current Bonus - Dollars</span><br/>{this.determineDollarRewardStatus(details)}
                  </div>
                </div>

                <div className="take-off col-sm-3">
                  <div className="icon"><i className="soap-icon-card yellow-color"></i></div>
                  <div>
                    <span className="skin-color">Annual Fee</span><br/>{details.annual_fee}
                  </div>
                </div>

                <div className="landing col-sm-3">
                  <div className="icon"><i className="soap-icon-savings yellow-color"></i></div>
                  <div>
                    <span className="skin-color">APR</span><br/>{details.apr}
                  </div>
                </div>

              </div>
              <div className="action">
                <a className="button btn-small full-width see-more-button" href={'/cards/' + details.id}>SEE MORE INFORMATION</a>
              </div>

            </div>
          </div>
        </div>
      </article>
    );
  }
});

var CardList = React.createClass({
  render : function() {
    var cards = this.props.cards.map(function (card, index) {
      return ( <Card key = {card.id} details = {card} />)
    });

    return (
      <div>
        {cards}
      </div>
    );
  }
});

var LoadCards = React.createClass({
  getInitialState : function () {
    return { cards: [] };
  },

  componentDidMount: function () {
    this.loadCardsFromAPI();
  },

  loadCardsFromAPI: function () {
    $.ajax({
      url: "api/v1/categories/" + this.props.id,
      dataType: 'json',
      success: function (cards) {
        this.setState({cards : cards});
      }.bind(this),
      error: function (xhr, status, err) {
        console.error(this.props.url, status, err.toString());
      }.bind(this)
    });
  },

  sortCardsByName : function() {
   var sortedCardsByName = _.sortBy(this.state.cards, function(o) { return o.name; })
   this.setState({ cards: sortedCardsByName })
  },

  sortCardsByAmount : function() {
    var sortedCardsByAmount = _.sortBy(this.state.cards, function(o) {
      if (o.rewards.length > 0) {
        return o.rewards[0].amount;
      } else if (o.rewards.length === 0) {
        return -1
      }
    })
    this.setState({ cards: sortedCardsByAmount.reverse() })
  },

  sortCardsByDollarAmount : function() {
    var sortedCardsByDollarAmount = _.sortBy(this.state.cards, function(o) {
      if (o.rewards.length > 0  &&  o.rewards[0].dollar_amount) {
        return o.rewards[0].dollar_amount;
      } else if (o.rewards.length > 0 && o.rewards[0].dollar_amount === null) {
        return -1
      } else if (o.rewards.length === 0) {
        return -1
      }
    })
    this.setState({ cards: sortedCardsByDollarAmount.reverse() })
  },

  render : function () {
    return (
      <div>
        <SortByName sortCardsByName = {this.sortCardsByName}
                    sortCardsByAmount = {this.sortCardsByAmount}
                    sortCardsByDollarAmount = {this.sortCardsByDollarAmount}/>
        <CardList cards={this.state.cards} />
      </div>
    );
  }
});

var CategoryCards = React.createClass({
  render : function() {
    return (
      <div>
        <LoadCards id={this.props.id} />
      </div>
      )
  }
});