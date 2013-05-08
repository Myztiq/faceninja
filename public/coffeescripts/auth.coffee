window.fbAsyncInit = ->
  
  # init the FB JS SDK
  FB.init
    appId: "168848406613915" # App ID from the app dashboard
    channelUrl: "/channel.html" # Channel file for x-domain comms
    status: true # Check Facebook Login status
    xfbml: true # Look for social plugins on the page

  FB.login ((response) ->
    if response.authResponse
      console.log "Welcome!  Fetching your information.... "

      FB.api "me/?fields=friendslist.fields(picture.type(large))", (response) ->
        images = response
        console.log images

    else
      console.log "User cancelled login or did not fully authorize."
  ),
    scope: "friends_photos"


  


# Additional initialization code such as adding Event Listeners goes here

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