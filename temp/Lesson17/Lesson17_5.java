public class Lesson17_5 {
  public static void main(String[] args) {
    SimpleLinkedList list = new SimpleLinkedList();
    list.insert(1, "Gamma");
    list.insert(1, "Beta");
    list.insert(1, "Alpha");
    list.insert(1, 5);
	  list.insert(1, 4);
    list.insert(1, "DDD");
    list.insert(1, "CCC");
    list.insert(1, "BBB");
    list.insert(1, "AAA");
    list.insert(1, 3);
    list.insert(1, 2);
    list.insert(1, 1);
    list.printAll();

    System.out.println("\n[ list cut from 0th to 1st ]");
    list.cut(0, 1);
    System.out.println("[ list cut from 100th to 150th ]");
    list.cut(100, 150);
    System.out.println("[ list cut from 3rd to 1st ]");
    list.cut(3, 1);

    System.out.println("\n[ list cut from 4th to 7th ]");
    list.cut(4, 7);
    list.printAll();
    System.out.println("length of list: " + list.getLength()+"\n");

    System.out.println("[ (new)list cut from 6th to 8th ]");
    list.cut(6, 8);
    list.printAll();
    System.out.println("length of list: " + list.getLength());
  }
}
