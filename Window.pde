import processing.sound.*;

class Window 
{
  SoundFile theme;
  Boolean playingMusic;
  Boolean activeWindow;
  SoundFile[] drums;
  PApplet project;
  
  Window(PApplet project) 
  {
    playingMusic = false;
    activeWindow = false;
    drums = new SoundFile[2];
    
    this.project = project;
  }
  
  // plays a sound after a click
  void click() 
  {
    int i = int(random(2));
    drums[i].play();
  }
  
  // sets the audio effects 
  void setDrums() 
  {
      drums[0] = new SoundFile(project, "drum_hit.wav");
      drums[0].amp(0.1);
      //TO DO: Issue with drum_hit.mp3
      //Sound library error: unable to decode sound file drum.mp3
      drums[1] = new SoundFile(project, "drum_hit.wav");
      drums[1].amp(0.1);
  }
  
  // sets the song
  void setSong(String filename) 
  {
    this.theme = new SoundFile(this.project, filename);
  }
  
  // starts playing the song
  void startSong() 
  {
    this.theme.loop();
    playingMusic = true;
  }
  
  // stops playing the song
  void stopSong() 
  {
    this.theme.stop();
    playingMusic = false;
  }
  
  // changes the volume
  void changeAmplitude(float amp) 
  {
    this.theme.amp(amp);
  }
  
  Boolean playingSong() 
  {
    return this.playingMusic;
  }
  
  Boolean getStatus() 
  {
    return activeWindow;
  }
  
  void setStatus(Boolean status) 
  {
    activeWindow = status;
  }
}
