var TransferPartner = React.createClass({
  render: function() {
    debugger;
    const { name, id, imageUrl} = this.props;
    return (
      <div className="col-sms-6 col-sm-6 col-md-3">
        <article className="box">
          <figure className="logo-figure">
            <img src={imageUrl} alt=""/>
          </figure>
          <div className="details">
            <h4 className="box-title logo-title">{name}</h4>
          </div>
        </article>
      </div>
    );
  }
});
