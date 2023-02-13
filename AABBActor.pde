class AABBActor {
  
  

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
    if (canSeeHitbox){
    
      fill(WHITE);
      stroke(RED);
      strokeWeight(2);
      
      pushMatrix();
      rect(x -w/2, y-h/2, w, h);
      line(edgeL, edgeT, edgeR, edgeT);
      line(edgeR, edgeT, edgeR,  edgeB);
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
    edgeL = x;
    edgeR = x + w;
    edgeT = y;
    edgeB = y + h;
  }

  boolean checkCollision(AABBActor other) {
    if (edgeR < other.edgeL) return false;
    if (edgeL > other.edgeR) return false;
    if (edgeB < other.edgeT) return false;
    if (edgeT > other.edgeB) return false;
    return true;
  }
}
