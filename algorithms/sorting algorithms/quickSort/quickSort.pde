
float[] values;
int delayValue = 10;

void setup() {
  size(600, 600);
  values = new float[width];
  for (int i = 0; i < values.length; i++) {
    values[i] = random(height);
  }
  thread("quicksort_constructor");
}

void draw() {
  
  background(0);
  
  for (int i = 0; i < values.length; i++) {
    stroke(255);
    line(i, height, i, height - values[i]);
  }

}

void quicksort_constructor() {
  delay(1000);
  quicksort(values, 0, values.length-1);
}

void quicksort(float[] arr, int start, int end) {
  if (start >= end) {
    return;
  }
  
  int pivotIndex = partition(arr, start, end);
  delay(delayValue);
  quicksort(arr, start, pivotIndex-1);
  quicksort(arr, pivotIndex+1, end);
}

float[] swap(float[] arr, int index1, int index2) {
  float t = arr[index1];
  arr[index1] = arr[index2];
  arr[index2] = t;
  return arr;
}

int partition(float[] arr, int start, int end) {
  int pivotIndex = start;
  float pivotValue = arr[end];
  for (int i = start; i < end; i++) {
    if (arr[i] < pivotValue) {
      arr = swap(arr, i, pivotIndex);
      pivotIndex++;
    }
  }
  arr = swap(arr, pivotIndex, end);
  return pivotIndex;
}
