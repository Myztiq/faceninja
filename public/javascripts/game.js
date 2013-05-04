(function() {
  var Q, getRandomArbitary;

  getRandomArbitary = function(min, max) {
    return Math.random() * (max - min) + min;
  };

  Q = window.Q = Quintus().include("Sprites, Scenes, Input, 2D, Anim, Touch, UI");

  Q.setup({
    maximize: true
  }).controls().touch(Q.SPRITE_ALL);

  Q.Sprite.extend("Enemy", {
    init: function(p) {
      p.vx = getRandomArbitary(0, 400);
      if (p.x > 400) p.vx *= -1;
      p.type = Q.SPRITE_ENEMY;
      p.collisionMask = 0;
      this._super(p, {
        vx: getRandomArbitary(-400, 400),
        vy: -1300,
        scale: getRandomArbitary(.5, .1),
        sheet: "enemy"
      });
      this.on('touch');
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
    }
  });

  Q.scene("level1", function(stage) {
    stage.insert(new Q.Repeater({
      asset: "background-wall.png",
      speedX: 0.5,
      speedY: 0.5
    }));
    console.log(stage);
    stage.insert(new Q.Enemy({
      x: getRandomArbitary(0, 800),
      y: 1000
    }));
    stage.insert(new Q.Enemy({
      x: getRandomArbitary(0, 800),
      y: 1000
    }));
    stage.insert(new Q.Enemy({
      x: getRandomArbitary(0, 800),
      y: 1000
    }));
    stage.insert(new Q.Enemy({
      x: getRandomArbitary(0, 800),
      y: 1000
    }));
    stage.insert(new Q.Enemy({
      x: getRandomArbitary(0, 800),
      y: 1000
    }));
    stage.insert(new Q.Enemy({
      x: getRandomArbitary(0, 800),
      y: 1000
    }));
    stage.insert(new Q.Enemy({
      x: getRandomArbitary(0, 800),
      y: 1000
    }));
    stage.insert(new Q.Enemy({
      x: getRandomArbitary(0, 800),
      y: 1000
    }));
    stage.insert(new Q.Enemy({
      x: getRandomArbitary(0, 800),
      y: 1000
    }));
    stage.insert(new Q.Enemy({
      x: getRandomArbitary(0, 800),
      y: 1000
    }));
    stage.insert(new Q.Enemy({
      x: getRandomArbitary(0, 800),
      y: 1000
    }));
    return stage.insert(new Q.Enemy({
      x: getRandomArbitary(0, 800),
      y: 1000
    }));
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
