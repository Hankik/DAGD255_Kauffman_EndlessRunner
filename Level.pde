class Level {

  // fields
  int id;
  ActorFactory factory = new ActorFactory();
  Player player;

  Level(int id) {

    this.id = id;

    switch (id) {

    case 0:
      
      player = (Player) factory.createActor("player", width*.5, height*.5, 40, 40);
      break;
    }
  }
  
  void update(){
    
    factory.update();
  }
  
  void draw(){
  
    factory.draw();
  }
}
