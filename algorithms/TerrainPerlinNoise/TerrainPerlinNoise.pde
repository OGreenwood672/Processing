int COLS, ROWS;
int WIDTH, HEIGHT;
int SCALE = 20;
float flying;

float[][] terrain;

void setup() {
  
  size(600, 600, P3D);
  
  int WIDTH = 2000;
  int HEIGHT = 2000;
  COLS = WIDTH / SCALE;
  ROWS = HEIGHT / SCALE;
  terrain = new float[COLS][ROWS];

}

void draw() {
  background(0);
  stroke(255);
  noFill();
  
  float yOff = flying;
  for (int y = 0; y < COLS; y++) {
    float xOff = 0;
    for (int x = 0; x < ROWS; x++) {
      terrain[x][y] = map(noise(xOff, yOff), 0, 1, -75, 75);
      xOff += 0.3;
    }
    yOff += 0.3;
  }
  flying -= 0.1;
  
  translate(width/2, height/2);
  rotateX(PI/3);
  
  translate(-width/2 - 100, -height/2 - 400);
  for (int y = 0; y < ROWS - 1; y++) {
    beginShape(TRIANGLE_STRIP);
    for (int x = 0; x < COLS; x++) {
      vertex(x*SCALE, y*SCALE, terrain[x][y]);
      vertex(x*SCALE, (y+1)*SCALE, terrain[x][y + 1]);
    }
    endShape();
  }
}
