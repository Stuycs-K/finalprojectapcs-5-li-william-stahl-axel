
# Technical Details:

PERIOD 5
William Li, Axel Stahl
Willexa
#### Project Description
Chess game. 8x8 grid with the standard setup in classical chess. 
Only legal moves allowed. Recognizes when a player wins, loses, or stalemates.
Displays possible moves. Has a timer for each side. Moves can only be made on your turn.
#### Expanded Description
**Critical features (Minimum Viable Product)**: Chess game that only allows legal moves and recognizes state (win/lose/stalemate).
**Nice to have features**: 
 - shows possible moves for piece
 - clock for each side with options for times.
 - show red when you are check/checkmate

# Project Design
![UML_General](https://github.com/user-attachments/assets/79ec5cd5-d28b-4991-bf71-fc19c1d79392)
![image](https://github.com/user-attachments/assets/08adae71-56a7-4fe9-8ada-6cfc4421efbe)
![image](https://github.com/user-attachments/assets/ed014005-948c-4dd8-b5d2-fff3c90741d8)

UML Diagrams and descriptions of key algorithms, classes, and how things fit together.


    
# Intended pacing:

- Position 5/27
- Piece abstract class 5/28
- Pieces subclasses 5/28
- Board setup() 5/29
- Board hints 5/30
- Board move/removePiece() 5/31
- Board move() 6/1
- Board checkState()/endGame() 6/1


TODO:
 - draw(): draw board. draw pieces.
 - getHints(Piece): Piece.getMoves(), then display those moves. get capture moves with getCaptures(). If the position has a piece in it, check if it is in getCaptures. add all these moves that pass into getHints()
 - showHints(): loop through hints, display gray semi-transparent circle on square. 
 - clearHints(): remove hints
 - movePiece(Position, Piece): if Position has piece, remove piece from board. Piece.moveTo(Position). clearHints(); draw();
 - mouseClick(): get Position from mouseX,mouseY. if Position in hints, movePiece(Position). if Position not in hint arr and hints arr full, clearHints(). If hints empty, getHints(); showHints;.


Fixes:
- check, checkmate
- going through pieces: have a function that has checks for vertical, horizontal, diagonal 
