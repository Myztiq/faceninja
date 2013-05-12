Q.scene 'start', (stage)->

  if Kinvey.getCurrentUser()?
    stage.insert new Q.Repeater(
      asset: "background-wall.png"
      speedX: 0.5
      speedY: 0.5
    )

    stage.insert new Q.UI.Button
      label: 'Start Game'
      y: 150
      x: Q.width/2
      border: 2
      fill: 'white'
    , ->
      Q.clearStages()
      Q.stageScene('loadLevel1')

    stage.insert new Q.UI.Button
      label: 'Logout'
      y: 350
      x: Q.width/2
      border: 2
      fill: 'white'
    , ->
      Kinvey.getCurrentUser().logout
        success: ->
          Q.clearStages()
          Q.stageScene('login')
        error: (e)->
          console.log e
          alert('Unable to logout!')
          Q.clearStages()
          Q.stageScene "login"

  else
    Q.stageScene "login"