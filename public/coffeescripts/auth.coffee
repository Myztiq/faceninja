Kinvey.init({
    'appKey': 'kid_TeG4DSfgkf',
    'appSecret': '989e6e6da8984a8b84e2fb9257e206e4'
});

window.auth =
  logout: (cb)->
    Kinvey.getCurrentUser().logout
      success: ->
        Kinvey.Store.Cached.clear
          success: ->
            cb?()
          error: (e)->
            cb? e
      error: (e)->
        cb? e

  loginWithFacebook: (cb)->
    Kinvey.OAuth.signIn 'facebook',
      success: (tokens)->
        user = new Kinvey.User()
        user.loginWithFacebook tokens, {},
          success: ->
            console.log user.getIdentity()
            cb? true
          error: (e)->
            console.log e
            alert('Unable to sign in.')
            cb? false

      error: (e)->
        console.log e
        alert("Unable to sign in.")
        cb? false

  loginWithTwitter: (cb)->
    Kinvey.OAuth.signIn 'twitter',
      success: (tokens)->
        user = new Kinvey.User()
        user.loginWithTwitter tokens, {},
          success: ->
            console.log tokens
            console.log user.getIdentity()
            cb? true
          error: (e)->
            console.log e
            alert('Unable to sign in.')
            cb? false

      error: (e)->
        console.log e
        alert("Unable to sign in.")
        cb? false


window.getFriends = (cb)->
  myFriends = new Kinvey.Collection('friends', {store: 'cachefirst-norefresh'})
  myFriends.fetch
    success: (friends)->
      rtn = []
      for friend in friends
        rtn.push friend.toJSON(true)

      cb rtn
    error: (e)->
      console.log e
      alert('Could not load friends!')