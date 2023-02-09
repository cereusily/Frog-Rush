color F_FROG_GREEN = color(92, 166, 73);
color F_BELLY_GREEN = color(154, 198, 143);
color F_BACKGROUND = color(255);
int NUM_FROGS = 2;

int frogWidth = 50;

ArrayList<Frog> frogsList = new ArrayList<Frog>();


void setup() {
  // Sets up windows and initiates frog
  size(800, 800);
  background(255);
  
  // Populates frogList with frogs
  for (int i = 0; i < NUM_FROGS; i++) {
    addNewFrog();
  }
}

void addNewFrog() {
  // Gets frog location
  int bx = (int) random(frogWidth/2, width - frogWidth/2);
  int by = (int) random(frogWidth/2, height - frogWidth/2);

  // Adds to frog list
  frogsList.add(new Frog(bx, by));
}

void draw() {
  // Draws the background
  background(F_BACKGROUND);
  
  // Draws the frogs and moves them
  for (int i = 0; i < frogsList.size(); i++) {
    Frog currFrog = frogsList.get(i);    
    currFrog.move(); 
    currFrog.drawCharacter();
  }
}
