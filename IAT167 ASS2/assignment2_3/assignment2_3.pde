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
}

void mousePressed() {
  // Checks if mouse clicked once
  clickOnce = true;
}

void draw() {
  // <--- DEBUG --->
  
  // <--- END DEBUG --->
  
 // Game loop
  if (isActive) {
    
    // Draws the background
    background(F_BACKGROUND);
     
    // Draws score & time 
    Score.drawScore();
    drawTime();
    
    // Check for frog rush
    Score.checkFrogRush();
    
    // Draws the frogs and moves them
    for (int i = 0; i < frogsList.size(); i++) {
      Frog currFrog = frogsList.get(i);   
      currFrog.update();
      
      // Updates if user clicks & checks for clicked frog
      if (clickOnce && (mouseButton == LEFT) && Score.canClick) {
        if (currFrog.isAlive() && dist(mouseX, mouseY, currFrog.x, currFrog.y) < frogWidth / 2) {
          Score.frogCount++;
          Score.caughtFrog = true;
          currFrog.kill();
        }
      } 
    }
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
    textSize(96);
    textAlign(CENTER);
    text(str(timeLimit/1000 - round(passedTime/1000)), 400, 400);
    textAlign(LEFT);
    textSize(45);
  }
  else {
    // Draws the time
    String timeText = "Time left: " + str(timeLimit/1000 - round(passedTime/1000));
    textSize(45);
    text(timeText, 25, 120);
  }
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
