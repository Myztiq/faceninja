(function() {
  var holdForFacebook, holds, isFbInit;

  holds = [];

  isFbInit = false;

  window.fbAsyncInit = function() {
    var hold, _i, _len, _results;
    isFbInit = true;
    FB.init({
      appId: "168848406613915",
      channelUrl: "/channel.html",
      status: true,
      xfbml: true
    });
<<<<<<< HEAD
    return FB.login((function(response) {
      if (response.authResponse) {
        console.log("Welcome!  Fetching your information.... ");
<<<<<<< HEAD
        return FB.api("me/?fields=friendslist.fields(picture.type(large))", function(response) {
          var images;
=======
=======
    _results = [];
    for (_i = 0, _len = holds.length; _i < _len; _i++) {
      hold = holds[_i];
      _results.push(hold());
    }
    return _results;
  };

  holdForFacebook = function(method) {
    if (!isFbInit) {
      return holds.push(method);
    } else {
      return typeof method === "function" ? method() : void 0;
    }
  };

  window.facebook = {
    isLoggedIn: function(cb) {
      return holdForFacebook(function() {
        return FB.getLoginStatus(function(response) {
          if (response.status === 'connected') {
            return typeof cb === "function" ? cb(true) : void 0;
          } else {
            return typeof cb === "function" ? cb(false) : void 0;
          }
        });
      });
    },
    login: function(cb) {
      return holdForFacebook(function() {
        return FB.login(function(response) {
          if (response.authResponse) {
            return typeof cb === "function" ? cb(true) : void 0;
          } else {
            return typeof cb === "function" ? cb(false) : void 0;
          }
        });
      });
    },
    logout: function(cb) {
      return holdForFacebook(function() {
        return FB.logout(function() {
          return typeof cb === "function" ? cb() : void 0;
        });
      });
    },
    getFriends: function(cb) {
      return holdForFacebook(function() {
>>>>>>> 898f09a9ac137cda4eecc0ea03d11ea1d4d69ec6
        return FB.api("me/?fields=friends.fields(picture.type(large))", function(response) {
          var friend, friends, images, _i, _len, _ref;
>>>>>>> 6b1c0a07eae175907542858fa23eea8302d49be5
          images = response;
          friends = [];
          _ref = images.friends.data;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            friend = _ref[_i];
            friends.push({
              id: friend.id,
              url: friend.picture.data.url
            });
          }
          return cb(friends);
        });
      });
    }
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

}).call(this);
