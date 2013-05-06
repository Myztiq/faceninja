
window.fbAsyncInit = ->
  
  # init the FB JS SDK
  FB.init
    appId: "168848406613915" # App ID from the app dashboard
    channelUrl: "/channel.html" # Channel file for x-domain comms
    status: true # Check Facebook Login status
    xfbml: true # Look for social plugins on the page

  
  # Additional initialization code such as adding Event Listeners goes here
  FB.login (response) ->
    if response.authResponse
      console.log "My access token is: " + response.authResponse.accessToken
	  console.log "My access token expiry is: " + response.authResponse.expiresIn
      FB.api "/me", (response) ->
        console.log "Good to see you, " + response.first_name + "."
        console.log response.friends.fields(picture)

    else
      console.log "User cancelled login or did not fully authorize."



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





