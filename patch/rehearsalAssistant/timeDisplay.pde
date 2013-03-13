class timeDisplay {
  
  PFont font;
  int gap;
  
  PVector rectLocation;
  PVector rectDimension;
  PVector textLocation;
  int minutesLocation;
  int secondsLocation;
  int millisLocation;
  
  int totalSeconds;
  int seconds;
  int minutes;
  int millis;
  
  timeDisplay(int x, int y, int w, int h, PFont useFont) {
    font = useFont;
    gap = 10;
    
    rectLocation = new PVector(x, y); 
    rectDimension = new PVector(w, h);
    textLocation = new PVector(rectLocation.x + (rectDimension.x / 3), rectLocation.y + 7);
    minutesLocation = (int)textLocation.x - gap;
    secondsLocation = (int)textLocation.x + gap;
  }
  
  void draw(int millisLocation) {
    millisLocation -= 400; // need to test .wav to see if the timing would be more precise...
    totalSeconds = millisLocation / 1000;
    seconds = totalSeconds % 60;
    minutes = (totalSeconds / 60) % 60;
    millis = millisLocation % 1000;
    
    fill(200); // rectangle fill
    noStroke();
    rectMode(CORNER);
    rect(rectLocation.x, rectLocation.y, rectDimension.x, rectDimension.y);
    textFont(font, 48);
    fill(0); // text fill
    textAlign(CENTER, TOP);
    text(":", textLocation.x, textLocation.y);
    textAlign(RIGHT, TOP);
    text(addZeros(minutes), minutesLocation, textLocation.y);
    textAlign(LEFT, TOP);
    text(addZeros(seconds), secondsLocation, textLocation.y);
    text(("." + corrector(millis)), secondsLocation + 66, textLocation.y);
  }
 
  private String addZeros(int number) {
    String output;
    if (number < 10) {
      output = "0" + number;
    } else {
      output = "" + number;
    }
    
    return output;
  }
  
  private String corrector(int number) {
    if (number < 0) {
      return "000";
    } else { return "" + number; }  
  }
}
