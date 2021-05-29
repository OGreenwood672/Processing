import java.time.LocalDateTime;

float sizeChange = 120;

float secondSize = 900;
float minuteSize = secondSize - sizeChange;
float hourSize = minuteSize - sizeChange;

float highlightSize = 25;

PFont f;

void setup() {
  size(1000, 1000);

  f = createFont("Arial", 16, true);
  textFont(f, 16);
}

void draw() {
  background(0);
  translate(width/2, height/2);

  noFill();
  strokeWeight(highlightSize);

  LocalDateTime datetime = LocalDateTime.now();

  int seconds = datetime.getSecond();
  int minutes = datetime.getMinute();
  int hours = datetime.getHour();

  //Rings
  //stroke(255);
  float hourAngle = mapValue(hours % 12, 0, 12, -HALF_PI, 2*PI - HALF_PI);
  //arc(0, 0, hourSize, hourSize, -HALF_PI, hourAngle);
  
  for (int i = 0; i < 12; i++) {
    if (hours % 12 >= i) {
      stroke(255);
    } else {
      stroke(105);
    }
    pushMatrix();
    rotate(i * 30 * (PI / 180) );
    line(0, highlightSize-hourSize/2, 0, - hourSize/2);
    popMatrix();
  }
  

  //stroke(34, 181, 74);
  float minuteAngle = mapValue(minutes, 0, 60, -HALF_PI, 2*PI - HALF_PI);
  //arc(0, 0, minuteSize, minuteSize, -HALF_PI, minuteAngle);
  for (int i = 0; i < 60; i++) {
    if (minutes >= i) {
      stroke(34, 181, 74);
    } else {
      stroke(34, 100, 40);
    }
    pushMatrix();
    rotate(i * 6 * (PI / 180) );
    line(0, highlightSize-minuteSize/2, 0, - minuteSize/2);
    popMatrix();
  }

  //stroke(207, 37, 37);
  float secondAngle = mapValue(seconds, 0, 60, -HALF_PI, 2*PI - HALF_PI);
  //arc(0, 0, secondSize, secondSize, -HALF_PI, secondAngle);
  for (int i = 0; i < 60; i++) {
    if (seconds >= i) {
      stroke(207, 37, 37);
    } else {
      stroke(150, 37, 37);
    }
    pushMatrix();
    rotate(i * 6 * (PI / 180) );
    line(0, highlightSize-secondSize/2, 0, - secondSize/2);
    popMatrix();
  } 

  //Hands
  strokeWeight(highlightSize/2);

  //Second Hand
  pushMatrix();
  stroke(207, 37, 37);
  rotate(secondAngle + HALF_PI);
  line(0, 0, 0, - 250);
  popMatrix();

  //Minute Hand
  pushMatrix();
  stroke(34, 181, 74);
  rotate(minuteAngle + HALF_PI);
  line(0, 0, 0, - 200);
  popMatrix();

  //Hour hand
  pushMatrix();
  stroke(255);
  rotate(hourAngle + HALF_PI);
  line(0, 0, 0, - 150);
  popMatrix();
  
  stroke(255);
  line(0, 0, 0, 0);

  //Digital Clock
  fill(255);
  text(hours + ":" + minutes + ":" + seconds, -width/2+5, -height/2+20);
}

float mapValue(float inp, float minInp, float maxInp, float minOut, float maxOut) {
  if (inp == 0) {
    return maxOut;
  }
  return ((inp - minInp) / (maxInp - minInp)) * (maxOut - minOut) + minOut;
}
