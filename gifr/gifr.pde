import gifAnimation.*;

PImage[] images;
String[] imageNames;
int imageCount;
int index = 0;

GifMaker gifExport;

void setup() {
  gifExport = new GifMaker(this, "out/export-" + timestamp() + ".gif");
  gifExport.setRepeat(0);
  gifExport.setTransparent(0,0,0);	// black is transparent

  // ------ load images ------
  // replace this location with a folder on your machine or use selectFolder()
  File dir = new File(selectFolder("choose a folder with collage footage ..."));
  //File dir = new File(sketchPath,"../_4_2_1_footage");
  if (dir.isDirectory()) {
    String[] contents = dir.list();
    images = new PImage[contents.length]; 
    imageNames = new String[contents.length]; 
    for (int i = 0 ; i < contents.length; i++) {
      // skip hidden files and folders starting with a dot, load .png files only
      if (contents[i].charAt(0) == '.') continue;
      else if (contents[i].toLowerCase().endsWith(".jpg")) {
        File childFile = new File(dir, contents[i]);        
        images[imageCount] = loadImage(childFile.getPath());
        imageNames[imageCount] = childFile.getName();
        println(imageCount+" "+contents[i]+"  "+childFile.getPath());
        imageCount++;             
      }
    }
  }
  size(images[0].width, images[0].height);
  background(0);
  for(index = 0; index < imageCount; index++) {
    image(images[index],1,1);
    gifExport.addFrame();
  }
  gifExport.finish();
  index = 0;
}

void draw(){
  image(images[index],1,1);
  index++;
  if(index == imageCount){
    index = 0;
  }
}

// timestamp
String timestamp() {
  Calendar now = Calendar.getInstance();
  return String.format("%1$ty%1$tm%1$td_%1$tH%1$tM%1$tS", now);
}
