getRandomArbitary = (min, max)->
  Math.random() * (max - min) + min;

Quintus.Particles = (Q)->
  Q.explode = (source)->
    width = source.p.w * source.p.scale
    height = source.p.h * source.p.scale
    stage = Q.stage()
    source.destroy()
    for i in [0..100]
      speed = 200
      stage.insert new Q.Splosion
        x: source.p.x + getRandomArbitary(-20,20)
        y: source.p.y + getRandomArbitary(-20,20)
        vx: getRandomArbitary(-speed,speed)
        vy: getRandomArbitary(-speed,speed)


Q.Sprite.extend "Splosion",
  init: (p) ->
    @_super p,
      type: Q.SPRITE_NONE
      w: getRandomArbitary(0,4)
      o: 1

      vx: 0,
      vy: 0,
      ax: 0,
      ay: 0,
      gravity: .02

    @add "tween"
    @on 'step'

    r = Math.round getRandomArbitary(0,255)
    g = Math.round getRandomArbitary(0,255)
    b = Math.round getRandomArbitary(0,255)
    @color = "rgba(#{r},#{g},#{b},#{@p.o})";

  draw: (ctx)->
    ctx.fillStyle = @color
    ctx.beginPath()
    ctx.arc(0, 0, @p.w, 0, Math.PI*2, true)
    ctx.closePath()
    ctx.fill()

  step: (dt)->
    if !@first
      @first = true
      @animate {w: 0, o: 0}, 1,
        callback: =>
          @destroy()
    p = @p
    dtStep = dt

    while dtStep > 0
      dt = Math.min(1 / 30, dtStep)

      # Updated based on the velocity and acceleration
      p.vx += p.ax * dt + Q.gravityX * dt * p.gravity
      p.vy += p.ay * dt + Q.gravityY * dt * p.gravity
      p.x += p.vx * dt
      p.y += p.vy * dt
      dtStep -= dt