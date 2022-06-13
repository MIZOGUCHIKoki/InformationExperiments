public class Study01_1 {
    public static void main(String[] args) {
        int input = Integer.parseInt(args[0]);
        String[][] array = new String[input * 2 + 1][];// 配列の"行"を作成

        for (int i = 0; i < array.length; i++) {// 配列の"列"を作成
            if (i < input) {
                array[i] = new String[input * 2 + 1 - i];// 無駄のないように，必要な配列のみ作成．
            } else {
                array[i] = new String[i + 1];
            }
        }

        for (int i = 0; i < array.length; i++) {
            if (i <= input) {// 逆三角形の処理
                for (int j = 0; j + i < array[i].length; j++) {
                    array[i][j + i] = "*";
                }
            } else {// 三角形の処理
                for (int j = 0; array.length - i - 1 + j < array[i].length; j++) {
                    array[i][array.length - i - 1 + j] = "*";
                }
            }
        }
        searchNull(array);// null検索
        printArray(array);// 出力
    }

    public static void printArray(String array[][]) {// 配列を出力するメソッド
        for (int i = 0; i < array.length; i++) {
            for (int j = 0; j < array[i].length; j++) {
                System.out.print(array[i][j]);
            }
            System.out.println();
        }
    }

    public static void searchNull(String array[][]) {// 配列の要素がNullだった場合にスペースに変換するメソッド
        for (int i = 0; i < array.length; i++) {
            for (int j = 0; j < array[i].length; j++) {
                if (array[i][j] == null) {
                    array[i][j] = " ";
                }
            }
        }
    }
}
