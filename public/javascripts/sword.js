
  Q.Sprite.extend("Sword", {
    init: function(p) {
      this._super(p, {
        type: Q.SPRITE_DEFAULT,
        w: 10,
        h: 10,
        o: 1
      });
      this.inactive = false;
      this.add("tween");
      this.on('step');
      return this.on('hit');
    },
    step: function(dx) {
      var _this = this;
      if (!this.inactive) this.stage.collide(this, Q.SPRITE_ENEMY);
      if (!this.started) {
        this.started = true;
        return this.animate({
          w: 0,
          h: 0,
          o: 0
        }, .05, Q.Easing.Quadratic.In, {
          callback: function() {
            return _this.destroy();
          }
        });
      }
    },
    draw: function(ctx) {
      ctx.fillStyle = "rgba(220,220,220," + this.p.o + ")";
      ctx.beginPath();
      ctx.arc(0, 0, this.p.w / 2, 0, Math.PI * 2, true);
      ctx.closePath();
      return ctx.fill();
    },
    hit: function(options) {
      if (!this.inactive) return options.obj.slice();
    },
    kill: function() {
      return this.inactive = true;
    }
  });