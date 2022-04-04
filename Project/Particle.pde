class Particle {

  Body body;
  float r;

  color col;

  String s;
  
  float t;
  
  Particle(float x, float y, float r_, float t_) {
    r = r_;
    t = t_;
    
    makeBody(x, y, r);
    body.setUserData(this);
  }

  void killBody() {
    box2d.destroyBody(body);
  }

  void display() {
    
    Vec2 pos = box2d.getBodyPixelCoord(body);

    float a = body.getAngle();
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(a);
    fill(col);
    stroke(0);
    strokeWeight(2);
    ellipse(0, 0, r*2, r*2);
    
    fill(255);
    textAlign(CENTER,CENTER);
    textSize(13);
    text(s,0,-3);
    popMatrix();
  }

  void makeBody(float x, float y, float r) {

    BodyDef bd = new BodyDef();

    bd.position = box2d.coordPixelsToWorld(x, y);
    bd.type = BodyType.DYNAMIC;
    body = box2d.createBody(bd);


    CircleShape cs = new CircleShape();
    cs.m_radius = box2d.scalarPixelsToWorld(r);

    FixtureDef fd = new FixtureDef();
    fd.shape = cs;

    setting();
    fd.density = density;
    fd.friction = 0.0;
    fd.restitution = 1;

    float ang = random(2*PI);
    float mag = 2/sqrt(fd.density/t);
    body.createFixture(fd);
    body.setGravityScale(0);
    body.setLinearVelocity(new Vec2(mag*cos(ang),mag*sin(ang)));
  }
  
  void setting() {
  }
  
  void changetemp(float t_) {
    Vec2 vel = body.getLinearVelocity();
    vel.mulLocal(sqrt(t_/t));
    body.setLinearVelocity(vel);
    t = t_;
  }
}