public class Ally extends Character {
    private static int IDcount = -1;
    private int ID;
    private int def_atk;

    public Ally(String name, int hp, int atk) {// コンストラクタ
        super(name, hp, atk);
        IDcount++;
        this.ID = IDcount;
        this.def_atk = atk;
    }

    @Override
    public void showStatus() {// IDをリセット
        super.showStatus();
        System.out.println("ID : " + this.ID);
    }

    public void resetStatus() {// Atkをリセット
        super.setAtk(def_atk);
    }

    public int getID() {
        return this.ID;
    }

    public void printUseSkill() {
        System.out.println(">>" + super.getName() + "はスキルを使った！");
    }
}
