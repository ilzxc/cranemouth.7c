class tapePlayer {
  
  AudioPlayer player;
  int fileLength;
  
  tapePlayer(String filename) {
    player = minim.loadFile(filename, 2048);
    fileLength = player.length();
  }
  
  int getPosition() {
    return player.position();
  }
  
  void setState(int state) {
    if (state == 0) { // pause
      play();
    } else if (state == 1) { // play
      pause();
    } else if (state == 2) { // stop
      player.pause();
      restart();
    } else if (state == 3) { // rewind
      restart();
    }
  }
  
  void restart() {
    player.rewind();
  }
  
  void play() {
    if(!( player.isPlaying() )) {
      player.play();
    }
  }
   
   void pause() { 
    if( player.isPlaying() ) {
     player.pause(); 
    }
  }
  
  void setRehearsal(int start, int end) {
    if (!( player.isLooping() )) {
      player.loop();
    }
    player.setLoopPoints(start, end);
    player.cue(start);
  }
  
  void toggleLoop() {
    if (!( player.isLooping() )) {
      player.loop();
    } else {
      player.setLoopPoints(0, fileLength);
      player.loop(0);
    }
  }
  
  void stop() {
    player.close();
  }
  
  
}
