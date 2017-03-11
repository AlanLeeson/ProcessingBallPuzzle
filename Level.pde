class Level
{
 String[] lines;
 int index = 0;
 ArrayList<Obstacle> obs;
 ArrayList<Integer> elem;
 
 Level()
 {
   obs = new ArrayList<Obstacle>();
   elem = new ArrayList<Integer>();
   read();
 }
 
 void read()
 {
   lines = loadStrings("test.txt");
   while(index < lines.length)
   {
     String[] piece = split(lines[index], '\n');
     
     for(int i = 0; i < piece.length; i++)
     {
       String[] elements = split(piece[i],'\t');
       if(elements[i].charAt(0) == 'O')
       {
         String[] stuff = split(elements[i],' ');
         makeObstacle(stuff);
       }
       String s = piece[i];
       print(s + "\n");
     }
     
     index ++;
   }
 }
  
 //used to make walls
 void makeObstacle(String[] elements)
 {
   
   for(int i = 0; i < elements.length; i++)
   {
     
     switch(elements.length)
     {
       case 11:
       //elem[i] = Integer.parseInt(elements[i]);
       case 10:
       
       case 6:
        // Obstacle ob = new Obstacle(elements[1],
        // elements[2],elements[3],elements[4],elements[5]);
       break;
     }
     String s = elements[i];
     print(s + "\n");
   }
 }
   
}
