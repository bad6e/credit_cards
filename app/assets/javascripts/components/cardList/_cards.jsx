var Cards = React.createClass({
  getInitialState : function () {
    return {
      sortBy: 'bonus-in-dollars',
      filterByCreditScore: 'all',
      loaderImg: false
    };
  },

  handleLoaderImg: function (event) {
    this.setState(
      { loaderImg: true }
    )
    setTimeout(function() {
      this.setState( { loaderImg: false });
    }.bind(this), 650);
  },

  //Card Info Display Functions
  determinePointRewardStatus : function(details) {
    return details && details.rewards && details.rewards.length
                        ? this.numberWithCommas(details.rewards[0].amount) : <div id="no-info">--</div>
  },

  determineDollarRewardStatus : function(details) {
    return details && details.rewards && details.rewards.length
                        ? this.dollarWithCommas(details.rewards[0].dollar_amount) : <div id="no-info">--</div>
  },

  numberWithCommas: function(number) {
    if (number > 0) {
      return number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    } else if (number === 0) {
      return 0
    }
  },

  dollarWithCommas: function(number) {
    if (number > 0) {
      return "$" + number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ",");
    } else if (number === 0) {
      return "$" + 0
    }
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

  //Card Bonus Sorting Functions
  onSortBy: function (value) {
    this.setState(
      { sortBy: value }
    )
    this.handleLoaderImg();
  },

  getSortedCards: function (cards) {
    let sortByState = this.state.sortBy;

    const map = {
      'bonus-in-dollars': this.sortCardsByDollarAmount,
      'bonus-in-points': this.sortCardsByAmount,
      'card-name': this.sortCardsByName,
    }
    return map[sortByState](cards);

  },

  sortCardsByDollarAmount: function (cards) {
    return _.sortBy(cards, function(card) {
      if (card.rewards.length > 0  &&  card.rewards[0].dollar_amount) {
        return card.rewards[0].dollar_amount;
      } else if (card.rewards.length > 0 && card.rewards[0].dollar_amount === 0) {
        return -1
      } else if (card.rewards.length > 0 && card.rewards[0].dollar_amount === null) {
        return -2
      } else if (card.rewards.length === 0) {
        return -3
      }
    }).reverse();
  },

  sortCardsByAmount: function (cards) {
    return _.sortBy(cards, function(card) {
      if (card.rewards.length > 0) {
        return card.rewards[0].amount;
      } else if (card.rewards.length === 0) {
        return -1
      }
    }).reverse();
  },

  sortCardsByName: function (cards) {
    return _.sortBy(cards, function(card) { return card.name; })
  },

  //Card Credit Score Filtering Functions
  onFilterByCreditScore: function (value) {
    this.setState(
      { filterByCreditScore: value }
    )
    this.handleLoaderImg();
  },

  resetFilters: function () {
    this.setState(
      {
        sortBy: 'bonus-in-dollars',
        filterByCreditScore: 'all'
      }
    )
  },

  getFilteredByCreditScoreCards: function (cards) {
    let score = this.state.filterByCreditScore
    if (score === 'all') {
      return cards
    } else {
      return _.filter(cards, function (card) {
        return card.credit_score == score
      })
    }
  },

  //Card Render Methods
  renderCardsOrNoResults: function(cards) {
    if (cards.length > 0) {
      return cards.map(this.renderCards)
    } else {
      return <NoResults resetFilters={this.resetFilters}
                        handleLoaderImg={this.handleLoaderImg}
                        searchTerm={this.props.searchTerm}
      />
    }
  },

  renderCards: function(card) {
    if (this.props.apiUrl.indexOf("/users/") > -1 == "1"){
      return (
        <FavoriteCard
          key={card.id}
          details={card}
          postFavoriteCard={this.props.postFavoriteCard}
          determinePointRewardStatus={this.determinePointRewardStatus}
          determineDollarRewardStatus={this.determineDollarRewardStatus}
          determineBestOfferColor={this.determineBestOfferColor}
          removeFavoriteCard={this.props.removeFavoriteCard}
          removeFavoriteCardFromState={this.props.removeFavoriteCardFromState}
        />
      )
    } else {
      return (
        <CardContainer
          key={card.id}
          details={card}
          favIds={this.props.favIds}
          postFavoriteCard={this.props.postFavoriteCard}
          removeFavoriteCard={this.props.removeFavoriteCard}
          determinePointRewardStatus={this.determinePointRewardStatus}
          determineDollarRewardStatus={this.determineDollarRewardStatus}
          determineBestOfferColor={this.determineBestOfferColor}
          numberWithCommas={this.numberWithCommas}
          currentUser={this.props.currentUser}
        />
      )
    }
  },

  render : function () {
    let cards = this.getSortedCards(this.props.cards);
    cards = this.getFilteredByCreditScoreCards(cards);
    const loadImg = this.state.loaderImg ?  <LoaderImg object={ "cards" } /> : null;

    return (
      <div>
        { loadImg }
        <SortByName sortBy={this.state.sortBy}
                    filterByCreditScore={this.state.filterByCreditScore}
                    onSortBy={this.onSortBy}
                    onFilterByCreditScore={this.onFilterByCreditScore}
                    handleLoaderImg={this.handleLoaderImg}
        />
        {this.renderCardsOrNoResults(cards)}
      </div>
    );
  }
});
