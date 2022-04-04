class Nitrogen extends Particle {
  
  Nitrogen(float x, float y, float r_, float t_) {
    
    super(x,y,r_,t_);
    col = color(255,0,255);
    s="N";
  }
  
  void makeBody(float x, float y, float r) {
    
    super.makeBody(x,y,r);
    
  }
  
  void display() {
    
    super.display();
    
  }
  
  void setting() {
    density=28;
  }
  
  void killBody() {
    super.killBody();
  }
  
  void changetemp(float t_) {
    super.changetemp(t_);
  }
  
}