public class Study01_5 {
    public static void main(String[] args) {
        if (args.length != 2) {
            System.out.println("コマンドライン引数は2つです");
            System.exit(0);
        }

        int firstNumber = Integer.parseInt(args[0]);
        int secondNumber = Integer.parseInt(args[1]);
        int linesCounter = 0;

        if (firstNumber > 1000 || firstNumber < 1 || secondNumber > 1000 || secondNumber < 1) {
            System.out.println("コマンドライン引数は1以上1000以下を入力してください");
            System.exit(0);
        }

        System.out.print("=============");
        System.out.printf("%4d", firstNumber);
        System.out.print("から");
        System.out.printf("%4d", secondNumber);
        System.out.print("までの素数");
        System.out.println("=============");

        if (firstNumber < secondNumber) {// 昇順
            for (int i = firstNumber; i <= secondNumber; i++) {
                if (isPrime(i) == true) {
                    System.out.printf("%4d", i);
                    if (linesCounter == 11) {// 改行判断
                        System.out.println();
                        linesCounter = 0;
                    } else {
                        linesCounter++;
                    }
                }

            }
        } else {// 降順
            for (int i = firstNumber; i >= secondNumber; i--) {
                if (isPrime(i) == true) {
                    System.out.printf("%4d", i);
                    if (linesCounter == 11) {// 改行判断
                        System.out.println();
                        linesCounter = 0;
                    } else {
                        linesCounter++;
                    }
                }
            }
        }

        if (linesCounter == 0) {// 最後の数値が12列目か否かでLINE
            System.out.println("================================================");
        } else {
            System.out.println();
            System.out.println("================================================");
        }
    }

    public static boolean isPrime(int i) {// 素数か否か判定するメソッド（素数であればTrue）
        if (i == 1) {
            return false;
        }
        if (i % 2 == 0 && i != 2) {
            return false;
        }
        double sqrtI = Math.sqrt(i);
        for (int j = 3; j <= sqrtI; j += 2) {
            if (i % j == 0) {
                return false;
            }
        }
        return true;
    }
}