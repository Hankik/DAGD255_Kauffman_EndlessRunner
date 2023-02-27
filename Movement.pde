class Movement extends Component {

  // variables
  Timer stopDelay = new Timer(16);
  PVector direction = new PVector(0, 0);

  Movement(AABBActor parent) {

    this.parent = parent;
    name = "movement";
  }

  void move(boolean moveLeft, boolean moveRight, boolean moveUp, boolean moveDown) {

    boolean isMoving = moveLeft || moveRight || moveUp || moveDown;

    // Player xVel is slowed to zero linearly based off how close timer is to zero
    if (!isMoving) {
      stopDelay.update();
      parent.velocity.x = lerp( parent.velocity.x, 0,  1 - stopDelay.timeLeft / stopDelay.duration );
      return;
    }
    
    if (stopDelay.timeLeft != stopDelay.duration) stopDelay.reset(); // reset timer once

    // determine direction
    if (moveLeft == true && moveRight == false) direction.x = -1.0;
    else if (moveLeft == false && moveRight == true) direction.x = 1.0;
    if (moveUp == true && moveDown == false) direction.y = -1.0;
    else if (moveUp == false && moveDown == true) direction.y = 1.0;

    direction.normalize();

    if (parent.xHitMaxSpeed) {
      parent.velocity.x = parent.velocity.x * .99; // constant velocity
    } else {
      parent.velocity.x += direction.x * parent.speed; // accelerate
    }

    if (parent.yHitMaxSpeed) {
      parent.velocity.y = parent.velocity.y * .99; // constant velocity
    } else {
      parent.velocity.y += direction.y * parent.speed; // accelerate
    }

    //println("moveLeft: " + moveLeft + "\nmoveRight: " + moveRight + "\nmoveUp: " + moveUp + "\nmoveDown: " + moveDown); // debug input
  }

  void update() {
  }

  void draw() {
    if (isVisible) {
      fill(WHITE);
      pushMatrix();
      translate(parent.x, parent.y);
      textAlign(CENTER);
      text("xVel: " + (int)parent.velocity.x + " | yVel: " + (int)parent.velocity.y , 0, parent.h);
      popMatrix();
    }
  }
}
