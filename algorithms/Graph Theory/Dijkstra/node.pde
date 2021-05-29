import java.util.ArrayList;


public class Node {

  PVector vector;

  Node parent;
  boolean searched = false;
  
  ArrayList<Node> neighbours = new ArrayList<Node>();
  ArrayList<Float> weights = new ArrayList<Float>();;

  boolean start;
  boolean end;
  
  float tentative_dist;
  
  public Node(PVector v) {

    vector = v;
    
  }
}
