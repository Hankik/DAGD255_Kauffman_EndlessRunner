class Player extends AABBActor {

  // fields
  
  Player(float x, float y, float w, float h){
    this.x = x;
    this.y = y;
    setSize(w, h);
  }
  
  void update(){
  
    // at end, call super.update() for draw() to recieve changes
    super.update(); 
  }
  
  void draw(){
    super.draw();
  }
}
