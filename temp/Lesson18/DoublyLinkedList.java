public class DoublyLinkedList {
  private DoublyElement firstElement;
  private DoublyElement lastElement;
  private int length;

  public DoublyLinkedList() {
    this.firstElement = new DoublyElement(null);
    this.lastElement = new DoublyElement(null);
    this.firstElement.setNextElement(this.lastElement);
    this.lastElement.setPreviousElement(this.firstElement);
    this.length = 0;
  }

  public Object get(int index) {
    // index 番目のデータを取りだす
    DoublyElement element = this.getElement(index);
    if (null == element) {
      System.out.println("Not exist: " + index);
      return null;
    }
    return element.getData();
  }

  public boolean insert(int index, Object obj) {
    // index 番目にobjを格納した要素を挿入
    if (index < 1) {
      System.out.println("Cannot insert: " + index);
      return false;
    }
    DoublyElement previous = this.getElement(index - 1);// index-1 番目をprevisouに入れる
    if (previous == null) {
      System.out.println("Cannot insert: " + index);// index - 1 がNULLならできない
      return false;
    }
    this.length++;
    DoublyElement element = new DoublyElement(obj); // elementを作成
    element.setNextElement(previous.getNextElement()); // elementの次 をpreviousの次に指定
    previous.getNextElement().setPreviousElement(element);// previousの次の要素の前をelementに指定
    previous.setNextElement(element); // previousの次 をelementに指定
    element.setPreviousElement(previous); // elementの前 をpreviousに指定
    return true;

  }

  public boolean remove(int index) {
    // index 番目の要素を削除
    if (index < 1) {
      System.out.println("Connot remove: " + index);
      return false;
    }
    DoublyElement removeElement = this.getElement(index);
    if (removeElement == null) {
      System.out.println("Cannot remove: " + index);
      return false;
    }

    this.length--;
    DoublyElement previous = this.getElement(index - 1);// previousにindex - 1を指定
    previous.setNextElement(removeElement.getNextElement());// previousの次にremoveの次を指定
    removeElement.getNextElement().setPreviousElement(previous);// removeの次の前にpreviousを指定
    removeElement.setNextElement(null);// 次を切断
    removeElement.setPreviousElement(null);// 前を切断
    return true;

  }

  private DoublyElement getElement(int index) {
    // index 番目の要素を取得
    DoublyElement currentElement = this.firstElement;
    for (int count = 0; count < index; count++) {
      currentElement = currentElement.getNextElement();
      if (currentElement == this.lastElement) {
        return null;
      }
    }
    return currentElement;
  }

  public void printAll() {
    DoublyElement currentElement = this.firstElement.getNextElement();
    while (currentElement != this.lastElement) {
      System.out.println(currentElement);
      currentElement = currentElement.getNextElement();

      if (currentElement != this.lastElement) {
        System.out.println("<->");
      }
    }
    System.out.println();
  }

  public void printAllReverse() {
    DoublyElement currentElement = this.lastElement.getPreviousElement();
    while (currentElement != this.firstElement) {
      System.out.println(currentElement);
      currentElement = currentElement.getPreviousElement();
      if (currentElement != this.firstElement) {
        System.out.println("<->");
      }
    }
    System.out.println();
  }

  public int getLength() {
    return this.length;
  }

  public int searchForward(Object obj) {
    DoublyElement currentElement = this.firstElement.getNextElement();
    int i = 1;
    while (currentElement != lastElement) {
      if (currentElement.getData().equals(obj)) {
        return i;
      }
      currentElement = currentElement.getNextElement();
      i++;
    }
    return -1;
  }

  public int searchBackward(Object obj) {
    DoublyElement currentElement = this.lastElement.getPreviousElement();
    int i = getLength();
    while (currentElement != firstElement) {
      if (currentElement.getData().equals(obj)) {
        return i;
      }
      currentElement = currentElement.getPreviousElement();
      i--;
    }
    return -1;
  }

  public boolean removeFromFirst(Object obj) {
    return this.remove(this.searchForward(obj));
  }

  public boolean removeFromLast(Object obj) {
    return this.remove(this.searchBackward(obj));
  }

  public DoublyLinkedList split(int index) {
    if (index < 1 || index > this.getLength()) {
      return null;
    }
    DoublyLinkedList DLL = new DoublyLinkedList();
    // DLL.firstElement.setNextElement(this.getElement(index));
    // DLL.lastElement.setPreviousElement(this.lastElement.getPreviousElement());
    // DLL.lastElement.setPreviousElement();
    return DLL;
  }
}
