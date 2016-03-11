var Card = React.createClass({
  render : function () {
    return (
      <div>
      <article className="box">
        <figure className="col-xs-3 col-sm-2">
          <span><img src={this.props.imageLink} alt="Card Image" /></span>
        </figure>
        <div className="details col-xs-9 col-sm-10">
          <div className="details-wrapper">
            <div className="first-row">
              <div>
                <h4 className="box-title">{this.props.name}</h4>
                <a className="button btn-mini stop">Favorite</a>
                <div className="amenities"></div>
              </div>
              <div>
                <span className="price"><small>Apply Now?</small>
                  <div className= 'best-offer-color'>
                    Yes
                  </div>
                </span>
              </div>
            </div>

            <div className="second-row">
              <div className="time">
                <div className="take-off col-sm-4">
                  <div className="icon"><i className="soap-icon-card yellow-color"></i></div>
                    <div>
                      <span className="skin-color">Annual Fee</span><br />1
                    </div>
                </div>
                <div className="landing col-sm-4">
                  <div className="icon"><i className="soap-icon-savings yellow-color"></i></div>
                    <div>
                      <span className="skin-color">APR</span><br />1
                    </div>
                </div>
                <div className="total-time col-sm-4">

                <div className="icon"><i className="soap-icon-party yellow-color"></i></div>
                  <div>
                    <span className="skin-color">Bonus</span><br />1
                  </div>

                  <div className="icon"><i className="soap-icon-clock yellow-color"></i></div>
                    <div>
                      <span className="skin-color">Intro Rate</span><br />1
                    </div>
                  </div>
                </div>

                <div className="action">
                  1
                </div>
              </div>
            </div>
          </div>
        </article>
      </div>




    );
  }
});

var CardList = React.createClass({
  render : function() {
    var cardNodes = this.props.cards.map(function (card, index) {
      return (
        <Card name={ card.name } imageLink= {card.image_link} key={index} />
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
      url: this.props.url,
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
        <h1>Cards</h1>
        <CardList cards={this.state.cards} />
      </div>
      );
  }
});


var Main = React.createClass({
  render : function() {
    return (
      <div>
        <CardBox url="/api/v1/categories/3" />
      </div>
      )
  }
});
//   React.renderComponent(
//     <Card name="Barclays Card" />,
//   );
// };



// var CardList = React.createClass({
//   render: function () {
//     var cardNodes = this.props.comments.map(function (card, index) {
//       return (
//         <Comment name={card.name} key={index} />
//         );
//     });

//     return (
//       <div className="cardList">
//         {cardNodes}
//       </div>
//       );
//   }
// });


// var Main = React.createClass({
//   render() {
//     return (
//       <div>
//         <h1>Hello, Creact!</h1>
//       </div>
//     )
//   }
// });
