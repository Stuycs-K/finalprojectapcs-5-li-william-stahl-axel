class Position {
  private int col; // 1 to 8
  private int row; // 1 to 8

  public Position(int col, int row) {
    this.col = constrain(col, 1, 8);
    this.row = constrain(row, 1, 8);
  }

  public int getX() {
    return (col - 1) * width / 8;
  }

  public int getY() {
    return (8 - row) * height / 8;
  }

  public int getCol() {
    return col;
  }

  public int getRow() {
    return row;
  }

  public void setCol(int c) {
    col = constrain(c, 1, 8);
  }

  public void setRow(int r) {
    row = constrain(r, 1, 8);
  }

  public boolean isPossible(int col,int row) {
    return col >= 1 && col <= 8 && row >= 1 && row <= 8;
  }

  public boolean equals(Position pos) {
    if (pos==null) return false;
    return this.col == pos.col && this.row == pos.row;
  }

  public String toString() {
    return "Position(col=" + col + ", row=" + row + ")";
  }

  
  public  Position cordToPos(int x, int y) {
    int col = constrain((int)(x * 8.0 / width) + 1, 1, 8);
    int row = constrain((int)(y * 8.0 / height) + 1, 1, 8);
    row = 9 - row;
    return new Position(col, row);
  }
}
