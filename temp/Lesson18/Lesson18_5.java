public class Lesson18_5 {
    public static void main(String[] args) {
        DoublyLinkedList list1 = new DoublyLinkedList();
        list1.insert(1, "A");
        list1.insert(2, "B");
        list1.insert(3, "C");
        list1.insert(4, "D");
        list1.insert(5, "E");
        System.out.println("/*   list1 length:" + list1.getLength() + "   */");
        list1.printAll();

        System.out.println("Split list1 at index2.");
        DoublyLinkedList list2 = list1.split(2);

        System.out.println("/*   list1 length:" + list1.getLength() + "   */");
        list1.printAll();

        System.out.println("/*   list2 length:" + list2.getLength() + "   */");
        list2.printAll();

        System.out.println("Split list2 at index3.");
        DoublyLinkedList list3 = list2.split(3);
        
        System.out.println("/*   list2 length:" + list2.getLength() + "   */");
        list2.printAll();

        System.out.println("/*   list3 length:" + list3.getLength() + "   */");
        list3.printAll();

        System.out.println("Split list2 at index-1.");
        DoublyLinkedList list4 = list2.split(-1);

        System.out.println("/*   list2 length:" + list2.getLength() + "   */");
        list2.printAll();
        
        System.out.println("/*   list4 length:" + list4.getLength() + "   */");
        list4.printAll();

    }
}
