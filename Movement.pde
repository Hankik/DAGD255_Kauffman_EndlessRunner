class Movement extends Component {

  // variables
  PVector direction = new PVector(0, 0);
  boolean moveLeft = false;
  boolean moveRight = false;
  boolean moveUp = false;
  boolean moveDown = false;

  Movement(AABBActor parent) {

    this.parent = parent;
    name = "movement";
  }

  void move(boolean moveLeft, boolean moveRight, boolean moveUp, boolean moveDown) {

    boolean isMoving = moveLeft || moveRight || moveUp || moveDown;

    // update direction
    if (moveLeft == true && moveRight == false) direction.x = -1.0;
    else if (moveLeft == false && moveRight == true) direction.x = 1.0;
    else if (moveUp == true && moveDown == false) direction.y = -1.0;
    else if (moveUp == false && moveDown == true) direction.y = 1.0;

    // update location
    direction.normalize();

    if (isMoving) {
      parent.velocity.x += direction.x * dt * parent.speed;
      parent.velocity.y += direction.y * dt * parent.speed;  // no up down movement in this way
    } else {
      parent.velocity.x *= 0;
    }
    //println("moveLeft: " + moveLeft + "\nmoveRight: " + moveRight + "\nmoveUp: " + moveUp + "\nmoveDown: " + moveDown); // debug input
  }

  void update() {
  }

  void draw() {
  }
}
