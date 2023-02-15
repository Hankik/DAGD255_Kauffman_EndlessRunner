class Player extends AABBActor {

  // fields
  Movement movement = new Movement(this);
  
  Player(float x, float y, float w, float h){
    addComponent(movement);
    
    this.x = x;
    this.y = y;
    setSize(w, h);
    gravityEnabled = true;
  }
  
  void update(){
    
    if ( (Keyboard.isDown(Keyboard.SPACE) || Keyboard.isDown(Keyboard.UP) ) && onGround) jump();
    movement.move(Keyboard.isDown(LEFT), Keyboard.isDown(RIGHT), Keyboard.isDown(UP), Keyboard.isDown(DOWN));
  
    // at end, call super.update() for draw() to recieve changes
    super.update(); 
  }
  
  void draw(){
    super.draw();
  }
  
  void jump(){
  
    velocity.y = -100;
    onGround = false;
  }
}
