class Frog {
  // Init variables
  float x;  // Position variables
  float y;
  
  float xSpeed; // Velocity variables
  float ySpeed;
  
  float scaleFactor = 0.25;  // Scale variable
  
  int deathTimer = -1;  // Checks time alive
  
  // Constructor
  Frog(float posX, float posY, int xSpeed, int ySpeed) {
    this.x = posX;
    this.y = posY;
    
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
  }
  
  void update() {
    // Updates frog
    move();
    checkCollide();
    
    // if frog still alive
    if (deathTimer == -1) {
      drawCharacter();
    }
    
    // TODO: Implement death animation
    if (deathTimer > 0) {
      // Death code --->
      deathTimer--;
      drawDeath();
    }
    
    // if Death -> remove from list
    if (deathTimer == 0) {
      frogsList.remove(this);
    }
  }
    
  void move() {
    // Moves the frog
    x += xSpeed;
    y += ySpeed;
  }
  
  void checkCollide() {
    // Handles collisions
    if (x < -frogWidth/2) x = width + frogWidth/2;
    if (x > width + frogWidth/2) x = -frogWidth/2;
    if (y < -frogWidth/2) y = height + frogWidth/2;
    if (y > height + frogWidth/2) y = -frogWidth/2;
  }
  
  boolean isAlive() {
    // Checks if frog is alive
    return deathTimer == -1;
  }
  
  void kill() {
    // Implement kill method;
    deathTimer = 60;
    xSpeed = 0;
    ySpeed = 0;
  }
  
  void drawCharacter() {
    // Draws the frog
    push();
    translate(x, y);
    scale(scaleFactor);
    
    noStroke();
    
    // Colours and lineweights
    fill(92, 166, 73);
    
    // Feet
    arc(0, 130, 290, 130, PI, PI+PI);
    
    // Left leg
    push();
    rotate(PI/-6);
    translate(-20, -75);
    ellipse(-100, 110, 60, 90);
    pop();
    
    // Right leg
    push();
    rotate(PI/6);
    translate(225, -80);
    ellipse(-100, 110, 60, 90);
    pop();
    
    // Body
    quad(
      -50, 0,
      50, 0,
      70, 125,
      -70, 125
    );
    
    // Belly
    fill(F_BELLY_GREEN);
    arc(0, 130, 100, 120, PI, PI+PI);
    fill(F_FROG_GREEN);
    
    // The head
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
    rect(-75, -40, 30, 15, 30); // left pupil
    rect(45, -40, 30, 15, 30); // right pupil
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
    
    // Left Arm
    ellipse(-60, 110, 40, 70);
    
    // fingers - left
    ellipse(-40, 150, 25, 25);
    ellipse(-80, 150, 25, 25);
    ellipse(-60, 150, 25, 25);
    
    // Right arm
    ellipse(60, 110, 40, 70);  
    
    // fingers - right
    ellipse(40, 150, 25, 25);
    ellipse(80, 150, 25, 25);
    ellipse(60, 150, 25, 25);
    
    pop();
  }
  
  void drawDeath() {
    // <--- TODO: Draw death animation --->
    // Draws the frog
    push();
    translate(x, y);
    scale(scaleFactor);
    
    noStroke();
    
    // Colours and lineweights
    fill(0);
    
    // Feet
    arc(0, 130, 290, 130, PI, PI+PI);
    
    // Left leg
    push();
    rotate(PI/-6);
    translate(-20, -75);
    ellipse(-100, 110, 60, 90);
    pop();
    
    // Right leg
    push();
    rotate(PI/6);
    translate(225, -80);
    ellipse(-100, 110, 60, 90);
    pop();
    
    // Body
    quad(
      -50, 0,
      50, 0,
      70, 125,
      -70, 125
    );
    
    // Belly
    fill(F_BELLY_GREEN);
    arc(0, 130, 100, 120, PI, PI+PI);
    fill(F_FROG_GREEN);
    
    // The head
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
    rect(-75, -40, 30, 15, 30); // left pupil
    rect(45, -40, 30, 15, 30); // right pupil
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
    
    // Left Arm
    ellipse(-60, 110, 40, 70);
    
    // fingers - left
    ellipse(-40, 150, 25, 25);
    ellipse(-80, 150, 25, 25);
    ellipse(-60, 150, 25, 25);
    
    // Right arm
    ellipse(60, 110, 40, 70);  
    
    // fingers - right
    ellipse(40, 150, 25, 25);
    ellipse(80, 150, 25, 25);
    ellipse(60, 150, 25, 25);
    
    pop();
  }

}
