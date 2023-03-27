class Communication extends Component {

  // fields
  Timer displayTime = new Timer(3);
  String[] lines;
  int currentLine = 0;

  Communication(AABBActor parent, String fileName) {

    name = "communication";

    this.parent = parent;
    lines = loadText(fileName);
    displayTime.isDone = true;
  }

  void update() {
    displayTime.update();
  }

  void draw() {
    if (!displayTime.isDone) {

      pushMatrix();
      fill(BLACK);
      text(lines[currentLine], parent.x, parent.y -parent.h*.75);
      popMatrix();
    }
  }

  void display() {
    displayTime.reset();
  }
  
  void setCurrentLine(int line){
    currentLine = line;
  }
  
  String nextLine(){
    currentLine++;
    if (currentLine >= lines.length) currentLine = 0;
    return lines[currentLine];
  }

  String[] loadText(String fileName) {
    
    try { // attempt to load in file
      String[] strArr = loadStrings(fileName);
      if (strArr == null) throw new NullPointerException("load failed");
      else return strArr;
    }
    catch (Exception e) {
      println(e + " // File '" + fileName + "' not found.");
      return new String[]{""};
    }
  }
}
