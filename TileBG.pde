class TileBG {

  int x, y;
  int speedX;
  PImage img;
  
  TileBG(String fileName, int speedX, int y){
    
    this.y = y;
    x = 0;
    this.speedX = speedX;
    img = loadImage(fileName);
  }
  
  void update(){
    
    x += speedX;
    if (x <= -img.width) x += img.width;
  }
  
  void draw(){
    image(img, x, y);
    image(img, x + img.width, y);
    image(img, x + img.width*2, y);
    
  
  }
}
