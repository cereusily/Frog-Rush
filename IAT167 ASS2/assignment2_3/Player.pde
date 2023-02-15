class Player {
  // Init variables
  float x;
  float y;
  
  float scaleFactor = 1;
  float rotateFactor;
  
  Player(float posX, float posY) {
    this.x = posX;
    this.y = posY;
  }
  
  void update(float posX, float posY) {
    this.x = posX;  // -> Updates location
    this.y = posY;
  }
  
  void drawCursor() {
    // Draws cursor
    push();
    
    translate(x + 25, y);
    scale(scaleFactor);
    rotate(rotateFactor);
    
    // Handle
    noStroke();
    fill(164, 116, 73);
    rectMode(CENTER);
    rect(0, 0, 15, 75);
    
    // Head
    fill(20, 20, 20);
    rect(0, -20, 50, 30);
    pop();
  }
}
