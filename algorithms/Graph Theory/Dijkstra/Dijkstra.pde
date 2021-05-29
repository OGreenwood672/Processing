import java.util.ArrayList;
import java.lang.Math;
import java.util.Collections;
import java.util.Comparator;

ArrayList<Node> nodes = new ArrayList<Node>();

int numberOfNodes = 10;
int nodeSize = 20;
int radius = 250;

float density = 0.5;

int weightRange = 10; //1 gives binary weights

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
    fill(255);
    if (n.start) fill(0, 255, 0);
    if (n.end) fill(255, 0, 0);
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

  dijkstra();
}

void dijkstra() {
  if (start == null || end == null) {
    return;
  }

  ArrayList<Node> unvisited = new ArrayList<Node>();

  for (Node n : nodes) {
    n.tentative_dist = Integer.MAX_VALUE;
    unvisited.add(n);
  }
  start.tentative_dist = 0;

  while (unvisited.size() > 0) {

    Node min_dist_node = getMinDistNode(unvisited);
    unvisited.remove(unvisited.indexOf(min_dist_node));

    for (int i =0; i < min_dist_node.neighbours.size(); i++) {

      float alt = min_dist_node.tentative_dist + min_dist_node.weights.get(i);

      if (alt < min_dist_node.neighbours.get(i).tentative_dist) {
        min_dist_node.neighbours.get(i).tentative_dist = alt;
        min_dist_node.neighbours.get(i).parent = min_dist_node;
      }
    }
  }

  //Find path
  ArrayList<Node> path = new ArrayList<Node>();
  path.add(end);
  Node next = end;
  strokeWeight(10);
  while (next.parent != null) {
    float weight = next.weights.get(next.neighbours.indexOf(next.parent));
    stroke(weight / weightRange * 150 + 105, 0, 0);
    strokeWeight(weight+3);
    line(next.vector.x, next.vector.y, next.parent.vector.x, next.parent.vector.y);
    path.add(next.parent);
    next = next.parent;
  }

  for (Node n : nodes) {
    n.parent = null;
    n.searched = false;
  }
}

Node getMinDistNode(ArrayList<Node> unvisited) {
  float minVal = Integer.MAX_VALUE;
  Node minNode = null;
  for (int i = 0; i < unvisited.size(); i++) {
    if (unvisited.get(i).tentative_dist < minVal) {
      minVal = unvisited.get(i).tentative_dist;
      minNode = unvisited.get(i);
    }
  }
  return minNode;
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
