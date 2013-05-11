getRandomArbitary = (min, max)->
  Math.random() * (max - min) + min;



# Create a new scene called level 1
_friends = null
Q.scene "loadLevel1", (stage) ->
  window.facebook.getFriends (friends)->
    _friends = null
    resources = []
    for friend in friends
      resources.push friend.url


    _friends = friends
    Q.stageScene 'loading'
    Q.load resources, ()->
      Q.clearStages()
      Q.stageScene 'level1'

Q.scene "level1", (stage) ->
  Q.stageScene 'score', 2

  width = 400
  mousePositions = []

  stage.on 'destroyed', (dt)->
    Q.el.removeEventListener "mousemove", @mousemoveListener

  @mousemoveListener = Q.el.addEventListener "mousemove", (e) ->
    mousePositions.push
      x: e.offsetX or e.layerX
      y: e.offsetY or e.layerY

  # Add in a repeater for a little parallax action

  stage.insert new Q.Repeater(
    asset: "background-wall.png"
    speedX: 1.5
    speedY: 1.5
  )
  timer = 0
  vibrating = false
  stage.add("viewport, tween")

  stage.on 'vibrate', ()->
    if !vibrating
      vibrating =  true
      vibration = 30
      @animate { x:Math.random()*vibration, y: Math.random()*vibration},.07,  Q.Easing.Quadratic.In,
        callback: ->
          @animate {x:0, y: 0, scale: 1},.07,  Q.Easing.Quadratic.In,
            callback: ->
              vibrating = false

  stage.on 'step', (dt)->
    Q.input.on "fire", ->
      stage.pause()
      Q.stageScene('pause', 1)
      return


    old = null
    for position in mousePositions
      if old? and position?
        # Fill the space between the two positions.
        distance =
          x: old.x - position.x
          y: old.y - position.y
        distance.total = Math.round(Math.sqrt(Math.pow(old.x - position.x,2) + Math.pow(old.y - position.y,2)))

        for step in [0..distance.total] by 4
          offset =
            x: distance.x * step / distance.total
            y: distance.y * step / distance.total

          stage.insert new Q.Sword
            x: position.x + offset.x
            y: position.y + offset.y

      else if position?
        stage.insert new Q.Sword
          x: position.x
          y: position.y

      old = position

    mousePositions = [mousePositions[mousePositions.length-1]]

    timer += dt
    if timer > 1.5
      timer = 0
      offset = Q.el.width
      min = offset / 2 - (width / 2)
      max = offset / 2 + (width / 2)

      height = Q.el.height
      for i in [0..getRandomArbitary(1,4)]
        friend = _friends[Math.round(getRandomArbitary(0,_friends.length-1))]
        stage.insert new Q.Enemy
          asset: friend.url
          friend: friend.id
          x: getRandomArbitary(min,max)
          y: height+20

