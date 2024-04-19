Player player = new Player();
MenuWindow menuWindow = new MenuWindow(this);
GameWindow gameWindow = new GameWindow(this);
Boolean downloaded = false;
Boolean loadingScreenBool = false;
PImage loadingScreen[];

// Downloads the files needed for the loading screen
void loading() 
{
  PImage temp = loadImage("loading.png");
  
  loadingScreen = new PImage[8];
  for (int i = 0; i < 8; i++) 
  {
    loadingScreen[i] = temp.get(i*102, 0, 102, 102);
  }
  
  loadingScreenBool = true;
}

// Downloads all necessary files
void download() 
{
  menuWindow.loadFiles();
  menuWindow.setSong("menutheme.wav");
  menuWindow.changeAmplitude(0.1);
  menuWindow.setDrums();
  
  gameWindow.loadFiles();
  gameWindow.setSong("synthsong.mp3");
  gameWindow.setDrums();
  
  downloaded = true;
}

void setup()
{
  size(800,500);
  
  // Downloads the files in a different thread
  thread("loading");
  thread("download");
}

int i = 0;
void draw(){
  if (downloaded && !gameWindow.getStatus()) 
  {
    // Starts the main menu song
    if (!menuWindow.playingSong()) 
    {
      menuWindow.startSong();
      menuWindow.setStatus(true);
    }
    
    // Dsiplays the menu or the choose your difficulty screen
    if (menuWindow.getMenu())
      menuWindow.displayMenu();
    else
      menuWindow.displayDifficulty();
  }
  else if (gameWindow.getStatus())
  {
    gameWindow.updateBlocks(); // Update the positions of blocks

    gameWindow.display();
  }
  else
  {
    // Displays the Loading Screen
    background(0);
    
    if (loadingScreenBool) 
    {
      image(loadingScreen[i], 20, height-120);
    }
    
    delay(40);
    
    i++;
    if (i > 7) 
    {
      i = 0;
    }
  }
}

void mousePressed() 
{
  // Checks what window is currently active
  if (menuWindow.getStatus())
  {         gameWindow.checkHit(); // Now checks hits in the rhythm game

    // Checks if the mouse is hovering over an option
    if (menuWindow.getMenu()) 
    {
      if (menuWindow.optionSelected("Quit", width/2+3, 3*height/4+3)) 
      {
        menuWindow.click();
        delay(250);
        exit();
      }
      if (menuWindow.optionSelected("Start", width/2+3, height/2+3)) 
      {
        menuWindow.click();
        menuWindow.setMenu(false);
      }
    }
    else 
    {
      if (menuWindow.optionSelected("Easy song", width/2+3, height/4+3) ||
      menuWindow.optionSelected("Medium song", width/2+3, height/2+3) ||
      menuWindow.optionSelected("Hard song", width/2+3, 3*height/4+3)) 
      {
        // Plays a sound when an options is clicked
        menuWindow.click();
        menuWindow.setStatus(false);
        // Stops the song previously playing
        menuWindow.stopSong();
        gameWindow.setStatus(true);
        gameWindow.startSong();
        
        // sets the difficulty
        gameWindow.difficulty[2] = menuWindow.optionSelected("Easy song", width/2+3, height/4+3);
        gameWindow.difficulty[1] = menuWindow.optionSelected("Medium song", width/2+3, height/2+3);
        gameWindow.difficulty[0] = menuWindow.optionSelected("Hard song", width/2+3, 3*height/4+3);
      }
    }
  }
  if (gameWindow.getStatus()) 
  {
    // Check if the mouse click is within the boundaries of the drum
    float distance = dist(mouseX, mouseY, 40, height/2);
    if (distance < 70 / 2) {
      // If the mouse click is within the drum, increase the score
      gameWindow.click();
      player.increaseScore(10);
    }
  }
}
void keyPressed() {
    if (key == ' ') {
        if (gameWindow.getStatus()) {
            gameWindow.checkHit(); // Respond to space bar presses
        }
    }
}
