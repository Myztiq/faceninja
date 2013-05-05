(function() {
  var Q, getRandomArbitary, mousePositions, width;

  Q = window.Q = Quintus().include("Sprites, Scenes, Input, 2D, Anim, Touch, UI");

  width = 400;

  mousePositions = [];

  getRandomArbitary = function(min, max) {
    return Math.random() * (max - min) + min;
  };

  Q.scene("level1", function(stage) {
    var timer;
    stage.insert(new Q.Repeater({
      asset: "background-wall.png",
      speedX: 0.5,
      speedY: 0.5
    }));
    timer = 0;
    return stage.on('step', function(dt) {
      var distance, height, i, max, min, offset, old, position, step, sword, swords, _i, _len, _ref, _ref2, _ref3, _results;
      old = null;
      for (_i = 0, _len = mousePositions.length; _i < _len; _i++) {
        position = mousePositions[_i];
        if ((old != null) && (position != null)) {
          distance = {
            x: old.x - position.x,
            y: old.y - position.y
          };
          distance.total = Math.round(Math.sqrt(Math.pow(old.x - position.x, 2) + Math.pow(old.y - position.y, 2)));
          for (step = 0, _ref = distance.total; step <= _ref; step += 5) {
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
      swords = Q('Sword');
      if (swords.length > 100) {
        for (i = 100, _ref2 = swords.length + 1; 100 <= _ref2 ? i <= _ref2 : i >= _ref2; 100 <= _ref2 ? i++ : i--) {
          sword = swords.at(i);
          if (sword) sword.kill();
        }
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
        for (i = 0, _ref3 = getRandomArbitary(1, 4); 0 <= _ref3 ? i <= _ref3 : i >= _ref3; 0 <= _ref3 ? i++ : i--) {
          _results.push(stage.insert(new Q.Enemy({
            x: getRandomArbitary(min, max),
            y: height + 20
          })));
        }
        return _results;
      }
    });
  });

  Q.load("background-wall.png, enemy.png", function() {
    Q.sheet("enemy", "enemy.png", {
      tilew: 300,
      tileh: 240
    });
    Q.setup({
      maximize: true
    }).controls().touch(Q.SPRITE_ALL);
    Q.stageScene("level1");
    return Q.el.addEventListener("mousemove", function(e) {
      return mousePositions.push({
        x: e.offsetX || e.layerX,
        y: e.offsetY || e.layerY
      });
    });
  });

}).call(this);
