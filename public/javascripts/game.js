(function() {
  var Q, getRandomArbitary, width;

  width = 400;

  getRandomArbitary = function(min, max) {
    return Math.random() * (max - min) + min;
  };

  Q = window.Q = Quintus().include("Sprites, Scenes, Input, 2D, Anim, Touch, UI");

  Q.setup({
    maximize: true
  }).controls().touch(Q.SPRITE_ALL);

  Q.Sprite.extend("Enemy", {
    init: function(p) {
      var height, offset;
      p.vx = getRandomArbitary(0, 400);
      offset = Q.el.width;
      if (p.x > offset / 2) p.vx *= -1;
      p.type = Q.SPRITE_ENEMY;
      height = Q.el.height;
      this._super(p, {
        vy: getRandomArbitary(-height, -height - height / 2),
        scale: getRandomArbitary(.3, .01),
        sheet: "enemy",
        angle: getRandomArbitary(-20, 20)
      });
      p.collisionMask = 0;
      this.on('touch');
      this.on('step');
      return this.add("2d, tween");
    },
    touch: function(data) {
      var angleX, angleY, fadeOutTime;
      var _this = this;
      if (!this.dead) {
        this.dead = true;
        angleX = data.oldLocation.x - data.location.x;
        angleY = data.oldLocation.y - data.location.y;
        this.p.vy -= angleY * 50;
        this.p.vx -= angleX * 50;
        fadeOutTime = .5;
        this.animate({
          angle: 1720,
          scale: .001
        }, fadeOutTime, Q.Easing.Linear);
        return window.setTimeout(function() {
          return _this.destroy();
        }, fadeOutTime * 1000);
      }
    },
    step: function() {
      if (!this.first) {
        this.first = true;
        this.animate({
          scale: this.p.scale + .3,
          angle: 0
        }, 2);
      }
      if (this.p.x > 2000) return this.destroy();
    }
  });

  Q.scene("level1", function(stage) {
    var height, max, min, offset;
    stage.insert(new Q.Repeater({
      asset: "background-wall.png",
      speedX: 0.5,
      speedY: 0.5
    }));
    offset = Q.el.width;
    min = offset / 2 - (width / 2);
    max = offset / 2 + (width / 2);
    height = Q.el.height;
    return setInterval(function() {
      var i, _ref, _results;
      _results = [];
      for (i = 0, _ref = getRandomArbitary(1, 4); 0 <= _ref ? i <= _ref : i >= _ref; 0 <= _ref ? i++ : i--) {
        _results.push(stage.insert(new Q.Enemy({
          x: getRandomArbitary(min, max),
          y: height + 20
        })));
      }
      return _results;
    }, 1000);
  });

  Q.load("background-wall.png, enemy.png", function() {
    var oldLocation;
    Q.sheet("enemy", "enemy.png", {
      tilew: 300,
      tileh: 240
    });
    Q.stageScene("level1");
    oldLocation = {
      x: 0,
      y: 0
    };
    return Q.el.addEventListener("mousemove", function(e) {
      var obj, stage, stageX, stageY, x, y;
      x = e.offsetX || e.layerX;
      y = e.offsetY || e.layerY;
      stage = Q.stage();
      stageX = Q.canvasToStageX(x, stage);
      stageY = Q.canvasToStageY(y, stage);
      obj = stage.locate(stageX, stageY);
      if ((obj != null ? obj.touch : void 0) != null) {
        obj.touch({
          location: {
            x: x,
            y: y
          },
          oldLocation: oldLocation
        });
      }
      return oldLocation = {
        x: x,
        y: y
      };
    });
  });

}).call(this);
