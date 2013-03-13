class partTracker {
  
  PVector position;
  PVector dimensions;
  
  PVector lineLocation;
  PVector lineLength;
  
  int secondsPerPage = 14;
  
  partTracker(int x, int y, int w, int h) {
    
  }
  
  void draw() {
    fill(0, 10, 10); noStroke();
    rect(position.x, position.y, dimensions.x, dimensions.y);
    strokeWeight(3); fill(255, 0, 0);
    //line(lineLocation.x, lineLocation.y, linelocation.x, lineLocation.y + lineLength);
  }
  
  void update(int millis) {
    millis -= 400; // synchronize with the timeDisplay of the tapePlayer
    
    float seconds = millis / 1000.0;
    int page = ( (millis / 1000) % 14 );
    
    
  }
}

/*

    millisLocation -= 400; // need to test .wav to see if the timing would be more precise...
    totalSeconds = millisLocation / 1000;
    seconds = totalSeconds % 60;
    minutes = (totalSeconds / 60) % 60;
    millis = millisLocation % 1000;
    
*/
