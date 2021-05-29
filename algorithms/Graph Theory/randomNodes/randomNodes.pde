import java.util.ArrayList;
import java.lang.Math;

ArrayList<Node> nodes = new ArrayList<Node>();

int numberOfNodes = 10;
int nodeSize = 20;
int radius = 250;

float density = 0.5;

int weightRange = 10; //1 gives binary weights


void setup() {
  size(600, 600);
  
  
  for (int i = 0; i < numberOfNodes; i++) {
    //PVector v = new PVector(random(width), random(height));
    float deg = (360 / numberOfNodes) * i;
    float x = radius * (float)Math.sin(Math.toRadians(deg)) + width/2;
    float y = radius * (float)Math.cos(Math.toRadians(deg)) + height/2;
    PVector v = new PVector(x, y);
    Node n = new Node(v);
    nodes.add(n);
  }
  
  for (int i = 0; i < nodes.size(); i++) {
    for (int j = 0; j < nodes.size(); j++) {
      if (i < j && random(100)/100 < density) {
        //ADD TWO WAY CONNECTION
        float weight = random(weightRange);
        Node node_i = nodes.get(i);
        Node node_j = nodes.get(j);
        
        node_i.neighbours.add(node_j);
        node_i.weights.add(weight);
        
        node_j.neighbours.add(node_i);
        node_j.weights.add(weight);
      }
    }
  }
  
}

void draw() {
  background(0);
  stroke(255);
  strokeWeight(1);

  //Draw nodes
  for (Node n : nodes) {
    ellipse(n.vector.x, n.vector.y, nodeSize, nodeSize);
  }
  
  //Draw lines
  for (int i = 0; i < nodes.size(); i++) {
    Node node1 = nodes.get(i);
    for (int j = 0; j < node1.neighbours.size(); j++) {
      strokeWeight(node1.weights.get(j));
      stroke(node1.weights.get(j) / weightRange * 150 + 105);
      Node node2 = node1.neighbours.get(j);
      line(node1.vector.x, node1.vector.y, node2.vector.x, node2.vector.y);
    }
  }
    
}
