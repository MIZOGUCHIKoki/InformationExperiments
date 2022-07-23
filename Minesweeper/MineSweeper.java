interface MineSweeperGUI {
  public void setTextToTile(int x, int y, String text);
  public void win();
  public void lose();
}

public class MineSweeper {
  private final int height;
  private final int width;
  private final int numTile;
  private final int numMine;
  private final int[][] table;

  public MineSweeper(int height, int width, int numMine) {
    this.height = height;
    this.width = width;
    this.numTile = height * width;
    this.numMine = numMine;
    this.table = new int [height][width];

    initTable();
  }

  public int getHeight() {
    return height;
  }

  public int getWidth() {
    return width;
  }

  void initTable() {
    setMine();

    /* ----- add implementation here ----- */
  }

  void setMine() {
    /* ----- add implementation here ----- */
  }

  public void openTile(int x, int y, MineSweeperGUI gui) {
    /* ----- add implementation here ----- */
  }

  public void setFlag(int x, int y, MineSweeperGUI gui) {
    /* ----- add implementation here ----- */
  }

  public void openAllTiles(MineSweeperGUI gui) {
    /* ----- add implementation here ----- */
  }
}
