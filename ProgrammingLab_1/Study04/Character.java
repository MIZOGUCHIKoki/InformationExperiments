public class Character {
	private String name;
	private int hp;
	private int atk;
	private int rand;
	private int def_hp;

	public Character(String name, int hp, int atk) {
		this.name = name;
		this.hp = hp;
		this.atk = atk;
    this.def_hp = hp;
	}

	public void damage(int atk) {// atk分のダメージを受ける処理
		this.hp -= atk;
		System.out.println(">>" + this.name + "に" + atk + "のダメージ！");
		if (this.hp <= 0) {
      this.hp = 0;
		}
    System.out.println(this.name + "残りHP : " + this.hp);
	}

	public void attack(Character c) {// Characterに攻撃する
		System.out.println(">>" + this.name + "の攻撃！");
		c.damage(this.atk);
	}

	public void showStatus() {
		System.out.println(this.name + "のステータス   HP : " + this.hp + "   ATK : " + this.atk);
	}

	public boolean judge(int odd) {
		rand = new java.util.Random().nextInt(99);
		if (rand < odd) {
			return true;
		}
		return false;
	}

	public String getName() {
		return this.name;
	}

	public int getDefHp() {
		return this.def_hp;
	}

	public int getHp() {
		return this.hp;
	}

	public void setHp(int set) {
    this.hp = set;
	}

	public int getAtk() {
		return this.atk;
	}

	public void setAtk(int set) {
		this.atk = set;
	}
}
