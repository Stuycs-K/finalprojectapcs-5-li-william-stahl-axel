import java.util.ArrayList;

class Pawn extends Piece{
   public Pawn(int turn, Position loc) {
    super(turn, loc, "pawn.png", new int[2][10]);//moves will be different
  }
  public ArrayList<Position> getMoves() {
    int[][] relative = {{0,-1}};
    if (getTurn() == 0) {
      relative = new int[][]{{0,1}};
    }
    return getMovesH(relative);
  }
}
