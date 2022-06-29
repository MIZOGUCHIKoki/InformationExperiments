public class SimpleLinkedListTest {
  public static void main(String[] args) {
    SimpleLinkedList list = new SimpleLinkedList();

    list.insert(1, "one");
    list.insert(1, "two");
    list.insert(2, "three");
    list.insert(2, "four");
    list.printAll();
    list.remove(3);
    list.insert(3, "five");
    list.printAll();
  }
}
