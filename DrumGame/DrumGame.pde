import processing.sound.*;

int score =0;

void setup(){
  size(800,500);
}

void draw(){
   background(255);
    // Display the drum
    fill(49, 178, 204);
    rect(0, height/4, width,height/2);
    fill(143, 98, 47);
    ellipse(40, height/2 , 70 , 70);
    
    // Display the score
    fill(0);
    textSize(20);
    text("Score: " + score, 20, 30);
}

void mouseClicked() {
  // Check if the mouse click is within the boundaries of the drum
  float distance = dist(mouseX, mouseY, 40, height/2);
  if (distance < 70 / 2) {
    // If the mouse click is within the drum, increase the score
    score += 10;
  }
}

class Song{
  SoundFile s;
  Song (SoundFile s1){
    s = s1;
  }
  
  
}
