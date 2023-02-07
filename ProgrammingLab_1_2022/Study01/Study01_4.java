public class Study01_4 {
    public static void main(String[] args) {
        String[] weekName = { "sun", "mon", "tue", "wed", "thu", "fri", "sat" };
        String[] week = { "土", "日", "月", "火", "水", "木", "金" };
        int weekShift = -1;
        if (args.length == 0 || args.length > 1) {// コマンドライン引数が不正の場合（入力なし，または，2つ以上の入力）にエラーを出し，終了
            printError(1);
            System.exit(0);
        }
        for (int i = 0; i < weekName.length; i++) {// コマンドライン引数で曜日シフト数を決定．
            if (args[0].equals(weekName[i])) {
                weekShift = i;
            }
        }
        if (weekShift == -1) {// コマンドライン引数が不正（weekName以外の値）の場合にエラーを出し，終了
            printError(1);
            System.exit(0);
        }

        while (true) {
            System.out.print("調べたい日付を入力してください(4月3日 => 4 3) : ");
            String input = new java.util.Scanner(System.in).nextLine();
            String[] dateStrings = input.split(" ");

            if (dateStrings.length > 2 || dateStrings.length <= 1) {// 3組以上または，1組以下の数の組み合わせが入力された場合に，次のInt型へ変換する際にエラーを起こさないようなシステム
                printError(2);
                continue;
            }

            int[] daysOfMoth = { 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31 };// index月が何日まであるか
            int inputMonth = Integer.parseInt(dateStrings[0]);
            int inputDay = Integer.parseInt(dateStrings[1]);

            if (inputDay == 0 && inputMonth == 0) {// 終了判定
                System.out.println("終了します");
                break;
            }

            if (judgeMothAndDate(inputMonth, inputDay, daysOfMoth) == false)continue;// 月日の組み合わせの不正判定
            int dayElapsed = daysElapsed(inputMonth, inputDay, daysOfMoth);// 1月1日からの経過日数を算出
            int mod7 = (dayElapsed + weekShift) % 7;
            System.out.println(inputMonth + "月" + inputDay + "日は，" + week[mod7] +"曜日です．");// 出力
        }
    }

    public static void printError(int i) {// 不正があった場合エラー分を吐く
        if (i == 0)
            System.out.println("調べたい日付が不正な組です");
        else if (i == 1)
            System.out.println("コマンドライン引数の値が不正です");
        else if (i == 2)
            System.out.println("調べたい日付が不正な入力です");
        else if (i == 3)
            System.out.println("演算できませんでした");
    }

    public static boolean judgeMothAndDate(int inputMonth, int inputDay, int[] daysOfMoth) {// 月日の組み合わせの判定（不正であればFalse）
        if (inputMonth > 12 || inputMonth < 1) {// 不正の条件
            printError(0);
            return false;
        }
        if (1 > inputDay || inputDay > daysOfMoth[inputMonth - 1]) {// 不正の条件
            printError(0);
            return false;
        }
        return true;
    }

    public static int daysElapsed(int inputMonth, int inputDay, int[] daysOfMoth) {// 1月1日からの経過日数を算出
        int daysElapsed = 0;
        for (int i = 0; i < inputMonth - 1; i++) {
            if (inputMonth == 1) {
                return inputDay;
            }
            daysElapsed += daysOfMoth[i];
        }
        daysElapsed += inputDay;
        return daysElapsed;
    }
}