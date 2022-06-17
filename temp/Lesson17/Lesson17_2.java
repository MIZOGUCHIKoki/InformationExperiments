public class Lesson17_2 {
	public static void main(String[] args) {
		SimpleLinkedList list = new SimpleLinkedList();
		list.insert(1, "E");
		list.insert(1, "D");
		list.insert(1, "C");
		list.insert(1, "B");
		list.insert(1, "A");
		list.printAll();

		System.out.println("Length : " + list.getLength());
		System.out.println();

		System.out.println("------insert------");
		list.append("F");
		list.printAll();

		System.out.println("Length : " + list.getLength());
	}
}
