int butterflyWidth=100; //diameter of "wing" arc, plus width of rect. body
int numButterflies=5; 
int space=10;
int score;

int startTime;
int respawnStartTime;
int timeLimit = 60_000;
int respawnTime = 5000;

ArrayList<Butterfly> butterflies = new ArrayList<Butterfly>(); 

void setup() {
  size(600, 600);
  
  // Draws in butterflies
  for (int i=0;i<numButterflies;i++) {
    addNewButterfly();
  }
  
  // Loads in font
  PFont font = loadFont("ComicSansMS-Bold-48.vlw");
  textFont(font);
  textSize(30);
  
  // Snapshot time
  startTime = millis();
  respawnStartTime = millis();
}

void addNewButterfly() {
  int bx=(int)random(butterflyWidth/2, width-butterflyWidth/2); 
  int by=(int)random(butterflyWidth/2, height-butterflyWidth/2); 
  butterflies.add(new Butterfly(bx, by, (int)random(-5, 5), (int)random(-5, 5)));
}

void draw() {
  fill(120, 120, 255, 50);
  rect(0, 0, width, height);
  drawScore();  // Draws in score

  // Updates all butterflies
  for (int i=0;i<butterflies.size();i++) {

    Butterfly currButterfly = butterflies.get(i);
    currButterfly.update();
    
    if (currButterfly.isAlive() && mousePressed && dist(mouseX, mouseY, currButterfly.x, currButterfly.y) < butterflyWidth/2){
      currButterfly.kill();
      score++;
    }
  }
  
  // Respawns butterflies if threshold is below 3
  respawnButterflies();
  
  // Tracks time for game over
  countTime();
}

void drawScore() {
  // Draws score
  fill(0);
  text("Congrats! You murdered " + score + " butterflies.", 20, 50);
}

void countTime() {
  // Tracks time passed
  int passedTime = millis() - startTime;
  
  // Checks if passed time exceeds time limit
  if (passedTime > timeLimit) {
    background(255);
    textSize(60);
    text("GAME OVER", 120, 300);
    println("Game ends");
  }
  
}

void respawnButterflies() {
  // Checks time passed
  int passedTime = millis() - respawnStartTime;
  
  // Checks if butterflies num drops below 3
  if (butterflies.size() < 3) {
    if (passedTime > respawnTime) {  // If 5 seconds passed -> add new butterfly
      addNewButterfly();
      respawnStartTime = millis();  // Resets timer
    }
  }
}
