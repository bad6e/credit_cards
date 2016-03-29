var FavoriteCard = React.createClass({
  render : function() {
    var details = this.props.details
    return (
      <div className="booking-info clearfix">
        <div className="date">
          <img src={details.image_link} alt={details.name}/>
        </div>
        <h4 className="box-title"><i className="icon soap-icon-plane-right takeoff-effect yellow-color circle"></i>{details.name}</h4>
        <dl className="info">
          <dt>Apply Now?</dt>
          <dd style={this.props.determineBestOfferColor(details.best_offer)}>{details.best_offer}</dd>
          <dt>Current Bonus - Dollars</dt>
          <dd>{this.props.determineDollarRewardStatus(details)}</dd>
          <dt>Current Bonus - Points</dt>
          <dd>{this.props.determinePointRewardStatus(details)}</dd>
        </dl>
        <button className="btn-mini status unfavorite">Unfavorite</button>
      </div>
    );
  }
});