public class DoublyElement {
  private Object data;
  private DoublyElement next, previous;
  private DoublyElement () {
  }
  public DoublyElement (Object obj) {
    this.data = obj;
  }
  public Object getData() {
    return this.data;
  }
  public DoublyElement getNextElement() {
    return this.next;
  }
  public void setNextElement(DoublyElement nextElement) {
    this.next = nextElement;
  }

  public DoublyElement getPreviousElement() {
    return this.previous;
  }

  public void  setPreviousElement(DoublyElement previousElement) {
    this.previous = previousElement;
  }

  public String toString() {
    return this.data.toString();
  }

}
