class Camera extends AABBActor {

  float x, y;
  Player target;
  float tx, ty; // Target's x and y coordinates.
  final float ZOOM_IN = 1.5, ZOOM_OUT = .5;
  float currentZoom = 1;
  float yOffset = -500;
  float xOffset = 700;
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


    velocity = target.velocity;

    float dx;
    float dy;

    if (target.distFromXBound <= 0) { // if true target the player

      target.velocity.x--;
      tx = target.x - target.w/2 ;
      ty = target.y - target.h/2;


      dx = 0;
    } else { // target the xBound

      tx = target.x + target.distFromXBound - xOffset - target.w/2;
      dx = tx - x;
    }
    dy = ty + yOffset - y ;
    
    text(dx, x + 200, y + 200);

    if (abs(dx) < 400) {

      x += dx * .05;
      y += dy * .05;
    } else {
      x += dx;
      y += dy;
    }
    
    //if (target.x <= speedControlXBound && target.x ){}
    super.update();
  }

  void stop() {
    isStopped = true;
  }

  void resume() {
    isStopped = false;
  }

  void draw() {
    super.draw();
  }
}
