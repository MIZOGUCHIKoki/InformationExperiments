public class Study01_2 {
    public static void main(String[] args) {
        while (true) {
            System.out.print("検索したい文字列を入力してください(終了時は入力なしで Enter):");
            String search = new java.util.Scanner(System.in).nextLine();
            if (search.equals("")) {// 終了するか否かの判断
                System.out.println("処理を終了します");
                break;
            }
            for (int i = 0; i < args.length; i++) {
                String[] splitArgs = args[i].split("");

                if (isExist(splitArgs, search) == true) {
                    System.out.println(args[i]);
                }
            }
        }
    }

    public static boolean isExist(String splitArgs[], String search) {// 検索メソッド（合致していればTrueを返す）
        int searchQuantity = search.length();// 検索文字数
        String compositeString = "";
        for (int i = 0; i + searchQuantity <= splitArgs.length; i++) {// 合成開始位置をシフト
            compositeString = "";// compositeStringを初期化
            for (int j = i; j < splitArgs.length; j++) {// splitArgs[i]~splitArgs[i + searchQuantitiy]を合成
                compositeString = compositeString + splitArgs[j];
                if (compositeString.equals(search))// 比較して同値であれば return true;
                    return true;
            }
        }
        return false;
    }
}