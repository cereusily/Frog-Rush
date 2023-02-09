color c = color(255, 120, 120);
float mouseScale = 1.0;

void setup() {
  size(600, 600);
}

void draw(){
  // Drawn per frame
  float r = map(mouseX, 0, width, -PI, 0);
  drawBG();
  drawBear(mouseScale, r);
  drawButterfly(c);
  if (mousePressed)
  {
    mouseScale += 0.05;
  }
}

void mousePressed() {
  // Set C to random colour
  c = color(random(255), random(255), random(255));
}

void mouseReleased() {
  if (mouseScale > 1.0) {
    mouseScale = 1.0;
  }
}
void drawBG(){
  //background
  background(255); 
  fill(0,0,255);
  rect(100,100,400,450);
  strokeWeight(3);
  stroke(183/2, 114/2, 15);
  fill(183, 114, 30);
}

void drawBear(float scaleFactor, float rotateFactor)
{
  // draw the bear
  
  // Start Snapshot + translate all drawings
  pushMatrix();
  translate(300, 350); // -> from lab tut

  //feet
  arc(0,200, 350, 400, -PI, 0);

  //body
  ellipse(0, 0, 250, 400);

  //arms 
  ellipse(-100, 0, 80, 200);
  //ellipse(100, 0, 80, 200);  // -> Static right arm
  
  //rotating right arm
  pushMatrix();
  translate(100, -100);
  rotate(rotateFactor);
  ellipse(0, 100, 80, 200);
  popMatrix();
  
  // End snapshot
  popMatrix();
  
  // translate face + set origins
  pushMatrix(); // snapshot to head
  translate(300, 150); // recenter to head center
  
  // scale face elements
  scale(scaleFactor);
  
  //ears
  ellipse(100, -30, 80, 80);
  ellipse(-100, -30, 80, 80);


  //head  

  ellipse(0, 0, 200, 200);

  
  //face
  noStroke();
  fill(247,202,147);
  ellipse(-40,0,80,80);
  ellipse(40,0,80,80); 
  ellipse(0,40,80,80);

  
  //irises
  fill(180,180,255);
  ellipse(-40,0,30,30);
  ellipse(40,0,30,30);
  
  //pupils
  fill(0); 
  ellipse(-40,0,8,8);
  ellipse(40,0,8,8);
  
  //nose
  triangle(
  0,40,
  -20,20,
  20,20
  );
  
  // mouth
  noFill();
  stroke(183/2, 114/2, 15);
  strokeWeight(5);
  arc(0,40,80,80,0,PI);
  
  popMatrix();

}

void drawButterfly(color wingColour)
{
  // draws the butterfly
  //butterfly
  
  pushMatrix();
  translate(mouseX - 105, mouseY - 125);
  
  //body
  fill(0);
  rect(
  100,
  100,
  20,80,ROUND);
  
  //attenae
  line(
  100,100,
  100,80
  );
  noFill();
  arc(90,80,20,20,-PI,0);
  line(120,100,120,80);
  arc(130,80,20,20,-PI,0);
  
  //wings
  stroke(255,50,50);
  fill(wingColour);
  arc(100,140,80,70,radians(110),radians(250));
  arc(120,140,80,70,radians(-70),radians(70));
  popMatrix();
}
