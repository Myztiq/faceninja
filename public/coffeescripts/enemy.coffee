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
      asset: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash4/c50.50.625.625/s160x160/420279_773038823690_1127613549_n.jpg"
      angle: getRandomArbitary(-20,20)
      type: Q.SPRITE_ENEMY
      scale: getRandomArbitary(.5,.1)

    @_super p
    @add "2d, tween"
    @p.collisionMask = Q.SPRITE_NONE

  slice: (data)->
    if !@dead
      @dead = true
#      angleX = data.x
#      angleY = data.y
#
#      @p.vy += angleY*50
#      @p.vx += angleX*50

      fadeOutTime = .5

#      rand = Math.round getRandomArbitary 1,5
#      Q.audio.play("/audio/effects/explode_#{rand}.mp3")

      Q.stage().trigger 'vibrate'
      Q.explode(@)
      @animate {angle: 1720, scale: .001}, fadeOutTime, Q.Easing.Linear,
        callback: =>
          @destroy()

  draw: (ctx)->
    ctx.beginPath()

    ctx.arc(0, 0, @p.w/2, 0, Math.PI*2, true)

    ctx.closePath()
    ctx.clip()
    ctx.drawImage(Q.asset(@p.asset),-@p.cx,-@p.cy)

  step: ()->
    if !@first
      @first = true
      @animate({scale: @p.scale+.3, angle: 0}, 2)

    if @p.y > Q.el.height + 200
      @destroy()