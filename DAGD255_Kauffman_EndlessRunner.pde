/*

Hank Kauffman
2/13/23
DAGD 255

*/

// declare global fields
final int LEVEL_AMOUNT = 1;
Level[] levels = new Level[LEVEL_AMOUNT];
int currentLevel = 0;

float dt, prevTime = 0;
boolean isPaused = false;


// Color constants
final color RED = #bf616a;
final color ORANGE = #d08770;
final color YELLOW = #ebcb8b;
final color GREEN = #a3be8c;
final color PURPLE = #b48ead;
final color BLUE = #5e81ac;
final color WHITE = #eceff4;
final color BLACK = #3b4252;
final color BROWN = #9e6257;
final color LIGHTGREEN = #d9e68f;
final color PINK = #db96ad;
final color LIGHTBLUE = #92cade;
final color LIGHTRED = #FF8C8C;
final color TONGUE = #c0003f;

void setup(){

  fullScreen();
  
  for (int i = 0; i < LEVEL_AMOUNT; i++){
    levels[i] = new Level(i);
  }
  
}

void draw(){
  background(BLACK);
  calcDeltaTime();
  
  if (!isPaused){
    levels[currentLevel].update();
  }
  
  levels[currentLevel].draw();

  
  Keyboard.update();
}

void keyPressed() {
  Keyboard.handleKeyDown(keyCode);
}

void keyReleased() {
  Keyboard.handleKeyUp(keyCode);
}

// A method to get delta time
void calcDeltaTime() {

  float currTime = millis();
  dt = (currTime - prevTime) / 1000;
  prevTime = currTime;
}
