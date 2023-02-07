public class Parrot1 {
    private String name;
    private int hp;
    private int power;
    private int agility;
    private int fly;
    private int def_hp;

    public Parrot1(String name, int hp, int power, int agility, int fly) {
        this.name = name;
        this.hp = hp;
        this.power = power;
        this.agility = agility;
        this.fly = fly;
        this.def_hp = hp;
    }

    public int attack() {
        System.out.println(this.name + "の攻撃");
        return this.power;
    }

    public void defend(int damage) {
        int n = new java.util.Random().nextInt(100);
        int m = new java.util.Random().nextInt(100);
        if (this.fly > n) {
            System.out.println("しかし，" + this.name + "は空を飛んで攻撃を回避した！");
        } else if (this.agility > m) {
            System.out.println("しかし，" + this.name + "は攻撃を回避した！");
        } else {
            if (this.hp - damage < 0) {
                this.hp = 0;
            } else {
                this.hp -= damage;
            }
            System.out.println(this.name + "に " + damage + " のダメージ！ HP（" + this.hp+ "/" + this.def_hp + "）");
        }
    }

    public void printStatus() {
        System.out.println("---" + this.name + "---");
        System.out.println("HP：" + this.hp);
        System.out.println("攻撃力：" + this.power);
        System.out.println("回避率：" + this.agility);
        System.out.println("飛行率：" + this.fly);
    }

    public int getHp() {
        return this.hp;
    }

    public String getName() {
        return this.name;
    }
}
