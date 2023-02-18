class Test extends AABBActor {
  
  // fields
  Movement movement = new Movement(this);
  Collision collision = new Collision(this);
  AABBActor target;

  Test(float x, float y, float w, float h, AABBActor target){
    
    this
      .addComponent(movement)
      .addComponent(collision);
  
    
    this.x = x;
    this.y = y;
    setSize(w, h);
    this.target = target;
  }
  
  void update(){
    
    movement.move(target.x < x, target.x > x, target.y < y, target.y > y);
    
    super.update();
  }
  
  void draw(){
    super.draw();
  }
}
