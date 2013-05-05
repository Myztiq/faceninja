(function() {
  var getRandomArbitary;

  getRandomArbitary = function(min, max) {
    return Math.random() * (max - min) + min;
  };

  Q.scene("level1", function(stage) {
    var mousePositions, timer, vibrating, width;
    width = 400;
    mousePositions = [];
    Q.el.addEventListener("mousemove", function(e) {
      return mousePositions.push({
        x: e.offsetX || e.layerX,
        y: e.offsetY || e.layerY
      });
    });
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

}).call(this);
