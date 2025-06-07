import java.util.ArrayList;

PImage boardImage, tmpPiece;
ArrayList<Piece> board = new ArrayList<Piece>(33);
int turn = 0;
ArrayList<Position> hints = new ArrayList<Position>();
Piece focus;
boolean whiteCheck = false;
boolean blackCheck = false;
boolean gameOver=false;

void setup() {
  size(773,800);
  boardImage = loadImage("board.png");
  image(boardImage,0,0);

  board.clear();
  hints.clear();
  focus=null;
  turn=0;
  whiteCheck = false;
  blackCheck = false;
  gameOver=false;
  for (int _turn=0; _turn<=1; _turn++) {
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
  if (!gameOver) {
    image(boardImage, 0, 0);
    for (Piece piece: board){
      image(piece.getIcon(), piece.getX(), piece.getY()); 
    }
    showHints();
  }
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
  hints.clear();

  for (Position position : moves){
    if (getPieceAt(position) == null){
      hints.add(position);
    }
  }

  for (Position position : captures){
    Piece enemy = getPieceAt(position);
    if (enemy != null && enemy.getTurn() != piece.getTurn()){
      hints.add(position); 
    }
  }

  if (piece.iconPath=="queen.png"||piece.iconPath=="bishop.png"||piece.iconPath=="rook.png")
    rangingCheck(piece, hints);

  for (int i = hints.size() - 1; i >= 0; i--) {
    Position move = hints.get(i);
    if (isCheckAfterMove(piece, move)) {
      hints.remove(i);
    }
  }
}

public void rangingCheck(Piece piece, ArrayList<Position> hints) {
  boolean removeUp = false;
  for (int i = 1; i < 8; i++) {
    Position pos = new Position(piece.loc.getCol(), piece.loc.getRow() + i);
    if (removeUp && pos.isPossible(piece.loc.getCol(), piece.loc.getRow() + i)) {
      for (int j = 0; j < hints.size(); j++) {
        if (hints.get(j).equals(pos)) {
          hints.remove(j);
          j--;
        }
      }
    } else {
      removeUp = getPieceAt(pos) != null;
    }
  }

  boolean removeDown = false;
  for (int i = 1; i < 8; i++) {
    Position pos = new Position(piece.loc.getCol(), piece.loc.getRow() - i);
    if (removeDown && pos.isPossible(piece.loc.getCol(), piece.loc.getRow() - i)) {
      for (int j = 0; j < hints.size(); j++) {
        if (hints.get(j).equals(pos)) {
          hints.remove(j);
          j--;
        }
      }
    } else {
      removeDown = getPieceAt(pos) != null;
    }
  }

  boolean removeUpRight = false;
  for (int i = 1; i < 8; i++) {
    Position pos = new Position(piece.loc.getCol() + i, piece.loc.getRow() + i);
    if (removeUpRight && pos.isPossible(piece.loc.getCol() + i, piece.loc.getRow() + i)) {
      for (int j = 0; j < hints.size(); j++) {
        if (hints.get(j).equals(pos)) {
          hints.remove(j);
          j--;
        }
      }
    } else {
      removeUpRight = getPieceAt(pos) != null;
    }
  }

  boolean removeUpLeft = false;
  for (int i = 1; i < 8; i++) {
    Position pos = new Position(piece.loc.getCol() - i, piece.loc.getRow() + i);
    if (removeUpLeft && pos.isPossible(piece.loc.getCol() - i, piece.loc.getRow() + i)) {
      for (int j = 0; j < hints.size(); j++) {
        if (hints.get(j).equals(pos)) {
          hints.remove(j);
          j--;
        }
      }
    } else {
      removeUpLeft = getPieceAt(pos) != null;
    }
  }

  boolean removeDownLeft = false;
  for (int i = 1; i < 8; i++) {
    Position pos = new Position(piece.loc.getCol() - i, piece.loc.getRow() - i);
    if (removeDownLeft && pos.isPossible(piece.loc.getCol() - i, piece.loc.getRow() - i)) {
      for (int j = 0; j < hints.size(); j++) {
        if (hints.get(j).equals(pos)) {
          hints.remove(j);
          j--;
        }
      }
    } else {
      removeDownLeft = getPieceAt(pos) != null;
    }
  }

  boolean removeDownRight = false;
  for (int i = 1; i < 8; i++) {
    Position pos = new Position(piece.loc.getCol() + i, piece.loc.getRow() - i);
    if (removeDownRight && pos.isPossible(piece.loc.getCol() + i, piece.loc.getRow() - i)) {
      for (int j = 0; j < hints.size(); j++) {
        if (hints.get(j).equals(pos)) {
          hints.remove(j);
          j--;
        }
      }
    } else {
      removeDownRight = getPieceAt(pos) != null;
    }
  }

  boolean removeLeft = false;
  for (int i = 1; i < 8; i++) {
    Position pos = new Position(piece.loc.getCol() - i, piece.loc.getRow());
    if (removeLeft && pos.isPossible(piece.loc.getCol() - i, piece.loc.getRow())) {
      for (int j = 0; j < hints.size(); j++) {
        if (hints.get(j).equals(pos)) {
          hints.remove(j);
          j--;
        }
      }
    } else {
      removeLeft = getPieceAt(pos) != null;
    }
  }

  boolean removeRight = false;
  for (int i = 1; i < 8; i++) {
    Position pos = new Position(piece.loc.getCol() + i, piece.loc.getRow());
    if (removeRight && pos.isPossible(piece.loc.getCol() + i, piece.loc.getRow())) {
      for (int j = 0; j < hints.size(); j++) {
        if (hints.get(j).equals(pos)) {
          hints.remove(j);
          j--;
        }
      }
    } else {
      removeRight = getPieceAt(pos) != null;
    }
  }
}

void showHints(){
  fill(200, 200, 200, 180);
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
  if (gameOver) {
    setup();
  }
  Position tmp = new Position(1, 1);
  Position mousePos = tmp.cordToPos(mouseX, mouseY);
  Piece clickedPiece = getPieceAt(mousePos);

  if (hints.isEmpty()) {
    if (clickedPiece != null && clickedPiece.turn==turn) {
      focus = clickedPiece;
      getHints(focus);
    }
  } else if (!positionInHints(mousePos)) {
    focus = null;
    clearHints();
  } else if (focus != null && focus.turn==turn && clickedPiece == null) {
    movePiece(mousePos, focus);
    focus = null;
    clearHints();
    turn = (turn+1)%2;
    Position kingPos = null;
    for (Piece p: board) {
      if (p.turn==turn) kingPos=p.loc;
    }
    if (turn == 0 && kingPos!=null) {
      whiteCheck = isCheck(turn, kingPos);
      blackCheck=false;
    } else if (kingPos!=null){
      blackCheck = isCheck(turn, kingPos);
      whiteCheck=false;
    }
    isCheckMate();
  } else if (focus.turn==turn) {
    board.remove(clickedPiece);
    movePiece(mousePos, focus);
    focus = null;
    clearHints();
    turn = (turn+1)%2;
    Position kingPos = null;
    for (Piece p: board) {
      if (p.turn==turn) kingPos=p.loc;
    }
    if (turn == 0 && kingPos!=null) {
      whiteCheck = isCheck(turn, kingPos);
    } else if (kingPos!=null){
      blackCheck = isCheck(turn, kingPos);
    }
    isCheckMate();
  }
  return;
}

boolean positionInHints(Position pos) {
  for (Position p : hints) {
    if (p.getX() == pos.getX() && p.getY() == pos.getY()) {
      return true;
    }
  }
  return false;
}

boolean isCheck(int kingTurn, Position kingPos) {
  for (Piece piece : board) {
    if (piece.getTurn() != kingTurn) {
      ArrayList<Position> attacks = new ArrayList<Position>();

      if (piece.iconPath.equals("rook.png") || piece.iconPath.equals("queen.png")) {
        int[][] rookDirs = {{0,1}, {1,0}, {0,-1}, {-1,0}};
        for (int[] dir : rookDirs) {
          for (int i = 1; i < 8; i++) {
            Position pos = new Position(piece.loc.getCol() + dir[0]*i, piece.loc.getRow() + dir[1]*i);
            if (!pos.isPossible(piece.loc.getCol() + dir[0]*i, piece.loc.getRow() + dir[1]*i)) break;
            Piece block = getPieceAt(pos);
            if (block == null) {
              attacks.add(pos);
            } else {
              if (block.getTurn() != piece.getTurn()) {
                attacks.add(pos);
              }
              break;
            }
          }
        }
      }

      if (piece.iconPath.equals("bishop.png") || piece.iconPath.equals("queen.png")) {
        int[][] bishopDirs = {{1,1}, {1,-1}, {-1,1}, {-1,-1}};
        for (int[] dir : bishopDirs) {
          for (int i = 1; i < 8; i++) {
            Position pos = new Position(piece.loc.getCol() + dir[0]*i, piece.loc.getRow() + dir[1]*i);
            if (!pos.isPossible(piece.loc.getCol() + dir[0]*i,piece.loc.getRow() + dir[1]*i)) break;
            Piece block = getPieceAt(pos);
            if (block == null) {
              attacks.add(pos);
            } else {
              if (block.getTurn() != piece.getTurn()) {
                attacks.add(pos);
              }
              break;
            }
          }
        }
      }

      if (attacks.isEmpty()) {
        attacks = piece.getCaptures();
      }

      for (Position attack : attacks) {
        if (attack.equals(kingPos)) {
          return true;
        }
      }
    }
  }
  return false;
}

boolean isCheckAfterMove(Piece piece, Position move) {
  Position originalPos = piece.getLoc();
  Piece capturedPiece = getPieceAt(move);
  piece.loc = move;
  if (capturedPiece != null) board.remove(capturedPiece);

  Piece king = null;
  for (Piece p : board) {
    if (p instanceof King && p.getTurn() == piece.getTurn()) {
      king = p;
      break;
    }
  }
  if (piece instanceof King) king = piece;

  boolean inCheck = false;
  if (king != null) {
    inCheck = isCheck(king.getTurn(), king.getLoc());
  }

  piece.loc = originalPos;
  if (capturedPiece != null) board.add(capturedPiece);

  return inCheck;
}

void isCheckMate() {
  if (whiteCheck||blackCheck) {
    for (Piece piece: board) {
      if (piece.getTurn()==turn) {
        getHints(piece);
        if (!hints.isEmpty()) {
          hints.clear();
          return;
        }
      }
    }
    gameOver=true;
    String winnerMessage;
    if (turn == 1) {
      winnerMessage = "Black wins!";
    } else {
      winnerMessage = "White wins!";
    }
    fill(0, 0, 0, 180);
    rect(0, 0, width, height);

    fill(255);
    textAlign(CENTER, CENTER);
    textSize(48);
    text(winnerMessage, width / 2, height / 2 - 30);

    textSize(24);
    text("Click to play again", width / 2, height / 2 + 30);
  }
}
