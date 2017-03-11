class Ball
{
  
  PVector location;
  PVector center;
  PVector velocity;
  PVector acceleration;
  PVector drag;
  int wid;
  int hei;
  float speedx;
  float speedy;
  PVector col;
  float sx, sy;
  boolean nextLevel;
   
  Ball(int x, int y, int w, int h)
  {
    nextLevel = false;
    sx = x;
    sy = y;
    location = new PVector(x,y);
    center = new PVector(x+wid/2,y+hei/2);
    velocity = new PVector(0,0);
    acceleration = new PVector(0,0);
    drag = new PVector(-1,-1,0);
    wid = w;
    hei = h;
    speedx = 0;
    speedy = 0;
    col = new PVector(123,0,164);
  }
  
  void applyForce(PVector force)
  {
    acceleration.add(force);
  }
  
  void update()
  {
    move();
    velocity.add(acceleration);
    location.add(velocity);
    center = new PVector(location.x+wid/2,location.y+hei/2);
    acceleration.mult(0);
  }
  
  void draw()
  {
    fill(col.x,col.y,col.z);
    stroke(0);
    strokeWeight(2);
    ellipse(location.x, location.y, wid, hei);
  }
  
  void move()
  {  
    PVector force = new PVector(speedx,speedy,0);
    
    float friction = 0.039f;
    
    force.mult(friction);
    
    if(location.x < 0)
    {
      location.x = 0;
      reset();
    }
    else if(location.x > width)
    {
      location.x = 0;
      nextLevel = true;
      reset();
      sy = location.y;
      sx = location.x;
    }
    else if(location.y < 0)
    {
      location.y = 0;
      reset();
    }
    else if(location.y > height - hei)
    {
      location.y = height - hei;
      reset();
    }
    
    applyForce(force);
    
  }
  
  void setSpeedX(boolean dir)
  {
    if(dir)
    {
      speedx = 2.0f;
    }
    else
    {
      speedx = -2.0f;
    }
  }
  
  void setSpeedY(boolean dir)
  {
    if(dir)
    {
      speedy = 2.0f;
    }
    else
    {
      speedy = -2.0f;
    }
  }
  
  void reset()
  {
    speedx = 0;
    speedy = 0;
    velocity = new PVector(0,0,0);
  }
  
  void die()
  {
    location.x = sx;
    location.y = sy;
    speedx = 0;
    speedy = 0;
    velocity = new PVector(0,0,0);
  }

}
