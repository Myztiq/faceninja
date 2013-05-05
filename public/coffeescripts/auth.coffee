Kinvey.init({
    'appKey': 'kid_PPKjRiOFxJ',
    'appSecret': '3067098a3063405cbc931e5ab9266434'
});

# Login the user.
FB.login (response) ->
  if response.authResponse
    
    # User is now logged in via Facebook.
    console.log "My access token is: " + response.authResponse.accessToken
    console.log "My access token expiry is: " + response.authResponse.expiresIn
  
  # Here, you want to call "Kinvey.User.loginWithFacebook" (see below).
  else


# User cancelled login or did not fully authorize.

# Create a new user object, and login using a Facebook access token. The second
# argument can be used to set additional user properties (in this case: "name").
user = new Kinvey.User()
user.loginWithFacebook
  access_token: "<access-token>"
  expires_in: "<access-token-expiry>"
,
  name: "John Doe"
,
  success: (user) ->

  
  # The Facebook account is now linked to a Kinvey.User.
  # user.getIdentity() will return the users Facebook identity.
  error: (e) ->


# Failed to login with Facebook.
# e holds information about the nature of the error.

