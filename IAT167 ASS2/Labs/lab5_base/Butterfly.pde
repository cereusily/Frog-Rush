class Butterfly {

  //fields
  int x;
  int y;
  int ySpeed;
  int xSpeed;
  
  float wingRotPos = PI/12;
  float wingRotVel = 0.07;
  
  int deathTimer = -1;

  Butterfly(int x, int y_, int xSpeed, int ySpeed) {
    this.x = x;
    y = y_;
    this.ySpeed = ySpeed;
    this.xSpeed = xSpeed;
  }
  
  void handleCollision() {
    // Handles collisions
    if (x < -butterflyWidth/2) x = width + butterflyWidth/2;
    if (x > width + butterflyWidth/2) x = -butterflyWidth/2;
    if (y < -butterflyWidth/2) y = height + butterflyWidth/2;
    if (y > height + butterflyWidth/2) y = -butterflyWidth/2;
  }
  
  boolean isAlive() {
    // checks if butterfly is alive
    return deathTimer == -1;
  }
  
  void update() {
    move();
    handleCollision();
    
    // If still alive
    if (deathTimer == -1) {
      drawMe();
    }
    
    // Death animation
    if (deathTimer > 0) {
      deathTimer--;
      wingRotPos += wingRotVel;
      
      if (wingRotPos > PI/10 || wingRotPos < -PI/10) wingRotVel = -wingRotVel;
      
      drawDyingButterfly();
      
      // Make the wing rotates between 
    }
    
    // If death -> remove from list
    if (deathTimer == 0) {
      butterflies.remove(this);
    }
  }
  
  void kill() {
    // Implement kill method
    deathTimer = 60;
    xSpeed = 0;
    ySpeed = 0;
  }

  //methods
  void move() {

    y += ySpeed;
    x += xSpeed;
  }

  void drawMe() {
    //butterfly
    pushMatrix();
    translate(x, y);
    //body
    fill(0);
    stroke(0);
    rect(-10, -40, 20, 80, ROUND);

    //attenae
    line(-10, -40, -10, -60);
    noFill();
    arc(-20, -60, 20, 20, -PI, 0);
    line(10, -40, 10, -60);
    arc(20, -60, 20, 20, -PI, 0);

    //wings
    stroke(255, 50, 50);
    fill(255, 120, 120, 180);
    arc(-10, 0, 80, 70, radians(110), radians(250));
    arc(10, 0, 80, 70, radians(-70), radians(70));
    popMatrix();
  }
  
  void drawDyingButterfly() {
    // Draws dying animation
    
    //butterfly
    pushMatrix();
    translate(x, y);
    //body
    fill(0);
    stroke(0);
    rect(-10, -40, 20, 80, ROUND);
    //attenae
    line(-10, -40, -10, -60);
    noFill();
    arc(-20, -60, 20, 20, -PI, 0);
    //wings
    stroke(255, 50, 50);
    fill(0);
    
    //make left wing flap
    pushMatrix();
    translate(-10, 0);
    rotate(wingRotPos);
    arc(0, 0, 80, 70, radians(170), radians(200));
    popMatrix();
    
    //make right wing flap
    pushMatrix();
    translate(-10, 0);
    rotate(wingRotPos);
    arc(10, 0, 80, 70, radians(-30), radians(30));
    popMatrix();
    popMatrix();
  }
}
