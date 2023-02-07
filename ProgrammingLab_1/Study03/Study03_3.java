public class Study03_3 {
    public static void main(String[] args) {
        Human3 h3_1 = new Human3("工科大介", 100, 10, 10, 50, 10);
        Parrot3 p3_1 = new Parrot3("シロッコくん", 30, 30, 40, 25, 10);

        int tern = 0;
        h3_1.printStatus();
        p3_1.printStatus();
        while (true) {
            tern++;
            if (tern == 5) {
                hyperMode(h3_1, p3_1);
            }
            System.out.println("----------ターン" + tern + "----------");
            p3_1.defend(h3_1.attack());
            if (p3_1.getHp() <= 0) {
                System.out.println(p3_1.getName() + "はHPが0になった！");
                System.out.println(p3_1.getName() + "は倒れた・・・");
                break;
            }
            h3_1.defend(p3_1.attack());
            if (h3_1.getHp() <= 0) {
                System.out.println(h3_1.getName() + "はHPが0になった！");
                System.out.println(h3_1.getName() + "は倒れた・・・");
                break;
            }
        }
    }

    public static void hyperMode(Human3 h, Parrot3 p) {
        System.out.println("*****サドンデス*****");
        h.setHighPower(2);
        p.setHighPower(2);
        if (h.getHp() == 1) {
            h.setHp(1);
        } else {
            h.setHp((int) (h.getHp() / 2));
        }
        if (p.getHp() == 1) {
            p.setHp(1);
        } else {
            p.setHp((int) (p.getHp() / 2));
        }
        h.printStatus();
        p.printStatus();
        System.out.println("*****");
    }
}
