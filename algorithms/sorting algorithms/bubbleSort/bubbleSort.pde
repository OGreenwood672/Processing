float[] values;

int i = 1;
int j = 0;
int maximum;

int speed = 175;

void setup() {
  size(800, 700);
  values = new float[width];
  maximum = values.length;
  for (int i = 0; i < values.length; i++) {
    values[i] = noise(i/100.0)*height;//random(height);
  }
}

void draw() {
  background(0);
  stroke(255);
  for (int i = 0; i < values.length; i++) {
    line(i, height, i,  height - values[i]);
  }
  
  //Bubble Sort
  for (int n = 0; n < speed; n++) {
    if (maximum == 1) {
      println("Finished");
      noLoop();
    }
    if (i >= maximum) {
      i = 1;
      j = 0;
      maximum--;
    }
    if (values[i] < values[j]) {
      float a = values[i];
      values[i] = values[j];
      values[j] = a;
    }
    i++;
    j++;
  }
}
