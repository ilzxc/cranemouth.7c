class statusMessages {
  
  PFont font;
  String message;
  boolean toBeDrawn;
  
  statusMessages(PFont f) {
    font = f;
  }
  
  void setString(String s) {
    message = s;
    toBeDrawn = true;
  }
  
  void doNotDraw() {
    toBeDrawn = false;
  }
  
  void draw(int x, int y) {
    if (toBeDrawn) {
      fill(0); noStroke();
      textAlign(CENTER, CENTER);
      textFont(font, 28);
      text(message, x, y);
    }
  }
  
  
}
