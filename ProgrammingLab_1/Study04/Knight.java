public class Knight extends Ally implements Member{

    public Knight(String name, int hp, int atk) {
        super(name, hp, atk);
    }

    @Override
    public void skill(Character c) {
        super.printUseSkill();
        super.setAtk(super.getAtk() * 2);
        super.attack(c);
        super.resetStatus();
    }
}
