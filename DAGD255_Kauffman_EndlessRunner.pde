/*

 Hank Kauffman
 2/13/23
 DAGD 255
 
 */

//
// declare global fields
//

final int LEVEL_AMOUNT = 1;               // LEVELS
int currentLevel = 0;
Level[] levels = new Level[LEVEL_AMOUNT];

float dt, prevTime = 0;                   // DELTA TIME

float WORLD_GRAVITY_SCALE = 40;          // GRAVITY
final float GRAVITY = 9.81;
final float GROUND_Y = 500;

boolean isPaused = false;

boolean isLeftDown, wasPrevLeftDown = false;



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

void setup() {

  size(1280, 720);
  //fullScreen();

  frameRate(120);

  for (int i = 0; i < LEVEL_AMOUNT; i++) {
    levels[i] = new Level(i);
  }
}

void draw() {
  calcDeltaTime();
  background(BLACK);

 
  if (!isPaused) {
    levels[currentLevel].update();
  }

  Keyboard.update();
}

void keyPressed() {
  Keyboard.handleKeyDown(keyCode);
}

void keyReleased() {
  Keyboard.handleKeyUp(keyCode);
}

void mousePressed() {
  if (!isPaused) {
    levels[currentLevel].mousePressed();
  }
  if (mouseButton == LEFT) isLeftDown = true;
}

void mouseReleased() {
  if (!isPaused) {
    levels[currentLevel].mouseReleased();
  }
  if (mouseButton == LEFT) isLeftDown = false;
}

// A method to get delta time
void calcDeltaTime() {

  float currTime = millis();
  dt = (currTime - prevTime) / 1000;
  prevTime = currTime;
}
