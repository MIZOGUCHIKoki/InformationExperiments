public class Study03_2 {
    public static void main(String[] args) {
        Human2 h2_1 = new Human2("工科大介", 100, 10, 10, 50);
        Parrot2 p2_1 = new Parrot2("シロッコくん", 30, 30, 40, 25);

        int tern = 0;
        h2_1.printStatus();
        p2_1.printStatus();
        while (true) {
            tern++;
            System.out.println("----------ターン" + tern + "----------");
            p2_1.defend(h2_1.attack());
            if (p2_1.getHp() <= 0) {
                System.out.println(p2_1.getName() + "はHPが0になった！");
                System.out.println(p2_1.getName() + "は倒れた・・・");
                break;
            }
            h2_1.defend(p2_1.attack());
            if (h2_1.getHp() <= 0) {
                System.out.println(h2_1.getName() + "はHPが0になった！");
                System.out.println(h2_1.getName() + "は倒れた・・・");
                break;
            }
        }
    }
}
