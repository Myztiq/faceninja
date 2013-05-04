(function() {
  var Q, getRandomArbitary;

  getRandomArbitary = function(min, max) {
    return Math.random() * (max - min) + min;
  };

  Q = window.Q = Quintus().include("Sprites, Scenes, Input, 2D, Anim, Touch, UI").setup({
    maximize: true
  }).controls().touch();

  Q.Sprite.extend("Enemy", {
    init: function(p) {
      p.scale = getRandomArbitary(.5, .1);
      p.vx = getRandomArbitary(0, 400);
      if (p.x > 400) p.vx *= -1;
      this._super(p, {
        vx: getRandomArbitary(-400, 400),
        vy: -1300,
        sheet: "enemy"
      });
      return this.add("2d");
    }
  });

  Q.scene("level1", function(stage) {
    var enemy;
    stage.insert(new Q.Repeater({
      asset: "background-wall.png",
      speedX: 0.5,
      speedY: 0.5
    }));
    return enemy = stage.insert(new Q.Enemy({
      x: getRandomArbitary(0, 800),
      y: 1000
    }));
  });

  Q.load("background-wall.png, enemy.png", function() {
    Q.sheet("enemy", "enemy.png", {
      tilew: 300,
      tileh: 240
    });
    return Q.stageScene("level1");
  });

}).call(this);
