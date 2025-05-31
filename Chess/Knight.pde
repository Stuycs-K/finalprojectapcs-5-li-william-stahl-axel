import java.util.*;
class Knight extends Piece{
  public Knight(int turn, Position loc) {
    super(turn, loc, "knight.jpg", new int[][]{{-2,-1},{-1,-2},{1,-2},{2,-1},{2,1},{1,2},{-1,2},{-2,1}});
  }
}
