class Camera extends AABBActor {

  float x, y;
  Player target;
  float tx, ty; // Target's x and y coordinates.
  final float ZOOM_IN = 1.5, ZOOM_OUT = .5;
  float currentZoom = 1;
  float yOffset = -200;
  float xOffset = 400;
  boolean isStopped;
  float speedControlXBound;

  Camera(Player p) {
    target = p;
    tx = target.x - width/2;
    ty = target.y - height/2;
    x = tx;
    y = ty;

    setSize(100, 100);

    speedControlXBound = x + 400;
  }

  void update() {

    speedControlXBound = x + 400;
    stroke(BLUE);
    line(speedControlXBound, -height, speedControlXBound, height*2);
    println(x);

    if (isStopped) return;

    tx = target.x - (width/2) / currentZoom;
    ty = target.y - (height/2) / currentZoom;


    float dx = tx + xOffset - x; // For Camera Easing Effect
    float dy = ty + yOffset - y;
    x += dx;// * 0.2;
    y += dy;// * 0.2;

    if (target.x > speedControlXBound) {

      //float dx = tx + xOffset - x; // For Camera Easing Effect
      //float dy = ty + yOffset - y;
      //x += dx;// * 0.2;
      //y += dy;// * 0.2;
    }
    if (target.x < x) {
    }
    //if (target.x <= speedControlXBound && target.x ){}
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
