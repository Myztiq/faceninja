# Set up an instance of the Quintus engine  and include
# the Sprites, Scenes, Input and 2D module. The 2D module
# includes the `TileLayer` class as well as the `2d` componet.

width = 400

getRandomArbitary = (min, max)->
  Math.random() * (max - min) + min;



# And turn on default input controls and touch input (for UI)
Q = window.Q = Quintus().include("Sprites, Scenes, Input, 2D, Anim, Touch, UI")
Q.setup({maximize: true}).controls().touch(Q.SPRITE_ALL)

# ## Enemy Sprite
# Create the Enemy class to add in some baddies
Q.Sprite.extend "Enemy",
  init: (p) ->
    p.vx = getRandomArbitary(0,400)

    offset = Q.el.width
    if p.x > offset / 2
      p.vx *= -1

    p.type = Q.SPRITE_ENEMY


    height = Q.el.height


    @_super p,
      vy:getRandomArbitary(-height, -height - height / 2)
      scale: getRandomArbitary(.3,.01)
      sheet: "enemy"
      angle: getRandomArbitary(-20,20)

    p.collisionMask = 0
    @on 'touch'
    @on 'step'

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

  step: ()->
    if !@first
      @first = true
      @animate({scale: @p.scale+.3, angle: 0}, 2)

    if @p.x > 2000
      @destroy()


# ## Level1 scene
# Create a new scene called level 1
Q.scene "level1", (stage) ->

  # Add in a repeater for a little parallax action

  stage.insert new Q.Repeater(
    asset: "background-wall.png"
    speedX: 0.5
    speedY: 0.5
  )

  offset = Q.el.width
  min = offset / 2 - (width / 2)
  max = offset / 2 + (width / 2)

  height = Q.el.height
  setInterval ->
    for i in [0..getRandomArbitary(1,4)]
      stage.insert new Q.Enemy
        x: getRandomArbitary(min,max)
        y: height+20

  , 1000


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
