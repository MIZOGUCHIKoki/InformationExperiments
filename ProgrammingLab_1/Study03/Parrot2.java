public class Parrot2 extends Animal1{
    private int fly;

    public Parrot2(String name, int hp, int power, int agility, int fly) {
        super(name, hp, power, agility);
        this.fly = fly;
    }

    @Override
    public void defend(int damage) {
        int n = new java.util.Random().nextInt(100);
        int m = new java.util.Random().nextInt(100);
        if (this.fly > n) {
            System.out.println("しかし，" + super.getName() + "は空を飛んで攻撃を回避した！");
        } else if (super.getAgility() > m) {
            System.out.println("しかし，" + super.getName() + "は攻撃を回避した！");
        } else {
            super.setHp(getHp() - damage);
            if (super.getHp() < 0) {
                super.setHp(0);
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
