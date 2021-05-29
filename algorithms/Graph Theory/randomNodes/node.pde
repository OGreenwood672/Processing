import java.util.ArrayList;


public class Node {

  PVector vector;
  
  ArrayList<Node> neighbours;
  ArrayList<Float> weights;

  public Node(PVector v) {

    vector = v;
    neighbours = new ArrayList<Node>();
    weights = new ArrayList<Float>();
    
  }
}
