public class sort {
    static int[] data1 = new int[2];// 元々のデータ
    static int ndata = data1.length;// データの個数
    static int[] data1r = new int[ndata];// push_heap後
    static int size = 0;
    static int[] sortdata = new int[ndata];
    static int max = 0;
    static int k = 0;
    static int big = 0;

    public static void main(String[] args) {
      buble(data1);
    }

    private static void printArray(int[] array) {
        for (int i = 1; i < array.length; i++) {
            System.out.print(array[i] + " ");
        }
        System.out.println();
    }
    private static void buble(int[] data) {
        long startTime = System.nanoTime();
        int max_index = 0;
        for (int i = ndata - 1; i > 0; i--) {
            max = data[0];
            max_index = -0;
            for (int j = 1; j <= i; j++) {
                if (data[j] >= max) {
                    max = data[j];
                    max_index = j;
                }
            }
            int m = data[max_index];
            data[max_index] = data[i];
            data[i] = m;
        }
         long endTime = System.nanoTime();
         System.out.println("実行時間" + (endTime - startTime) + "ns");
    }
}
