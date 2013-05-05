(function() {
  var Q, getRandomArbitary, mousePositions, width;

  Q = window.Q = Quintus().include("Sprites, Scenes, Input, 2D, Anim, Touch, UI");

  width = 400;

  mousePositions = [];

  getRandomArbitary = function(min, max) {
    return Math.random() * (max - min) + min;
  };

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

  Q.scene('start', function(stage) {
    stage.insert(new Q.Repeater({
      asset: "background-wall.png",
      speedX: 0.5,
      speedY: 0.5
    }));
    stage.insert(new Q.UI.Button({
      label: 'Start Game',
      y: 150,
      x: Q.width / 2,
      border: 2,
      fill: 'white'
    }, function() {
      Q.clearStages();
      return Q.stageScene('level1');
    }));
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

  Q.scene("level1", function(stage) {
    var timer, vibrating;
    stage.insert(new Q.Repeater({
      asset: "background-wall.png",
      speedX: 0.5,
      speedY: 0.5
    }));
    timer = 0;
    vibrating = false;
    stage.add("viewport, tween");
    stage.on('vibrate', function() {
      if (!vibrating) {
        vibrating = true;
        return this.animate({
          x: Math.random() * 20,
          y: Math.random() * 20
        }, .1, Q.Easing.Quadratic.In, {
          callback: function() {
            return this.animate({
              x: 0,
              y: 0,
              scale: 1
            }, .05, Q.Easing.Quadratic.In, {
              callback: function() {
                return vibrating = false;
              }
            });
          }
        });
      }
    });
    return stage.on('step', function(dt) {
      var distance, height, i, max, min, offset, old, position, step, _i, _len, _ref, _ref2, _results;
      Q.input.on("fire", function() {
        stage.pause();
        Q.stageScene('pause', 1);
      });
      old = null;
      for (_i = 0, _len = mousePositions.length; _i < _len; _i++) {
        position = mousePositions[_i];
        if ((old != null) && (position != null)) {
          distance = {
            x: old.x - position.x,
            y: old.y - position.y
          };
          distance.total = Math.round(Math.sqrt(Math.pow(old.x - position.x, 2) + Math.pow(old.y - position.y, 2)));
          for (step = 0, _ref = distance.total; step <= _ref; step += 4) {
            offset = {
              x: distance.x * step / distance.total,
              y: distance.y * step / distance.total
            };
            stage.insert(new Q.Sword({
              x: position.x + offset.x,
              y: position.y + offset.y
            }));
          }
        } else if (position != null) {
          stage.insert(new Q.Sword({
            x: position.x,
            y: position.y
          }));
        }
        old = position;
      }
      mousePositions = [mousePositions[mousePositions.length - 1]];
      timer += dt;
      if (timer > 1.5) {
        timer = 0;
        offset = Q.el.width;
        min = offset / 2 - (width / 2);
        max = offset / 2 + (width / 2);
        height = Q.el.height;
        _results = [];
        for (i = 0, _ref2 = getRandomArbitary(1, 4); 0 <= _ref2 ? i <= _ref2 : i >= _ref2; 0 <= _ref2 ? i++ : i--) {
          _results.push(stage.insert(new Q.Enemy({
            x: getRandomArbitary(min, max),
            y: height + 20
          })));
        }
        return _results;
      }
    });
  });

  Q.load("background-wall.png, enemy.png, https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash4/c50.50.625.625/s160x160/420279_773038823690_1127613549_n.jpg", function() {
    Q.include('Particles');
    Q.sheet("enemy", "enemy.png", {
      tilew: 300,
      tileh: 240
    });
    Q.setup({
      maximize: true
    }).controls().touch(Q.SPRITE_ALL);
    Q.stageScene("login");
    return Q.el.addEventListener("mousemove", function(e) {
      return mousePositions.push({
        x: e.offsetX || e.layerX,
        y: e.offsetY || e.layerY
      });
    });
  });

}).call(this);
