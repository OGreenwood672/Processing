/*

Applications
Used to determine the shortest paths and minimum spanning trees.
Used by search engine crawlers to build indexes of web pages.
Used to search on social networks.
Used to find available neighbour nodes in peer-to-peer networks such as BitTorrent.

*/

import java.lang.Math;
import java.util.HashMap;

ArrayList<Node> nodes = new ArrayList<Node>();

int numberOfNodes = 20;
int nodeSize = 20;
int radius = 250;

//Binary Weights
float density = 0.2;

//int weightRange = 1; //1 gives binary weights

Node start;
Node end;

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
        //float weight = random(weightRange);
        Node node_i = nodes.get(i);
        Node node_j = nodes.get(j);
        
        node_i.neighbours.add(node_j);
        //node_i.weights.add(weight);
        
        node_j.neighbours.add(node_i);
        //node_j.weights.add(weight);
      }
    }
  }
  
  println("Press <space> to reset");
  
}

void draw() {
  background(0);
  
  strokeWeight(1);
  stroke(255);
  
  //Draw nodes
  for (Node n : nodes) {
    fill(255);
    if (n.start) fill(0, 255, 0);
    if (n.end) fill(255, 0, 0);
    ellipse(n.vector.x, n.vector.y, nodeSize, nodeSize);
  }
  
  //Draw lines
  for (int i = 0; i < nodes.size(); i++) {
    Node node1 = nodes.get(i);
    for (int j = 0; j < node1.neighbours.size(); j++) {
      //strokeWeight(node1.weights.get(j));
      //stroke(node1.weights.get(j) / weightRange * 150 + 105);
      Node node2 = node1.neighbours.get(j);
      line(node1.vector.x, node1.vector.y, node2.vector.x, node2.vector.y);
    }
  }
  
  breadth_first_search();
  
}

void breadth_first_search() {
  //Algorithm
  if (start != null && end != null) {
    ArrayList<Node> queue = new ArrayList<Node>();
    start.searched = true;
    queue.add(start);
    
    while (queue.size() > 0) {
      
      Node current = queue.get(0);
      queue.remove(0);
      
      if (current == end) {
        break;
      }
      
      for (Node n : current.neighbours) {
        if (!n.searched) {
          n.searched = true;
          n.parent = current;
          queue.add(n);
        }
      }
    }
    
    //Find path
    ArrayList<Node> path = new ArrayList<Node>();
    path.add(end);
    Node next = end;
    strokeWeight(10);
    stroke(255, 0, 0);
    while (next.parent != null) {
      line(next.vector.x, next.vector.y, next.parent.vector.x, next.parent.vector.y);
      path.add(next.parent);
      next = next.parent;
    }
        
    //reset
    for (Node n : nodes) {
      n.searched = false;
      n.parent = null;
    }
   
  }
}

void keyPressed() {
  if (key == ' ') {
    if (start != null) {
      start.start = false;
      start = null;
    }
    if (end != null) {
      end.end = false;
      end = null;
    }
  }
}

void mousePressed() {
  for (Node n : nodes) {
    boolean x = n.vector.x - (nodeSize/2) < mouseX && mouseX < n.vector.x + (nodeSize/2);
    boolean y = n.vector.y - (nodeSize/2) < mouseY && mouseY < n.vector.y + (nodeSize/2);
    if (x && y) {
      if (start == null) {
        start = n;
        n.start = true;
      } else if (end == null && !n.start) {
        end = n;
        n.end = true;
      }
    }
  }
}
