class Oxygen extends Particle {
  
  Oxygen(float x, float y, float r_, float t_) {
    
    super(x,y,r_,t_);
    col = color(0,255,255);
    s="O";
  }
  
  void makeBody(float x, float y, float r) {
    
    super.makeBody(x,y,r);
    
  }
  
  void display() {
    
    super.display();
    
  }
  
  void setting() {
    density=32;
  }
  
  void killBody() {
    super.killBody();
  }
  
  void changetemp(float t_) {
    super.changetemp(t_);
  }
  
}