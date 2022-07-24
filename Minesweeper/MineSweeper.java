import java.util.Random;

import jdk.dynalink.linker.GuardedInvocation;

interface MineSweeperGUI {
    public void setTextToTile(int x, int y, String text);

    public void win();

    public void lose();
}

public class MineSweeper {

    private final int height;
    private final int width;
    private final int numberOfTiles;
    private final int numberOfBombs;
    private final int[][] table;
    private int RemainTile;

    public MineSweeper(int height, int width, int numberOfBombs) {
        this.height = height;
        this.width = width;
        this.numberOfTiles = height * width;
        this.numberOfBombs = numberOfBombs;
        this.table = new int[height][width];
        this.RemainTile = numberOfTiles - numberOfBombs;

        initTable();
    }

    public int getHeight() {
        return height;
    }

    public int getWidth() {
        return width;
    }

    void initTable() {
        setBombs();

        /* ----- ここから実装してください． ----- */
    }

    void setBombs() {
        /* ----- ここから実装してください． ----- */
        Random ranndom = new Random();
        for (int i = 0; i < this.numberOfBombs; i++) {
            int y = ranndom.nextInt(this.height);
            int x = ranndom.nextInt(this.width);
            if (this.checkBombs(x, y) == false) {
                i--;
                continue;
            }
            this.table[y][x] = -1;
            System.out.println(y + " " + x);
        }
    }

    public void openTile(int x, int y, MineSweeperGUI gui) {
        /* ----- ここから実装してください． ----- */
        if (this.table[y][x] <= 9) {
            if (this.checkBombs(x, y) == false) {
                gui.lose();
                this.openAllTiles(gui);
            }
            int count = 0;
            // y>0の時
            if (y != 0) {
                if (checkBombs(x, y - 1) == false) {
                    count++;
                }
                if (x != 0) {
                    if (checkBombs(x - 1, y) == false) {
                        count++;
                    }
                    if (checkBombs(x - 1, y - 1) == false) {
                        count++;
                    }
                }
                if (x != width - 1) {
                    if (checkBombs(x + 1, y) == false) {
                        count++;
                    }
                    if (checkBombs(x + 1, y - 1) == false) {
                        count++;
                    }
                }
                if (y != height - 1) {
                    if (checkBombs(x, y + 1) == false) {
                        count++;
                    }
                    if (x != 0) {
                        if (checkBombs(x - 1, y + 1) == false) {
                            count++;
                        }
                    }
                    if (x != width - 1) {
                        if (checkBombs(x + 1, y + 1) == false) {
                            count++;
                        }
                    }
                }
            }
            // y=0の時
            if (y == 0) {
                if (x != 0) {
                    if (checkBombs(x - 1, y) == false) {
                        count++;
                    }
                }
                if (x != width - 1) {
                    if (checkBombs(x + 1, y) == false) {
                        count++;
                    }
                }
                if (checkBombs(x, y + 1) == false) {
                    count++;
                }
                if (x != 0) {
                    if (checkBombs(x - 1, y + 1) == false) {
                        count++;
                    }
                }
                if (x != width - 1) {
                    if (checkBombs(x + 1, y + 1) == false) {
                        count++;
                    }
                }
            }
            String Count = Integer.toString(count);
            gui.setTextToTile(x, y, Count);
        }
        this.RemainTile--;
        if (this.RemainTile == 0) {
            gui.win();
        }
    }

    public void setFlag(int x, int y, MineSweeperGUI gui) {
        /* ----- ここから実装してください． ----- */
        if (this.table[y][x] >= 9) {
            gui.setTextToTile(x, y, null);
            this.table[y][x] -= 10;
        } else {
            this.table[y][x] += 10;
            gui.setTextToTile(x, y, "F");
        }
    }

    private void openAllTiles(MineSweeperGUI gui) {
        /* ----- ここから実装してください． ----- */
        for (int y = 0; y < height; y++) {
            for (int x = 0; x < width; x++) {
                if (this.table[y][x] == -1) {
                    gui.setTextToTile(x, y, "-1");
                } else {
                    int count = 0;
                    // y<0の時
                    if (y != 0) {
                        if (checkBombs(x, y - 1) == false) {
                            count++;
                        }
                        if (x != 0) {
                            if (checkBombs(x - 1, y) == false) {
                                count++;
                            }
                            if (checkBombs(x - 1, y - 1) == false) {
                                count++;
                            }
                        }
                        if (x != width - 1) {
                            if (checkBombs(x + 1, y) == false) {
                                count++;
                            }
                            if (checkBombs(x + 1, y - 1) == false) {
                                count++;
                            }
                        }
                        if (y != height - 1) {
                            if (checkBombs(x, y + 1) == false) {
                                count++;
                            }
                            if (x != 0) {
                                if (checkBombs(x - 1, y + 1) == false) {
                                    count++;
                                }
                            }
                            if (x != width - 1) {
                                if (checkBombs(x + 1, y + 1) == false) {
                                    count++;
                                }
                            }
                        }
                    }
                    // y=0の時
                    if (y == 0) {
                        if (x != 0) {
                            if (checkBombs(x - 1, y) == false) {
                                count++;
                            }
                        }
                        if (x != width - 1) {
                            if (checkBombs(x + 1, y) == false) {
                                count++;
                            }
                        }
                        if (checkBombs(x, y + 1) == false) {
                            count++;
                        }
                        if (x != 0) {
                            if (checkBombs(x - 1, y + 1) == false) {
                                count++;
                            }
                        }
                        if (x != width - 1) {
                            if (checkBombs(x + 1, y + 1) == false) {
                                count++;
                            }
                        }
                    }
                    String Count = Integer.toString(count);
                    gui.setTextToTile(x, y, Count);
                }
            }
        }
    }

    // 指定されたタイルに爆弾があればfalseを返す
    public boolean checkBombs(int x, int y) {
        if (this.table[y][x] == -1) {
            return false;
        }
        return true;
    }

}