public class Lesson18_3 {
    public static void main(String[] args) {
        DoublyLinkedList list = new DoublyLinkedList();
        list.insert(1, args[0]);
        list.insert(2, args[1]);
        list.insert(3, args[2]);
        list.insert(4, args[3]);
        System.out.println("/*   list length:" + list.getLength() + "   */");
        list.printAll();
        System.out.println("/*   search   */");
        System.out.println("search \"D\" : " + list.searchForward("D"));
        System.out.println("search \"A\" : " + list.searchForward("A"));
        System.out.println("search \"C\" : " + list.searchForward("C"));
        System.out.println("search \"B\" : " + list.searchBackward("B"));
        System.out.println("search \"E\" : " + list.searchBackward("E"));
        list.remove(1);
        list.remove(1);
        list.remove(1);
        list.remove(1);
        System.out.println("/*   list length:" + list.getLength() + "   */");
        list.printAll();
    }

}
