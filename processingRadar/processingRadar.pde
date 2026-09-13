import processing.serial.*;

Serial myPort;
int angle = 0;
int distance = 0;
String data = "";

void setup() {
  size(1000, 600); // Window size
  background(0);   // Background size

  // Displays the list of available ports in the console
  printArray(Serial.list());

  // Port I'am using
  myPort = new Serial(this, "/dev/ttyACM0", 9600);

  // Receive data until '.'
  myPort.bufferUntil('.');
}

void draw() {
  // Adding fade effect
  fill(0, 15);
  rect(0, 0, width, height);

  // Drawing green radar net
  drawRadar();
  
  // Drawing green lines (current position of the sensor) 
  drawLine();
  // Drawing red dots (how far is the object)
  drawObject();
  
  // Draw text
  drawTextInfo();
}

// Function is automatically called after getting the data
void serialEvent(Serial myPort) 
{
  data = myPort.readStringUntil('.');
  if (data != null) {
    data = trim(data.replace(".", "")); // Remove white chars
    
    // Separate the text after comma (angle, distance)
    String[] list = split(data, ',');
    if (list.length == 2) {
      angle = int(trim(list[0]));
      distance = int(trim(list[1]));
    }
  }
}

void drawRadar() 
{
  pushMatrix();
  translate(width/2, height - 60); // Moving the axis 
  noFill();
  strokeWeight(2);
  stroke(0, 255, 0); // Setting green color

  // 1. Drawing distance arcs
  arc(0, 0, 200, 200, PI, TWO_PI); // 10 cm
  arc(0, 0, 400, 400, PI, TWO_PI); // 20 cm
  arc(0, 0, 600, 600, PI, TWO_PI); // 30 cm
  arc(0, 0, 800, 800, PI, TWO_PI); // 40 cm

  // 2. Drawing lines every 30 degrees
  line(0, 0, -400, 0); // 180
  line(0, 0, -400 * cos(radians(30)), -400 * sin(radians(30))); // 150
  line(0, 0, -400 * cos(radians(60)), -400 * sin(radians(60))); // 120
  line(0, 0, 0, -400); // 90
  line(0, 0, 400 * cos(radians(60)), -400 * sin(radians(60)));  // 60
  line(0, 0, 400 * cos(radians(30)), -400 * sin(radians(30)));  // 30
  line(0, 0, 400, 0); // 0

  // 3. Distance labels 
  fill(0, 255, 0);
  textSize(14);
  textAlign(LEFT, CENTER);
  text("10 cm", 105, -10);
  text("20 cm", 205, -10);
  text("30 cm", 305, -10);
  text("40 cm", 405, -20);

  // 4. Descriptions of angles at the edges of the angle lines
  textAlign(CENTER, CENTER);
  text("0°", 425, 0);
  text("30°", 425 * cos(radians(30)), -425 * sin(radians(30)));
  text("60°", 425 * cos(radians(60)), -425 * sin(radians(60)));
  text("90°", 0, -420);
  text("120°", -425 * cos(radians(60)), -425 * sin(radians(60)));
  text("150°", -425 * cos(radians(30)), -425 * sin(radians(30)));
  text("180°", -425, 0);

  popMatrix();
}

void drawLine() 
{
  pushMatrix();
  translate(width/2, height - 60);
  strokeWeight(3);
  stroke(0, 255, 0);
  
  // Converting an angle to Cartesian coordinates
  float x = 400 * cos(radians(angle));
  float y = -400 * sin(radians(angle));
  line(0, 0, x, y);
  popMatrix();
}

void drawObject() 
{
  pushMatrix();
  translate(width/2, height - 60);
  strokeWeight(7);
  stroke(255, 0, 0); // Red color

  float pixDistance = distance * 10; // 1 cm = 10 px

  if (distance < 40 && distance > 0) 
  { // Draw object if its closer than 40 cm
    float x = pixDistance * cos(radians(angle));
    float y = -pixDistance * sin(radians(angle));
    point(x, y);
  }
  popMatrix();
}

void drawTextInfo() 
{    
  // Black bar masking overlapping text
  fill(0);
  noStroke();
  rect(0, height - 35, width, 35);

  // Just more useful labels
  fill(0, 255, 0);
  textSize(18);
  textAlign(LEFT, CENTER);
  
  text("Angle: " + angle + "°", 50, height - 20);
  
  if (distance < 40 && distance > 0) 
  {
    text("Distance: " + distance + " cm", 300, height - 20);
  } 
  else 
  {
    text("Distance: out of range (>40cm)", 300, height - 20);
  }
}
