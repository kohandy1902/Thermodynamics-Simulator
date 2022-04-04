class Water extends Particle {
  
  Water(float x, float y, float r_, float t_) {
    
    super(x,y,r_,t_);
    col = color(64,224,208);
    s="H2O";
  }
  
  void makeBody(float x, float y, float r) {
    
    super.makeBody(x,y,r);
    
  }
  
  void display() {
    
    super.display();
    
  }
  
  void setting() {
    density=18;
  }
  
  void killBody() {
    super.killBody();
  }
  
  void changetemp(float t_) {
    super.changetemp(t_);
  }
  
}