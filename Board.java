public class Board {
 private int[][] square;
 private int turn = 0;

  Board() {
    square = new int[5][5];
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        square[i][j] = 0;
      }
    }
  }

  // x,y に置くことができるか
  public boolean isLegal(int x, int y) {
    if (square[y][x] == 0) {
      turn ++;
      if(turn % 2 != 0) {// 先手処理
        square[y][x] = 1;
      } else {// 後手処理
        square[y][x] = 2;
      }
      return false;
    }
    return true;
  }

  // ゲームの終了判定 : 置ける場所がない（勝敗がついた時とは別）
  public boolean isEnd() {// 空白あり（true）
    for (int nx=0;nx<5;nx++) {
      for (int ny=0;ny<5;ny++) {
        if (square[ny][nx] == 0) {
          return true;// 空白あり
        }
      }
    }
    return false;// 空白なし
  }

  // 最後に着手したプレイヤが勝った（4目並べた）か判定
  public boolean isWinning() {
      for (int ny=0; ny<5; ny++) {
        int numx = 0;
        for (int nx=0; nx<5; nx++) {
          if (square[ny][nx] == 1) {
            numx++;
            if (numx == 4) {
              return true;// Win
            }
          } else {
            numx = 0;
          }
        }
      }

      for (int nx=0; nx<5; nx++) {
        int numy = 0;
        for (int ny=0; ny<5; ny++) {
          if (square[ny][nx] == 1) {
            numy++;
            if (numy == 4) { return true; }
          } else { numy = 0; }
        }
      }
    return false;
  }

  // 盤面表示
  public void showBoard() {
    for (int i = 0; i < 5; i++) {
      for (int j = 0; j < 5; j++) {
        switch (square[i][j]) {
          case 0:
            System.out.print("_");
            break;
          case 1:
            System.out.print("o");
            break;
          case 2:
            System.out.print("x");
            break;
        }
      }
      System.out.println();
    }
  }
}
