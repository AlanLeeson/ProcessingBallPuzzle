class Kid
{
  PVector location;
  PVector velocity;
  PVector acceleration;
  PVector col;
  float maxforce;    // Maximum steering force
  float maxspeed;
  boolean follow;
  boolean explode;
  System particleSystem;
  Door door;
  
  Kid(int x, int y, PVector c, int speed, Door d)
  {
    location = new PVector(x,y);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    col = c;
    maxspeed = speed;
    maxforce = 0.5;
    follow = false;
    explode = true;
    door = d;
    particleSystem = new System(c);
  }
  
  void applyForce(PVector force)
  {
    acceleration.add(force);
  }
  
  void arrive(PVector target)
  {
     PVector desired = PVector.sub(target,location);  // A vector pointing from the location to the target
     float d = desired.mag();
     // Scale with arbitrary damping within 100 pixels
     if (d < 50) 
     {
       float m = map(d,0,50,0,maxspeed);
       desired.setMag(m);
     }
     else 
     {
       desired.setMag(maxspeed);
     }
     // Steering = Desired minus Velocity
     PVector steer = PVector.sub(desired,velocity);
     steer.limit(maxforce);  // Limit to maximum steering force
     applyForce(steer);
  }
  
  void update()
  {
    velocity.add(acceleration);
    location.add(velocity);
    acceleration.mult(0);
  }
  
  void draw()
  {
    if(follow)
    {
      if(explode)
      {
        for(int i = 0; i < 50; i++)
        {
          particleSystem.addParticle(location.x+5,location.y+5);
        }
        explode = false;
      }
      else
      {
        particleSystem.update();
        particleSystem.display();
      }
    }
    
    update();
    strokeWeight(1);
    fill(col.x,col.y,col.z);
    ellipse(location.x,location.y,10,10);
    if(!follow)
    {
      door.display();
    }
  }
  
  void collision(Ball b)
  {
    if(b.location.x < location.x + 20 && b.location.x + b.wid > location.x
       && b.location.y < location.y + 20 && b.location.y + b.hei > location.y)
    {
      follow = true;
    }
  }

}
