class Pawn extends Piece{
   public Pawn(int turn, Position loc) {
    super(turn, loc, "placehold.jpg", new int[2][10]);
  }
    public  int[][] getMoves() {return Moves();} //loops and checks if movePossible   
 public  int[][] getCaptures() {return new int[2][10];} //usually calls getMoves, Pawn is diff  
 public  boolean movePossible(Position move) {return false;}  
 public  boolean capturePossible(Position move) {return false;}  
}
