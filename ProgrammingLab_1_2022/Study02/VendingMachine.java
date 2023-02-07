class VendingMachine {

  private int money_exist = 0;
  int index_length = 5;
  int[] stock_drink = new int[index_length];
  Drink[] data_drink = new Drink[index_length];

  public void registDrink(int index, Drink drink, int stock) {
    if (data_drink[index - 1] == null) {
      data_drink[index - 1] = drink;
      stock_drink[index - 1] = stock;
      System.out.println(index + "番目に「" + drink.getName() + "」を" + stock + "個登録しました");
    } else {
      System.out.println(index + "番目には既に飲み物が登録されています");
    }
  }

  public void printInfo() {
    System.out.printf("\n\n");
    System.out.println("====================");
    for (int i = 0; i < index_length; i++) {
      if (data_drink[i] == null) {
        System.out.println(i + 1 + "番 -----未登録-----");
      } else {
        if (stock_drink[i] == 0) {
          System.out.println(
              i + 1 + "番 " + data_drink[i].getName() + " " + data_drink[i].getPrice() + "円 売切");
        } else {
          System.out.println(
              i + 1 + "番 " + data_drink[i].getName() + " " + data_drink[i].getPrice() + "円 " + stock_drink[i] + "個");
        }
      }
    }
    System.out.println("====================");
    System.out.println("現在" + money_exist + "円入っています");
  }

  public void insertMoney(int money) {
    money_exist += money;
    System.out.println("現在" + money_exist + "円入っています");
  }

  public void buyDrink(int index) {
    if (index > index_length || data_drink[index - 1] == null) {
      buyDrinkError(index + "番には飲み物が登録されていません");
    } else if (money_exist < data_drink[index - 1].getPrice()) {
      buyDrinkError("お金が足りません");
    } else if (stock_drink[index - 1] <= 0) {
      buyDrinkError("売り切れています");
    } else {
      System.out.println(index + "番の「" + data_drink[index - 1].getName() + "」を購入しました");
      money_exist -= data_drink[index - 1].getPrice();
      stock_drink[index - 1]--;
    }
  }

  public void buyDrinkError(String message) {
    System.out.println("購入できませんでした（" + message + "）");
  }

  public void returnMoney() {
    System.out.println(money_exist + "円のお釣りを出力しました");
    money_exist = 0;
  }
}
