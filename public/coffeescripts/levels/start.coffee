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


    usr = Kinvey.getCurrentUser()

    label = 'Mute'
    if usr.get('isMuted')
      label = 'Unmute'

    stage.insert new Q.UI.Button
      label: label
      y: 250
      x: Q.width/2
      border: 2
      fill: 'white'
    , ->
      window.muteSounds = !window.muteSounds
      usr.set('isMuted', window.muteSounds)
      usr.save()
      Q.stageScene 'start'

    stage.insert new Q.UI.Button
      label: 'Logout'
      y: 350
      x: Q.width/2
      border: 2
      fill: 'white'
    , ->
      window.auth.logout (e)->
        if e
          console.log e
          alert('Unable to logout!')

        Q.clearStages()
        Q.stageScene "login"

  else
    Q.stageScene "login"