class sort {
    static int[] data = { 1, 10, 100, 3, 30, 300, 2, 20, 200, 3, 30, 300, 0, 00, 000, 2, 20, 200 };
    static int sot = 3;
    static int length = data.length;

    public static void main(String[] args) {
        sort();
        for (int i = 0; i < length; i++) {
            System.out.print(data[i] + " ");
            if (i % 3 == 2) {
                System.out.print(", ");
            }
        }
        System.out.println();
    }

    public static void sort() {
        for (int i = length - sot; i > 0; i -= sot) {
            int max = data[0];
            int max_indent = 0;
            for (int j = sot; j <= i; j += sot) {
                if (data[j] >= max) {
                    max = data[j];
                    max_indent = j;
                }
            }
            for (int k = 0; k < sot; k++) {
                int m = data[max_indent + k];
                data[max_indent + k] = data[i + k];
                data[i + k] = m;
            }
        }
    }
}