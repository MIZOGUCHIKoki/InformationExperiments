public class Human2 extends Animal1 {
    private int item;
    private double item_point;

    public Human2(String name, int hp, int power, int agility, int item) {
        super(name, hp, power, agility);
        this.item = item;
        this.item_point = 1.4;
    }

    @Override
    public int attack() {
        System.out.println(super.getName() + "の攻撃");
        int n = new java.util.Random().nextInt(100);
        if (this.item > n) {
            System.out.println(super.getName() + "は道具を使った！攻撃力" + this.item_point + "倍！");
            return (int)(super.getPower() * item_point);
        } else {
            return super.getPower();
        }
    }
    
    @Override
    public void printStatus() {
        super.printStatus();
        System.out.println("道具使用率：" + this.item);
    }

}
