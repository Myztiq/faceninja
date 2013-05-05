
Q.Sprite.extend "Sword",
  init: (p)->
    @_super p,
      type: Q.SPRITE_DEFAULT
      w: 10
      h: 10
      o: 1

    @inactive = false
    @add "tween"
    @on 'step'
    @on 'hit'

  step: (dx)->
    if !@inactive
      @stage.collide @, Q.SPRITE_ENEMY

    if !@started
      @started=true
      @animate {w: 0,h: 0, o: 0}, .05, Q.Easing.Quadratic.In,
        callback: =>
          @destroy()

  draw: (ctx)->
    ctx.fillStyle = "rgba(220,220,220,#{@p.o})";
    ctx.beginPath()
    ctx.arc(0, 0, @p.w/2, 0, Math.PI*2, true)
    ctx.closePath()
    ctx.fill()

  hit: (options)->
    if !@inactive
      options.obj.slice()

  kill: ()->
    @inactive = true