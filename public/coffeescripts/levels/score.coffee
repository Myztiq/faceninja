window.score = {}

Q.scene "score", (stage) ->
  window.score =
    kills: 0
    lives: 5

  kills = stage.insert new Q.UI.Text
    label: ""
    y: 20
    x: Q.width/2 + 100

  lives = stage.insert new Q.UI.Text
    label: ""
    size: 50
    y: 20
    x: Q.width/2 - 100

  stage.on 'step', ()->
    kills.p.label = "Kills #{window.score.kills}"

    if window.score.lives < 0
      Q.clearStages()
      Q.stageScene 'gameOver'




    livesLabel = ""
    for life in [0..window.score.lives]
      livesLabel += "♥"

    lives.p.label = livesLabel