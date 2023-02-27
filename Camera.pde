class Camera extends AABBActor {

  float x, y;
  Player target;
  float tx, ty; // Target's x and y coordinates.
  final float ZOOM_IN = 1.5, ZOOM_OUT = .5;
  float currentZoom = 1;
  float yOffset = -200;
  float xOffset = 400;
  boolean isStopped;

  Camera(Player p) {
    target = p;
    tx = target.x - width/2;
    ty = target.y - height/2;
    x = tx;
    y = ty;
    
    setSize(100, 100);
  }

  void update() {
    
    if (isStopped) return;
    tx = target.x + xOffset - (width/2) / currentZoom;
    ty = target.y + yOffset - (height/2) / currentZoom;


    // For Camera Easing Effect
    float dx = tx - x;
    float dy = ty - y;
    x += dx;// * 0.2;
    y += dy;// * 0.2;
  }
  
  void stop(){
    isStopped = true;
  }
  
  void resume(){
    isStopped = false;
  }

  void draw() {
    super.draw();
  }
}
