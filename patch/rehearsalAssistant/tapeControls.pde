class tapeControls {
  
  PVector buttonDimensions;
  PVector transportLocation;
  PVector transportDimensions;
  PVector[] buttonPositions;
  int gap;
  
  int flashFrames = 7;
  int frameCounter;
  
  PImage[] buttons;
  int state;
  boolean stateChanged;
  boolean redraw = false;
  boolean[] displayWhich;
  // due to a lack of ENUM support:
  // 0 :: pause (shows play)
  // 1 :: play (shows pause)
  // 2 :: stop (idle)
  // 3 :: stop (active)
  // 4 :: rewind (idle)
  // 5 :: rewind (active)
  
  tapeControls(PImage playImg, PImage pauseImg, PImage stopIdleImg, PImage stopActiveImg, PImage rewindIdleImg, PImage rewindActiveImg) {
    buttons = new PImage[6];
    buttons[0] = playImg;
    buttons[1] = pauseImg;
    buttons[2] = stopIdleImg;
    buttons[3] = stopActiveImg;
    buttons[4] = rewindIdleImg;
    buttons[5] = rewindActiveImg;
    gap = 7;
    
    buttonDimensions = new PVector(buttons[0].width, buttons[0].height);
    transportLocation = new PVector(width / 2, (buttonDimensions.y / 2) + gap + 10);
    buttonPositions = new PVector[3];
    buttonPositions[0] = new PVector(transportLocation.x - (buttonDimensions.x + gap), transportLocation.y);
    buttonPositions[1] = new PVector(transportLocation.x, transportLocation.y);
    buttonPositions[2] = new PVector(transportLocation.x + (buttonDimensions.x + gap), transportLocation.y);
    transportDimensions = new PVector((buttonPositions.length * buttonDimensions.x) + (buttonPositions.length + 1) * gap, buttonDimensions.y + gap);
    displayWhich = new boolean[buttonPositions.length];
    displayWhich[0] = false; displayWhich[1] = true; displayWhich[2] = true;
    state = 1; // show play
    stateChanged = true;
  }
  
  void draw() {
    if (stateChanged) {
      rectMode(CENTER);
      fill(255); stroke(0); strokeWeight(1);
      rect(transportLocation.x, transportLocation.y, transportDimensions.x, transportDimensions.y);
      imageMode(CENTER);
      for (int i = 0; i < buttonPositions.length; i++) {
        drawButton(i);
      }
      stateChanged = false;
      
      if(frameCounter < flashFrames) {
        frameCounter++;
      } else { displayWhich[2] = true; redraw = true; }
      
      if (redraw) {
        drawButton(2);
        redraw = false;
      }
    }
  }
  
  void input(int x, int y) {
    if ( insideTransport(x, y) ) {
      for(int i = 0; i < buttonPositions.length; i++) {
        if ( insideButton(x, y, i) ) {
          toggleButton(i);
          stateChanged = true;
        }
      }
    }
  }
  
  void drawButton(int index) {
    image(buttons[ getButtonIndex(index, displayWhich[index]) ], buttonPositions[index].x, buttonPositions[index].y);
  }
  
  private boolean insideTransport(int x, int y) {
    if ( ( x < ( transportLocation.x - (transportDimensions.x / 2) ) ) || ( x > ( transportLocation.x + (transportDimensions.x / 2) ) ) ) {
      return false;
    }
    
    if ( ( y < ( transportLocation.y - (transportDimensions.y / 2) ) ) || ( y > ( transportLocation.y + (transportDimensions.y / 2) ) ) ) {
      return false;
    }
    
    return true;
  }
  
  private boolean insideButton(int x, int y, int which) {
    if ( ( x < ( buttonPositions[which].x - (buttonDimensions.x / 2) ) ) || ( x > ( buttonPositions[which].x + (buttonDimensions.x / 2) ) ) ) {
      return false;
    }
    if ( ( y < ( buttonPositions[which].y - (buttonDimensions.y / 2) ) ) || ( y > ( buttonPositions[which].y + (buttonDimensions.y / 2) ) ) ) {
      return false;
    }
    
    return true;
  }
  
  private void toggleButton(int which) {
    displayWhich[which] = !(displayWhich[which]);
    if (which == 0) {            // if play is hit:
      state = (displayWhich[0]) ? 0 : 1;
      displayWhich[1] = true;      // stop-idle
      displayWhich[2] = true;      // rewind-idle
    } else if (which == 1) {     // if stop is hit:
      state = 2;
      displayWhich[0] = false;     // pause
      displayWhich[2] = true;      // rewind-idle;
    } else if (which == 2) {     // if rewind is hit:
      state = 3;
      displayWhich[2] = true;
//      frameCounter = 0;
    }
  }
  
  private int getButtonIndex(int index, boolean state) {
    if (state) {
      return ( index * 2);
    } else { 
      return ( (index * 2) + 1 ); 
    }
  }
  
  int getState() {
    return state; // 0::play; 1::pause; 2::stop; 3::rewind.
  }
  
}
