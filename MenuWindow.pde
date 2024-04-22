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
    this.titleFont = createFont("CyberwayRiders.ttf", 85);
    this.optionFont = createFont("CyberwayRiders.ttf", 40);
    this.background = loadImage("background2.jpeg");
  }
  
  // displays the difficulty selection window
  void displayDifficulty() 
  {
    background(255);
    image(this.background, -1, 0, 800, 500);
    
    fill(0);
    textFont(optionFont);
    //text("Easy Song", width/2, height/4);
    text("Easy Song", width/2, height/4);
    text("Hard Song", width/2, 3*height/4);
    
    /*if (optionSelected("Easy song", width/2+3, height/4+3))
      fill(#2EAAB4);//#3BEEFC
    else
      fill(#3BEEFC);
    
    text("Easy song", width/2+3, height/4+3);*/
    
    if (optionSelected("Easy song", width/2+3, height/4+3))
      fill(#2EAAB4);
    else
      fill(#3BEEFC);
    
    text("Easy song", width/2+3, height/4+3);
    
    
    if (optionSelected("Hard song", width/2+3, 3*height/4+3))
      fill(#2EAAB4);
    else
      fill(#3BEEFC);
    
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
    text("RHYTHM PRISM", width/2, height/4);
    
    /*rectMode(CENTER);
    fill(0);
    stroke(#3BEEFC);
    strokeWeight(3);
    rect(width/2+3, height/2+3, 200,75);*/
    fill(0);
    textFont(optionFont);
    text("Start", width/2, height/2);
    text("Quit", width/2, 3*height/4);
    
    fill(#FF00E2);
    textFont(titleFont);
    textAlign(CENTER, CENTER);
    text("RHYTHM PRISM", width/2+3, height/4+3);
    
    textFont(optionFont);
    
    if (optionSelected("Start", width/2+3, height/2+3))
      fill(#2EAAB4); //#2EAAB4
    else
      fill(#3BEEFC);
    
    text("Start", width/2+3, height/2+3);
    
    if (optionSelected("Quit", width/2+3, 3*height/4+3))
      fill(#2EAAB4); //#5300F0
    else
      fill(#3BEEFC);
    
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
