var CardContainer = React.createClass({
  onButtonClick : function() {
    var id = this.props.details.id
    document.getElementById("favorite-button-" + id).text="FAVORITED!";
    document.getElementById("favorite-button-" + id).style.backgroundColor="#e9b02b"
    this.props.postFavoriteCard(id);
  },

  checkIfFavoriteCard : function() {
    var id = this.props.details.id
    var favoriteCardIds = this.props.details.favorite_card_ids
    if (_.includes(favoriteCardIds, id)) {
      return <a className="button btn-small yellow active favorite-button" id={"favorite-button-" + id} onClick={this.onButtonClick}>FAVORITED!</a>
    } else {
      return <a className="button btn-small green active favorite-button" id={"favorite-button-" + id} onClick={this.onButtonClick} href="javaScript:void(0);">FAVORITE CARD</a>
    }
  },

  render : function() {
    const details = this.props.details
    const hasCurrentUser = (this.props.currentUser != "" ? true : false);
    const buttonOptions = this.checkIfFavoriteCard();
    const buttonText = (hasCurrentUser ?  buttonOptions : <a href="#" className="button btn-small sky-blue1 active soap-popupbox favorite-button" data-target="#travelo-login">LOGIN TO FAVORITE</a>);
    const applyNowButton = details.rewards && details.rewards.length >= 1 ? <a className="btn btn-success btn-lg btn-block full-width apply-now-button" href={details.rewards[0].apply_link}>APPLY NOW</a> :  false;
    return (
      <article className="box card-box" id={'card-' + details.id}>
        <div className="details col-xs-12">
          <a href={'/cards/' + details.id}><img className="card-image-cat" src={details.image_link} alt={details.name}/></a>
          <div className="details-wrapper">
            <div className="first-row">
              <a href={'/cards/' + details.id}><h4 id="cat-card-title">{details.name}</h4></a>
            </div>
            <div>
              <span className="price" id="apply-now-color">
                <h6 className="apply-now-title">Apply Now</h6>
                <div className="best-offer-color" id="best-offer-color" style={this.props.determineBestOfferColor(details.best_offer)}>
                  {details.best_offer}<br/>
                </div>
                <div className="desktop">
                  <BonusInPoints details={details}
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
                  <BonusInPoints details={details}
                                 size='col-xs-6'
                                 applyNowTitle='Points'
                                 determinePointRewardStatus={this.props.determinePointRewardStatus}
                  />

                  <BonusInDollars details={details}
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
