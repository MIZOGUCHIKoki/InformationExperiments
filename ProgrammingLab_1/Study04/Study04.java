public class Study04 {
    public static void main(String[] args) {
        int input;
        int party_index = 0;
        int hero_index = 0;

        Ally[] ch = new Ally[4];
        Satan satan = new Satan("魔王", 200, 30);

        ch[0] = new Hero("勇者", 100, 25);
        ch[1] = new Knight("騎士", 150, 20);
        ch[2] = new Monk("僧侶", 80, 5);
        ch[3] = new Wizard("魔術師", 80, 10);

        for (int i = 0; i < ch.length; i++) {
            ch[i].showStatus();
            if (ch[i] instanceof Hero) {
                hero_index = i;
            }
        }

        while (true) {
            System.out.println(">>連れていく仲間を選んでください（IDを入力）");
            System.out.print("ID: ");
            input = new java.util.Scanner(System.in).nextInt();
            if (input >= ch.length ) {
              System.out.println("正しいIDを入力してください");
              continue;
            }
            for (int i = 0; i < ch.length; i++) {
                if (ch[i].getID() == input) {
                    System.out.println();
                    party_index = i;
                    break;
                }
            }
            if (!(ch[party_index] instanceof Hero)) {
                System.out.println(">>" + ch[party_index].getName() + "が仲間になった！");
                System.out.println();
                break;
            } else {
                System.out.println("Heroクラス以外のメンバを選択してください");
            }

        }

        System.out.println(">>現在のパーティ");
        ch[hero_index].showStatus();
        ch[party_index].showStatus();
        System.out.println(">>" + satan.getName() + "が現れた！");
        satan.showStatus();

        battle(ch[party_index], ch[hero_index], satan);
    }

    public static void battle(Ally ally, Ally hero, Satan satan) {
        int turn = 0;
        Ally[] allies = { hero, ally };
        System.out.println("----------BATTLE START----------");
        while (true) {
            turn++;
            System.out.println("ラウンド " + turn);
            if (ally.getHp() > 0) {
              if (turn % 2 == 0) {
                if (ally instanceof Knight) {
                  ((Knight) ally).skill(satan);
                } else if (ally instanceof Monk) {
                  ((Monk) ally).skill(hero);
                } else if (ally instanceof Wizard) {
                  ((Wizard) ally).skill(hero);
                }
              } else {
                ally.attack(satan);
                if (judgeHp(satan) == true) {
                  System.out.println("-----YOU WIN-----");
                  break;
                }
              }
            }
            ((Hero) hero).heroAttack(satan);
            if (judgeHp(satan) == true) {
              System.out.println("-----YOU WIN-----");
              break;
            }
            System.out.println();
            satan.satanAttack(allies);
            if (judgeHp(hero) == true) {
                
                System.out.println("-----YOU LOSE-----");
                break;
            }
            System.out.println();
            System.out.println();
        }
    }

    public static boolean judgeHp(Character c) {
        if (c.getHp() <= 0) {
            System.out.println();
            System.out.println();
            System.out.println(">>" + c.getName() + "倒れた！");
            return true;
        }
        return false;
    }
}
