class Level {

  // fields
  int id;
  ActorFactory actors = new ActorFactory();
  Player player;

  Level(int id) {

    this.id = id;

    switch (id) {

    case 0:
      
      player = (Player) actors.createActor("player", width*.5, height*.5, 40, 40);
      break;
    }
  }
  
  void update(){
    
    actors.update();
  }
  
  void draw(){
  
    actors.draw();
  }
  
  void mousePressed(){}
  
  void mouseReleased(){}
}
