import java.util.ArrayList;

PImage boardImage, tmpPiece;
ArrayList<Piece> board = new ArrayList<Piece>(33);
int turn = 0;//0-white   1-black
ArrayList<Position> hints = new ArrayList<Position>();
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
}
