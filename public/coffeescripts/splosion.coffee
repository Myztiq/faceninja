getRandomArbitary = (min, max)->
  Math.random() * (max - min) + min;

canvas = document.createElement('canvas')
ctx = canvas.getContext '2d'

Quintus.Particles = (Q)->
  Q.explode = (source, options = {})->
    options.pieces or= 50

    xPieces = Math.ceil(Math.sqrt(options.pieces))
    yPieces = Math.ceil(Math.sqrt(options.pieces))

    if source.p.w < xPieces
      xPieces = source.p.w

    if source.p.h < yPieces
      yPieces = source.p.h

    #Setup the canvas
    canvas.width = source.p.w
    canvas.height = source.p.h
    ctx.save()

    ctx.translate(source.p.w/2, source.p.h/2)

    ctx.rotate(source.p.angle*Math.PI/180)
    source.draw(ctx)
    source.destroy()
    ctx.restore()

    imgData = canvas.toDataURL()

    img = new Image
    img.src = imgData

    stepX = Math.round(source.p.w/xPieces)
    stepY = Math.round(source.p.h/yPieces)

    stage = Q.stage()

    for x in [0..source.p.w-1] by stepX
      for y in [0..source.p.h-1] by stepY

        splosionSettings =
          x: x * source.p.scale + source.p.x - source.p.w * source.p.scale / 2
          y: y * source.p.scale + source.p.y - source.p.h * source.p.scale / 2
          scale: source.p.scale
          subImage:
            full: img
            startX: x
            startY: y
            width: stepX
            height: stepY

          vx: source.p.vx
          vy: source.p.vy

        splosionSettings.vx = getRandomArbitary(-200,200)
        splosionSettings.vy = getRandomArbitary(-200,200)

        stage.insert new Q.Splosion splosionSettings


Q.Sprite.extend "Splosion",
  init: (p) ->
    @_super p,
      type: Q.SPRITE_NONE
      vx: 0,
      vy: 0,
      ax: 0,
      ay: 0,
      gravity: .2
      o: 1

    @p.w = @p.subImage.width
    @p.h = @p.subImage.height

    @add "tween"
    @on 'step'

    @p.scale *= getRandomArbitary(1,2)
    @p.angle = getRandomArbitary(-500,500)

  draw: (ctx)->
    ctx.globalAlpha = @p.o
    ctx.drawImage(@p.subImage.full, @p.subImage.startX, @p.subImage.startY, @p.subImage.width, @p.subImage.height, 0, 0, @p.subImage.width, @p.subImage.height)

  step: (dt)->
    if !@first
      @first = true
      @animate {angle: 0, scale: 0, o: 0}, 1,
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