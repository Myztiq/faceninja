

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
    Q.stageScene('level1')

  stage.insert new Q.UI.Button
    label: 'Resume Game'
    y: 250
    x: Q.width/2
    border: 2
    fill: 'white'
  , unpause

  stage.insert new Q.UI.Button
    label: 'Logout'
    y: 350
    x: Q.width/2
    border: 2
    fill: 'white'
  , ->
    Q.clearStages()
    Q.stageScene('login')
