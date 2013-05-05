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
      Q._defaults(p, {
        vy: getRandomArbitary(-height, -height - height / 2),
        asset: "https://fbcdn-profile-a.akamaihd.net/hprofile-ak-ash4/c50.50.625.625/s160x160/420279_773038823690_1127613549_n.jpg",
        angle: getRandomArbitary(-20, 20),
        type: Q.SPRITE_ENEMY,
        scale: getRandomArbitary(.5, .1)
      });
      this._super(p);
      this.add("2d, tween");
      return this.p.collisionMask = Q.SPRITE_NONE;
    },
    slice: function(data) {
      var angleX, angleY, fadeOutTime;
      var _this = this;
      if (!this.dead) {
        this.dead = true;
        angleX = data.x;
        angleY = data.y;
        this.p.vy += angleY * 50;
        this.p.vx += angleX * 50;
        fadeOutTime = .5;
        Q.stage().trigger('vibrate');
        Q.explode(this);
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
    draw: function(ctx) {
      ctx.save();
      ctx.beginPath();
      ctx.arc(0, 0, this.p.w / 2, 0, Math.PI * 2, true);
      ctx.closePath();
      ctx.clip();
      ctx.drawImage(Q.asset(this.p.asset), -this.p.cx, -this.p.cy);
      return ctx.restore();
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
