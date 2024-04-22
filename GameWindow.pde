class GameWindow extends Window {
  PImage[] background;
  Boolean[] difficulty;
  int[] scoreThreshold;
  int[] maxScore;
  float[] easyBeats = {1000,1000,2000,1000,1000, 2000,1000,500,500,2000,1000,500,500,  2000,1000,1000,1000,500,500,1000,1000,1000,500,500,
                      4000,1000,250,250,500,500,250,250,500, 2500,1000,1000,2000,1000,1000,2000,1000,1000, 1000,500,500, 
                      2000,500,500,500,500,500,500,250,250,500, 500,500,500,500,500,500,250,250,500,500,500,500,500,500,500,250,250,500,500,500,500,500,500,500,250,250,
                      4400,1000,1000,1000,500,500,1000,1000,1000,500,500,1000,1000,1000,500,500, 
                      4000,500,3500,500,3500,500,3500,500, 3400,1000,500,500, 1000,1000,1000,500,500,1000,1000,1000,500,500,
                      2000,1000,1000, 
                      1950,500,500,500,500,500,500,250,250,500,500,500,500,500,500,500,250,250,500,500,500,500,500,500,500,250,250,500,500,500,500,500,500,500,250,250,500,500,500,500,500,500,500,250,250,490,500,500,500,500,500,500,250,250,250,250,
                      8000};
  float[] hardBeats = {1000, 1000,1000,1000,1000,1000};
  int beatIndex;
  PImage drum;
  PImage drumHit;
  PImage neonrect;
  ArrayList<Block> blocks;
  float spawnRate = 1; // Blocks per second
  int lastSpawnTime = 0;
  float drumX; // X position for the drum
  boolean firstBeat;

  GameWindow(PApplet project) {
    super(project);
    background = new PImage[2];
    difficulty = new Boolean[2];
    
    //TEMP score values- change them based on the number of blocks end up using.
    scoreThreshold = new int[2];
    scoreThreshold[0] = 2000; //hard
    scoreThreshold[1] = 1200; //easy
    maxScore = new int[2];
    maxScore[0] = hardBeats.length * 10; //hard
    maxScore[1] = easyBeats.length * 10; //easy
    firstBeat = false;
    println(maxScore[0]);
    println(maxScore[1]);
    
    beatIndex = 0;

    blocks = new ArrayList<Block>();
    drumX = 50; // Adjust the drum position slightly to the right from the left side
    for (int i = 0; i < 2; i++) {
      difficulty[i] = false;
    }
  }

  void loadFiles() {
    //background[2] = loadImage("background.jpeg");
    background[1] = loadImage("neonbackground2.jpeg");
    background[0] = loadImage("background.jpeg");
    drum = loadImage("neondrum.png");
    drum.resize(100, 100);
    drumHit = loadImage("neondrumhit.png");
    drumHit.resize(140, 140);
    neonrect = loadImage("neonrect.png");
    
  }

  void startSong() {
    super.startSong(false);
    lastSpawnTime = millis(); // Start spawning blocks when the song starts
    firstBeat=true;
  }

  void display() {
    background(255);  // Clear the screen

    // Display the correct background based on difficulty
    for (int i = 0; i < 2; i++) {
      if (difficulty[i]) {
        image(background[i], 0, 0, 800, 500);
      }
    }
    //
    noStroke();
    fill(#7CF1FF, 80);
    rectMode(CORNERS);
    rect(0, height/4, width, 3*height/4);

    // Display the drum at the updated position
    image(drum, drumX, height/2-50);

    // Display the score
    fill(255);
    textSize(20);
    text("Score: " + player.getScore(), 50, 30);

    if (super.checkIsPlaying()) {
      // Update and display blocks
      updateBlocks();
      displayBlocks();
    } else {  
      //has ended
      fill(0);
      rectMode(CENTER);
      rect(width/2, height/2, 275, 175, 25);
      image(neonrect, width/2-neonrect.width/2, height/2-neonrect.height/2);
      fill(255);
      textSize(30);
      text("Final Score: " + player.getScore(), width/2, height/2-20);
      //check if score reaches a threshold
      for (int i=0; i<2; i++) {
        if (difficulty[i]) {
          if (player.getScore() == maxScore[i]) {
            text("Perfect!", width/2, height/2+10);
          }
          else if (player.getScore() >= scoreThreshold[i]) {
            text("You pass!", width/2, height/2+10);
          }
          else{
            text("Better luck next time.", width/2, height/2+10);
          }
        }
      }
    }
  }

  void updateBlocks() {
    int currentTime = millis();
    if(firstBeat && currentTime - lastSpawnTime >= 2560){
      blocks.add(new Block(width));  // Add new block
      lastSpawnTime = currentTime;
      firstBeat = false;
    }
    //if easy
    if(difficulty[1] && beatIndex < easyBeats.length && currentTime - lastSpawnTime >= easyBeats[beatIndex] && !firstBeat){
      blocks.add(new Block(width));  // Add new block
      lastSpawnTime = currentTime;
      beatIndex++;
    }
    //if hard
    else if(difficulty[0] && beatIndex < hardBeats.length && currentTime - lastSpawnTime >= hardBeats[beatIndex] && !firstBeat){
      blocks.add(new Block(width));  // Add new block
      lastSpawnTime = currentTime;
      beatIndex++;
    }
    
    /*
    if (currentTime - lastSpawnTime >= 1000 / spawnRate && !firstBeat) {
      blocks.add(new Block(width));  // Add new block
      lastSpawnTime = currentTime;
    }*/

    for (int i = blocks.size() - 1; i >= 0; i--) {
      Block b = blocks.get(i);
      b.update();
      if (b.x < -10) {  // Check when block reaches the drum
        blocks.remove(i);
      }
    }
  }

  void displayBlocks() {
    for (Block b : blocks) {
      b.display();
    }
  }

  void checkHit() {
    if (super.checkIsPlaying()) {
      float hitRange = 160; // Pixels range to consider a hit
      //for (int i = blocks.size() - 1; i >= 0; i--) {
        for(int i=0; i<blocks.size(); i++){
        Block b = blocks.get(i);
        if (abs(b.x - drumX) < hitRange) {
          blocks.remove(i);
          if (abs(b.x - (drumX+50)) < 40) {
            player.increaseScore(10);  // Increase score for a hit
          } else if (abs(b.x-(drumX+50)) < 70) {
            //late or early
            player.increaseScore(5);
          }
          image(drumHit, drumX-20, height/2-70);
          click();  // Play the sound effect on hit
          break;  // Only allow one hit per input
        }
      }
    }
  }

  class Block {
    float x;
    float speed = 3; // Speed at which blocks move towards the drum

    Block(float startX) {
      x = startX;
    }

    void update() {
      x -= speed;  // Move block towards the drum
    }

    void display() {
      fill(#00ECFF);  // Red color for blocks
      ellipse(x, height/2, 50, 50);  // Draw block
    }
  }
}
