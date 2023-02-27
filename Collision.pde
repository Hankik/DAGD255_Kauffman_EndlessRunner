class Collision extends Component {

  // fields
  AABBActor parent;

  Collision(AABBActor parent) {

    name = "collision";
    this.parent = parent;
  }

  void update() {
    handleWorldCollision();
  }

  void draw() {
  }

  void handleWorldCollision() {

//    if (parent.x > width - parent.halfW) {
      
//      parent.x = width - parent.halfW;
//      parent.velocity.x = 0;
      
//    } else if (parent.x < parent.halfW) {
      
//      parent.x = parent.halfW;
//      parent.velocity.x = 0;
      
//    }

//    if (parent.y > height - parent.halfH) {
      
//      parent.y = height - parent.halfH;
//      parent.velocity.y = 0;
      
//    } else if (parent.y < parent.halfH) {
      
//      parent.y = parent.halfH;
//      parent.velocity.y = 0;
      
//    }
  }
}
