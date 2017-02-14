var CardContainer = React.createClass({
  addFavoriteCard: function() {
    const id = this.props.details.id
    this.props.postFavoriteCard(id);
  },

  checkIfFavoriteCard : function() {
    const id = this.props.details.id;
    const favoriteCardIds = this.props.favIds;

    if (_.includes(favoriteCardIds, id)) {
      return <Heart id={id}
              cssClass="heart"
             />
    } else {
      return <Heart id={id}
              cssClass="empty-heart"
              addFavoriteCard={this.addFavoriteCard}
             />
    }
  },

  render : function() {
    const details = this.props.details
    const hasCurrentUser = (this.props.currentUser != "" ? true : false);
    const buttonOptions = this.checkIfFavoriteCard();
    const busCard = details.bus_card ? <BusCardLabel/> : null;
    const buttonText = (hasCurrentUser ?  buttonOptions : <LoginHeart/>);
    const applyNowButton = details.rewards
                           && details.rewards.length >= 1
                           ? <a className="btn btn-success btn-lg btn-block full-width apply-now-button-category" href={details.rewards[0].apply_link} target="_blank">APPLY NOW</a> : false;

    return (
      <article className="box card-box" id={'card-' + details.id}>
        <div className="details col-xs-12">
          {busCard}
          <a href={'/cards/' + details.id}><img className="card-image-cat" src={details.image_link} alt={details.name}/></a>
          <div className="details-wrapper">
            <div className="first-row">
              <a href={'/cards/' + details.id}><h4 id="cat-card-title">{details.name}</h4></a>
            </div>
            <div>
              <span className="price" id="apply-now-color">
              <ApplyNowInfo
                details={details}
                numberWithCommas={this.props.numberWithCommas}
                determineBestOfferColor={this.props.determineBestOfferColor}
              />
                <div className="best-offer-color" id="best-offer-color" style={this.props.determineBestOfferColor(details.best_offer)}>
                  {details.best_offer}<br/>
                </div>
                <div className="desktop">
                  <BonusInPoints
                    details={details}
                    size='col-xs-4'
                    applyNowTitle='Bonus in Points'
                    determinePointRewardStatus={this.props.determinePointRewardStatus}
                  />

                  <BonusInDollars details={details}
                    size='col-xs-4'
                    applyNowTitle='Bonus in Dollars'
                    determineDollarRewardStatus={this.props.determineDollarRewardStatus}
                  />

                  <AnnualFee details={details} />
                </div>

                <div className="mobile">
                  <BonusInPoints
                    details={details}
                    size='col-xs-6'
                    applyNowTitle='Points'
                    determinePointRewardStatus={this.props.determinePointRewardStatus}
                  />

                  <BonusInDollars
                    details={details}
                    size='col-xs-6'
                    applyNowTitle='Dollars'
                    determineDollarRewardStatus={this.props.determineDollarRewardStatus}
                  />
                </div>
              </span>
            </div>

            <div className="second-row">
              <div className="action">
                {buttonText}
              </div>
            </div>

            <div className="third-row">
              <div className="action">
                {applyNowButton}
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
