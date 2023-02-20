class Platform extends AABBActor {

  Platform(float x, float y, float w, float h){
    
    name = "platform";
  
    this.x = x;
    this.y = y;
    setSize(w, h);
  }
  
  void update(){
    super.update();
  }
  
  void draw(){
  
    super.draw();
  }
}
