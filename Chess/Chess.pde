import java.util.ArrayList;

PImage boardImage, tmpPiece;
ArrayList<Piece> board = new ArrayList<Piece>(33);
int turn = 0;//0-white   1-black
ArrayList<Position> hints = new ArrayList<Position>();
Piece focus;
void setup() {
  size(773,800);
  boardImage = loadImage("board.png");
  image(boardImage,0,0);

  for (int _turn=0; _turn<=1; _turn++) {//black and white pieces
    board.add(new Rook(_turn, new Position(1, 1+7*_turn)));
    board.add(new Knight(_turn, new Position(2, 1+7*_turn)));
    board.add(new Bishop(_turn, new Position(3,1+7*_turn)));
    board.add(new Queen(_turn, new Position(4, 1+7*_turn)));
    board.add(new King(_turn, new Position(5, 1+7*_turn)));
    board.add(new Bishop(_turn, new Position(6, 1+7*_turn)));
    board.add(new Knight(_turn, new Position(7,1+7*_turn)));
    board.add(new Rook(_turn, new Position(8, 1+7*_turn)));
    for (int i = 1; i <= 8; i++) 
      board.add(new Pawn(_turn, new Position(i, 2+5*_turn)));
  }

  for (Piece piece: board) {
    image(piece.getIcon(),piece.getX(),piece.getY());
  }
}
void draw() {
  image(boardImage, 0, 0);
  
  for (Piece piece: board){
     image(piece.getIcon(), piece.getX(), piece.getY()); 
  }
  showHints();
}

Piece getPieceAt(Position position){
   for (Piece piece: board){
     
      if (piece.getLoc().equals(position)){
        
         return piece; 
      }
   }
   return null;
}

void getHints(Piece piece){
    ArrayList<Position> moves = piece.getMoves();
    ArrayList<Position> captures = piece.getCaptures();
    
    // no piece there
    for (Position position : moves){
       if (getPieceAt(position) == null){
           hints.add(position);
       }
    }
    
    // piece there to capture
    for (Position position : captures){
       Piece enemy = getPieceAt(position);
       if (enemy != null && enemy.getTurn() != piece.getTurn()){ // checks if there is a different color piece
          hints.add(position); 
       }
    }
    rangingCheck(piece, hints);
}
  public void rangingCheck(Piece piece, ArrayList<Position> hints) {
    boolean removeUp = false; // up
    for (int i = 1; i<8; i++) {
      Position pos = new Position(piece.loc.getCol(),piece.loc.getRow()+i);
      
      if (removeUp) {
        for (int j=0;j<hints.size();j++) {
          if(hints.get(j).equals(pos)) {
            hints.remove(j);
            j--;
          }
        }
        
      } else{
      removeUp = getPieceAt(pos)!=null;}
    }
   
    boolean removeDown = false; // down
    for (int i = 1; i<8; i++) {
      Position pos = new Position(piece.loc.getCol(),piece.loc.getRow()-i);
      
      if (removeDown) {
        for (int j=0;j<hints.size();j++) {
          if(hints.get(j).equals(pos)) {
            hints.remove(j);
            j--;
          }
        }
        
      } else{
      removeDown = getPieceAt(pos)!=null;}
    }
  
    boolean removeUpRight = false; // upwards and right
    for (int i = 1; i < 8; i++){
      Position pos = new Position(piece.loc.getCol() + i, piece.loc.getRow() + i);
      
      if (removeUpRight){
           for (int j = 0; j < hints.size(); j++){
              if (hints.get(j).equals(pos)){
                 hints.remove(j);
                 j--;
              }
           }
      }
      else{
         removeUpRight = getPieceAt(pos) != null; 
      }
    }
    
    boolean removeUpLeft = false; // upwards and left
    for (int i = 1; i < 8; i++){
      Position pos = new Position(piece.loc.getCol() - i, piece.loc.getRow() + i);
      
      if (removeUpLeft){
           for (int j = 0; j < hints.size(); j++){
              if (hints.get(j).equals(pos)){
                 hints.remove(j);
                 j--;
              }
           }
      }
      else{
         removeUpLeft = getPieceAt(pos) != null; 
      }
    }    
    
    boolean removeDownLeft = false; // down and left
    for (int i = 1; i < 8; i++){
      Position pos = new Position(piece.loc.getCol() - i, piece.loc.getRow() - i);
      
      if (removeDownLeft){
           for (int j = 0; j < hints.size(); j++){
              if (hints.get(j).equals(pos)){
                 hints.remove(j);
                 j--;
              }
           }
      }
      else{
         removeDownLeft = getPieceAt(pos) != null; 
      }
    }   
    
    boolean removeDownRight = false; // down and right
    for (int i = 1; i < 8; i++){
      Position pos = new Position(piece.loc.getCol() + i, piece.loc.getRow() - i);
      
      if (removeDownRight){
           for (int j = 0; j < hints.size(); j++){
              if (hints.get(j).equals(pos)){
                 hints.remove(j);
                 j--;
              }
           }
      }
      else{
         removeDownRight = getPieceAt(pos) != null; 
      }
    } 
    
    boolean removeLeft = false; // left
    for (int i = 1; i < 8; i++){
      Position pos = new Position(piece.loc.getCol() - i, piece.loc.getRow());
      
      if (removeLeft){
           for (int j = 0; j < hints.size(); j++){
              if (hints.get(j).equals(pos)){
                 hints.remove(j);
                 j--;
              }
           }
      }
      else{
         removeLeft = getPieceAt(pos) != null; 
      }
    } 
    
    boolean removeRight = false; // right
    for (int i = 1; i < 8; i++){
      Position pos = new Position(piece.loc.getCol() + i, piece.loc.getRow());
      
      if (removeRight){
           for (int j = 0; j < hints.size(); j++){
              if (hints.get(j).equals(pos)){
                 hints.remove(j);
                 j--;
              }
           }
      }
      else{
         removeRight = getPieceAt(pos) != null; 
      }
    } 
    
  }
void showHints(){
   fill (200, 200, 200, 180);
   noStroke();
    for (Position position : hints){
        float centerXCor = position.getX() + width/16;
        float centerYCor = position.getY() + height/16;
        circle(centerXCor, centerYCor, 40);
  } 
}

void clearHints(){
   hints.clear(); 
}

void movePiece(Position position, Piece piece) {
  Piece pieceAtPosition = getPieceAt(position);
  if (pieceAtPosition != null) {
    board.remove(pieceAtPosition);
  } 
  piece.moveTo(position);
  clearHints();
  draw();
}

void mouseClicked() {

  Position tmp = new Position(1, 1);
  Position mousePos = tmp.cordToPos(mouseX, mouseY);

  Piece clickedPiece = getPieceAt(mousePos);

  if (hints.isEmpty()) {
    if (clickedPiece != null) {
      focus = clickedPiece;
      getHints(focus);
    }
  } else if (!positionInHints(mousePos)) {
    focus = null;
    clearHints();
  } else if (focus != null && clickedPiece == null) {
    movePiece(mousePos, focus);
    focus = null;
    clearHints();
  } else {
    board.remove(clickedPiece);
    movePiece(mousePos, focus);
    focus = null;
    clearHints();
  }
    
}
boolean positionInHints(Position pos) {
  for (Position p : hints) {
    if (p.getX() == pos.getX() && p.getY() == pos.getY()) {
      return true;
    }
  }
  return false;
}
