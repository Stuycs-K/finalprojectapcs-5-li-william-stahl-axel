class King extends Piece{
   public King(int turn, Position loc) {
    super(turn, loc, "king.png", new int[][]{{-1,-1},{-1,0},{-1,1},{0,-1},{0,1},{1,-1},{1,0},{1,1}});
  }
}
