[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/YxXKqIeT)
# Project Description

This project is a remake of the well known game of chess. The game allows for a user to play against someone else by alternating mouse clicks. Our project works the same as the normal game of chess, including illegal moves, castling, en passant, pawn promotion, check/checkmate and also stalemate detection. Running the project displays a chess board on screen with the arranged pieces.

# Intended usage:

To play chess, start by simply clicking a piece to move.
If there are any legal moves for a piece it will be shown on the board.
Start as white, after moving, white will play.
This will continue until the game ends by either stalemate or checkmate.
Standard legal moves will be shown, including castles, en passant, and promotion.

To start from a custom position, you can add a file named `board.txt` to `Chess/data/`.
The board's syntax is as follows:
 - Each line represents a piece
 - Each line includes information seperated by spaces: `piece_name turn_number x_cord y_cord`
 - `piece_name` is `pawn`, `rook`, `knight`, `bishop`, `king`, `queen`
 - `turn_number`: `0`: white, `1`: black
 - `x_cord`/`y_cord` range from `1`-`8`. `1` `1` starts on the bottom left and increases.
