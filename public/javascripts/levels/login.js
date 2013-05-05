
  Q.scene('login', function(stage) {
    stage.insert(new Q.Repeater({
      asset: "background-wall.png",
      speedX: 0.5,
      speedY: 0.5
    }));
    return stage.insert(new Q.UI.Button({
      label: 'Login',
      y: 150,
      x: Q.width / 2,
      border: 2,
      fill: 'white'
    }, function() {
      Q.clearStages();
      return Q.stageScene('start');
    }));
  });
