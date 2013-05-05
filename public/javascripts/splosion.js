(function() {
  var getRandomArbitary;

  getRandomArbitary = function(min, max) {
    return Math.random() * (max - min) + min;
  };

  Quintus.Particles = function(Q) {
    return Q.explode = function(source) {
      var height, i, stage, width, _results;
      width = source.p.w * source.p.scale;
      height = source.p.h * source.p.scale;
      stage = Q.stage();
      source.destroy();
      _results = [];
      for (i = 0; i <= 100; i++) {
        _results.push(stage.insert(new Q.Splosion({
          x: source.p.x,
          y: source.p.y,
          vx: getRandomArbitary(0, 3) * source.p.vx,
          vy: getRandomArbitary(0, 3) * source.p.vy
        })));
      }
      return _results;
    };
  };

  Q.Sprite.extend("Splosion", {
    init: function(p) {
      this._super(p, {
        type: Q.SPRITE_NONE,
        w: 1,
        h: 1,
        o: 1
      });
      this.add("tween, 2d");
      this.on('step');
      return this.p.collisionMask = Q.SPRITE_NONE;
    },
    draw: function(ctx) {
      var b, g, r;
      r = Math.round(getRandomArbitary(0, 255));
      g = Math.round(getRandomArbitary(0, 255));
      b = Math.round(getRandomArbitary(0, 255));
      ctx.fillStyle = "rgba(" + r + "," + g + "," + b + "," + this.p.o + ")";
      ctx.beginPath();
      ctx.arc(0, 0, 2, 0, Math.PI * 2, true);
      ctx.closePath();
      return ctx.fill();
    },
    step: function() {
      var _this = this;
      if (!this.first) {
        this.first = true;
        return this.animate({
          angle: 300,
          o: 0
        }, .6, {
          callback: function() {
            return _this.destroy();
          }
        });
      }
    }
  });

}).call(this);
