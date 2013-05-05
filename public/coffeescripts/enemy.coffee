getRandomArbitary = (min, max)->
  Math.random() * (max - min) + min;

# ## Enemy Sprite
# Create the Enemy class to add in some baddies
Q.Sprite.extend "Enemy",
  init: (p) ->
    p.vx = getRandomArbitary(0,400)

    offset = Q.el.width
    if p.x > offset / 2
      p.vx *= -1

    height = Q.el.height

    Q._defaults p,
      vy:getRandomArbitary(-height, -height - height / 2)
      scale: getRandomArbitary(.3,.01)
      sheet: "enemy"
      angle: getRandomArbitary(-20,20)
      type: Q.SPRITE_ENEMY

    @_super p
    @add "2d, tween"
    @p.collisionMask = Q.SPRITE_NONE

  slice: (data)->
    if !@dead
      @dead = true
      angleX = data.x
      angleY = data.y

      @p.vy += angleY*50
      @p.vx += angleX*50

      fadeOutTime = .5
      Q.stage().trigger 'vibrate'

      @animate {angle: 1720, scale: .001}, fadeOutTime, Q.Easing.Linear,
        callback: =>
          @destroy()

  step: ()->
    if !@first
      @first = true
      @animate({scale: @p.scale+.3, angle: 0}, 2)

    if @p.y > Q.el.height + 200
      @destroy()