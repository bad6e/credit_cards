var MobileSocialIcons = React.createClass({
  render : function() {
    return (
      <div>
        <div className="social-wrapper">
          <div className="social-item">
            <a href={"http://www.facebook.com/sharer.php?u=" + this.props.referringUrl} target="_blank">
              <img src="https://simplesharebuttons.com/images/somacro/facebook.png" alt="Facebook" />
            </a>
          </div>
          <div className="social-item">
            <a href={"https://twitter.com/share?url=" + this.props.referringUrl} target="_blank">
              <img src="https://simplesharebuttons.com/images/somacro/twitter.png" alt="Twitter" />
            </a>
          </div>
          <div className="social-item">
            <a href="javascript:void((function()%7Bvar%20e=document.createElement('script');e.setAttribute('type','text/javascript');e.setAttribute('charset','UTF-8');e.setAttribute('src','http://assets.pinterest.com/js/pinmarklet.js?r='+Math.random()*99999999);document.body.appendChild(e)%7D)());">
              <img src="https://simplesharebuttons.com/images/somacro/pinterest.png" alt="Pinterest" />
            </a>
          </div>
          <div className="social-item">
            <a href={"http://www.linkedin.com/shareArticle?mini=true&url=" + this.props.referringUrl} target="_blank">
              <img src="https://simplesharebuttons.com/images/somacro/linkedin.png" alt="LinkedIn" />
            </a>
          </div>
          <div className="social-item">
            <a href={"mailto:?Subject=" + this.props.blog.title + "&Body=I%20saw%20this%20article%20on%20Too%20Many%20Miles%20and%20thought%20of%20you!%20 " + this.props.referringUrl}>
              <img src="https://simplesharebuttons.com/images/somacro/email.png" alt="Email" />
            </a>
          </div>
        </div>
      </div>
    );
  }
});