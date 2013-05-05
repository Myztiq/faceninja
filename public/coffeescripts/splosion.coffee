getRandomArbitary = (min, max)->
  Math.random() * (max - min) + min;

Quintus.Particles = (Q)->
  Q.explode = (source)->
    width = source.p.w * source.p.scale
    height = source.p.h * source.p.scale
    console.log width, height

Q.Sprite.extend "Splosion",
  init: (p) ->
    @_super p,
      type: Q.SPRITE_DEFAULT
      w: 1
      h: 1
      o: 1
    @add "tween"
    @on 'step'
    @p.collisionMask = Q.SPRITE_NONE

  draw: (ctx)->
    ctx.fillStyle = "rgba(220,220,220,#{@p.o})";
    ctx.beginPath()
    ctx.arc(0, 0, @p.w/2, 0, Math.PI*2, true)
    ctx.closePath()
    ctx.fill()

  step: ()->
    if !@first
      @first = true
      @animate {scale: @p.scale+.3, angle: 0}, 2,
        callback: =>
          @destroy()