class MenuWindow extends Window 
{
  PImage background;
  PFont titleFont;
  PFont optionFont;
  Boolean menu;
  
  MenuWindow(PApplet project) 
  {
    super(project);
    menu = true;
  }
  
  void setMenu(Boolean bool) 
  {
    menu = bool;
  }
  
  Boolean getMenu() 
  {
    return menu;
  }
 
  // loads the files needed
  void loadFiles() 
  {
    this.titleFont = createFont("ChinelaBrush.ttf", 70);
    this.optionFont = createFont("ChinelaBrush.ttf", 40);
    this.background = loadImage("background.tiff");
  }
  
  // displays the difficulty selection window
  void displayDifficulty() 
  {
    background(255);
    image(this.background, -1, 0, 800, 500);
    
    fill(0);
    textFont(optionFont);
    text("Easy Song", width/2, height/4);
    text("Medium Song", width/2, height/2);
    text("Hard Song", width/2, 3*height/4);
    
    if (optionSelected("Easy song", width/2+3, height/4+3))
      fill(#625242);
    else
      fill(#89725C);
    
    text("Easy song", width/2+3, height/4+3);
    
    if (optionSelected("Medium song", width/2+3, height/2+3))
      fill(#625242);
    else
      fill(#89725C);
    
    text("Medium song", width/2+3, height/2+3);
    
    if (optionSelected("Hard song", width/2+3, 3*height/4+3))
      fill(#625242);
    else
      fill(#89725C);
    
    text("Hard song", width/2+3, 3*height/4+3);
  }

  // displays the main menu
  void displayMenu() 
  {
    background(255);
    image(this.background, -1, 0, 800, 500);
    
    fill(0);
    textFont(titleFont);
    textAlign(CENTER, CENTER);
    text("Drum Hero", width/2, height/4);
    
    textFont(optionFont);
    text("Start", width/2, height/2);
    text("Quit", width/2, 3*height/4);
    
    fill(#89725C);
    textFont(titleFont);
    textAlign(CENTER, CENTER);
    text("Drum Hero", width/2+3, height/4+3);
    
    textFont(optionFont);
    
    if (optionSelected("Start", width/2+3, height/2+3))
      fill(#625242);
    else
      fill(#89725C);
    
    text("Start", width/2+3, height/2+3);
    
    if (optionSelected("Quit", width/2+3, 3*height/4+3))
      fill(#625242);
    else
      fill(#89725C);
    
    text("Quit", width/2+3, 3*height/4+3);
  }
  
  // checks if an option was selected
  Boolean optionSelected(String text, float x, float y) 
  {
    textFont(optionFont);
    
    float optionWidth = textWidth(text);
    float optionHeight = textAscent() + textDescent();
    float optionX = x - optionWidth/2;
    float optionY = y - optionHeight/2;
    
    return (mouseX >= optionX && mouseX <= optionX + optionWidth &&
        mouseY >= optionY && mouseY <= optionY + optionHeight) ;
  }
}
