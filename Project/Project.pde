import shiffman.box2d.*;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.joints.*;
import org.jbox2d.collision.shapes.*;
import org.jbox2d.collision.shapes.Shape;
import org.jbox2d.common.*;
import org.jbox2d.dynamics.*;
import org.jbox2d.dynamics.contacts.*;
import controlP5.*;

Box2DProcessing box2d;

ControlP5 cp5;
ControlTimer timer;
Textlabel label;
CheckBox checkbox;

float av,density,radius,left,right;

int keys[],tot[],thick=50;
int startleft=1050,startup=50,bet=20,inter=50;
int[] h,he,n,o,w,a;

Particle p1,p2;

Piston piston;

ArrayList<Boundary> wall;
ArrayList<Particle> particle;
ArrayList<Hydrogen>[] hydrogen;
ArrayList<Helium>[] helium;
ArrayList<Nitrogen>[] nitrogen;
ArrayList<Oxygen>[] oxygen;
ArrayList<Water>[] water;
ArrayList<Ammonia>[] ammonia;

void setup(){
  size(1400,600);
  
  width=1000;
  
  keys = new int[3];
  keys[0]=keys[1]=0;
  
  tot = new int[2];
  h = new int[2];
  he = new int[2];
  n = new int[2];
  o = new int[2];
  w = new int[2];
  a = new int[2];
  
  radius = 15;
  
  box2d = new Box2DProcessing(this);
  box2d.createWorld();
  box2d.listenForCollisions();
  
  particle = new ArrayList<Particle>();
  //for(int i=0;i<20;i++) particle.add(new Particle(random(width),random(height),30));
  
  hydrogen = new ArrayList[2];
  hydrogen[0] = new ArrayList<Hydrogen>();
  hydrogen[1] = new ArrayList<Hydrogen>();
  //for(int i=0;i<20;i++) hydrogen.add(new Hydrogen(random(width),random(height),15));
  
  helium = new ArrayList[2];
  helium[0] = new ArrayList<Helium>();
  helium[1] = new ArrayList<Helium>();
  //for(int i=0;i<20;i++) helium.add(new Helium(random(width),random(height),20));
  
  nitrogen = new ArrayList[2];
  nitrogen[0] = new ArrayList<Nitrogen>();
  nitrogen[1] = new ArrayList<Nitrogen>();
  //for(int i=0;i<20;i++) nitrogen.add(new Nitrogen(random(width),random(height),25));
  
  oxygen = new ArrayList[2];
  oxygen[0] = new ArrayList<Oxygen>();
  oxygen[1] = new ArrayList<Oxygen>();
  //for(int i=0;i<20;i++) oxygen.add(new Oxygen(random(width),random(height),30));
  
  water = new ArrayList[2];
  water[0] = new ArrayList<Water>();
  water[1] = new ArrayList<Water>();
  
  ammonia = new ArrayList[2];
  ammonia[0] = new ArrayList<Ammonia>();
  ammonia[1] = new ArrayList<Ammonia>();
  
  wall = new ArrayList<Boundary>();
  wall.add(new Boundary(width/2, height-5, width, 10));
  wall.add(new Boundary(width/2, 5, width, 10));
  wall.add(new Boundary(5,height/2,10,height));
  wall.add(new Boundary(width-5,height/2,10,height));
  
  piston = new Piston(width/2,height/2,thick,height-20);
  
  cp5 = new ControlP5(this);
  
  cp5.addNumberbox("left")
   .setPosition(1050,400)
   .setSize(100,20)
   .setRange(1,10000)
   .setMultiplier(10)
   .setValue(273)
   ;
  

  cp5.addNumberbox("right")
   .setPosition(1200,400)
   .setSize(100,20)
   .setRange(1,10000)
   .setMultiplier(10) 
   .setValue(273)
   ;
   
  timer = new ControlTimer();
  label = new Textlabel(cp5,"--",100,100);
  timer.setSpeedOfTime(1);
  
  checkbox = cp5.addCheckBox("checkBox")
                .setPosition(1050, 460)
                .setSize(40, 40)
                .setItemsPerRow(2)
                .setSpacingColumn(100)
                .setSpacingRow(20)
                .addItem("Left Water", 0)
                .addItem("Right Water", 0)
                .addItem("Left Ammonia", 0)
                .addItem("Right Ammonia", 0)
                //.addItem("Piston Insulated?",0)
                ;
  /*for(int i=0;i<40;i++) {
    Vec2 pos = box2d.getBodyPixelCoord(piston.body);
    hydrogen[0].add(new Hydrogen(random(radius,pos.x-thick-radius),random(radius,height-radius),radius,left));
    nitrogen[0].add(new Nitrogen(random(radius,pos.x-thick-radius),random(radius,height-radius),radius,left));
    helium[1].add(new Helium(random(pos.x+thick+radius,width-radius),random(radius,height-radius),radius,right));
    oxygen[1].add(new Oxygen(random(pos.x+thick+radius,width-radius),random(radius,height-radius),radius,right));
  }*/
}

void draw(){
  //saveFrame("frames/####.tif");
  background(255);
  
  box2d.step();

  process();
  
  piston.display();
 
  description();
  
  sum();
  
  ManageCombine();
  
}

void process() {
  for(int j = 0; j < 2; j++) {
    for (int i = hydrogen[j].size()-1; i >= 0; i--) {
      Hydrogen h = hydrogen[j].get(i);
      if(j==0) h.changetemp(left);
      if(j==1) h.changetemp(right);
      h.display();
    }
  }
  
  for(int j = 0; j < 2; j++) {
    for (int i = helium[j].size()-1; i >= 0; i--) {
      Helium he = helium[j].get(i);
      if(j==0) he.changetemp(left);
      if(j==1) he.changetemp(right);
      he.display();
    }
  }
  
  for(int j = 0; j < 2; j++) {
    for (int i = nitrogen[j].size()-1; i >= 0; i--) {
      Nitrogen n = nitrogen[j].get(i);
      if(j==0) n.changetemp(left);
      if(j==1) n.changetemp(right);
      n.display();
    }
  }
  
  for(int j = 0; j < 2; j++) {
    for (int i = oxygen[j].size()-1; i >= 0; i--) {
      Oxygen o = oxygen[j].get(i);
      if(j==0) o.changetemp(left);
      if(j==1) o.changetemp(right);
      o.display();
    }
  }
  
  for(int j = 0; j < 2; j++) {
    for (int i = water[j].size()-1; i >= 0; i--) {
      Water h2o = water[j].get(i);
      if(j==0) h2o.changetemp(left);
      if(j==1) h2o.changetemp(right);
      h2o.display();
    }
  }
  
  for(int j = 0; j < 2; j++) {
    for (int i = ammonia[j].size()-1; i >= 0; i--) {
      Ammonia nh3 = ammonia[j].get(i);
      if(j==0) nh3.changetemp(left);
      if(j==1) nh3.changetemp(right);
      nh3.display();
    }
  }
  
  for(int i=0;i<4;i++){
    Boundary b = wall.get(i);
    b.display();
  }
  
}

void description() {
  
  fill(0);
  rectMode(CENTER);
  rect(1210,400,400,800);
  textAlign(LEFT,CENTER);
  Vec2 pos = box2d.getBodyPixelCoord(piston.body);
  av=av/frameCount;
  av=av*(frameCount-1);
  av=av+(pos.x-thick/2-10)/frameCount;
  float tmp1 = tot[0]*left;
  float tmp2 = tot[1]*right;
  float r1 = (width-thick-20)*tmp1/(tmp1+tmp2);
  float r2 = (width-thick-20)*tmp2/(tmp1+tmp2);
  fill(255);
  int tmp=startup;
  text("Current",startleft,startup);
  text("Left : "+(pos.x-thick/2-10),startleft,startup+bet);
  text("Right : "+(width-pos.x-thick/2-10),startleft,startup+bet*2);
  startup=startup+bet*2+inter;
  
  text("Average",startleft,startup);
  text("Left : "+av,startleft,startup+bet);
  text("Right : "+(width-av-thick-20),startleft,startup+bet*2);
  startup=startup+bet*2+inter;
  
  text("How many?",startleft,startup);
  text("Left : "+tot[0],startleft,startup+bet);
  text("Right : "+tot[1],startleft,startup+bet*2);
  startup=startup+bet*2+inter;
  
  text("Theoretical Ratio",startleft,startup);
  text("Left : "+r1,startleft,startup+bet);
  text("Right : "+r2,startleft,startup+bet*2);
  startup=tmp;
  
  label.setValue(timer.toString());
  label.draw(this);
  label.setPosition(1180,20);
  
  
}
    
void sum() {
  for(int i=0;i<2;i++) {
    tot[i]=hydrogen[i].size()+helium[i].size()+nitrogen[i].size()+oxygen[i].size()+water[i].size()+ammonia[i].size();
  }
}

void generate(int x,int y) {
  
  Vec2 pos = box2d.getBodyPixelCoord(piston.body);
  if(y==1) {
    if(x==0) hydrogen[0].add(new Hydrogen(random(radius,pos.x-thick-radius),random(radius,height-radius),radius,left));
    if(x==1) hydrogen[1].add(new Hydrogen(random(pos.x+thick+radius,width-radius),random(radius,height-radius),radius,right));
  }
  
  if(y==2) {
    if(x==0) helium[0].add(new Helium(random(radius,pos.x-thick-radius),random(radius,height-radius),radius,left));
    if(x==1) helium[1].add(new Helium(random(pos.x+thick+radius,width-radius),random(radius,height-radius),radius,right));
  }
  
  if(y==7) {
    if(x==0) nitrogen[0].add(new Nitrogen(random(radius,pos.x-thick-radius),random(radius,height-radius),radius,left));
    if(x==1) nitrogen[1].add(new Nitrogen(random(pos.x+thick+radius,width-radius),random(radius,height-radius),radius,right));
  }
  
  if(y==8) {
    if(x==0) oxygen[0].add(new Oxygen(random(radius,pos.x-thick-radius),random(radius,height-radius),radius,left));
    if(x==1) oxygen[1].add(new Oxygen(random(pos.x+thick+radius,width-radius),random(radius,height-radius),radius,right));
  }
  
}

void keyPressed() {
  if (key==' ') checkbox.deactivateAll();
  
  if(key == CODED) {
    if(keyCode == CONTROL) keys[0]=1;
  }
  
  if(key == '1') keys[1]=1;
  if(key == '2') keys[1]=2;
  if(key == '7') keys[1]=7;
  if(key == '8') keys[1]=8;
  
  generate(keys[0],keys[1]);
  
}

void keyReleased() {
   keys[0]=keys[1]=0;
}

void combine1(int x) {
  
  for(int i=oxygen[x].size()-1;i>=0;i--) {
    int cnt=-1;
    Oxygen o = oxygen[x].get(i);
    for(int j=hydrogen[x].size()-1;j>=0;j--) {
      
      Hydrogen h = hydrogen[x].get(j);
      Vec2 opos = box2d.getBodyPixelCoord(o.body);
      Vec2 hpos = box2d.getBodyPixelCoord(h.body);
      Vec2 tmp = opos.sub(hpos);
      float dist = tmp.length();
      if(dist<=4*radius) {
        if(cnt==-1) cnt=j;
        else {
          o.killBody();
          hydrogen[x].get(cnt).killBody();
          h.killBody();
          oxygen[x].remove(i);
          hydrogen[x].remove(cnt);
          hydrogen[x].remove(j);
          water[x].add(new Water(opos.x,opos.y,radius,left));
          water[x].add(new Water(hpos.x,hpos.y,radius,left));
          break;
        }
      }
    }
  }
}

void combine2(int x) {
  
  for(int i=nitrogen[x].size()-1;i>=0;i--) {
    int cnt1=-1;
    int cnt2=-1;
    Nitrogen n = nitrogen[x].get(i);
    for(int j=hydrogen[x].size()-1;j>=0;j--) {
      
      Hydrogen h = hydrogen[x].get(j);
      Vec2 npos = box2d.getBodyPixelCoord(n.body);
      Vec2 hpos = box2d.getBodyPixelCoord(h.body);
      Vec2 tmp = npos.sub(hpos);
      float dist = tmp.length();
      if(dist<=5*radius) {
        if(cnt1==-1) cnt1=j;
        else if(cnt2==-1) cnt2=j;
        else {
          n.killBody();
          hydrogen[x].get(cnt1).killBody();
          hydrogen[x].get(cnt2).killBody();
          h.killBody();
          nitrogen[x].remove(i);
          hydrogen[x].remove(cnt1);
          hydrogen[x].remove(cnt2);
          hydrogen[x].remove(j);
          ammonia[x].add(new Ammonia(npos.x,npos.y,radius,left));
          ammonia[x].add(new Ammonia(hpos.x,hpos.y,radius,left));
          break;
        }
      }
    }
  }
}

void ManageCombine() {
  if(checkbox.getArrayValue()[2]==1) combine2(0);
  if(checkbox.getArrayValue()[0]==1) combine1(0);
  if(checkbox.getArrayValue()[3]==1) combine2(1);
  if(checkbox.getArrayValue()[1]==1) combine1(1);
}


  