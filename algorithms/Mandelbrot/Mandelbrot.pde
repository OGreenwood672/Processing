
void setup() {
  size(600, 600);
  colorMode(RGB, 1);
}

void draw() {
   background(0);
   
   float w = 5;
   float h = (w * height) / width;
   
   float xmin = -w/2;
   float ymin = -h/2;
   
   loadPixels();
   
   int maxiters = 100;
   
   float xmax = xmin + w;
   float ymax = ymin + h;
   
   float dx = (xmax - xmin) / (width);
   float dy = (ymax - ymin) / (height);
   
   float y = ymin;
   for (int j = 0; j < height; j++) {
     
     float x = xmin;
     for (int i = 0; i < width; i++) {
     
       float a = x;
       float b = y;
       int n = 0;
       while (n < maxiters) {
         float aa = a * a;
         float bb = b * b;
         float ab2 = 2 * a * b;
         a = aa - bb + x;
         b = ab2 + y;
         
         if (a*a + b*b > 16.0) {
           break;
         }
         n++;
       }
       
       if (n == maxiters) {
         pixels[i+j*width] = color(0);
       } else {
         pixels[i+j*width] = color(sqrt(float(n) / maxiters));
       }
       x += dx;
     }
     y += dy;
   }
   updatePixels();
  
}
