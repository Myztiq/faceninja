getRandomArbitary = (min, max)->
  Math.random() * (max - min) + min;

Quintus.Particles = (Q)->
  Q.explode = (source)->
    width = source.p.w * source.p.scale
    height = source.p.h * source.p.scale
    stage = Q.stage()
    source.destroy()
    for i in [0..100]
      stage.insert new Q.Splosion
        x: source.p.x
        y: source.p.y
        vx: getRandomArbitary(0,3) * source.p.vx
        vy: getRandomArbitary(0,3) * source.p.vy


Q.Sprite.extend "Splosion",
  init: (p) ->
    @_super p,
      type: Q.SPRITE_NONE
      w: 1
      h: 1
      o: 1
    @add "tween, 2d"
    @on 'step'
    @p.collisionMask = Q.SPRITE_NONE

  draw: (ctx)->
    r = Math.round getRandomArbitary(0,255)
    g = Math.round getRandomArbitary(0,255)
    b = Math.round getRandomArbitary(0,255)
    ctx.fillStyle = "rgba(#{r},#{g},#{b},#{@p.o})";
    ctx.beginPath()
    ctx.arc(0, 0, 2, 0, Math.PI*2, true)
    ctx.closePath()
    ctx.fill()

  step: ()->
    if !@first
      @first = true
      @animate {angle: 300, o: 0}, .6,
        callback: =>
          @destroy()