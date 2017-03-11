class Dialogue
{
  PVector col;
  PVector position;
  String dialogueText;
  boolean hide;
  Dialogue(int x, int y, PVector c, String t)
  {
    position = new PVector(x,y,0);
    col = c;
    dialogueText = t;
  }
  
  void draw()
  {
    strokeWeight(2);
    fill(230);
    rect(position.x,position.y,200,75);
    fill(col.x,col.y,col.z);
    textAlign(LEFT);
    textSize(20);
    text(dialogueText,position.x+2,position.y+2,200,75);
    textSize(12);
    fill(20);
    text("'Enter' to continue",position.x+100,position.y+60,200,75);
    stroke(0);
  }
}
