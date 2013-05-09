Q.scene 'login', (stage)->
  stage.insert new Q.Repeater(
    asset: "background-wall.png"
    speedX: 0.5
    speedY: 0.5
  )

  stage.insert new Q.UI.Button
    label: 'Login'
    y: 150
    x: Q.width/2
    border: 2
    fill: 'white'
  , ->
    window.facebook.login (loggedIn)->
      if loggedIn
        Q.clearStages()
        Q.stageScene('start')
      else
        alert('You must authorize this app in order to use it.')