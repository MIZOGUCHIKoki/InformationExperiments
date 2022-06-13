public class Human1 {
    private String name;
    private int hp;
    private int power;
    private int agility;
    private int item;
    private int def_hp;
    private double item_point;

    public Human1(String name, int hp, int power, int agility, int item) {
        this.name = name;
        this.hp = hp;
        this.power = power;
        this.agility = agility;
        this.item = item;
        this.def_hp = hp;
        this.item_point = 1.4;
    }

    public int attack() {
        System.out.println(this.name + "の攻撃");
        int n = new java.util.Random().nextInt(100);
        if (this.item > n) {
            System.out.println(this.name + "は道具を使った！攻撃力" + this.item_point + "倍！");
            return (int) (this.power * this.item_point);
        } else {
            return this.power;
        }
    }

    public void defend(int damage) {
        int n = new java.util.Random().nextInt(100);
        if (this.agility > n) {
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
        System.out.println("道具使用率：" + this.item);
    }

    public int getHp() {
        return this.hp;
    }

    public String getName() {
        return this.name;
    }
}
