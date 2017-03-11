class Particle 
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector col;
  float lifespan;
  
  float r = 5;
  boolean highlight;

  Particle(float x, float y, PVector c)
  {
    acceleration = new PVector(0, random(-0.05,0.05));
    velocity = new PVector(random(-1, 1), random(-1, 1));
    location = new PVector(x, y);
    lifespan = 200.0;
    col = c;
  }
  
  void applyForce(PVector f) 
  {
    acceleration.add(f); 
  }

  void update() 
  {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
    lifespan -= 2.0;
  }

  void display() 
  {
    stroke(0, lifespan);
    strokeWeight(2);
    fill(col.x,col.y,col.z, lifespan);
    ellipse(location.x, location.y, r*2, r*2);
  }

  boolean isDead() 
  {
    if (lifespan < 0.0)
    {
      return true;
    } 
    else 
    {
      return false;
    }
  }
}

