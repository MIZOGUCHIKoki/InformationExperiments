import java.util.*;

public class C4 {
  static public void main(String[] args) {
    Scanner scan = new Scanner(System.in);
    Random rand = new Random(0); //乱数は実行毎に同じ結果を得るため, 乱数のseed を0 に設定する
    Board b = new Board();

    boolean gameEnd = false; // ゲームが終わったか(終わったらTrue)
    boolean hasEmpty = true; // 空きマスがあるか(空きます存在したらTrue)
    int turn = 1;
    b.showBoard();// 盤面表示

    while (true) {
      int x = -1, y = -1;
      turn++;
      do {
        x = rand.nextInt(5);
        y = rand.nextInt(5);
      } while (b.isLegal(x, y));
      if(turn % 2 == 0){
        System.out.println("先手は " + x + " " + y + " に置きました");
      }else{
        System.out.println("後手は " + x + " " + y + " に置きました");
      }

      b.showBoard();// 盤面表示

      if(b.isWinning()) {// 勝利判定
        break;
      }

      if(!b.isEnd()){// 空白の有無判定
        hasEmpty = false;
        break;
      }
    }

    if (!hasEmpty) {
      System.out.println("引き分けです");
    } else if (turn % 2 == 0) {
      System.out.println("先手が勝ちました");
    } else {
      System.out.println("後手が勝ちました");
    }
  }
}
