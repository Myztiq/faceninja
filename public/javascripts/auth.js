
  window.fbAsyncInit = function() {
    FB.init({
      appId: "168848406613915",
      channelUrl: "/channel.html",
      status: true,
      xfbml: true
    });
    return FB.login((function(response) {
      if (response.authResponse) {
        console.log("Welcome!  Fetching your information.... ");
        return FB.api("me/?fields=friends.fields(picture.type(large))", function(response) {
          var friend, friends, images, _i, _len, _ref;
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
          console.log('yay?');
          return console.log(friends);
        });
      } else {
        return console.log("User cancelled login or did not fully authorize.");
      }
    }), {
      scope: "friends_photos"
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
