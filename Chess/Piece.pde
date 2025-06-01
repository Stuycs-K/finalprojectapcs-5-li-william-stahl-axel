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
   public ArrayList<Position> getMoves() {return getMovesH(Moves());}
   public  ArrayList<Position> getMovesH(int[][] relative) {
    Position tmp;
    ArrayList<Position> possibleMoves = new ArrayList<Position>();
    int x = getLoc().getCol();
    int y = getLoc().getRow();
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
    PImage icon;
    if (turn == 0) {
      icon = loadImage(iconPath);
    } else {
      icon = loadImage("black-"+iconPath);
    }
    icon.resize(width/8,height/8);
    return icon;
  }
  public boolean getHasMoved() {return hasMoved;}
  public int getTurn() {return turn;}
  public String toString() {
    String colorz = (turn == 0) ? "White" : "Black";
    return getClass().getSimpleName() + " (" + colorz + ") at " + loc + (hasMoved ? " [Moved]" : " [Not moved]");
  }
}  
