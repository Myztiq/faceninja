# Set up an instance of the Quintus engine  and include
# the Sprites, Scenes, Input and 2D module. The 2D module
# includes the `TileLayer` class as well as the `2d` componet.

Q = window.Q = Quintus().include("Sprites, Scenes, Input, 2D, Anim, Touch, UI")

# ## Asset Loading and Game Launch
# Q.load can be called at any time to load additional assets
# assets that are already loaded will be skipped
# The callback will be triggered when everything is loaded
document.addEventListener 'DOMContentLoaded', ->
  Q.load "background-wall.png, enemy.png, https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash4/c50.50.625.625/s160x160/420279_773038823690_1127613549_n.jpg", ->
    Q.include 'Particles'
    Q.sheet "enemy", "enemy.png",
      tilew: 300
      tileh: 240

    # And turn on default input   controls and touch input (for UI)
    Q.setup({maximize: true}).controls().touch(Q.SPRITE_ALL)

    # Finally, call stageScene to run the game
    window.facebook.isLoggedIn (loggedIn)->
      if loggedIn
        Q.stageScene "start"
      else
        Q.stageScene "login"
