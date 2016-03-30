var Card = React.createClass({
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
      return <a className="button btn-small yellow active" id={"favorite-button-" + id} onClick={this.onButtonClick}>FAVORITED!</a>
    } else {
      return <a className="button btn-small green active" id={"favorite-button-" + id} onClick={this.onButtonClick}>FAVORITE CARD</a>
    }
  },

  render : function() {
    var details = this.props.details
    var hasCurrentUser = (this.props.currentUser != null ? true : false);
    var buttonOptions = this.checkIfFavoriteCard();
    var buttonText = (hasCurrentUser ?  buttonOptions : <a href="#" className="button btn-small active soap-popupbox" data-target="#travelo-login">Login to Favorite</a>);

    return (
      <article className="box" id={'card-' + details.id}>
        <div className="details col-xs-12">
          <a href={'/cards/' + details.id}><img className="card-image-cat" src={details.image_link} alt={details.name}/></a>
          <div className="details-wrapper">
            <div className="first-row">
              <a href={'/cards/' + details.id}><h4 id="cat-card-title">{details.name}</h4></a>
            </div>
            <div>
              <span className="price" id="apply-now-color">
                <h6 id="apply-now-title">Apply Now?</h6>
                <div className="best-offer-color" style={this.props.determineBestOfferColor(details.best_offer)}>{details.best_offer}<br/></div>
              </span>
            </div>

            <div className="second-row">
              <div className="action">
              {buttonText}
              </div>
            </div>

            <div className="third-row">
              <div className="time">

                <div className="total-time col-sm-3">
                  <div className="icon"><i className="soap-icon-party yellow-color"></i></div>
                  <div>
                    <span className="skin-color">Current Bonus - Points</span><br/>{this.props.determinePointRewardStatus(details)}
                  </div>
                </div>

                <div className="total-time col-sm-3">
                  <div className="icon"><i className="soap-icon-features yellow-color"></i></div>
                  <div>
                    <span className="skin-color">Current Bonus - Dollars</span><br/>{this.props.determineDollarRewardStatus(details)}
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
