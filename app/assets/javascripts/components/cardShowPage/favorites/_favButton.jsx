class FavButton extends React.Component {
  constructor() {
    super();
    this.addFavoriteCard = this.addFavoriteCard.bind(this);
    this.checkIfFavoriteCard = this.checkIfFavoriteCard.bind(this);
  }

  addFavoriteCard() {
    const id = this.props.cardId;
    this.props.postFavoriteCard(id);
  }

  checkIfFavoriteCard() {
    const id = this.props.cardId;
    const favoriteCardIds = this.props.ids;

    if (_.includes(favoriteCardIds, parseInt(id))) {
      return <Heart
                id={id}
                cssClass="heart"
             />
    } else {
      return <Heart
                id={id}
                cssClass="empty-heart"
                addFavoriteCard={this.addFavoriteCard}
             />
    }
  }

  render() {
    const isCurrentUser = (this.props.currentUser !== "" ? true : false);
    const buttonOptions = this.checkIfFavoriteCard();
    const buttonText = (isCurrentUser ?  buttonOptions : <LoginHeart/>);
    return (
      <div>
        {buttonText}
      </div>
    )
  }
 }
