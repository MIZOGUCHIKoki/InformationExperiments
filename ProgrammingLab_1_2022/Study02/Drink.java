class Drink {

  private String name;
  private int price;

  public Drink(String name, int price) {// コンストラクタ
    this.name = name;
    if (price % 10 != 0) {
      System.out.println(this.name + "の金額を，10円単位で設定してください．");
      System.exit(0);
    } else {
      this.price = price;
    }
    this.name = name;
  }

  public String getName() {
    return this.name;
  }

  public int getPrice() {
    return this.price;
  }

}
