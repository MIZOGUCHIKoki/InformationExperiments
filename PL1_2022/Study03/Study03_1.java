public class Study03_1 {
    public static void main(String[] args) {
        Human1 h1 = new Human1("工科大介", 100, 10, 10, 50);
        Parrot1 p1 = new Parrot1("シロッコくん", 30, 30, 40, 25);

        int tern = 0;
        h1.printStatus();
        p1.printStatus();
        while (true) {
            tern++;
            System.out.println("----------ターン" + tern + "----------");
            p1.defend(h1.attack());
            if (p1.getHp() <= 0) {
                System.out.println(p1.getName()+"はHPが0になった！");
                System.out.println(p1.getName() + "は倒れた・・・");
                break;
            }
            h1.defend(p1.attack());
            if (h1.getHp() <= 0) {
                System.out.println(h1.getName()+"はHPが0になった！");
                System.out.println(h1.getName() + "は倒れた・・・");
                break;
            }
        }
    }
}
