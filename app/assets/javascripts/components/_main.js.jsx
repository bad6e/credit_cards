var Card = React.createClass({

  determineRewards : function(rewards) {
    if (rewards === undefined) {
      return "No Rewards for this Card"
    } else {
      return rewards
    }
  },

  render : function () {
    var rewards = this.props.rewards[0]

    return (
      <article className="box">
        <div className="details col-xs-12">
          <a href={'/cards/' + this.props.route}><img className="card-image-cat" src={this.props.imageLink} alt={this.props.name}/></a>
          <div className="details-wrapper">
            <div className="first-row">
              <h4 id="cat-card-title">{this.props.name}</h4>
            </div>
            <div>
              <span className="price" id="apply-now-color">
                <h6 id="apply-now-title">Apply Now?</h6>
                <div className="best-offer-color">{this.props.bestOffer}<br/></div>
              </span>
            </div>

            <div className="second-row">
              <div className="action">
                <a className="button btn-small active">Favorite Card</a><hr/>
              </div>
            </div>

            <div className="third-row">
              <div className="time">

                <div className="take-off col-sm-4">
                  <div className="icon"><i className="soap-icon-card yellow-color"></i></div>
                  <div>
                    <span className="skin-color">Annual Fee</span><br/>{this.props.annualFee}
                  </div>
                </div>

                <div className="landing col-sm-4">
                  <div className="icon"><i className="soap-icon-savings yellow-color"></i></div>
                  <div>
                    <span className="skin-color">APR</span><br/>{this.props.apr}
                  </div>
                </div>

                <div className="total-time col-sm-4">
                  <div className="icon"><i className="soap-icon-party yellow-color"></i></div>
                  <div>
                    <span className="skin-color">Current Bonus</span><br/>{this.determineRewards(rewards)}
                  </div>
                </div>
              </div>
              <div className="action">
                <a className="button btn-small full-width see-more-button" href={'/cards/' + this.props.route}>SEE MORE INFORMATION</a>
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
    var cardNodes = this.props.cards.map(function (card, index) {
      return (
        <Card name = {card.name}
              route = {card.id}
              imageLink = {card.image_link}
              bestOffer = {card.best_offer}
              annualFee = {card.annual_fee}
              apr = {card.apr}
              rewards = {card.rewards.map(function(one_reward, index) {
                return (

                  one_reward.amount
                  )
              })}
              key ={index} />
      );
    });

    return (
      <div className="cardList">
        {cardNodes}
      </div>
      );
  }
});

var CardBox = React.createClass({
  getInitialState : function () {
    return { cards: [] };
  },

  componentDidMount: function () {
    this.loadCommentsFromServer();
  },

  loadCommentsFromServer: function () {
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

  render : function () {
    return (
      <div className="cardBox">
        <CardList cards={this.state.cards} />
      </div>
      );
  }
});

var Cards = React.createClass({

  render : function() {
    return (
      <div>
        <CardBox id={this.props.id} />
      </div>
      )
  }
});




