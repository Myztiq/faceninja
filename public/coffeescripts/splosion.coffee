getRandomArbitary = (min, max)->
  Math.random() * (max - min) + min;

canvas = document.createElement('canvas')
canvas.width = 2000
canvas.height = 2000
ctx = canvas.getContext '2d'

getPixelData = (imageData, x, y)->
  idx = y * imageData.width * 4 + x * 4
  return [
    imageData.data[idx]
    imageData.data[++idx]
    imageData.data[++idx]
    imageData.data[++idx]
  ]



Quintus.Particles = (Q)->
  Q.explode = (source, options = {})->
    options.pieces or= 50

    xPieces = Math.round(Math.sqrt(options.pieces))
    yPieces = Math.round(Math.sqrt(options.pieces))

    #Setup the canvas
    canvas.width = 2000
    canvas.height = 2000

    ctx.translate(source.p.w/2, source.p.h/2)

    ctx.rotate(source.p.angle*Math.PI/180)
    source.draw(ctx)
    source.destroy()

    imgData = ctx.getImageData(0,0,source.p.w, source.p.h)

#    while imgData.width % xPieces != 0
#      xPieces--
#
#    while imgData.height % yPieces != 0
#      yPieces--


    stepX = Math.round(imgData.width/xPieces)
    stepY = Math.round(imgData.height/yPieces)

    stage = Q.stage()

    for x in [0..imgData.width-1] by stepX
      for y in [0..imgData.height-1] by stepY
        myImageData = ctx.createImageData(stepX, stepY);
        counter = 0

        for subY in [1..stepY]
          for subX in [1..stepX]
            pixelData = getPixelData(imgData, subX+x, subY+y)
            for pixel in pixelData
              myImageData.data[counter] = pixel
              counter++

        splosionSettings =
          x: x * source.p.scale + source.p.x - source.p.w * source.p.scale / 2
          y: y * source.p.scale + source.p.y - source.p.h * source.p.scale / 2
          scale: source.p.scale
          pixelData: myImageData
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

    @p.w = @p.pixelData.width
    @p.h = @p.pixelData.height

    @add "tween"
    @on 'step'

    @p.scale *= getRandomArbitary(1,2)
    @p.angle = getRandomArbitary(-500,500)

    canvas.width = @p.pixelData.width
    canvas.height = @p.pixelData.height
    ctx.putImageData(@p.pixelData, 0,0)
    img = new Image
    img.src = canvas.toDataURL()
    @p.img = img


  draw: (ctx)->
    ctx.drawImage(@p.img, 0, 0)

  step: (dt)->
    if !@first
      @first = true
      @animate {scale: 0, angle: 0}, 1,
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