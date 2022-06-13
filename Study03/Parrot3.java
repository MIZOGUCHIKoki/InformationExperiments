public class Parrot3 extends Animal2 {
    private int fly;

    public Parrot3(String name, int hp, int power, int agility, int fly, int defend) {
        super(name, hp, power, agility, defend);
        this.fly = fly;
    }

    @Override
    public void defend(int damage) {
        int n = new java.util.Random().nextInt(100);
        int m = new java.util.Random().nextInt(100);
        if (damage - super.getDefense() <= 0) {
            damage = 1;
        } else {
            damage -= super.getDefense();
        }
        if (this.fly > n) {
            System.out.println("しかし，" + super.getName() + "は空を飛んで攻撃を回避した！");
        } else if (super.getAgility() > m) {
            System.out.println("しかし，" + super.getName() + "は攻撃を回避した！");
        } else {
            if (super.getHp() - damage < 0) {
                super.setHp(0);
            } else {
                super.setHp(super.getHp()-damage);
            }
            System.out.println(super.getName() + "に " + damage + " のダメージ！ HP（" + super.getHp() + "/" + super.getDef_hp() + "）");
        }
    }

    @Override
    public void printStatus() {
        super.printStatus();
        System.out.println("飛行率：" + this.fly);
    }
}
