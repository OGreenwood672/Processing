
float[] values;

void setup() {
  size(600, 600);
  values = new float[width];
  for (int i = 0; i < values.length; i++) {
    values[i] = noise(i/100.0)*height;//random(height);
  }
  
  thread("mergesort");
  
}

void draw() {
  background(0);
  
  for (int i = 0; i < values.length; i++) {
    stroke(255);
    line(i, height, i, height - values[i]);
  }
}

void mergesort() {
  delay(1000);
  values = TopDownSplitMerge(values);
}

float[] TopDownSplitMerge(float[] arr) {

  if (arr.length <= 1) {
    return arr;
  }
  
  float[] left = new float[arr.length/2];
  float[] right = new float[arr.length-arr.length/2];
  for (int i = 0; i < arr.length; i++) {
    if (i < arr.length/2) {
      left[i] = arr[i];
    } else {
      right[i-arr.length/2] = arr[i];
    }
  }
  delay(arr.length * 2);
  values = arr;
  left = TopDownSplitMerge(left);
  right = TopDownSplitMerge(right);


  return merge(left, right);
}

float[] merge(float[] left, float[] right) {
  
  float[] result = new float[left.length + right.length];
  int resIndex = 0;
  
  ArrayList<Float> left_list = new ArrayList<Float>();
  for (Float f : left) {
    left_list.add(f);
  }
  
  ArrayList<Float> right_list = new ArrayList<Float>();
  for (Float f : right) {
    right_list.add(f);
  }

  while (left_list.size() > 0 && right_list.size() > 0) {
    if (left_list.get(0) <= right_list.get(0)) {
      result[resIndex] = left_list.get(0);
      left_list.remove(0);
    } else {
      result[resIndex] = right_list.get(0);
      right_list.remove(0);
    }
    resIndex++;
  }
  while (left_list.size() > 0) {
    result[resIndex] = left_list.get(0);
    left_list.remove(0);
    resIndex++;
  }
  while (right_list.size() > 0) {
    result[resIndex] = right_list.get(0);
    right_list.remove(0);
    resIndex++;
  }
  return result;
}
