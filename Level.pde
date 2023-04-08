class Level {

  // fields
  int id;
  ActorFactory actors = new ActorFactory();
  Player player;
  Camera camera;
  ArrayList<Particle> particles = new ArrayList();
  
  // Bounds fields
  float rightBound = 4000;
  float leftBound = 0;

  Level(int id) {

    this.id = id;

    switch (id) {

    case 0:

      player = (Player) actors.createActor("player", width*.5, height*.5, 40, 80);
      // ...........................{something, something, something}
      boolean[] playerProgression = {false, false, false};
      player.progression.setupProgression(playerProgression);
      
      for (int i = 0; i < 10; i++){
        //actors.createActor("platform", i*400, height*.7, 50, 50);
      }
      
      // create NPC1: her purse is stolen and needs it returned // you can also just kill them
      NPC npc1 = (NPC) actors.createActor("npc", 1800, GROUND_Y - 40, 40, 80);
      // ........................ {talked with, purse retrieved, picked up}
      boolean[] npc1Progression = {false, false, false};
      npc1.progression.setupProgression(npc1Progression);
      
      // create NPC2: purse snatcher must be killed to drop purse
      actors.createActor("npc", 3000, GROUND_Y - 40, 40, 80);
      
      
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
    for (int i = particles.size() - 1; i >= 0; i--) { // update, draw, and cull particles

      particles.get(i).update();
      particles.get(i).draw();
      if (particles.get(i).lifetime.isDone) particles.remove(i);
    }

    //for (AABBActor a : actors.list) {
    //  if (!a.name.equals("platform")) continue; // only collide with platforms
    //  if (player.checkCollision(a)) { // only collide if overlapping
    //    player.onGround = true;
    //    player.fixOverlap(a);
    //  }
    //}

    draw(); // levels handle their own drawing

    drawGround();

    popMatrix();
  }

  void draw() {

    actors.draw();
  }
  
  void keyPressed() {
    player.keyPressed();
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
    
    for (float i = 0; i <= 20; i++){
    
      float x = (i/10)*rightBound;
      line(x, -height, x, height);
    }
  }
}
