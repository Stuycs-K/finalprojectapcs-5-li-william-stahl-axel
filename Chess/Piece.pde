abstract class Piece {
   private int turn; //distinguish between black and white  
   private int[][] moves; //array of relative cords  
   private String iconPath;  
   private Position loc;  
   private boolean hasMoved; //pawns and castling

   public Piece(int turn, Position loc, String iconPath, int[][] moves) {  
     this.turn = turn;  
     this.loc = loc;  
     this.iconPath = iconPath;  
     this.moves = moves;  
     this.hasMoved = false;  
   }  


   public int[][] Moves() {return moves;}
   public int getX() {return loc.getX();}
   public int getY() {return loc.getY();}
   public  ArrayList<Position> getMoves() {
    Position tmp;
    ArrayList<Position> possibleMoves = new ArrayList<Position>();
    int x = getLoc().getX();
    int y = getLoc().getY();
    int[][] relative = Moves();
    for (int[] pair : relative) {
      tmp = new Position(x+pair[0],y+pair[1]);
      if (movePossible(tmp)) {
        possibleMoves.add(tmp);
      }
    }
    return possibleMoves;
  }
  public  ArrayList<Position> getCaptures() {
   return getMoves();
 } //usually calls getMoves, Pawn is diff  
 public  boolean movePossible(Position move) {return move.isPossible();}  
 public  boolean capturePossible(Position move) {return move.isPossible();} 
   public Position getLoc() {return loc;}
   public void moveTo(Position dest) {  
      this.loc = dest;  
      this.hasMoved = true;  
   } 
  public PImage getIcon() {
    if (turn == 0) {
      return loadImage(iconPath);
    } else {
      return loadImage("black-"+iconPath);
    }
  }
  public boolean getHasMoved() {return hasMoved;}
}  
