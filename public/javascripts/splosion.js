(function() {
  var getRandomArbitary;

  getRandomArbitary = function(min, max) {
    return Math.random() * (max - min) + min;
  };

  Quintus.Particles = function(Q) {
    return Q.explode = function(source) {
      var height, width;
      width = source.p.w * source.p.scale;
      height = source.p.h * source.p.scale;
      return console.log(width, height);
    };
  };

  Q.Sprite.extend("Splosion", {
    init: function(p) {
      this._super(p, {
        type: Q.SPRITE_DEFAULT,
        w: 1,
        h: 1,
        o: 1
      });
      this.add("tween");
      this.on('step');
      return this.p.collisionMask = Q.SPRITE_NONE;
    },
    draw: function(ctx) {
      ctx.fillStyle = "rgba(220,220,220," + this.p.o + ")";
      ctx.beginPath();
      ctx.arc(0, 0, this.p.w / 2, 0, Math.PI * 2, true);
      ctx.closePath();
      return ctx.fill();
    },
    step: function() {
      var _this = this;
      if (!this.first) {
        this.first = true;
        return this.animate({
          scale: this.p.scale + .3,
          angle: 0
        }, 2, {
          callback: function() {
            return _this.destroy();
          }
        });
      }
    }
  });

}).call(this);
