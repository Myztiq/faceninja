Q.scene "loading", (stage) ->
  stage.insert new Q.Repeater(
    asset: "background-wall.png"
    speedX: 0.5
    speedY: 0.5
  )

  stage.insert new Q.UI.Text
    label: 'Loading....'
    y: 150
    x: Q.width/2