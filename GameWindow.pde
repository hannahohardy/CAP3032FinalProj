class GameWindow extends Window 
{
  PImage background[];
  Boolean difficulty[];
  PImage drum;
  // data structure to store the songs
  
  // data structure storing the notes and their offset
  // classes implementing these data structures could be necessary
  
  // variables to store combos
  
  // functions that allows the player to go back to the menu and choose a different song
  
  // system that recognizes when the song is over
  
  GameWindow(PApplet project) 
  {
    super(project);
    background = new PImage[3];
    difficulty = new Boolean[3];
    
    for (int i = 0; i < 3; i++)
      difficulty[i] = false;
  }
  
  // loads the files needed
  void loadFiles() 
  {
    // changes the background depending on the difficulty selected
    background[2] = loadImage("game_background.jpeg");
    background[1] = loadImage("musicbackground2.jpeg");
    background[0] = loadImage("musicbackground1.jpeg");
    drum = loadImage("drum.png");
  }
  
  void display() 
  {
    background(255);
    
    for (int i = 0; i < 3; i++) 
    {
      if (difficulty[i])
            image(background[i], 0, 0, 800, 500);
    }
    
    // Display the drum
    fill(#0896FF, 100);
    noStroke();
    rect(0, height/4, width,height/2);
    fill(0, 0, 0, 0);
    PImage temp = drum.get(0, 0, 120, 128);
    image(temp, 3, height/2-34, 80, 80);
    ellipse(40, height/2 , 70 , 60);
    
    // Display the score
    fill(255);
    textSize(20);
    
    textAlign(LEFT);
    text("Score: " + player.getScore(), 10, height/4-10);
  }
}
