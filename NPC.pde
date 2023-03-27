class NPC extends AABBActor implements Interacting {

  // fields
  Communication communication;
  Progression progression;
  float distFromPlayer = -1;
  boolean interacted = false;
  PImage sprite = loadImage("npc.png");

  NPC(float x, float y, float w, float h, String fileName) {
    
    name = "npc";

    progression = new Progression(this);
    communication = new Communication(this, fileName);
    
    this
      .addComponent(progression) // not sure why but first component added will not be updated or drawn...
      .addComponent(communication);

    progression.setVisibility(true);
    
    canSeeHitbox = false;

    this.x = x;
    this.y = y;
    setSize(w, h);
    sprite.resize((int) w, (int) h);
  }

  void update() {
    distFromPlayer = distanceFrom(levels[currentLevel].player); // calculate distance from player in update
    // ^^ this prevents me from having to loop over all the npcs after updates to determine overlapping

    Player currentPlayer = levels[currentLevel].player;

    if (currentPlayer.velocity.x + 10 > currentPlayer.xMaxVelocity
      && checkCollision(currentPlayer)) {
        currentPlayer.velocity.x -= 200;
        kill(currentPlayer.velocity.x);
    }
    //else levels[currentLevel].player.drop(this);
    if (currentPlayer.velocity.x - 10 < currentPlayer.xMinVelocity
      && checkCollision(currentPlayer)) {
      currentPlayer.acquire(this);
    }
    //else {
    //  currentPlayer.drop(this);
    //}

    super.update();
  }

  void draw() {
    super.draw();
    pushMatrix();
    translate(x,y);
    image(sprite, -w/2, -h/2);
    popMatrix();
  }
  
  // on death method call
  void kill(float speed){
    int particleAmount = 20;
    for (int i = 0; i < particleAmount; i++) levels[currentLevel].particles.add( new Particle(
                                    x, y,                                   // position
                                    speed,                                  // velocity
                                    new PVector(random(1,2), random(-1,1)), // direction
                                    random(.2, .6)));                       // duration
    isDead = true;
  }

  void onInteract(AABBActor invoker) {
    if (!checkCollision(invoker)) return; // early return if not colliding
    println(invoker.name + " interacted with " + name);
    
    communication.display();
  }
}
