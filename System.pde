class System 
{
  ArrayList<Particle> particles;
  PVector col;

  System(PVector c) 
  {
    particles = new ArrayList<Particle>();
    col = c;
  }

  void addParticle(float x, float y) 
  {
    particles.add(new Particle(x,y,col));
  }

  void display() 
  {
    for (Particle p : particles) 
    {
      p.display();
    }
  }
  
  void update()
  {
    for (int i = particles.size()-1; i >= 0; i--)
    {
      Particle p = particles.get(i);
      p.update();
      if (p.isDead()) 
      {
        particles.remove(i);
      }
    }
  }
}


