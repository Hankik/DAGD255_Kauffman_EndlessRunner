class Level {

  // fields
  int id;
  ActorFactory actors = new ActorFactory();
  Player player;
  Platform platform;
  Camera camera;
  
  // Bounds fields
  float rightBound = 4000;
  float leftBound = 0;

  Level(int id) {

    this.id = id;

    switch (id) {

    case 0:

      player = (Player) actors.createActor("player", width*.5, height*.5, 40, 80);
      platform = (Platform) actors.createActor("platform", width*.7, height *.6, 80, 30);
      camera = new Camera(player);

      break;
    }
  }

  void update() {

    pushMatrix();
    translate(-camera.x, -camera.y);

    camera.update();

    actors.update();
    if (player.x - player.w*.5 > rightBound) {
      player.x = leftBound + player.w;
      
    }
    if (player.x + player.w*.5 < leftBound) {
      player.x = rightBound - player.w;
    }

    for (AABBActor a : actors.list) {
      if (!a.name.equals("platform")) continue; // only collide with platforms
      if (player.checkCollision(a)) { // only collide if overlapping
        player.onGround = true;
        player.fixOverlap(a);
      }
    }

    draw(); // levels handle their own drawing

    drawGround();

    popMatrix();
  }

  void draw() {

    actors.draw();
  }

  void mousePressed() {
  }

  void mouseReleased() {
  }
  
  void handleCamera(){
  
    if (camera.x + width*.5 > rightBound) camera.stop();
    else camera.resume();
    
  }



  void drawGround() {

    stroke(RED);
    line(camera.x - width*.5 - player.w, GROUND_Y, camera.x + width + player.w, GROUND_Y);
    
    for (float i = 0; i <= 10; i++){
    
      float x = (i/10)*rightBound;
      line(x, -height, x, height);
    }
  }
}
