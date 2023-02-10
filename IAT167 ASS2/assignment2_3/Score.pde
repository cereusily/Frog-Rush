class Score {
  // Init Variables
  int frogCount;
  int FROG_RUSH_COMBO = 10;
  boolean hitRush = false;
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
  
  int frogRushStartTime;
  float frogRushMaxTime = 5.0;  // X seconds
  int frogRushCountTime = 1_000;  // -> 1 second counter
  int frogRushCounter;
  boolean justRushed = false;
  
  float rippleSize;  
  float maxRippleSize = 4000;
  float rippleColorIncrement = 0.01;
  color current = color(255);
  color newColor;
  
  int rippleTimer;
  
  // Constructor
  Score(float multiplier, float modifier) {
    this.scoreMultiplier = multiplier;
    this.scoreModifier = modifier;
  }

  void checkFrogRush() {
    // Draws frog rush if reaches frog rush combo  
    frogRush = comboCount >= FROG_RUSH_COMBO && frogRushCounter < frogRushMaxTime;
    
    // If rush just ended, reset combo
    if (justRushed && !frogRush) {
      resetCombo();
    }
    
    // <--- FROG RUSH --->
    if (frogRush) { 
      // Draws frog rush
      drawFrogRush();
      frogRushTimer();
      
      // Drawsing ripples
      if (rippleTimer > 0) {
        drawRipples();
      }
      rippleTimer--;
      justRushed = true;
    }
    // <--- END OF FROG RUSH --->
    else {
      frogRush = false;
      justRushed = false;
   
      // resets ripples
      rippleSize = 0;
      rippleColorIncrement = 0;
      newColor = color(255);
      rippleTimer = 120;
    }
  }
  
  void checkCombo() {
    if (caughtFrog) { 
      // Combo calculations
      caughtFrog = false;
      hasCombo = true;
      comboCount++;
      frogRushCounter = 0;
      
      // Calculates frog rush combos -> else standard calc
      if (frogRush) {
        scoreMultiplier *= (1.5 * scoreModifier);
      }
      else {
        scoreMultiplier *= scoreModifier;
      }
        
      // Adds combo score from multiplier
      comboScore += floor((100 * scoreMultiplier));
    }
    else {
      // Resets combo stats
      resetCombo();
    }
    canClick = true;
  }
  
  void resetCombo() {
    // Resets combo
    score += comboScore;
    hasCombo = false;
    frogRush = false;
    comboCount = 0;
    scoreMultiplier = 1;
    comboScore = 0;
  }
  
  void drawScore() {
    // Draws score
    fill(0);
    text("You caught " + frogCount + "  frogs.", 20, 50);
    text("HI SCORE: " + nf(Score.score, 0, 0), 20, 200);
    
    // Draws combo score
    if (hasCombo) {
      // Changes font colour depending on frog rush
      color comboColour = (frogRush) ? color(F_FROG_GREEN) : color(0);
      
      // Adds jitter
      comboJitter = (int) random(-comboCount/2, comboCount/2);  
      
      // Draws combo
      fill(0);
      text("COMBO X " + str(comboCount), 500 + comboJitter, 700 + comboJitter);
      textSize(60);
      fill(comboColour);
      text(nf(comboScore, 0, 0), 500 + comboJitter, 640 + comboJitter);
      fill(0);
    }
  }
  
  void drawFrogRush() {
    // Draws Frog Rush text
    String frogRushText = "FROG RUSH";
    push();
    fill(F_FROG_GREEN);
    textSize(100);
    textAlign(CENTER);
    text(frogRushText, 400 + comboJitter, 400 + comboJitter);
    pop();
  }
  
  void frogRushTimer() {
    // Checks time passed
    int passedRushTime = millis() - frogRushStartTime;
    
    // 1 second timer
    if (passedRushTime > frogRushCountTime) {  // If 1 second passes -> decrease the meter
      frogRushCounter++;
      frogRushStartTime = millis();  // Resets timer back
    }
     
    // Draws timer limit
    push();
    noStroke();
    rectMode(CENTER);
    fill(F_FROG_GREEN);
    rect(
      400 + comboJitter, 
      430 + comboJitter, 
      400 - (map(frogRushCounter, 0, frogRushMaxTime, 0, 400)), 
      30, 
      30);
    pop();
  }
  
  void drawRipples() {
    // Draws ripples
    noFill();
    push();
    translate(400, 400); 
    stroke(255);
    
    // Lerps colours
    newColor = lerpColor(current, F_BACKGROUND, rippleColorIncrement);
    
    if (rippleSize <= maxRippleSize) {
      stroke(newColor);
      strokeWeight(16);
      
      // Draws ripples
      rippleSize += 20;
      ellipse(0, 0, rippleSize, rippleSize);
      ellipse(0, 0, rippleSize * .75, rippleSize * .75);
      ellipse(0, 0, rippleSize * .5, rippleSize * .5);
      
      rippleColorIncrement += 0.01;
    }
  pop();
}
  
  void drawEndScore() {
    // Displays game over stats
    background(F_FROG_GREEN);
    fill(0);
    textSize(60);
    text("GAME OVER", 240, 400);
    textSize(30);
    text("You caught: " + str(Score.frogCount) + " frogs!", 240, 450); 
    text("HI SCORE: " + nf(Score.score, 0, 0), 240, 500);
    
    // Ends game
    isActive = false;
  }
}
