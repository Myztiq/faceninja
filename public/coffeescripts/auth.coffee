Kinvey.init({
    'appKey': 'kid_PPKjRiOFxJ',
    'appSecret': '3067098a3063405cbc931e5ab9266434'
});

window.fbAsyncInit = ->
  
  # init the FB JS SDK
  FB.init
    appId: "168848406613915" # App ID from the app dashboard
    channelUrl: "/channel.html" # Channel file for x-domain comms
    status: true # Check Facebook Login status
    xfbml: true # Look for social plugins on the page

  
  # Additional initialization code such as adding Event Listeners goes here
  # Login the user.
  FB.login (response) ->
	if response.authResponse
	    
	  # User is now logged in via Facebook.
	  console.log "My access token is: " + response.authResponse.accessToken
	  console.log "My access token expiry is: " + response.authResponse.expiresIn
	  
	# Here, you want to call "Kinvey.User.loginWithFacebook" (see below).
	else


	# User cancelled login or did not fully authorize.

FB.api "/me", (response) ->
  console.log "Your name is " + response.name




# Load the SDK asynchronously
((d, s, id) ->
  js = undefined
  fjs = d.getElementsByTagName(s)[0]
  return  if d.getElementById(id)
  js = d.createElement(s)
  js.id = id
  js.src = "//connect.facebook.net/en_US/all.js"
  fjs.parentNode.insertBefore js, fjs
) document, "script", "facebook-jssdk"





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