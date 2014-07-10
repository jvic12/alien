PImage planet;
PImage ship;
ArrayList Balls;
short mass;
byte h;
PFont font;
int count = 0; 
int shipx = int(random(640));
int shipy = int(random(270, 500));
int capsule = 10;

 
void setup(){
  size(640, 640);
  frameRate(60);
  planet = loadImage("earth2.jpg");
  ship = loadImage("ship1.jpg");
  Balls = new ArrayList();
  mass = 400;
  h = 61;
  font = createFont("Onyx", 12);
}
 
//x^2+y^2=z^2(distance)
float distance(PVector pos, PVector pos2){
  return sqrt(((pos.x-pos2.x)*(pos.x-pos2.x))+((pos.y-pos2.y)*(pos.y-pos2.y)));
}
 
//???
PVector grav(PVector pos){
  PVector direction = new PVector(width/2 - pos.x, height/2 - pos.y);
  direction.normalize();
  float d = distance(pos, new PVector(width/2, height/2));
  direction.mult(mass/(d*d));
  return direction;
} //could add an extra function
   
 
class Ball{
  PVector position;
  PVector velocity;
  Ball(float px, float py, float vx, float vy){
    position = new PVector(px, py);
    velocity = new PVector(vx/100, vy/100);
  }
  void drawball(){
    PVector gravity = grav(position);
    PVector velgrav = velocity;
    velgrav.add(gravity); //could be removed
    position.add(velgrav);
    ellipse(position.x, position.y, 10, 10);
  }
}
 
void draw(){
 
  background(0);
   
  fill(255);
  text("[Based on Kelson Ball's Orbit Simulation]", 10,40);
  text("Game developed by Jerry, Jonathan, and Joyce", 10,60);
//  text("w - initial height up", 10, 10);
//  text("s - initial hieght down", 10, 20);
  //text("c - reset", 10, 60);
  
  float ds = distance(new PVector(mouseX, mouseY), new PVector(width/2, height/2 - 60));
  
//  fill(0,150,0);
//  ellipse(320,320,118,118);
  imageMode(CENTER);
  image(planet,width/2,height/2);
  image(ship,shipx,shipy);
  if (254 < shipx && shipx < 384 && 243 < shipy && shipy < 385) {
    shipx = int(random(640));
    
    shipy = int(random(270, 500));

  }
  stroke(200, 200*(ds/250), 50);
  strokeWeight(4);
  line(width/2, height/2 - h, mouseX, mouseY);
  fill(int(random(255)),int(random(255)),int(random(255)));
  noStroke();
  for (int i = Balls.size()-1; i >= 0; i--){
    Ball a = (Ball) Balls.get(i);
    a.drawball();
    if (abs(a.position.x-shipx) < 10 && abs(a.position.y-shipy) < 10) {
      //shipx = int(random(640));
      Balls.remove(i);
      fill(0,255,0);
      text("SUCCESS!",280,250);
      noLoop();
      
         //shipy = int(random(270, 450));
         
      
    }
    float dis = distance(a.position, new PVector(width/2, height/2));
    if ( dis < 60 || dis > 700){
      Balls.remove(i);
      count--;
    }
  }
  if (capsule <= 0) {
    fill(255,0,0);
    text("Ran out of space capsules!!!", 200,200);
//    text("You are stuck on the earth.",200,230);
//    text("[DESTROY THE EARTH!!!]",200,260);
  }
   
   fill(255,0,0);
    textSize(20);
    text("remaining capsules:",width-250,100);
    text(capsule,width-50,100);
    println(count);
    if (count <= 0 && capsule == 0) {
      text("You are stuck on the earth.",200,230);
      text("[DESTROY THE EARTH!!!]",200,260);
    }
    
}
 
void mousePressed(){
  if(capsule>0) capsule--; 
   if (count < 10 && capsule > 0) {
      Balls.add(new Ball(width/2, height/2 - h, mouseX - width/2, mouseY - (height/2 - h)));
      count++;
    }
  if (count <= 0 && capsule == 0 && mouseX > 200 && mouseX < 400 && mouseY > 255 && mouseY < 265) {
    link("http://lsk567.github.io/alien-story");
  }
}
 
/*void keyPressed(){
//  if (key == 'w' && h < 121){
//    h++;
//  }else if (key == 's' && h > 61){
//    h--;
   if ((key == 'c')){
    for (int i = Balls.size()-1; i >= 0; i--){
      Balls.remove(i);
    }
    for (int x = Balls.size(); x <= 0; x++){
      capsule = 10;
      count = 0;  
    }
   
  }
}*/

