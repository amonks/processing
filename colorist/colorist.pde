//needs generative design for color sort
import generativedesign.*;



//varz
PImage from;
float where = 0;
float colorStep;
boolean ellipticalPixel = false;
boolean hueonly = false;
  int depth = 4;
  int periods = 5;
  PImage[][] imgs;
  color[][] colors;
  
int segmentCount = 360;
int radius = 450;

color[] period;
int transp = 255;
int c = 0;
int x, y, p, cy, cx, i;
String sortMode = GenerativeDesign.HUE;

void setup(){
  size(1000,1000);
  colorMode(HSB, 2); //RGB also works
  colors = new color[periods][100*depth];
  noStroke();
  frameRate(1);
  
  //load images
  imgs = new PImage[periods][depth];
  for(x = 0; x < periods; x++){
    c = 0;
    for(y = 0; y < depth; y++){
      imgs[x][y] = loadImage( x + "-" + y + ".jpg");
      // load colors
      for(cx=0; cx < 10; cx++){
        for(cy=0; cy < 10; cy++){
          println(c + " " + x + " " + y + " " + cx + " " + cy);
          colors[x][c] = imgs[x][y].get(cx * (imgs[x][y].width / 10), cy * (imgs[x][y].height / 10) );
          println(hue(colors[x][c]) + " " + saturation(colors[x][c]) + " " + brightness(colors[x][c]));
          c++;
        }
      }
      
    }
  }

  
}
void draw() {
  
  background(0);
  
  float angleStep = 360/segmentCount;
  
  beginShape(TRIANGLE_FAN);
  vertex(width/2, height/2);
  
  
    period = new color[depth*100];
    for( c = 0; c < depth * 100; c++ ){
      period[c] = colors[p][c];
    }
    if (sortMode != null) period = GenerativeDesign.sortColors(this, period, GenerativeDesign.HUE);
    for(c = 0; c <= 360; c+=angleStep){
      if(hueonly == true) {fill(hue(period[c]),saturation(period[c]),255);} else {fill(period[c]);}
      float vx = width/2 + cos(radians(c))*radius;
      float vy = height/2 + sin(radians(c))*radius;
      vertex(vx, vy);
    }
  
}

void keyReleased(){
  if (key=='0') p = 0;
  if (key=='1') p = 1;
  if (key=='2') p = 2;
  if (key=='3') p = 3;
  if (key=='4') p = 4;
  if (key=='5') p = 5;
  if (key=='6') p = 6;
  if (key=='7') p = 7;
  if (key=='8') p = 8;
  if (key=='9') p = 9;


  
  
  if (key=='s' || key=='S') saveFrame("out/"+timestamp()+"_##.png");
  if (key=='r' || key=='R') {colorMode(RGB); println("RGB");}
  if (key=='h' || key=='H') {colorMode(HSB); println("HSB");}
  if (key=='F' || key=='f') {hueonly = false;}
  if (key=='T' || key=='t') {hueonly = true;}
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}


