
import maxlink.*;

PImage img;
color[] colors;

String sortMode = null;

MaxLink link = new MaxLink(this, "cagevariations"); // ** added for MaxLink


void setup(){
  colorMode(HSB, 360, 100, 100, 100);
  noStroke();
  noCursor();
  img = loadImage("cage.jpeg"); 
  size(img.width, img.height);
}


void draw(){
  println("START HERE======================================================");

  int tileCount = 25;
  float rectSize = width / float(tileCount);

  // get colors from image
  int i = 0; 
  colors = new color[tileCount*tileCount];
  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {
      int px = (int) (gridX * rectSize);
      int py = (int) (gridY * rectSize);
      colors[i] = img.get(px, py);
      println(gridX + ", " + gridY + ", " + hue(colors[i]) + ", " + saturation(colors[i]) + ", " + brightness(colors[i]));
      i++;
    }
  }

  // sort colors
  

  // draw grid
  i = 0;
  for (int gridY=0; gridY<tileCount; gridY++) {
    for (int gridX=0; gridX<tileCount; gridX++) {
      fill(colors[i]);
      rect(gridX*rectSize, gridY*rectSize, rectSize, rectSize);
      i++;
    }
  }

}


// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}












