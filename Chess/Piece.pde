abstract class Piece{
   private String name;
   private int[] moves;
   private String iconPath;
   private Position loc;
   
   public abstract String getName();
   public abstract int[] getMoves();
   public abstract boolean movePossible();
   public abstract boolean capturePossible();
   public abstract void moveTo();
}
