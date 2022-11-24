public class Animal1 {
    private String name;
    private int hp;
    private int power;
    private int agility;
    private int def_hp;

    public Animal1(String name, int hp, int power, int agility) {
        this.name = name;
        this.hp = hp;
        this.power = power;
        this.agility = agility;
        this.def_hp = hp;
    }

    public int attack() {
        System.out.println(this.name + "の攻撃");
        return this.power;
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
    }

    public String getName() {
        return this.name;
    }

    public int getPower() {
        return this.power;
    }

    public int getHp() {
        return this.hp;
    }

    public void setHp(int hp) {
        this.hp = hp;
    }

    public int getAgility() {
        return this.agility;
    }

    public int getDef_hp() {
        return this.def_hp;
    }
}
