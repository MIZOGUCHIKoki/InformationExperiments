public class Study01_3 {
    public static void main(String[] args) {
        while (true) {
            System.out.print("1以上1000以下の自然数もしくは exit を入力してください:");
            String input = new java.util.Scanner(System.in).nextLine();
            if (input.equals("exit"))// "exit"が入力されたらWhileループを抜けて終了する
                break;
            int number = Integer.parseInt(input);// inputをInt型に変換してnumberへ代入
            if (number == 1) {// 1が入力されたら，1=1と返す
                System.out.println("1 = 1");
                continue;
            } else if (number < 1 || 1000 < number) {
                System.out.println("1以上1000以下の値を入力してください");
                continue;
            }
            System.out.print(number + " = ");

            int factorialCounter = 1;// 階乗のカウンタ

            for (int i = 2; i <= number; i++) {
                if (number % i == 0) {// numberをiで割った剰余が0ならば，numberはその数を素因数にもつ
                    number = number / i;// numberにnumberをiで割った商を代入
                    if (number % i == 0) {// もう一度同じ数で割った剰余が0ならば，カウンタをインクリメント
                        factorialCounter++;
                    } else {
                        printPrimeFactor(number, i, factorialCounter);// 素因数を出力するメソッドへ．
                        factorialCounter = 1;// カウンタをリセット
                    }
                    i = 1;
                }
            }
            System.out.println();// 改行する
        }
    }

    public static void printPrimeFactor(int number, int i, int factorialCounter) {
        if (number == 1) {// その素因数が最大の時
            if (factorialCounter == 1) {// その素因数が1乗の時
                System.out.print(i);
            } else {
                System.out.print(i + "^" + factorialCounter);
            }
        } else {// その素因数が最大でない時
            if (factorialCounter == 1) {// その素因数が1乗の時
                System.out.print(i + " * ");
            } else {
                System.out.print(i + "^" + factorialCounter + " * ");
            }
        }
    }
}