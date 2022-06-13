public class Monk extends Ally implements Member{

    private int revival;// 回復HPの指数

    public Monk(String name, int hp, int atk) {
        super(name, hp, atk);
        this.revival = 20;
    }

    public void skill(Character c) {
        super.printUseSkill();
        System.out.println(">>" + super.getName() + "の回復魔法！");
        if (c.getHp() + revival > c.getDefHp()) {
            c.setHp(c.getDefHp());
            System.out.println(c.getName() + "残りHP : " + c.getHp());
        } else {
            c.setHp(revival + c.getHp());
            System.out.println(c.getName() + "残りHP : " + c.getHp());
        }
    }
}
