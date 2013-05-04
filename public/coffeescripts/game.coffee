# Set up an instance of the Quintus engine  and include
# the Sprites, Scenes, Input and 2D module. The 2D module
# includes the `TileLayer` class as well as the `2d` componet.

# Maximize this game to whatever the size of the browser is

getRandomArbitary = (min, max)->
  Math.random() * (max - min) + min;



# And turn on default input controls and touch input (for UI)
Q = window.Q = Quintus().include("Sprites, Scenes, Input, 2D, Anim, Touch, UI")
Q.setup(maximize: true).controls().touch(Q.SPRITE_ALL)

# ## Enemy Sprite
# Create the Enemy class to add in some baddies
Q.Sprite.extend "Enemy",
  init: (p) ->
    p.vx = getRandomArbitary(0,400)
    if p.x > 400
      p.vx *= -1

    @_super p,
      vx: getRandomArbitary(-400,400)
      vy:-1300
      scale: getRandomArbitary(.5,.1)
      sheet: "enemy"

    @on 'touch'

    # Enemies use the Bounce AI to change direction
    # whenver they run into something.

    @add "2d, tween"

  touch: (data)->
    if !@dead
      @dead = true
      angleX = data.oldLocation.x - data.location.x
      angleY = data.oldLocation.y - data.location.y

      @p.vy -= angleY*50
      @p.vx -= angleX*50

      fadeOutTime = .5
      @animate({angle: 1720, scale: .001}, fadeOutTime, Q.Easing.Linear)
      window.setTimeout =>
        @destroy()
      , fadeOutTime * 1000




# ## Level1 scene
# Create a new scene called level 1
Q.scene "level1", (stage) ->

  # Add in a repeater for a little parallax action

  stage.insert new Q.Repeater(
    asset: "background-wall.png"
    speedX: 0.5
    speedY: 0.5
  )

  # Create the player and add them to the stage

  console.log stage
  stage.insert new Q.Enemy
    x: getRandomArbitary(0,800)
    y: 1000
  stage.insert new Q.Enemy
    x: getRandomArbitary(0,800)
    y: 1000
  stage.insert new Q.Enemy
    x: getRandomArbitary(0,800)
    y: 1000
  stage.insert new Q.Enemy
    x: getRandomArbitary(0,800)
    y: 1000
  stage.insert new Q.Enemy
    x: getRandomArbitary(0,800)
    y: 1000
  stage.insert new Q.Enemy
    x: getRandomArbitary(0,800)
    y: 1000
  stage.insert new Q.Enemy
    x: getRandomArbitary(0,800)
    y: 1000
  stage.insert new Q.Enemy
    x: getRandomArbitary(0,800)
    y: 1000
  stage.insert new Q.Enemy
    x: getRandomArbitary(0,800)
    y: 1000


# ## Asset Loading and Game Launch
# Q.load can be called at any time to load additional assets
# assets that are already loaded will be skipped
# The callback will be triggered when everything is loaded
Q.load "background-wall.png, enemy.png", ->

  Q.sheet "enemy", "enemy.png",
    tilew: 300
    tileh: 240

  # Finally, call stageScene to run the game
  Q.stageScene "level1"

  # Touch events do most of the work for us, but the
  # touch system doesn't handle mousemouse events, so lets add
  # in an event listener and use `Stage.locate` to highlight
  # sprites on desktop.
  oldLocation =
    x: 0
    y: 0
  Q.el.addEventListener "mousemove", (e) ->
    x = e.offsetX or e.layerX
    y = e.offsetY or e.layerY
    stage = Q.stage()

    # Use the helper methods from the Input Module on Q to
    # translate from canvas to stage
    stageX = Q.canvasToStageX(x, stage)
    stageY = Q.canvasToStageY(y, stage)

    # Find the first object at that position on the stage
    obj = stage.locate(stageX, stageY)

    if obj?.touch?
      # Set a `hit` property so the step method for the
      # sprite can handle scale appropriately
      obj.touch
        location:
          x: x
          y: y
        oldLocation: oldLocation

    oldLocation =
      x: x
      y: y
