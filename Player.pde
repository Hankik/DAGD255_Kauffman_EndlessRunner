class Player extends AABBActor implements Attacking {

  // fields
  Movement movement = new Movement(this);
  Collision collision = new Collision(this);
  
  Player(float x, float y, float w, float h){
    
    this
      .addComponent(movement)
      .addComponent(collision);
      
    xMinVelocity = 150;
    xMaxVelocity = 500;
    
    movement.setVisibility(true);
    
    this.x = x;
    this.y = y;
    setSize(w, h);
    gravityEnabled = true;
  }
  
  void update(){
    
    if ( (Keyboard.isDown(Keyboard.SPACE) || Keyboard.isDown(Keyboard.UP) ) && onGround) jump();
    movement.move(Keyboard.isDown(LEFT), Keyboard.isDown(RIGHT), false, false);
  
    // at end, call super.update() for draw() to recieve changes
    super.update(); 
  }
  
  void draw(){
    super.draw();
  }
  
  void jump(){
  
    velocity.y = -jumpHeight;
    onGround = false;
  }
  
  void attack(float damage, float knockback){
  }
}
