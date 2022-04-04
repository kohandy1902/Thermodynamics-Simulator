class Helium extends Particle {
  
  Helium(float x, float y, float r_, float t_) {
    
    super(x,y,r_,t_);
    col = color(255,215,0);
    s="He";
  }
  
  void makeBody(float x, float y, float r) {
    
    super.makeBody(x,y,r);
    
  }
  
  void display() {
    
    super.display();
    
  }
  
  void setting() {
    density=4;
  }
  
  void killBody() {
    super.killBody();
  }
  
  void changetemp(float t_) {
    super.changetemp(t_);
  }
  
}