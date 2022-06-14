public class Lesson17_4 {
	public static void main(String[] args) {
		SimpleLinkedList list1 = new SimpleLinkedList();
		list1.insert(1, 5);
		list1.insert(1, 4);
		list1.insert(1, 3);
		list1.insert(1, 2);
		list1.insert(1, 1);
		System.out.println("[list1]");
		list1.printAll();

		SimpleLinkedList list2 = new SimpleLinkedList();
		list2.insert(1, "K");
		list2.insert(1, "F");
		list2.insert(1, "A");
		System.out.println("[list2]");
		list2.printAll();

		SimpleLinkedList list3 = new SimpleLinkedList();
		System.out.println("[list3]\n");
		list3.printAll();
		System.out.println("length of list1: " + list1.getLength());
		System.out.println("length of list2: " + list2.getLength());
		System.out.println("length of list3: " + list3.getLength() + "\n");
		System.out.println("[ insert list2 to list1, 0th ]");
		list1.insertList(list2, 0);
		System.out.println();
		System.out.println("[ insert list2 to list1, 100th ]");
		list1.insertList(list2, 100);
		System.out.println();
		System.out.println("[ insert list3 to list1, 1st ]");
		list1.insertList(list3, 1);
		System.out.println();

		System.out.println("[ insert list2 to list1, 3rd ]");
		list1.insertList(list2, 3);
		list1.printAll();
		System.out.println("length of list1: " + list1.getLength());
	}
}
