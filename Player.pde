class Player 
{
  int score;
  
  // variables to store the player's highest score
  
  Player() 
  {
    this.score = 0;
  }
  
  void increaseScore(int points) 
  {
    this.score += points;
  }
  
  public int getScore() 
  {
    return this.score;
  }
}
