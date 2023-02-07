public class Human3 extends Animal2 {
    private int item;
    private double item_point;

    public Human3(String name, int hp, int power, int agility, int item, int defend) {
        super(name, hp, power, agility, defend);
        this.item = item;
        this.item_point = 1.4;
    }

    @Override
    public int attack() {
        int n = new java.util.Random().nextInt(100);
        if (this.item > n) {
            System.out.println(super.getName() + "は道具を使った！攻撃力" + this.item_point + "倍！");
            System.out.println(super.getName() + "の攻撃");
            return (int) (super.getPower() * item_point);
        } else {
            System.out.println(super.getName() + "の攻撃");
            return super.getPower();
        }
    }

    @Override
    public void printStatus() {
        super.printStatus();
        System.out.println("道具使用率：" + this.item);
    }

}
