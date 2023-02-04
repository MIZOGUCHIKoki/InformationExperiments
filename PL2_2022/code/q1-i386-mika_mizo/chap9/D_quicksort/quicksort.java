public class QuickSortTest {
    public static void main(String[] args) {
        int[] data = {5, 10, 3, 7, 8, 1, 9, 2};
        print_data(data);
        quick_sort(data, 0, data.length-1);
        print_data(data);
    }
    // 配列dのleftからrightまでの間のデータ列をクイックソートする
    static void quick_sort(int[] data, int left, int right) {
        if (left>=right) {
            return;
        }
        int p = data[(right+left)/2];
        int l = left;
        int r = right;
        int tmp;
        while(l<=r) {
            while(data[l] < p) { l++; }
            while(data[r] > p) { r--; }
            if (l<=r) {
                tmp = data[l]; 
                data[l] = data[r];
                data[r] = tmp;
                l++; 
                r--;
            }
        }
        quick_sort(data, left, r);  // ピボットより左側をクイックソート
        quick_sort(data, l, right); // ピボットより右側をクイックソート
    }

    // 配列内のデータ列を表示する
    static void print_data(int[] d) {
        for(int i = 0; i < d.length; i++) System.out.print(d[i] + " ");
        System.out.println();
    }
}

