class GameWindow extends Window {
  PImage[] background;
  Boolean[] difficulty;
  PImage drum;
  ArrayList<Block> blocks;
  float spawnRate = 1.0; // Blocks per second
  int lastSpawnTime = 0;
  float drumX; // X position for the drum

  GameWindow(PApplet project) {
    super(project);
    background = new PImage[3];
    difficulty = new Boolean[3];
    blocks = new ArrayList<Block>();
    drumX = 120; // Adjust the drum position slightly to the right from the left side
    for (int i = 0; i < 3; i++) {
      difficulty[i] = false;
    }
  }

  void loadFiles() {
    background[2] = loadImage("game_background.jpeg");
    background[1] = loadImage("musicbackground2.jpeg");
    background[0] = loadImage("musicbackground1.jpeg");
    drum = loadImage("drum.png");
  }

  void startSong() {
    super.startSong();
    lastSpawnTime = millis(); // Start spawning blocks when the song starts
  }

  void display() {
    background(255);  // Clear the screen
    
    // Display the correct background based on difficulty
    for (int i = 0; i < 3; i++) {
      if (difficulty[i]) {
        image(background[i], 0, 0, 800, 500);
      }
    }
    
    // Display the drum at the updated position
    image(drum, drumX - drum.width / 2, height - drum.height - 30, drum.width, drum.height);
    
    // Update and display blocks
    updateBlocks();
    displayBlocks();
    
    // Display the score
    fill(0);
    textSize(20);
    text("Score: " + player.getScore(), 10, 30);
  }

  void updateBlocks() {
    int currentTime = millis();
    if (currentTime - lastSpawnTime >= 1000 / spawnRate) {
      blocks.add(new Block(width));  // Add new block
      lastSpawnTime = currentTime;
    }

    for (int i = blocks.size() - 1; i >= 0; i--) {
      Block b = blocks.get(i);
      b.update();
      if (b.x < drumX - 20) {  // Check when block reaches the drum
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
    float hitRange = 50; // Pixels range to consider a hit
    for (int i = blocks.size() - 1; i >= 0; i--) {
      Block b = blocks.get(i);
      if (abs(b.x - drumX) < hitRange) {
        blocks.remove(i);
        player.increaseScore(10);  // Increase score for a hit
        click();  // Play the sound effect on hit
        break;  // Only allow one hit per input
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
      fill(200, 0, 0);  // Red color for blocks
      ellipse(x, height - 60, 50, 50);  // Draw block
    }
  }
}
