class Score {
  // Init Variables
  int frogCount;
  int FROG_RUSH_COMBO = 10;
  boolean frogRush = false;
  boolean canClick = true;
  boolean caughtFrog = false;
  boolean hasCombo = false;
  int comboCount;
  float comboScore;
  float scoreMultiplier;
  float scoreModifier;
  float score;
  int comboJitter;
  
  // Constructor
  Score(float multiplier, float modifier) {
    this.scoreMultiplier = multiplier;
    this.scoreModifier = modifier;
  }
  
  void checkCombo() {
    if (caughtFrog) { 
      // Combo calculations
      caughtFrog = false;
      hasCombo = true;
      comboCount++;
      
      if (frogRush) {
        scoreMultiplier *= (1.5 * scoreModifier);
      }
      else {
        scoreMultiplier *= scoreModifier;
      }
        
      
      comboScore += floor((100 * scoreMultiplier));
    }
    else {
      // Resets combo stats
      score += comboScore;
      hasCombo = false;
      frogRush = false;
      comboCount = 0;
      scoreMultiplier = 1;
      comboScore = 0;
    }
    canClick = true;
  }
  
  void drawScore() {
    // Draws score
    fill(0);
    text("You caught " + frogCount + "  frogs.", 20, 50);
    text("HI SCORE: " + nf(Score.score, 0, 0), 20, 200);
    
    // Draws combo score
    if (hasCombo) {
      comboJitter = (int) random(-comboCount/2, comboCount/2);  
      text("COMBO X " + str(comboCount), 500 + comboJitter, 480 + comboJitter);
      textSize(60);
      text(nf(comboScore, 0, 0), 600 + comboJitter, 420 + comboJitter);
    }
  }
  
  void drawFrogRush() {
    // Enables Frog rush
    frogRush = true;
    
    // Draws Frog Rush
    String frogRushText = "FROG RUSH";
    push();
    textSize(100);
    textAlign(CENTER);
    text(frogRushText, 400 + comboJitter, 400 + comboJitter);
    pop();
  }
  
  void drawEndScore() {
    // Displays game over stats
    background(255);
    textSize(60);
    text("GAME OVER", 240, 400);
    textSize(30);
    text("You caught: " + str(Score.frogCount) + " frogs!", 240, 450); 
    text("HI SCORE: " + nf(Score.score, 0, 0), 240, 500);
    
    // Ends game
    isActive = false;
  }
}
