public class SimpleLinkedList {
  private Element firstElement;
  private int length;

  public SimpleLinkedList() {
    this.firstElement = new Element(null);
    this.length = 0;
  }

  public Object get(int index) {
    // index 番目のデータを取り出す
    Element element = this.getElement(index);
    // 指定された場所にElementオブジェクトがあるか調べる
    if (null == element) {
      System.out.println("Element-" + index + "is not exist.");
      return null;
    }
    return element.getData();
  }

  public boolean insert(int index, Object obj) {
    // index 番目にobjを挿入
    // 指定した場所が正しいかどうか
    if (index < 1) {
      System.out.println("Cannot insert: " + index);
      return false;
    }
    Element previous = this.getElement(index - 1);
    if (previous == null) {
      System.out.println("Cannot insert: " + index);
      return false;
    }
    this.length++;
    Element element = new Element(obj);
    element.setNextElement(previous.getNextElement());
    previous.setNextElement(element);
    return true;

  }

  public boolean remove(int index) {
    // index 番目の要素を削除
    if (index < 1) {
      System.out.println("Cannnot remove: " + index);
      return false;
    }
    Element removeElement = this.getElement(index);
    if (removeElement == null) {
      System.out.println("Cannnot remove: " + index);
      return false;
    }
    this.length--;
    Element previous = this.getElement(index - 1);
    previous.setNextElement(removeElement.getNextElement());
    removeElement.setNextElement(null);
    return true;
  }

  private Element getElement(int index) {
    // index 番目の要素を取得
    Element currentElement = this.firstElement;
    // 指定された場所まで先頭から順番に移動する
    for (int count = 0; count < index; count++) {
      // リスとの最後まで到達
      if (null == currentElement) {
        return null;
      }
      // 次の要素へ移動
      currentElement = currentElement.getNextElement();
    }
    return currentElement;
  }

  public void printAll() {
    int count = 0;
    Element currentElement = this.firstElement.getNextElement();
    while (currentElement != null) {
      count++;
      System.out.println(count + " : " + currentElement);
      currentElement = currentElement.getNextElement();
    }
    System.out.println();
  }

  public int getLength() {
    return this.length;
  }

  public boolean append(Object obj) {
    return this.insert(this.length + 1, obj);
  }

  public int search(Object obj) {
    for (int i = 1; i < length; i++) {
      if (getElement(i).getData().equals(obj)) {
        return i;
      }
    }
    System.out.println("Not found " + obj);
    return -1;
  }

  public boolean remove(Object obj) {
    if (this.search(obj) != -1) {
      this.remove(this.search(obj));
      return true;
    }
    System.out.println("Cannot remove " + obj);
    return false;
  }

  public boolean insertList(SimpleLinkedList list, int index) {
    if (index > this.getLength()) {
      System.out.println("Cannot insert List : index out of bounds");
      return false;
    }
    if (list.getElement(index) == null || index <= 0) {
      System.out.println("Cannot insert List : insert list is empty");
      return false;
    }
    for (int i = index, j = 1; i < index + list.getLength(); i++, j++) {
      this.insert(index, list.getElement(j).getData());
    }
    return true;
  }

  public boolean cut(int from, int to) {
    if (from <= 0) {
      System.out.println("Cannot cut list: from is smaller than 1");
      return false;
    }
    if (from > to) {
      System.out.println("Cannot cut list: from is bigger than \"to\"");
      return false;
    }
    if (this.getLength() < from || this.getLength() < to) {
      System.out.println("Cannot cut list: index out of bounds");
      return false;
    }

    Element previous = this.getElement(from - 1);
    Element nextElement = this.getElement(to + 1);
    previous.setNextElement(nextElement);
    length -= to - from + 1;
    return true;
  }

  public boolean stringListSort() {
    SimpleLinkedList sortedList = new SimpleLinkedList();// ソート後のリスト
    int num = 1;
    int times = this.getLength();

    for (int j = 0; j < times; j++) {
      Element smallest = this.getElement(1);
      for (int i = 1; i <= this.getLength(); i++) {
        Element element = this.getElement(i);
        String s = (String) smallest.getData();
        String s2 = (String) element.getData();
        if (s2.compareTo(s) <= 0) {
          smallest = element;
          num = i;
        }
      }
      this.remove(num);
      sortedList.append(smallest);
    }
    this.insertList(sortedList, 1);
    return true;
  }
}
