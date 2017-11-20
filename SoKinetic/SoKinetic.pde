import org.openkinect.freenect.*;
import org.openkinect.processing.*;
import processing.sound.*;

KinectTracker tracker;
Kinect kinect;
int mechonX = 400;
int mechonY = 400;
PImage Monado;
PImage Mechon;
float rot = 0;
float randX = 0;
float randY = 0;
SoundFile file;

void setup()
{
  size(600,600);
  kinect = new Kinect(this);
  tracker = new KinectTracker();
  Monado = loadImage("Monadopng.png");
  Mechon = loadImage("mechon.png");
  file = new SoundFile(this,"Climax Reasoning V3.mp3");
  file.play();
  file.amp(0.5);
  
}

void draw() 
{
  background(255);
  tracker.track();
  tracker.display();
  PVector v1 = tracker.getPos();
  fill(100, 0, 50, 200);
  noStroke();
  ellipse(v1.x, v1.y, 20, 20);
  PVector v2 = tracker.getLerpedPos();
  pushMatrix();
  translate(v2.x,v2.y);
  rotate(rot);
  imageMode(CENTER);
  image(Monado,0,0,22,100);
  popMatrix();
  rot-=PI/6;
  imageMode(CORNER);
  imageMode(CENTER);
  image(Mechon, randX, randY, 100, 110);
  imageMode(CORNER);
  if (mechonY < -100)
  {
    mechonY = 800;
  }
  if(dist(v2.x,v2.y,randX,randY)<100)
  {
    randX = random(width);
    randY = random(400);
  }
  int t = tracker.getThreshold();
  fill(0);
  text("threshold: " + t + "    " +  "framerate: " + int(frameRate) + "    " + 
    "UP increase threshold, DOWN decrease threshold", 10, 500);
}
void keyPressed() 
{
  int t = tracker.getThreshold();
  if (key == CODED) 
  {
    if (keyCode == UP) 
    {
      t+=5;
      tracker.setThreshold(t);
    } 
    else if (keyCode == DOWN) 
    {
      t-=5;
      tracker.setThreshold(t);
    }
  }
}