var Cards = React.createClass({
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

  render : function() {
    return (
      <div>
        <SortByName sortCardsByName={this.props.sortCardsByName}
                    sortCardsByAmount={this.props.sortCardsByAmount}
                    sortCardsByDollarAmount={this.props.sortCardsByDollarAmount}/>
        {this.props.cards.map(this.renderCards)}
      </div>
    );
  }
});
