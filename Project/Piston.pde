class Piston {

  Body body;
  float w;
  float h;

  Piston(float x_, float y_, float w_, float h_) {
    float x = x_;
    float y = y_;
    w = w_;
    h = h_;
    makeBody(new Vec2(x, y), w, h);
    body.setUserData(this);
  }

  void display(){
    Vec2 pos = box2d.getBodyPixelCoord(body);
    float a = body.getAngle();

    rectMode(PConstants.CENTER);
    pushMatrix();
    translate(pos.x, pos.y);
    rotate(-a);
    fill(175);
    stroke(0);
    rect(0, 0, w, h);
    popMatrix();
    
  }

  void makeBody(Vec2 center, float w_, float h_) {

    BodyDef bd = new BodyDef();
    bd.type = BodyType.DYNAMIC;
    bd.position.set(box2d.coordPixelsToWorld(center));
    body = box2d.createBody(bd);

    PolygonShape sd = new PolygonShape();
    float box2dW = box2d.scalarPixelsToWorld(w_/2);
    float box2dH = box2d.scalarPixelsToWorld(h_/2);
    sd.setAsBox(box2dW, box2dH);

    FixtureDef fd = new FixtureDef();
    fd.shape = sd;

    fd.density = 50;
    fd.friction = 0;
    fd.restitution = 1;

    body.createFixture(fd);
    body.setGravityScale(0);
    
  }
  
}