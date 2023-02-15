class Frog {
  // Init variables
  float x;  // Position variables
  float y;
  
  float xSpeed; // Velocity variables
  float ySpeed;
  
  float scaleFactor = 0.3;  // Scale variable
  float theta;
  float fWidth = 70;
  
  float starOneX;  // Star coordinates
  float starTwoX;
  float starSpeedX;
  
  int deathTimer = -1;  // Checks time alive
  
  
  // Constructor
  Frog(float posX, float posY, int xSpeed, int ySpeed) {
    this.x = posX;
    this.y = posY;
    
    this.xSpeed = xSpeed;
    this.ySpeed = ySpeed;
    
    theta = 0;
   
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
    x += (xSpeed * (1 + float(Score.comboCount/5)));
    y += (ySpeed * (1 + float(Score.comboCount/5)));
  }
  
  void checkCollide() {
    // Handles collisions
    if (x < -fWidth/2) x = width + fWidth/2;
    if (x > width + fWidth/2) x = -fWidth/2;
    if (y < -fWidth/2) y = height + fWidth/2;
    if (y > height + fWidth/2) y = -fWidth/2;
  }
  
  boolean hitFrog(float x, float y) {  // Returns if mouse is on frog
    return (dist(x, y, this.x, this.y) < fWidth / 2);
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
    
    // Tickles frog
    x += random(-1.5, 1.5);
    y += random(-1.5, 1.5);
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
    
    // <---- The eyes ---->
    push();
    scale(1.3);
    
    fill(255);
    ellipse(-60, -40, 50, 50);   // Left eye
    ellipse(60, -40, 50, 50);    // Right eye
    noFill();
    
    // The pupil
    fill(0);  
    theta += 0.25;  // Rotates pupils
    
    push();
    rectMode(CENTER);
    translate(-60, -40);
    rotate(theta); 
    rect(0, 0, 30, 15, 30); // left pupil
    pop();
    
    push();
    rectMode(CENTER);
    translate(60, -40);
    rotate(theta); 
    rect(0, 0, 30, 15, 30); // right pupil
    pop();
    
    fill(F_FROG_GREEN);
    
    pop();
    // <--- End eyes --->
  
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
    
    // Tongue
    fill(255, 0, 0);  // The Tongue
    quad(
      -10, 20,    //bottom 1
      30, 20,     // bottom 2
      30, 70,   // top 1
      -10, 70    // top 2
    );
    fill(F_FROG_GREEN);
    
    // <--- Stars for head --->
    fill(255);
    push();
    scale(0.5);

    // <--- Star 1
    push();  
    translate(-200, -250);

    // Calculates bounce
    if (starOneX <= 0) {
      starSpeedX = 15;
    }
    if (starOneX >= 410) {
      starSpeedX = -15;
    }
    starOneX += starSpeedX;
    drawStar(starOneX, 0, 30, 70, 5);   
    pop();
    // --->
    
    // <--- Star 2
    push();
    translate(200, -250);
    starTwoX += -starSpeedX;  // Star 2 X is inverse of star 1 X
    drawStar(starTwoX, 0, 30, 70, 5);
    pop();
    // --->
 
    pop();   
    // <--- End stars --->
    
    pop();
  }
  
  void drawStar(float x, float y, float radius1, float radius2, int npoints) {
    // Star method from https://processing.org/examples/star.html 
    float angle = TWO_PI / npoints;
    float halfAngle = angle/2.0;
    beginShape();
    for (float a = 0; a < TWO_PI; a += angle) {
      float sx = x + cos(a) * radius2;
      float sy = y + sin(a) * radius2;
      vertex(sx, sy);
      sx = x + cos(a+halfAngle) * radius1;
      sy = y + sin(a+halfAngle) * radius1;
      vertex(sx, sy);
    }
    endShape(CLOSE);
  }
}
