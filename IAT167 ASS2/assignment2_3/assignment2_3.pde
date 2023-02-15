/*
FROG RUSH

Catch as many frogs as you can within 60 seconds!
You earn more points for each frog you catch without missing and
if you manage to catch 10 frogs in a row, you'll enter FROG RUSH
and you'll earn even more points per frog!

Timothy Kung
301420651
*/


color F_FROG_GREEN = color(92, 166, 73);
color F_BELLY_GREEN = color(154, 198, 143);
color F_BACKGROUND = color(20, 70, 185);
int NUM_FROGS = 6;
int MAX_FROGS = 10;

int frogWidth = 70;

int startTime;
int respawnStartTime;
int timeLimit = 60_000;
int respawnTime = 1_000;

int passedTime;
boolean isActive;
boolean clickOnce;

ArrayList<Frog> frogsList = new ArrayList<Frog>();

Score Score = new Score(1, 1.06);
Player user = new Player(mouseX, mouseY);

void setup() {
  // Sets up windows and initiates frog
  size(800, 800);
  background(F_BACKGROUND);
  
  // Sets up frame-rate
  frameRate(60);
  
  // Populates frogList with frogs
  for (int i = 0; i < NUM_FROGS; i++) {
    addNewFrog();
  }
  
  // Loads in font
  PFont font = loadFont("ComicSansMS-Bold-48.vlw");
  textFont(font);
  textSize(30);
  
  // Snapshot time
  startTime = millis();
  respawnStartTime = millis();
  
  // Starts game
  isActive = true;
}

void addNewFrog() {
  // Gets frog location
  int bx = (int) random(frogWidth/2, width - frogWidth/2);
  int by = (int) random(frogWidth/2, height - frogWidth/2);
  
  // Generates random velocity
  int vx = (int) random(-5, 5);
  int vy = (int) random(-5, 5);
  
  // Adds to frog list
  frogsList.add(new Frog(bx, by, vx, vy));
}

void mouseReleased() { 
  // Checks combo
  if (isActive) {
    Score.checkCombo();
  }
  clickOnce = false;
  user.rotateFactor = 0;
}

void mousePressed() {
  // Checks if mouse clicked once
  clickOnce = true;
  
  // Rotates user hammer
  user.rotateFactor = -PI/3;
}

void draw() {

  // Game loop
  if (isActive) {
    
    // Draws the background
    drawScene();
    
    // Check for frog rush
    Score.checkFrogRush();
    
    // Draws the frogs and moves them
    for (int i = 0; i < frogsList.size(); i++) {
      Frog currFrog = frogsList.get(i);   
      currFrog.update();
      
      // Updates if user clicks & checks for clicked frog
      if (clickOnce && (mouseButton == LEFT) && Score.canClick) {
        if (currFrog.isAlive() && currFrog.hitFrog(mouseX, mouseY)) {
          Score.frogCount++;
          Score.caughtFrog = true;
          currFrog.kill();
        }
      } 
    }
    // Draws cursor
    user.update(mouseX, mouseY);
    user.drawCursor();
    
    // Draws score & time 
    Score.drawScore();
    drawTime();
    
    // Adds new frogs when threshold < 10
    respawnFrog();
    
    // Tracks time
    countTime();
    
    // Resets click once
    clickOnce = false;
    
  }
}

void countTime() {
  // Tracks time passed
  passedTime = millis() - startTime;
  
  // Checks if passed time exceeds time limit
  if (passedTime > timeLimit) {
    Score.score += Score.comboScore;  // Tallies combo score 
    Score.drawEndScore();  // Draws end score
  }
}

void drawTime() {
  // Draws time
  if (timeLimit/1000 - round(passedTime/1000) < 6) {  // -> Draws countdown
    textAlign(CENTER);
    
    // Shadow text
    textSize(96);
    fill(2, 32, 48);
    text(str(timeLimit/1000 - round(passedTime/1000)), 405, 420);
    
    // Main text
    textSize(96);
    fill(255);
    text(str(timeLimit/1000 - round(passedTime/1000)), 400, 420);
    
    
    textAlign(LEFT);
    textSize(45);
  }
  else {
    // Draws the time
    String timeText = "Time left: " + str(timeLimit/1000 - round(passedTime/1000));
    
    // Main shadow text
    fill(2, 48, 32);
    textSize(47);
    text(timeText, 480, 80);
    
    // Main score text
    fill(255);
    textSize(47);
    text(timeText, 475, 80);
    
  }
}

void drawScene() {
  // Draws the background
  background(F_BACKGROUND);
  
  // Land outline
  noFill();
  rectMode(CENTER);
  ellipseMode(CENTER);
  
  strokeWeight(128);
  stroke(2, 48, 32);
  ellipse(400, 400, 1000, 1000);
  
  strokeWeight(64);
  stroke(57,133,74);
  ellipse(400, 400, 850, 850);
  
  stroke(97,190,144);
  ellipse(400, 400, 750, 750);
  
  strokeWeight(32);
  stroke(1, 87, 155);
  ellipse(400, 400, 670, 670);
  
}

void respawnFrog() {
  // Checks time passed
  int passedRespawnTime = millis() - respawnStartTime;
  
  // Checks if frog num drops below 10
  if (frogsList.size() < MAX_FROGS) {
    if (passedRespawnTime > respawnTime) {  // If X seconds passed -> add new frog
      addNewFrog();
      respawnStartTime = millis();  // Resets timer
    }
  }
}
