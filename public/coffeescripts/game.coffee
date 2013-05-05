# Set up an instance of the Quintus engine  and include
# the Sprites, Scenes, Input and 2D module. The 2D module
# includes the `TileLayer` class as well as the `2d` componet.

Q = window.Q = Quintus().include("Sprites, Scenes, Input, 2D, Anim, Touch, UI")

width = 400
mousePositions = []

getRandomArbitary = (min, max)->
  Math.random() * (max - min) + min;

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
    Q.clearStages()
    Q.stageScene('start')

Q.scene 'start', (stage)->
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
    Q.stageScene('level1')

  stage.insert new Q.UI.Button
    label: 'Logout'
    y: 350
    x: Q.width/2
    border: 2
    fill: 'white'
  , ->
    Q.clearStages()
    Q.stageScene('login')


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



# ## Level1 scene
# Create a new scene called level 1
Q.scene "level1", (stage) ->

  # Add in a repeater for a little parallax action

  stage.insert new Q.Repeater(
    asset: "background-wall.png"
    speedX: 0.5
    speedY: 0.5
  )
  timer = 0
  vibrating = false
  stage.add("viewport, tween")

  stage.on 'vibrate', ()->
    if !vibrating
      vibrating =  true
      @animate { x:Math.random()*20, y: Math.random()*20},.1,  Q.Easing.Quadratic.In,
        callback: ->
          @animate {x:0, y: 0, scale: 1},.05,  Q.Easing.Quadratic.In,
            callback: ->
              vibrating = false

  stage.on 'step', (dt)->
    Q.input.on "fire", ->
      stage.pause()
      Q.stageScene('pause', 1)
      return


    old = null
    for position in mousePositions
      if old? and position?
        # Fill the space between the two positions.
        distance =
          x: old.x - position.x
          y: old.y - position.y
        distance.total = Math.round(Math.sqrt(Math.pow(old.x - position.x,2) + Math.pow(old.y - position.y,2)))

        for step in [0..distance.total] by 4
          offset =
            x: distance.x * step / distance.total
            y: distance.y * step / distance.total

          stage.insert new Q.Sword
            x: position.x + offset.x
            y: position.y + offset.y

      else if position?
        stage.insert new Q.Sword
          x: position.x
          y: position.y

      old = position

    mousePositions = [mousePositions[mousePositions.length-1]]

    timer += dt
    if timer > 1.5
      timer = 0
      offset = Q.el.width
      min = offset / 2 - (width / 2)
      max = offset / 2 + (width / 2)

      height = Q.el.height
      for i in [0..getRandomArbitary(1,4)]
        stage.insert new Q.Enemy
          x: getRandomArbitary(min,max)
          y: height+20



# ## Asset Loading and Game Launch
# Q.load can be called at any time to load additional assets
# assets that are already loaded will be skipped
# The callback will be triggered when everything is loaded
Q.load "background-wall.png, enemy.png, https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash4/c50.50.625.625/s160x160/420279_773038823690_1127613549_n.jpg", ->
  Q.include 'Particles'
  Q.sheet "enemy", "enemy.png",
    tilew: 300
    tileh: 240

  # And turn on default input   controls and touch input (for UI)
  Q.setup({maximize: true}).controls().touch(Q.SPRITE_ALL)

  # Finally, call stageScene to run the game
  Q.stageScene "login"

  Q.el.addEventListener "mousemove", (e) ->
    mousePositions.push
      x: e.offsetX or e.layerX
      y: e.offsetY or e.layerY