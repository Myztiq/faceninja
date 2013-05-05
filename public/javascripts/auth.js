(function() {
  var user;

  Kinvey.init({
    'appKey': 'kid_PPKjRiOFxJ',
    'appSecret': '3067098a3063405cbc931e5ab9266434'
  });

  window.fbAsyncInit = function() {
    return FB.init({
      appId: "168848406613915",
      channelUrl: "http://www.friendassassin.com/channel.html",
      status: true
    });
  };

  (function(d, s, id) {
    var fjs, js;
    js = void 0;
    fjs = d.getElementsByTagName(s)[0];
    if (d.getElementById(id)) return;
    js = d.createElement(s);
    js.id = id;
    js.src = "//connect.facebook.net/en_US/all.js";
    return fjs.parentNode.insertBefore(js, fjs);
  })(document, "script", "facebook-jssdk");

  FB.login(function(response) {
    if (response.authResponse) {
      console.log("My access token is: " + response.authResponse.accessToken);
      return console.log("My access token expiry is: " + response.authResponse.expiresIn);
    } else {

    }
  });

  user = new Kinvey.User();

  user.loginWithFacebook({
    access_token: "<access-token>",
    expires_in: "<access-token-expiry>"
  }, {
    name: "John Doe"
  }, {
    success: function(user) {},
    error: function(e) {}
  });

  Kinvey.User.loginWithFacebook;

}).call(this);
