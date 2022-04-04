class Ammonia extends Particle {
  
  Ammonia(float x, float y, float r_, float t_) {
    
    super(x,y,r_,t_);
    col = color(238,130,238);
    s="NH3";
  }
  
  void makeBody(float x, float y, float r) {
    
    super.makeBody(x,y,r);
    
  }
  
  void display() {
    
    super.display();
    
  }
  
  void setting() {
    density=17;
  }
  
  void killBody() {
    super.killBody();
  }
  
  void changetemp(float t_) {
    super.changetemp(t_);
  }
  
}