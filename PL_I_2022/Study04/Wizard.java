public class Wizard extends Ally implements Member {
    public Wizard(String name, int hp, int atk) {
        super(name, hp, atk);
    }

    public void skill(Character c) {
        printUseSkill();
        System.out.println(super.getName()+"が"+c.getName()+"の攻撃力を三倍にした！");
        c.setAtk(c.getAtk() * 3);
    }
}
