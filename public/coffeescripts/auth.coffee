holds = []
isFbInit = false
window.fbAsyncInit = ->
  isFbInit = true
  
  # init the FB JS SDK
  FB.init
    appId: "168848406613915" # App ID from the app dashboard
    channelUrl: "/channel.html" # Channel file for x-domain comms
    status: true # Check Facebook Login status
    xfbml: true # Look for social plugins on the page

  #release holds
  for hold in holds
    hold()

holdForFacebook = (method)->
  if !isFbInit
    holds.push method
  else
    method?()


window.facebook =
  isLoggedIn: (cb)->
    holdForFacebook ()->
      FB.getLoginStatus (response)->
        if response.status == 'connected'
          cb?(true)
        else
          cb?(false)

  login: (cb)->
    holdForFacebook ()->
      FB.login (response)->
        if response.authResponse
          cb? true
        else
          cb? false

  logout: (cb)->
    holdForFacebook ()->
      FB.logout ->
        cb?()

  getFriends: (cb)->
    holdForFacebook ()->
      FB.api "me/?fields=friends.fields(picture.type(large))&redirect=false", (response) ->
        images = response
        friends = []
        for friend in images.friends.data
          if friend.picture.data.url.indexOf('fbcdn.net') == -1
            friends.push
             id: friend.id
             url: friend.picture.data.url

        cb friends


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
