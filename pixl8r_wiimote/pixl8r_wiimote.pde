import processing.opengl.*;
import maxlink.*;

PImage img;
color moduleColor = color(0);
int moduleAlpha = 180;
int actRandomSeed = 0;
int max_distance = screen.width; 
int gridStep = 40;
int  spotX = mouseX;
int bgcolor = 0;
int  spotY = mouseY;
boolean holdSpot = false;
boolean invertSize = true;
MaxLink link = new MaxLink(this,"wiimote");
public float wiiPitch;
public float wiiRoll;
int wiiY,wiiX;

void setup(){
  img = loadImage("grass.jpg"); 
  size(img.width, img.height, OPENGL);
  noStroke();
  colorMode(HSB, 360, 100, 100, 100);
  noCursor();
  link.declareInlet("wiiPitch");
  link.declareInlet("wiiRoll");
}

void draw() {
  background(bgcolor);
  smooth();
  
  wiiX = int(wiiRoll * width);
  wiiY = int(wiiPitch * height);
  println(wiiX + " x " + wiiY);

  randomSeed(actRandomSeed);

  if(holdSpot == false) {
    spotX = wiiX;
    spotY = wiiY;
    noCursor();
  }

  for (int gridY=0; gridY<img.height; gridY+=gridStep) {
    for (int gridX=0; gridX<img.width; gridX+=gridStep) {
      fill(img.get(gridX, gridY));
      
      float diameter = dist(spotX, spotY, gridX, gridY);
      if(invertSize == true){
        diameter = max_distance - dist(spotX, spotY, gridX, gridY);
      }
      diameter = diameter/max_distance * 40;
      
      pushMatrix();
      translate(gridX, gridY, diameter*5);
      rect(0, 0, diameter, diameter);    //// also nice: ellipse(...)
      popMatrix(); 
    }
  }
}

void mousePressed() {
  actRandomSeed = (int) random(100000);
  if(holdSpot) {
    cursor();
    spotX = wiiX;
    spotY = wiiY;
  }
}

void keyReleased(){
  if (key=='s' || key=='S') saveFrame("out/"+timestamp()+"_##.png");

  if (key == '1') img = loadImage("fb.jpg");
  if (key == '2') img = loadImage("galaxy.jpg"); 
  if (key == '3') img = loadImage("grass.jpg"); 
  if (key == '3') img = loadImage("lion.jpg"); 
  if (key == '4') img = loadImage("mtfuji.jpg"); 
  
  if (key == '5') gridStep =  10;
  if (key == '6') gridStep =  30;
  if (key == '7') gridStep =  50;
  if (key == '8') gridStep =  70;
  if (key == '9') gridStep =  90;
  
  if (key == '0') {
    if (holdSpot == false) { holdSpot = true; }
    else { holdSpot = false;}
  }
  
  if (key == '[') {
    if (invertSize == false) { invertSize = true; }
    else { invertSize = false;}
  }
  
  if (key == ']') {
    if (bgcolor==255){bgcolor = 0;}
    else { bgcolor = 255; }
  }
}


// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}



