public class Hero extends Ally {
	private int hero_cit;// クリティカルヒットで用いる確率変数

	public Hero(String name, int hp, int atk) {
		super(name, hp, atk);
		this.hero_cit = 10;
	}

	public void heroAttack(Satan satan) {
		if (super.judge(hero_cit) == true) {
			System.out.println(">>" + super.getName() + "の攻撃！");
			System.out.println(">>クリティカルヒット！");
			satan.damage(super.getAtk() * 2);
		} else {
			super.attack(satan);
		}
    super.resetStatus();
	}
}
