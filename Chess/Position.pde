class Position{
   private int x;
   private int y;
   
   public Position(int xCord, int yCord){
       x = xCord;
       y = yCord;
   }
   
   public int getX(){
     return x;
   }
   
   public int getY(){
     return y;
   }
   
   public void setX(int xVal){
     x = xVal;
   }
   
   public void setY(int yVal){
     y = yVal;
   }
   
   // is on the board
   public boolean isPossible(){
     return (x > 0 && x < 9 && y > 0 && y < 9);
   }
   
   //find Position from cords
   public Position cordToPos(int x, int y) {
     return new Position(min(x*8 / width + 1, 8), min(y*8 / height + 1, 8));
   }
   
}
