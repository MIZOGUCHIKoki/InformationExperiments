public class Lesson18_2 {
    public static void main(String[] args) {
        DoublyLinkedList list = new DoublyLinkedList();
        list.insert(1, "A");
        list.insert(2, "B");
        list.insert(3, "C");
        list.insert(4, "D");

        System.out.println("/*   printAll   */");
        list.printAll();
        System.out.println("/*   printAllReverse   */");
        list.printAllReverse();
    }
}
