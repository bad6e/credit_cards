var Cards = React.createClass({
  getInitialState : function () {
    return {
      filterbyName: false,
      filterByDollarAmount: false,
      filterByPointAmount: false,
      filterByCreditScore: false,
      loaderImg: true
    };
  },

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

  sortCardsByDollarAmount : function (cards) {
    if (cards.length > 0) {

      let sortedCardsByDollarAmount = _.sortBy(cards, function(card) {
        if (card.rewards.length > 0  &&  card.rewards[0].dollar_amount) {
          return card.rewards[0].dollar_amount;
        } else if (card.rewards.length > 0 && card.rewards[0].dollar_amount === 0) {
          return -1
        } else if (card.rewards.length > 0 && card.rewards[0].dollar_amount === null) {
          return -2
        } else if (card.rewards.length === 0) {
          return -3
        }

      })
      return sortedCardsByDollarAmount.reverse();
    } else {
      return []
    }
  },

  sortCardsByName : function () {
    var sortedCardsByName = _.sortBy(this.state.cards, function(o) { return o.name; })
  },

  sortCardsByAmount : function () {
    var sortedCardsByAmount = _.sortBy(this.state.cards, function(o) {
      if (o.rewards.length > 0) {
        return o.rewards[0].amount;
      } else if (o.rewards.length === 0) {
        return -1
      }
    })
  },

  sortCardsByCreditScore: function (score) {
    let allCards = this.state.unfilteredCards
    let sortedCardsByCreditScore = _.filter(allCards, function (card) {
      return card.credit_score == score
    })
  },

  renderCards: function(card) {
    if (this.props.apiUrl.indexOf("/users/") > -1 == "1"){
      return (
        <FavoriteCard key={card.id}
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
        <CardContainer key={card.id}
                       details={card}
                       postFavoriteCard={this.props.postFavoriteCard}
                       removeFavoriteCard={this.props.removeFavoriteCard}
                       determinePointRewardStatus={this.determinePointRewardStatus}
                       determineDollarRewardStatus={this.determineDollarRewardStatus}
                       determineBestOfferColor={this.determineBestOfferColor}
                       currentUser={this.props.currentUser}
        />
      )
    }
  },

  render : function () {
    // debugger;
    let cards = this.sortCardsByDollarAmount(this.props.cards)

    //I have an array of objects (this.props.cards) - Im just going to filter it down

      //Ok first things first - lets default to showing all the cards ordered by bonus amount and all credit scores

      //Next I need to list to what buttons were clicked - aka if the good credit score if clicked - i will update filterByCreditScoreGood to true
        //If the good credit scores is clicked - i need filter all the cards by good credit scores
        //If the the good credit score and sort by card name - I need to filter all the cards first by good credit score then name

      //



    //I am going to call functions based on the buttons are clicked

    //I'll need to know which functions to call based on what the sort by name returns

    //this.filterCardsb(this.props.cards)

    return (
      <div>
        <SortByName sortCardsByName={this.sortCardsByName}
                    sortCardsByAmount={this.sortCardsByAmount}
                    sortCardsByDollarAmount={this.sortCardsByDollarAmount}
                    sortCardsByCreditScore={this.sortCardsByCreditScore}
        />
        {cards.map(this.renderCards)}
      </div>
    );
  }
});
