Q.scene 'login', (stage)->
  stage.insert new Q.Repeater(
    asset: "background-wall.png"
    speedX: 0.5
    speedY: 0.5
  )

  stage.insert new Q.UI.Button
    label: 'Login with Facebook'
    y: 150
    x: Q.width/2
    border: 2
    fill: 'white'
  , ->
    window.auth.loginWithFacebook (loggedIn)->
      if loggedIn
        Q.clearStages()
        Q.stageScene('start')
      else
        alert('You must authorize this app in order to use it.')

#  stage.insert new Q.UI.Button
#    label: 'Login with Twitter'
#    y: 250
#    x: Q.width/2
#    border: 2
#    fill: 'white'
#  , ->
#      window.auth.loginWithTwitter (loggedIn)->
#      if loggedIn
#        Q.clearStages()
#        Q.stageScene('start')
#      else
#        alert('You must authorize this app in order to use it.')