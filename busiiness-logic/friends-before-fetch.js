function onPreFetch(request, response, modules){
  var username = request.username;
  getUser(request, response, modules, username, function(user){
    if (user._socialIdentity != null && user._socialIdentity.facebook != null) {
      getFacebookFriends(request, response, modules, user, function(friends){
        response.body = friends;
        response.complete(200);
      });
    }else if (user._socialIdentity != null && user._socialIdentity.twitter != null){
      getTwitterFriends(request, response, modules, user, function(friends){
        response.body = friends;
        response.complete(200);
      });
    }else{

      response.body = "Unable to find social identity";
      response.complete(404);
    }
  })
}

function getFacebookFriends(request, response, modules, user, cb){
  modules.request.get({
      uri: 'https://graph.facebook.com/me/',
      qs:{
        fields: 'friends.fields(picture.type(large))',
        redirect: false,
        access_token: user._socialIdentity.facebook.access_token
      }
    },
    function(e, xhr, body){
      if(e){
        response.body = e;
        response.complete(500);
        return;
      }
      if(xhr.status != 200){
        response.body = body;
        response.complete(xhr.status);
        return;
      }

      rtn = []
      friends = JSON.parse(body).friends.data;
      for(var i=0;i<friends.length;i++){
        if(friends[i].picture.data.url.indexOf('fbcdn.net') == -1){
          rtn.push({
            type: 'facebook',
            id: friends[i].id,
            url: friends[i].picture.data.url
          });
        }
      }
      cb(rtn);
    }
  );
}

function getTwitterFriends(request, response, modules, user, cb){
  getOauthSettings(request, response, modules, 'twitter', function(oauthSettings){
    modules.request.get({
        uri: 'https://api.twitter.com/1.1/friends/list.json',
        oauth:{
          consumer_key: oauthSettings.consumer_key
        , consumer_secret: oauthSettings.consumer_secret
        , token: user._socialIdentity.twitter.access_token
        }
      },
      function(e, xhr, body){
        if(e){
          response.body = e;
          response.complete(500);
          return;
        }
        if(xhr.status != 200){
          response.body = body;
          response.complete(xhr.status);
          return;
        }

        rtn = []
        friends = JSON.parse(body);
        modules.logger.info(friends)
        for(var i=0;i<friends.length;i++){
          if(friends[i].picture.data.url.indexOf('fbcdn.net') == -1){
            rtn.push({
              type: 'facebook',
              id: friends[i].id,
              url: friends[i].picture.data.url
            });
          }
        }
        cb(rtn);
      }
    );
  })
}

function getOauthSettings(request, response, modules, key, cb){
  modules.collectionAccess.collection('oauth').find({_id: key}, function(err, oauth){
    if(err){
      response.body(err)
      response.error(500);
    }else{
      cb(oauth[0]);
    }
  });
}

function getUser(request, response, modules, username, cb){
  modules.collectionAccess.collection('user').find({username: username}, function(err, user){
    if(err){
      response.body(err)
      response.error(500);
    }else{
      cb(user[0]);
    }
  });
}