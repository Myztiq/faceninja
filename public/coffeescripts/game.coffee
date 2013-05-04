# Set up an instance of the Quintus engine  and include
# the Sprites, Scenes, Input and 2D module. The 2D module
# includes the `TileLayer` class as well as the `2d` componet.

# Maximize this game to whatever the size of the browser is

getRandomArbitary = (min, max)->
  Math.random() * (max - min) + min;



# And turn on default input controls and touch input (for UI)
Q = window.Q = Quintus().include("Sprites, Scenes, Input, 2D, Anim, Touch, UI").setup(maximize: true).controls().touch()

# ## Enemy Sprite
# Create the Enemy class to add in some baddies
Q.Sprite.extend "Enemy",
  init: (p) ->

    # Get a number between .5 and .1
    p.scale = getRandomArbitary(.5,.1)
    p.vx = getRandomArbitary(0,400)
    if p.x > 400
      p.vx *= -1
    @_super p,
      vx: getRandomArbitary(-400,400)
      vy:-1300
      sheet: "enemy"

    # Enemies use the Bounce AI to change direction
    # whenver they run into something.
    @add "2d"



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
  enemy = stage.insert new Q.Enemy
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