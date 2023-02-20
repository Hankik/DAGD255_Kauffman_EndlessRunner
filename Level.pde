class Level {

  // fields
  int id;
  ActorFactory actors = new ActorFactory();
  Player player;
  Platform platform;
  Test test, test2, test3, test4, test5, test6, test7;
  TileBG bg = new TileBG("bg1.png", -2, -300), bg2 = new TileBG("bg2.png", -4, -100), bg3 = new TileBG("bg3.png", -1, -100);

  Level(int id) {

    this.id = id;

    switch (id) {

    case 0:

      player = (Player) actors.createActor("player", width*.5, height*.5, 40, 80);
      platform = (Platform) actors.createActor("platform", width*.75, height*.65, 70, 20);
      test = (Test) actors.createActor("test", random(width), random(height), random(100), random(100));
      test2 = (Test) actors.createActor("test", random(width), random(height), random(100), random(100));
      test3 = (Test) actors.createActor("test", random(width), random(height), random(100), random(100));
      test4 = (Test) actors.createActor("test", random(width), random(height), random(100), random(100));
      test5 = (Test) actors.createActor("test", random(width), random(height), random(100), random(100));
      test6 = (Test) actors.createActor("test", random(width), random(height), random(100), random(100));
      test7 = (Test) actors.createActor("test", random(width), random(height), random(100), random(100));

      break;
    }
  }

  void update() {

    bg3.update();
    bg.update();
    bg2.update();
    actors.update();

    for (AABBActor a : actors.list) {
      if (!a.name.equals("platform")) continue; // only collide with platforms
      if (player.checkCollision(a)) { // only collide if overlapping
        player.onGround = true;
        player.fixOverlap(a);
      }
    }
  }

  void draw() {

    bg3.draw();
    bg.draw();
    bg2.draw();
    actors.draw();
  }

  void mousePressed() {
  }

  void mouseReleased() {
  }
}
