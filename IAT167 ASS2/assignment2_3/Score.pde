class Score {
  // Init Variables
  
  // <--- Combo variables --->
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
  int highestCombo;
  
  // <--- Frog Rush variables --->
  int frogRushStartTime;
  float frogRushMaxTime = 5.0;  // 5 second MAX rush time
  int frogRushCountTime = 1_000;  // -> 1 second counter
  int frogRushCounter;
  boolean justRushed = false;
  
  // <--- Ripples variable for rush --->
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
      frogRush = false;  // -> Resets rush
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
      
      // Compares highest combo
      highestCombo = (highestCombo < comboCount) ? comboCount : highestCombo;
      
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
    
    // Shadow text
    fill(2, 48, 32);
    textSize(45);
    text("HI SCORE: " + nf(Score.score, 0, 0), 20, 80);
    
    // Main text
    fill(255);
    text("HI SCORE: " + nf(Score.score, 0, 0), 15, 80);
    
    // Draws combo score
    if (hasCombo) {
      // Changes font colour depending on frog rush
      color comboColour = (frogRush) ? color(F_FROG_GREEN) : color(255);
      
      // Adds jitter
      comboJitter = (int) random(-comboCount/2, comboCount/2);  
      
      // Draws shadow combo text
      fill(2, 48, 32);
      text("COMBO X " + str(comboCount), 500 + comboJitter, 705 + comboJitter);
      
      // Draws main combo text
      fill(255);
      text("COMBO X " + str(comboCount), 500 + comboJitter, 700 + comboJitter);
      
      // Draw shadow combo text
      textSize(60);
      fill(2, 48, 32);
      text(nf(comboScore, 0, 0), 500 + comboJitter, 645 + comboJitter);
      
      // Draw main combo text
      fill(comboColour);
      textSize(60);
      text(nf(comboScore, 0, 0), 500 + comboJitter, 640 + comboJitter);
      fill(255);
    }
    // Draws jar score
    drawJar();
  }
  
  void drawFrogRush() {
    // Draws Frog Rush text
    String frogRushText = "FROG RUSH";
    push();
    
    // Shadow text
    fill(2, 48, 32);
    textSize(103);
    textAlign(CENTER);
    text(frogRushText, 400 + comboJitter, 405 + comboJitter);
    
    // Main text
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
    newColor = lerpColor(current, F_FROG_GREEN, rippleColorIncrement);
    
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
  
  void drawJar() {
    // Draws the jar
    push();
    
    rectMode(CENTER);
    translate(80, 720);
    scale(0.75);
    
    // Jar body
    noStroke();
    fill(173, 216, 230);
    rect(0, 0, 80, 100, 24);
    
    // Jar lid
    fill(164, 116, 73);
    rect(0, -50, 80, 20, 12);
    
    // <--- Draw frog logo --->
    
    push();
    scale(0.3);
    
    // The head
    fill(F_FROG_GREEN);
    ellipse(0, 0, 175, 125);
    ellipse(-60, -40, 75, 75);
    ellipse(60, -40, 75, 75);
    
    // The eyes
    fill(255);
    ellipse(-60, -40, 50, 50);   // Left eye
    ellipse(60, -40, 50, 50);    // Right eye
    noFill();
    
    // The pupil
    fill(0);
    rect(-75 + 15, -40, 30, 15, 30); // left pupil
    rect(45 + 15, -40, 30, 15, 30); // right pupil
    fill(F_FROG_GREEN);
  
    // Nose
    strokeWeight(4);
    ellipse(-10, 0, 5, 5); // left nostril
    ellipse(15, 0, 5, 5); // left nostril
    
    fill(F_BELLY_GREEN);
    
    // Mouth
    line(
      -50, 20, 
        50, 20
        );
    
    curve(
      -50, -250,
      -70, 20,
      70, 20,
      50, -250
    );
    fill(F_FROG_GREEN);
    
    // if frog rush, stick out tongue
    if (frogRush) {
      fill(255, 0, 0);  // The Tongue
      rect(0, 45, 40, 60, 20);
    }
    
    pop(); 
    // <--- End frog --->
    
    // Frog count text
    fill(255);
    textSize(45);
    text("x " + frogCount, 50, 10);
    pop();
  }
  
  void drawEndScore() {
    // Displays game over stats
    background(F_FROG_GREEN);
    fill(0);
    textSize(60);
    text("GAME OVER", 240, 400);
    textSize(30);
    text("You caught: " + str(frogCount) + " frogs!", 240, 450); 
    text("HI SCORE: " + nf(score, 0, 0), 240, 500);
    text("HIGHEST COMBO: " + str(highestCombo), 240, 550);
    
    // Ends game
    isActive = false;
   }
 
   
 }
