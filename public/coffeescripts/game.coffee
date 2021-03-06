# Set up an instance of the Quintus engine  and include
# the Sprites, Scenes, Input and 2D module. The 2D module
# includes the `TileLayer` class as well as the `2d` componet.

Q = window.Q = Quintus({ audioSupported: [ 'mp3', 'ogg' ] }).include("Sprites, Scenes, Input, 2D, Anim, Touch, UI, Audio").enableSound()

# ## Asset Loading and Game Launch
# Q.load can be called at any time to load additional assets
# assets that are already loaded will be skipped
# The callback will be triggered when everything is loaded
document.addEventListener 'DOMContentLoaded', ->
  loadArray =[
    "background-wall.png"
    "enemy.png"
  ]

  for i in [1..5]
    loadArray.push '/audio/effects/mellow-explode/explode_'+i+'.mp3'
#    loadArray.push '/audio/effects/explode/explode_'+i+'.mp3'


  Q.load loadArray, ->
    Q.include 'Particles'
    Q.sheet "enemy", "enemy.png",
      tilew: 300
      tileh: 240

    # And turn on default input   controls and touch input (for UI)
    Q.setup({maximize: true}).controls().touch(Q.SPRITE_ALL)

    # Finally, call stageScene to run the game
    if Kinvey.getCurrentUser()?
      Q.stageScene "start"
    else
      Q.stageScene "login"