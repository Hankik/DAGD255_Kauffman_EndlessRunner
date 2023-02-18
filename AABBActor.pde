public class AABBActor {

  // AABB fields
  float x, y, w, h;
  float edgeL, edgeR, edgeT, edgeB;
  float halfW, halfH;

  // Actor fields
  String name = "";
  boolean isDead = false;
  boolean canSeeHitbox = true;

  // Component fields
  ArrayList<Component> components = new ArrayList();

  // Gravity fields
  float gravityScale = 1;
  boolean gravityEnabled = false;
  boolean onGround = false;

  // Movement fields
  PVector velocity = new PVector();
  float xMaxVelocity = 300;
  float yMaxVelocity = 300;
  float friction = 1;
  float speed = 10;
  float jumpHeight = 225;
  boolean xHitMaxSpeed = false;
  boolean yHitMaxSpeed = false;


  AABBActor() {
    // All child classes of AABBActor must call setSize() in constructor
  }

  void update() {


    calculateVelocity();
    calculateGravity();

    updateComponents();

    calcAABB();
  }

  void draw() {
    drawComponents();

    if (canSeeHitbox) {

      fill(WHITE);
      stroke(RED);
      strokeWeight(2);

      pushMatrix();
      //rect(x - w/2, y - h/2, w, h);
      line(edgeL, edgeT, edgeR, edgeT);
      line(edgeR, edgeT, edgeR, edgeB);
      line(edgeR, edgeB, edgeL, edgeB);
      line(edgeL, edgeB, edgeL, edgeT);
      popMatrix();

      noStroke();
    }
  }

  void setSize(float w, float h) {
    this.w = w;
    this.h = h;
    halfW = w/2;
    halfH = h/2;
  }

  void calcAABB() {
    edgeL = x - halfW;
    edgeR = x + halfW;
    edgeT = y - halfH;
    edgeB = y + halfH;
  }

  boolean checkCollision(AABBActor other) {
    if (edgeR < other.edgeL) return false;
    if (edgeL > other.edgeR) return false;
    if (edgeB < other.edgeT) return false;
    if (edgeT > other.edgeB) return false;
    return true;
  }

  void calculateGravity() {

    if (gravityEnabled) {

      velocity.y += GRAVITY * gravityScale * WORLD_GRAVITY_SCALE * dt;

      if (y >= GROUND_Y - halfH) {
        y = GROUND_Y - halfH;
        onGround = true;
      }
    }
  }

  void calculateVelocity() {

    if ( velocity.x > xMaxVelocity || velocity.x < -xMaxVelocity ) xHitMaxSpeed = true;
    else xHitMaxSpeed = false;
    if ( velocity.y > yMaxVelocity || velocity.y < -yMaxVelocity ) yHitMaxSpeed = true;
    else yHitMaxSpeed = false;

    x += velocity.x * dt;
    y += velocity.y * dt;
  }

  //
  // Component methods
  //
  void updateComponents() {
    for (Component c : components) c.update();
  }

  void drawComponents() {
    for (Component c : components) c.update();
  }

  // A method to add components to actor
  AABBActor addComponent(Component c) {

    components.add(c);

    return this; // Actor return type allows for chaining addComponent() calls
  }
}

class ActorFactory {

  // fields
  ArrayList<AABBActor> actors = new ArrayList();

  void update() {

    for (AABBActor a : actors) a.update();
  }

  void draw() {
    for (AABBActor a : actors) a.draw();
  }

  AABBActor createActor(String name, float x, float y, float w, float h) {

    if (name == null) return null;

    if (name.equalsIgnoreCase("PLAYER")) {
      Player p = new Player(x, y, w, h);
      actors.add(p);
      return p;
    }
    if (name.equalsIgnoreCase("TEST")){
      Test t = new Test(x, y, w, h, actors.get(0));
      actors.add(t);
      return t;
    }

    return null;
  }
}
