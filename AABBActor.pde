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
  HashMap<String, Component> components = new HashMap();

  // Gravity fields
  float gravityScale = 1;
  boolean gravityEnabled = false;
  boolean onGround = false;

  // Movement fields
  PVector velocity = new PVector();
  float xMaxVelocity = 300;
  float yMaxVelocity = 300;
  float xMinVelocity = -300;
  float yMinVelocity = -300;
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
      textAlign(CENTER);
      text("xPos: " + (int)x + " | yPos: " + (int)y, x, y + h*.75);
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

  //
  // Collision resolution methods
  //
  public void fixOverlap(AABBActor other) {
    float pushUp = edgeB - other.edgeT;
    float pushLeft = edgeR - other.edgeL;

    if (pushUp <= pushLeft) setBottomEdge(other.edgeT);
    else {
    }//setRightEdge(other.edgeL);
  }
  public void setBottomEdge(float Y) {
    y = Y - halfH;
    velocity.y = 0;
    calcAABB();
  }
  public void setRightEdge(float X) {
    x = X - halfW;
    velocity.x = 0;
    calcAABB();
  }
  /**
   * This method finds the best solution for moving (this) AABB out from an (other)
   * AABB object. The method compares four possible solutions: moving (this) box
   * left, right, up, or down. We only want to choose one of those four solutions.
   * The BEST solution is whichever one is the smallest. So after finding the four
   * solutions, we compare their absolute values to discover the smallest.
   * We then return a vector of how far to move (this) AABB.
   * NOTE: you should first verify that (this) and (other) are overlapping before
   * calling this method.
   * @param  other  The (other) AABB object that (this) AABB is overlapping with.
   * @return  The vector that respresents how far (and in which direction) to move (this) AABB.
   */
  public PVector findOverlapFix(AABBActor other) {

    float moveL = other.edgeL - edgeR; // how far to move this box so it's to the LEFT of the other box.
    float moveR = other.edgeR - edgeL; // how far to move this box so it's to the RIGHT of the other box.
    float moveU = other.edgeT - edgeB; // how far to move this box so it's to the TOP of the other box.
    float moveD = other.edgeB - edgeT; // how far to move this box so it's to the BOTTOM of the other box.

    // The above values are potentially negative numbers; the sign indicates what direction to move.
    // But we want to find out which ABSOLUTE value is smallest, so we get a non-signed version of each.

    float absMoveL = abs(moveL);
    float absMoveR = abs(moveR);
    float absMoveU = abs(moveU);
    float absMoveD = abs(moveD);

    PVector result = new PVector();

    result.x = (absMoveL < absMoveR) ? moveL : moveR; // store the smaller horizontal value.
    result.y = (absMoveU < absMoveD) ? moveU : moveD; // store the smaller vertical value.

    if (abs(result.y) <= abs(result.x)) {
      // If the vertical value is smaller, set horizontal to zero.
      result.x = 0;
    } else {
      // If the horizontal value is smaller, set vertical to zero.
      result.y = 0;
    }

    return result;
  }

  //
  // Velocity methods
  //

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

    velocity.x = max(xMinVelocity, velocity.x);
    velocity.y = max(yMinVelocity, velocity.y);

    x += velocity.x * dt;
    y += velocity.y * dt;
  }

  //
  // Component methods
  //
  void updateComponents() {
    for (Map.Entry<String, Component> entry : components.entrySet()) entry.getValue().update();
  }

  void drawComponents() {
    for (Map.Entry<String, Component> entry : components.entrySet()) entry.getValue().draw();
  }

  // A method to add components to actor
  AABBActor addComponent(Component c) {

    components.put(c.name, c);

    return this; // Actor return type allows for chaining addComponent() calls
  }

  // If using this method, always check for possibility of NULL
  Component getComponent(String name) {

    if (components.containsKey(name)) return components.get(name);

    println(this.name + " could not find component '" + name + "'.");
    return null;
  }

  float distanceFrom(AABBActor other) {

    return dist(other.x, other.y, x, y);
  }

  float distanceFrom(Component other) {
    try {

      return dist(other.x, other.y, x, y);
    }
    catch(Exception e) {
      println("No position found in '" + other.name + "' component.");
      return -1;
    }
  }
}

class ActorFactory {

  // fields
  ArrayList<AABBActor> list = new ArrayList();
  int npcAmount = 0;

  void update() {

    for (int i = list.size() - 1; i >= 0; i--) { // loop backwards through all actors

      AABBActor a = list.get(i); // access actor at index i

      if (a.isDead) { // if dead, remove and dont update
        list.remove(i);
        continue;
      }

      a.update();
    }
  }

  void draw() {
    for (AABBActor a : list) a.draw();
  }

  AABBActor createActor(String name, float x, float y, float w, float h) {

    if (name == null) return null;

    if (name.equalsIgnoreCase("PLAYER")) {
      Player p = new Player(x, y, w, h);
      list.add(p);
      return p;
    }
    if (name.equalsIgnoreCase("PLATFORM")) {

      Platform p = new Platform(x, y, w, h);
      list.add(p);
      return p;
    }
    if (name.equalsIgnoreCase("NPC")) {
      npcAmount++;
      // naming convention matters here. each npc and its script need to be named the same
      NPC n = new NPC(x, y, w, h, "npc" + npcAmount + ".txt");
      list.add(n);
      return n;
    }

    return null;
  }
}
