abstract class Component {

  // fields
  String name = "";
  AABBActor parent;
  float x, y;
  boolean isVisible = false;
  
  
  abstract void update();
  
  abstract void draw();
  
}
