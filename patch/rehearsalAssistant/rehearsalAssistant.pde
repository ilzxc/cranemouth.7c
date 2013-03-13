import ddf.minim.*;

Minim minim;
timeDisplay myTimer;
tapePlayer tape;
tapeControls transport;
statusMessages mess;

void setup() {
  size(512, 200, P3D); 
  mess = new statusMessages(loadFont("Vitesse-BlackItalic-72.vlw"));
  loadingScreen();
  
  
  minim = new Minim(this);
  tape = new tapePlayer("tape.mp3");
  myTimer = new timeDisplay(20, int(height * 0.7), 300, 50, loadFont("Vitesse-BlackItalic-72.vlw"));
  PImage[] buttonImages = new PImage[6];
  for (int i = 1; i <= buttonImages.length; i++) {
    buttonImages[i - 1] = loadImage("button_artwerk-0" + i +".png");
  }
  transport = new tapeControls(buttonImages[0], buttonImages[1], buttonImages[2], buttonImages[3], buttonImages[4], buttonImages[5]);
}

int seconds, lastseconds;

void draw() {
  // background(255);
  myTimer.draw(tape.getPosition());
  
  if (transport.stateChanged) {
    tape.setState(transport.getState());
  }
  
  transport.draw();
}

void mouseReleased() {
  transport.input(mouseX, mouseY);
}

void stop() {
  tape.stop();
  minim.stop();
  super.stop();
}

void keyReleased() {

}

void loadingScreen() {
  background(255);
  mess.setString("Please Wait ....");
  mess.draw(width/2, height/2);
}
