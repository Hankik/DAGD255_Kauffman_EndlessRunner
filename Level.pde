class Level {

  // fields
  int id;
  ActorFactory actors = new ActorFactory();
  Player player;
  Test test, test2, test3, test4, test5, test6, test7;

  Level(int id) {

    this.id = id;

    switch (id) {

    case 0:
      
      player = (Player) actors.createActor("player", width*.5, height*.5, 40, 80);
      test = (Test) actors.createActor("test", random(width), random(height), random(100),random(100));
      test2 = (Test) actors.createActor("test", random(width), random(height), random(100),random(100));
      test3 = (Test) actors.createActor("test", random(width), random(height), random(100),random(100));
      test4 = (Test) actors.createActor("test", random(width), random(height), random(100),random(100));
      test5 = (Test) actors.createActor("test", random(width), random(height), random(100),random(100));
      test6 = (Test) actors.createActor("test", random(width), random(height), random(100),random(100));
      test7 = (Test) actors.createActor("test", random(width), random(height), random(100),random(100));
      
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
