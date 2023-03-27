class Player extends AABBActor implements Interacting {

  // component fields
  Movement movement = new Movement(this);
  Collision collision = new Collision(this);
  Progression progression = new Progression(this);

  // misc fields
  float distFromXBound;

  // sprite fields
  PImage[] frames = new PImage[12];
  int currentFrame = 0;
  Timer nextFrameDelay = new Timer(.025); // this duration determines time between sprite frames

  Player(float x, float y, float w, float h) {
    
    name = "player";

    this
      .addComponent(movement)
      .addComponent(progression)
      .addComponent(collision);

    println(distanceFrom(movement));
    xMinVelocity = 150;
    xMaxVelocity = 500;
    speed = 4;
    jumpHeight = 300;

    canSeeHitbox = false;
    movement.setVisibility(true);

    this.x = x;
    this.y = y;
    setSize(w, h);
    gravityEnabled = true;

    // load images named run1-12 to the frames array
    for (int i = 0; i < 12; i++) {
      frames[i] = loadImage("run" + (i + 1) + ".png");
      frames[i].resize( (int) w, (int) h);
    }
  }

  void update() {

    nextFrameDelay.update();

    if ( (Keyboard.isDown(Keyboard.SPACE) || Keyboard.isDown(Keyboard.UP) ) && onGround) jump();
    movement.move(Keyboard.isDown(Keyboard.LEFT), Keyboard.isDown(Keyboard.RIGHT), false, false);

    nextFrameDelay.duration = map(velocity.x, xMinVelocity, xMaxVelocity, .025, .006125); //.0125
    if (!onGround) nextFrameDelay.duration = .1;

    distFromXBound = map(velocity.x, xMinVelocity, xMaxVelocity, 300, 0);
    distFromXBound = clamp(distFromXBound, 0, 300);
    //stroke(BLUE);
    //line(x + distFromXBound, -height, x + distFromXBound, height*2);

    // at end, call super.update() for draw() to recieve changes
    super.update();
  }

  void draw() {
    super.draw();
    pushMatrix();
    translate(x, y);
    image(frames[currentFrame], -w/2, -h/2);
    if (nextFrameDelay.isDone) {
      nextFrameDelay.reset();
      currentFrame++;
    }
    if (currentFrame > 11) currentFrame = 0; 
    popMatrix();
  }

  void jump() {

    velocity.y = -jumpHeight;
    onGround = false;
  }
  
  void onInteract(AABBActor invoker){
  }
  
  void keyPressed(){
    if (key == 'e'){
      interact("npc");
    }
  }
  
  void interact(String name){
    
    invokeInteractNPC( acquiredActors.get(name) );
  }
  
  void invokeInteractNPC(AABBActor a){ 
    if (a instanceof Interacting) ((NPC)a).onInteract(this);
  }
}
