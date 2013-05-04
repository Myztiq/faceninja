(function() {
  var getRandomArbitary;

  getRandomArbitary = function(min, max) {
    return Math.random() * (max - min) + min;
  };

  Q.Sprite.extend("Enemy", {
    init: function(p) {
      var height, offset;
      p.vx = getRandomArbitary(0, 400);
      offset = Q.el.width;
      if (p.x > offset / 2) p.vx *= -1;
      height = Q.el.height;
      this._super(p, {
        vy: getRandomArbitary(-height, -height - height / 2),
        scale: getRandomArbitary(.3, .01),
        sheet: "enemy",
        angle: getRandomArbitary(-20, 20),
        type: Q.SPRITE_ENEMY
      });
      p.collisionMask = 0;
      this.on('step');
      return this.add("2d, tween");
    },
    slice: function(data) {
      var angleX, angleY, fadeOutTime;
      var _this = this;
      if (!this.dead) {
        this.dead = true;
        angleX = 0;
        angleY = 0;
        this.p.vy = angleY * -50;
        this.p.vx = angleX * -50;
        fadeOutTime = .5;
        return this.animate({
          angle: 1720,
          scale: .001
        }, fadeOutTime, Q.Easing.Linear, {
          callback: function() {
            return _this.destroy();
          }
        });
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
      if (this.p.y > Q.el.height + 200) return this.destroy();
    }
  });

}).call(this);
