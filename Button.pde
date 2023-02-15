class Button {
  
  float x, y, w = 150, h = 60;
  String buttonName;
  
  boolean isHovered = false;
  boolean isPressed = false;
  
  Button(float xPos, float yPos, String name) {
    x = xPos;
    y = yPos;
    buttonName = name;
  }
  
  void update() {
    
    if(mouseX > x && mouseX < x + w && mouseY > y && mouseY < y + h) {
      isHovered = true;
    } else {
      isHovered = false;
    }
    
    if(isHovered) {
      if(isLeftDown && !wasPrevLeftDown) {
        isPressed = true;
      }
    }
    
  }
  
  void draw() {
    if(isHovered) fill(200);
    else fill(255);
    stroke(0);
    strokeWeight(3);
    rect(x, y, w, h);
    fill(0);
    textAlign(CENTER, CENTER);
    text(buttonName, x + 75, y + 30);
  }
  
}
