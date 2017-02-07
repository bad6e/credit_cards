var FavoriteCard = React.createClass({
  onButtonClick : function() {
    var id = this.props.details.id;
    this.props.removeFavoriteCardFromState(id);
    this.props.removeFavoriteCard(id);
  },

  render : function() {
    var details = this.props.details
    return (
      <div className="booking-info clearfix" id={"unfavorite-" + details.id}>
        <div className="date">
          <a href={'/cards/' + details.id}><img className="favorite-card-img" src={details.image_link} alt={details.name}/></a>
        </div>
        <a href={'/cards/' + details.id}><h4 className="box-title"><i className="icon soap-icon-plane-right takeoff-effect yellow-color circle"></i>{details.name}</h4></a>
        <dl className="info">
          <dt>Apply Now?</dt>
          <dd style={this.props.determineBestOfferColor(details.best_offer)}>{details.best_offer}</dd>
          <dt>Current Bonus - Dollars</dt>
          <dd>{this.props.determineDollarRewardStatus(details)}</dd>
          <dt>Current Bonus - Points</dt>
          <dd>{this.props.determinePointRewardStatus(details)}</dd>
        </dl>
        <button className="btn-mini status unfavorite" onClick={this.onButtonClick}>Unfavorite</button>
      </div>
    );
  }
});