import java.util.ArrayList;
import java.util.Arrays;
import java.io.FileNotFoundException;
import java.util.Scanner;


PImage boardImage, tmpPiece;
ArrayList<Piece> board = new ArrayList<Piece>(33);
int turn = 0;
ArrayList<Position> hints = new ArrayList<Position>();
Piece focus;
boolean whiteCheck = false;
boolean blackCheck = false;
boolean gameOver=false;
Position enPassantSpot = null; //where en passant happens
boolean isPromoting = false;
Piece promotingPawn = null;


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
  board=parse("default.txt");

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
    if (isPromoting) {
      showPromotionMenu();
    }
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
  
  if (piece.iconPath == "pawn.png" && enPassantSpot != null){
     int pRow = piece.getLoc().getRow();
     int pCol = piece.getLoc().getCol();
     int direction;
     
     if (piece.getTurn() == 0){
        direction = 1; 
     }
     else{
        direction = -1; 
     }
     
     if (enPassantSpot.getRow() == pRow + direction &&
         Math.abs(enPassantSpot.getCol() - pCol) == 1){
            hints.add(new Position(enPassantSpot.getCol(), enPassantSpot.getRow())); 
         }
  }

  if (piece.iconPath=="queen.png"||piece.iconPath=="bishop.png"||piece.iconPath=="rook.png")
    rangingCheck(piece, hints);

// castling
  if (piece.iconPath == "king.png" && !piece.getHasMoved()){
     int row = piece.getLoc().getRow();
     
     // kingside (right for white)
     Piece ksRook = getPieceAt(new Position(8, row));
     if (ksRook != null && ksRook.iconPath == "rook.png" && !ksRook.getHasMoved()){
        // between pieces
        if (getPieceAt(new Position(6, row)) == null &&
            getPieceAt(new Position(7, row)) == null &&
            !isCheck(piece.getTurn(), piece.getLoc())){
              hints.add(new Position(7, row)); // castle possible
            }
     }
     
     // queenside (left for white)
     Piece qsRook = getPieceAt(new Position(1, row));
      if (qsRook != null && qsRook.iconPath == "rook.png" && !qsRook.getHasMoved()){
        // between pieces
        if (getPieceAt(new Position(2, row)) == null &&
            getPieceAt(new Position(3, row)) == null &&
            getPieceAt(new Position(4, row)) == null &&
            !isCheck(piece.getTurn(), piece.getLoc())){
              hints.add(new Position(3, row)); // castle possible
            }
     }
  }

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
  
  // castling moves two
  if (piece.iconPath == "king.png" && Math.abs(position.getCol() - piece.getLoc().getCol()) == 2){
    if (position.getCol() == 7){ // ks
        Piece rook = getPieceAt(new Position(8, position.getRow()));
        if (rook != null){
           rook.moveTo(new Position(6, position.getRow())); 
        }
    }
    
    if (position.getCol() == 3){ // qs
        Piece rook = getPieceAt(new Position(1, position.getRow()));
        if (rook != null){
           rook.moveTo(new Position(4, position.getRow())); 
        }
    }
  }
  
  // en passant case
  if (piece.iconPath == "pawn.png" && enPassantSpot != null){
     if (position.equals(enPassantSpot)){
        int capturedRow;
        if (piece.getTurn() == 0){
           capturedRow = position.getRow() - 1; 
        }
        else{
           capturedRow = position.getRow() + 1; 
        }
        Piece capturedPawn = getPieceAt(new Position(position.getCol(), capturedRow));
        if (capturedPawn != null && capturedPawn.iconPath == "pawn.png"){
           board.remove(capturedPawn); 
        }
     }
  }
  
  int oldRow = piece.getLoc().getRow();
  piece.moveTo(position);
  
  enPassantSpot = null;
  if (piece.iconPath == "pawn.png"){
     int rowDiff = Math.abs(position.getRow() - oldRow); 
     if (rowDiff == 2){
        int direction;
        if (piece.getTurn() == 0){
           direction = 1; 
        }
        else{
           direction = -1; 
        }
        enPassantSpot = new Position(position.getCol(), position.getRow() - direction);
     }
  }
  
  clearHints();
  draw();
}

void mouseClicked() {
  if (gameOver) {
    setup();
  }

  if (isPromoting) {
    handlePromotionSelection();
    return;
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

  if (focus == null && hints.isEmpty()) {
    for (Piece p : board) {
      if (p.iconPath.equals("pawn.png")) {
        int row = p.getLoc().getRow();
        if ((p.getTurn() == 0 && row == 8) || (p.getTurn() == 1 && row == 1)) {
          isPromoting = true;
          promotingPawn = p;
          return;
        }
      }
    }
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
  for (int i = 0; i < board.size(); i++) {
    Piece piece = board.get(i);
    if (piece.getTurn() == turn) {
      getHints(piece);
      if (!hints.isEmpty()) {
        hints.clear();
        return;
      }
    }
  }
  gameOver = true;
  String winnerMessage;
  if (!whiteCheck && !blackCheck) {
    winnerMessage = "Draw by stalemate";
  } else if (turn == 1) {
    winnerMessage = "White wins!";
  } else {
    winnerMessage = "Black wins!";
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


ArrayList<Piece> parse(String fileName) {
  ArrayList<Piece> newBoard = new ArrayList<Piece>();
  String[] lines = loadStrings(fileName);

  for (String line : lines) {
    String[] parts = split(line, ' ');
    if (parts.length != 4) continue;

    String pieceType = parts[0].toLowerCase();
    int turn = int(parts[1]);
    int col = int(parts[2]);
    int row = int(parts[3]);
    Position pos = new Position(col, row);

    if (pieceType.equals("pawn")) newBoard.add(new Pawn(turn, pos));
    else if (pieceType.equals("rook")) newBoard.add(new Rook(turn, pos));
    else if (pieceType.equals("knight")) newBoard.add(new Knight(turn, pos));
    else if (pieceType.equals("bishop")) newBoard.add(new Bishop(turn, pos));
    else if (pieceType.equals("queen")) newBoard.add(new Queen(turn, pos));
    else if (pieceType.equals("king")) newBoard.add(new King(turn, pos));
  }
  return newBoard;
}

void showPromotionMenu() {
  String colorPrefix = "";
  if (promotingPawn.getTurn() == 1) {
    colorPrefix = "black-";
  }
  String[] options = {"queen", "rook", "bishop", "knight"};
  
  PImage[] images = new PImage[4];
  images[0] = loadImage(colorPrefix + "queen.png");
  images[1] = loadImage(colorPrefix + "rook.png");
  images[2] = loadImage(colorPrefix + "bishop.png");
  images[3] = loadImage(colorPrefix + "knight.png");
  
  int optionWidth = 80;
  int optionHeight = 90;
  int menuWidth = optionWidth * 4 + 20;
  int menuHeight = 130;
  int menuX = width/2 - menuWidth/2;
  int menuY = height/2 - menuHeight/2;
  
  fill(0, 0, 0, 150);
  rect(0, 0, width, height);
  
  fill(240);
  rect(menuX, menuY, menuWidth, menuHeight, 10);
  
  fill(0);
  textAlign(CENTER, CENTER);
  textSize(18);
  text("Promote pawn to:", width/2, menuY + 20);
  
  for (int i = 0; i < 4; i++) {
    int x = menuX + 10 + i * (optionWidth + 5);
    int y = menuY + 45;
    
    boolean mouseOver = mouseX > x && mouseX < x + optionWidth &&
                       mouseY > y && mouseY < y + optionHeight;
    if (mouseOver) {
      fill(200, 230, 255);
    } else {
      fill(255);
    }
    rect(x, y, optionWidth, optionHeight, 5);
    
    image(images[i], x + optionWidth/2 - 30, y + 5, 60, 60);
    
    fill(0);
    textSize(12);
    text(options[i], x + optionWidth/2, y + 75);
  }
}

void handlePromotionSelection() {
  String[] options = {"queen", "rook", "bishop", "knight"};
  int optionWidth = 80;
  int menuX = width/2 - (optionWidth * 4 + 20)/2;
  int menuY = height/2 - 50;
  
  for (int i = 0; i < 4; i++) {
    int x = menuX + 10 + i * (optionWidth + 5);
    int y = menuY + 40;
    
    if (mouseX > x && mouseX < x + optionWidth &&
        mouseY > y && mouseY < y + optionWidth - 20) {
      Position pos = promotingPawn.getLoc();
      int turn = promotingPawn.getTurn();
      Piece newPiece;
      
      if (options[i].equals("queen")) {
        newPiece = new Queen(turn, pos);
      } else if (options[i].equals("rook")) {
        newPiece = new Rook(turn, pos);
      } else if (options[i].equals("bishop")) {
        newPiece = new Bishop(turn, pos);
      } else if (options[i].equals("knight")) {
        newPiece = new Knight(turn, pos);
      } else {
        newPiece = new Queen(turn, pos);
      }
      
      board.remove(promotingPawn);
      board.add(newPiece);
      isPromoting = false;
      promotingPawn = null;
      turn = (turn + 1) % 2;
      break;
    }
  }
}
