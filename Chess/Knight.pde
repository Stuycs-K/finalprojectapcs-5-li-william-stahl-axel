import java.util.*;
class Knight extends Piece{
  public Knight(int turn, Position loc) {
    super(turn, loc, "placehold.jpg", new int[2][10]);
  }
<<<<<<< HEAD
   public  int[][] getMoves() {return new int[2][10];} //loops and checks if movePossible   
   public  int[][] getCaptures() {return new int[2][10];} //usually calls getMoves, Pawn is diff  
   public  boolean movePossible(Position move) {return false;}  
   public  boolean capturePossible(Position move) {return false;}  
=======
   //loops and checks if movePossible   
  
>>>>>>> 97f5c87805cc2b520a2962bbf2cac2943d357342
}
