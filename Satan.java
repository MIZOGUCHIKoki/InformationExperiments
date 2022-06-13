public class Satan extends Character {
    private int satan_attack;// satanAttackで用いる確率変数


    public Satan(String name, int hp, int atk) {
        super(name, hp, atk);
        this.satan_attack = 30;
    }

    public void satanAttack(Ally[] party) {  
        if (super.judge(satan_attack) == true) {// ある確率で全攻撃
            System.out.println(super.getName() + "の全体攻撃！");
            for (int i = 0; i < party.length; i++) {
                if(party[i].getHp() >= 0) {
                    party[i].damage(super.getAtk());
                }
            }
        } else {// Heroのみに攻撃
            for (int i = 0; i < party.length; i++) {
                if (party[i] instanceof Hero) {
                    super.attack(party[i]);
                }
            }
        }
    }
}
