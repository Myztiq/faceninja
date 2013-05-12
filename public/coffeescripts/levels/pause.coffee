

Q.scene 'pause', (stage)->
  unpause = ->
    Q.clearStage(1)
    Q.stage(0).unpause()

  Q.input.on "fire",unpause

  stage.insert new Q.UI.Button
    label: 'Restart Game'
    y: 150
    x: Q.width/2
    border: 2
    fill: 'white'
  , ->
    Q.clearStages()
    Q.stageScene('loadLevel1')

  stage.insert new Q.UI.Button
    label: 'Resume Game'
    y: 200
    x: Q.width/2
    border: 2
    fill: 'white'
  , unpause

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
    Q.stageScene 'pause', 1


  stage.insert new Q.UI.Button
    label: 'Logout'
    y: 300
    x: Q.width/2
    border: 2
    fill: 'white'
  , ->
    window.auth.logout ()->
      Q.clearStages()
      Q.stageScene('login')
