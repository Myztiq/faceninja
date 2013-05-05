
  Q.scene('pause', function(stage) {
    var unpause;
    unpause = function() {
      Q.clearStage(1);
      return Q.stage(0).unpause();
    };
    Q.input.on("fire", unpause);
    stage.insert(new Q.UI.Button({
      label: 'Restart Game',
      y: 150,
      x: Q.width / 2,
      border: 2,
      fill: 'white'
    }, function() {
      Q.clearStages();
      return Q.stageScene('level1');
    }));
    stage.insert(new Q.UI.Button({
      label: 'Resume Game',
      y: 250,
      x: Q.width / 2,
      border: 2,
      fill: 'white'
    }, unpause));
    return stage.insert(new Q.UI.Button({
      label: 'Logout',
      y: 350,
      x: Q.width / 2,
      border: 2,
      fill: 'white'
    }, function() {
      Q.clearStages();
      return Q.stageScene('login');
    }));
  });
