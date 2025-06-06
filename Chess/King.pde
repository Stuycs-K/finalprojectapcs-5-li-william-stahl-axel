class King extends Piece{
   public King(int turn, Position loc) {
    super(turn, loc, "king.png", new int[][]{{-1,-1},{-1,0},{-1,1},{0,-1},{0,1},{1,-1},{1,0},{1,1}});
  }
  public boolean isCheck(Piece king, Position loc){
    for (Piece piece : board){
       if (piece.turn != king.turn){
          ArrayList<Position> temp = (ArrayList<Position>) hints.clone();
          getHints(piece);
          for (Position position : hints){
             if (position.equals(loc)){
                return true; 
             }
          }
          hints = temp;
       }
    }
  return false;
}

}
