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
}

void showHints(){
   fill (200, 200, 200, 180);
  for (Position position : hints){
      float centerXCor = position.getX() + width/16;
      float centerYCor = position.getY() + height/16;
      circle(centerXCor, centerYCor, 100);
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
  System.out.println("\n\nFocus before click: " + focus);

  Position tmp = new Position(1, 1); // Just to access cordToPos
  Position mousePos = tmp.cordToPos(mouseX, mouseY);
  System.out.println("Mouse clicked at: " + mousePos);

  Piece clickedPiece = getPieceAt(mousePos);
  System.out.println("Piece at click: " + clickedPiece);

  if (hints.isEmpty()) {
    if (clickedPiece != null) {
      focus = clickedPiece;
      getHints(focus);
      System.out.println("Setting focus and showing hints for: " + focus);
    }
  } else if (!positionInHints(mousePos)) {
    System.out.println("Clicked outside hints, clearing.");
    focus = null;
    clearHints();
  } else if (focus != null && clickedPiece == null) {
    System.out.println("Moving " + focus + " to " + mousePos);
    movePiece(mousePos, focus);
    focus = null;
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
