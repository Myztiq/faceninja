(function() {
  var user;

  Kinvey.init({
    'appKey': 'kid_PPKjRiOFxJ',
    'appSecret': '3067098a3063405cbc931e5ab9266434'
  });

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

}).call(this);
