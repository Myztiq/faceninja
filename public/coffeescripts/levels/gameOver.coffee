Q.scene "gameOver", (stage) ->
  usr = Kinvey.getCurrentUser()

  stage.insert new Q.Repeater(
    asset: "background-wall.png"
    speedX: 0.5
    speedY: 0.5
  )

  globalRank = stage.insert new Q.UI.Text
    label: "loading global rank..."
    y: 300
    x: Q.width/2

  globalLeaderboard = stage.insert new Q.UI.Text
    label: "loading global leaderboard..."
    y: 350
    x: Q.width/2


  loadScores = ()->
    query = new Kinvey.Query()
    query.on('highestScore').greaterThan(usr.get('highestScore'))
    users = new Kinvey.Collection('user',{query: query})
    users.count
      success: (count)->
        globalRank.p.label = "Global Rank: #{count+1}"

    query = new Kinvey.Query()
    query.on('highestScore').sort(Kinvey.Query.DESC).setLimit(5)
    users = new Kinvey.Collection('user',{query: query})
    users.fetch
      success: (users)->
        globalLeaderboard.p.label = 'Leaderboard'

        counter = 0
        label = ""
        for user in users
          label += "##{++counter}: #{user.get('name')} - #{user.get('highestScore')}\n"

        stage.insert new Q.UI.Text
            label: label
            y: 350 + ((users.length + 1) * 25)
            x: Q.width/2


  stage.insert new Q.UI.Text
    label: "Game Over"
    size: 50
    y: 100
    x: Q.width/2


  stage.insert new Q.UI.Text
    label: "#{window.score.kills} Kills"
    y: 200
    x: Q.width/2

  stage.insert new Q.UI.Button
    label: 'Continue'
    y: 250
    x: Q.width/2
    border: 2
    fill: 'white'
  , ->
    Q.stageScene('start')

  totalGameTime = usr.get('totalGameTime')
  totalGameTime or= 0

  totalGameTime += new Date() - window.gameStartTime

  usr.set('totalGameTime', totalGameTime)

  highestScore = usr.get('highestScore')
  highestScore or= 0
  if highestScore > window.score.kills
    stage.insert new Q.UI.Text
      label: "Keep Trying. Personal best: #{highestScore}"
      y: 150
      x: Q.width/2
    loadScores()
    usr.save()
  else
    usr.set('winningGameTime', new Date() - window.gameStartTime)
    usr.set('highestScore', window.score.kills)
    usr.save
      success: ->
        loadScores()

    stage.insert new Q.UI.Text
      label: "New personal best!"
      y: 150
      x: Q.width/2


