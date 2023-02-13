abstract class Component {

  // fields
  String name = "";
  AABBActor parent;
  float x, y;
  boolean isVisible = false;
  
  Component(AABBActor parent){
    this.parent = parent;
  }
  
  abstract void update();
  
  abstract void draw();
  
}
