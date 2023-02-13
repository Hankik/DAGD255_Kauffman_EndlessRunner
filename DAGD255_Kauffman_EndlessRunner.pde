/*

Hank Kauffman
2/13/23
DAGD 255

*/

void setup(){

  fullScreen();
}

void draw(){

  
  Keyboard.update();
}

void keyPressed() {
  Keyboard.handleKeyDown(keyCode);
}

void keyReleased() {
  Keyboard.handleKeyUp(keyCode);
}
