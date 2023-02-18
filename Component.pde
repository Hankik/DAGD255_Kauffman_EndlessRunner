abstract class Component {

  // fields
  String name = "";
  ArrayList<Component> components;
  AABBActor parent;
  float x, y;
  boolean isVisible = false;


  abstract void update();

  abstract void draw();
}
