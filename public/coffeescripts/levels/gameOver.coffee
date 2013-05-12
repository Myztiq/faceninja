Q.scene "gameOver", (stage) ->

  stage.insert new Q.Repeater(
    asset: "background-wall.png"
    speedX: 0.5
    speedY: 0.5
  )

  stage.insert new Q.UI.Text
    label: "Game Over"
    size: 50
    y: 100
    x: Q.width/2


  stage.insert new Q.UI.Text
    label: "#{window.score.kills} Kills"
    y: 200
    x: Q.width/2

  stage.insert new Q.UI.Button
    label: 'Continue'
    y: 250
    x: Q.width/2
    border: 2
    fill: 'white'
  , ->
    Q.stageScene('start')

  usr = Kinvey.getCurrentUser()
  highestScore = usr.get('highestScore')
  if highestScore > window.score.kills
    stage.insert new Q.UI.Text
      label: "Keep Trying. Personal best: #{highestScore}"
      y: 150
      x: Q.width/2
  else
    usr.set('highestScore', window.score.kills)
    usr.save()
    stage.insert new Q.UI.Text
      label: "New personal best!"
      y: 150
      x: Q.width/2

