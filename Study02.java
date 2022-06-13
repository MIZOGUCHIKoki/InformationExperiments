public class Study02 {
  public static void main(String[] args) {
    VendingMachine vm = new VendingMachine();

    Drink drink1 = new Drink("ソーダ", 130);
    Drink drink2 = new Drink("コーラ", 130);
    Drink drink3 = new Drink("天然水", 100);
    Drink drink4 = new Drink("烏龍茶", 120);

    vm.registDrink(1, drink1, 1);
    vm.registDrink(1, drink1, 2);
    vm.registDrink(2, drink2, 2);
    vm.registDrink(3, drink3, 5);
    vm.registDrink(5, drink4, 2);

    while (true) {
      vm.printInfo();
      if (menuScreen(vm) == false) {
        break;
      }
    }

  }

  public static boolean menuScreen(VendingMachine vm) {
    while (true) {
      System.out.printf("\n\n");
      System.out.println("行いたい操作を指定してください");
      System.out.print("(1：お金の投入， 2：飲み物の購入，3：お釣りの返却，4：終了) > ");
      int input = new java.util.Scanner(System.in).nextInt();

      switch (input) {
        case 1:
          System.out.print("投入する金額を指定してください > ");
          int insert_money = new java.util.Scanner(System.in).nextInt();
          if (insert_money % 10 != 0) {
            System.out.println(insert_money % 10 + "円が出力");
            insert_money = insert_money - insert_money % 10;
          }
          System.out.println(insert_money + "円を投入しました");
          vm.insertMoney(insert_money);
          break;
        case 2:
          System.out.print("購入する飲み物の番号を指定してください > ");
          int index = new java.util.Scanner(System.in).nextInt();
          vm.buyDrink(index);
          return true;
        case 3:
          vm.returnMoney();
          break;
        default:
          return false;
      }

    }
  }
}
