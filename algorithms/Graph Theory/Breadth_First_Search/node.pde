import java.util.ArrayList;


public class Node {

  PVector vector;

  Node parent;
  boolean searched;
  
  ArrayList<Node> neighbours; //  = new ArrayList<Node>();
  ArrayList<Float> weights;

  boolean start;
  boolean end;

  public Node(PVector v) {

    vector = v;
    neighbours = new ArrayList<Node>();
    weights = new ArrayList<Float>();
    
  }
}
