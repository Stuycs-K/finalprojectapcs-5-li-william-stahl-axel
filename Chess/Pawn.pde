import java.util.ArrayList;

class Pawn extends Piece{
   public Pawn(int turn, Position loc) {
    super(turn, loc, "pawn.png", new int[2][10]);//moves will be different
  }
  public ArrayList<Position> getMoves() {
    ArrayList<Position> moves = new ArrayList<Position>();
    
    int direction;
    if (turn == 0){
       direction = 1;
    }
    else{
       direction = -1; 
    }
    
    Position one = new Position(getLoc().getCol(), getLoc().getRow() + direction);
    if (one.isPossible(one.getCol(), one.getRow()) && getPieceAt(one) == null){
       moves.add(one);   // regular movement
       
       if (!getHasMoved()){
          Position two = new Position(getLoc().getCol(), getLoc().getRow() + 2*direction);
          if (two.isPossible(two.getCol(), two.getRow()) && getPieceAt(two) == null){
             moves.add(two); // starting position so it can move two squares as well 
          }
       }
    }
    
    return moves;
  }
  public ArrayList<Position> getCaptures() {
    int[][] relative = {{-1,-1},{1,-1}};
    if (getTurn() == 0) {
      relative = new int[][]{{1,1},{-1,1}};
    }
    return getMovesH(relative);
  }
}
