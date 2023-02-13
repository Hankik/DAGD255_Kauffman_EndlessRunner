public class AABBActor {

  // AABB fields
  float x, y, w, h;
  float edgeL, edgeR, edgeT, edgeB;

  // Actor fields
  String name = "";
  boolean isDead = false;
  boolean canSeeHitbox = true;


  AABBActor() {
    // All child classes of AABBActor must call setSize() in constructor
  }

  void update() {
    calcAABB();
  }

  void draw() {
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
  }

  void calcAABB() {
    edgeL = x - w/2;
    edgeR = x + w/2;
    edgeT = y - h/2;
    edgeB = y + h/2;
  }

  boolean checkCollision(AABBActor other) {
    if (edgeR < other.edgeL) return false;
    if (edgeL > other.edgeR) return false;
    if (edgeB < other.edgeT) return false;
    if (edgeT > other.edgeB) return false;
    return true;
  }
}

class ActorFactory {

  // fields
  ArrayList<AABBActor> actors = new ArrayList();
  
  void update(){
  
    for (AABBActor a : actors) a.update();
  }
  
  void draw(){
    for (AABBActor a : actors) a.draw();
  }
  
  AABBActor createActor(String name, float x, float y, float w, float h){
    
    if (name == null) return null;
    
    if (name.equalsIgnoreCase("PLAYER")){
      Player p = new Player(x, y, w, h);
      actors.add(p);
      return p;
    }
    
    return null;
  }
}
