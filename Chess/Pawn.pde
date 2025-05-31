class Pawn extends Piece{
   public Pawn(int turn, Position loc) {
    super(turn, loc, "pawn.png", new int[2][10]);//moves will be different
  }
}
