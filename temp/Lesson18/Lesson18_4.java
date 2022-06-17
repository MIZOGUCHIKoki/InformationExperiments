public class Lesson18_4 {
        public static void main(String[] args) {
          DoublyLinkedList list = new DoublyLinkedList();
          list.insert(1, "A");
          list.insert(2, "garbage");
          list.insert(3, "B");
          list.insert(4, "garbage");
          list.insert(5, "C");
          list.insert(6, "garbage");
          list.insert(7, "D");
          System.out.println("/*   list with a lot of garbage   */");
          list.printAll();
          System.out.println("/*   remove garbage at first   */");
          if(list.removeFromFirst("garbage")) list.printAll();
          else System.out.println("/*   didn't find garbage     */");
    
          System.out.println("/*   remove garbage at last   */");
          if(list.removeFromLast("garbage")) list.printAll();
          else System.out.println("/*   didn't find garbage     */");

          System.out.println("/*   remove dust at first   */");
          if(list.removeFromLast("dust")) list.printAll();
          else System.out.println("/*   didn't find dust     */");
        }
    }
    
