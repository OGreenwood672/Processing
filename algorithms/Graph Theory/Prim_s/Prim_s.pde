//Prim's algorithm
import java.util.ArrayList;

ArrayList<PVector> vectors = new ArrayList<PVector>();

int nodeSize = 20;
int lineWeight = 4;

boolean process = false;

void setup() {
  size(600, 600);
  
  println("Press <space> to add random point");
  println("Press <r> to reset canvas");
  println("Click to add point");
  
}

void mousePressed() {
  vectors.add(new PVector(mouseX, mouseY));
}

void keyPressed() {
  if (key == ' ') {
    vectors.add(new PVector(random(width), random(height)));
  }
  if (key == 'r') {
    vectors = new ArrayList<PVector>();
  }
}


void draw() {
  background(0);
  
  for (PVector vector : vectors) {
    ellipse(vector.x, vector.y, nodeSize, nodeSize);
  }
  
  if (vectors.size() > 2) {
    
    ArrayList<PVector> reached = new ArrayList<PVector>();
    ArrayList<PVector> unreached = new ArrayList<PVector>();
    
    for (int i = 0; i < vectors.size(); i++) {
      unreached.add(vectors.get(i));
    }
  
    reached.add(unreached.get(0));
    unreached.remove(0);
      
    while (unreached.size() > 0) {
      float record = 10000;
      int rIndex = 0;
      int uIndex = 0;
      
      for (int i = 0; i < reached.size(); i++) {
        for (int j = 0; j < unreached.size(); j++) {
          PVector v1 = reached.get(i);
          PVector v2 = unreached.get(j);
          
          float d = PVector.dist(v1, v2);
          if (d < record) {
            record = d;
            rIndex = i;
            uIndex = j;
          }
          
        }
      }
      
      stroke(255);
      strokeWeight(lineWeight);
      line(reached.get(rIndex).x, reached.get(rIndex).y, unreached.get(uIndex).x, unreached.get(uIndex).y);
      
      reached.add(unreached.get(uIndex));
      unreached.remove(uIndex);
    }
  }


}
