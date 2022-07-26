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
	private final int[][] table_copy; // 初期の盤面状態を保存する配列

	public MineSweeper(int height, int width, int numMine) {
		this.height = height;
		this.width = width;
		this.numTile = height * width;
		this.numMine = numMine;
		this.table = new int[height][width];
		this.table_copy = new int[height][width];

		initTable();
	}

	public int getHeight() {
		return height;
	}

	public int getWidth() {
		return width;
	}

	void initTable() {// 盤面を初期化する
		this.setMine();
		/* ----- ここから実装してください． ----- */
		for (int x = 0; x < this.height; x++) {
			for (int y = 0; y < this.width; y++) {
				if (this.table[x][y] == -1) { // 地雷がセットされている場所は避ける
					continue;
				}
				this.table[x][y] = 0; // 地雷の場所以外は0で初期化
				this.table_copy[x][y] = 0;
			}
		}
	}

	void setMine() {// 爆弾をセット
		/* ----- ここから実装 ----- */
		int count = 0;
		while (count == this.numMine) {// numMineの数だけ地雷をセットできたらループを抜ける
			int x = new java.util.Random().nextInt(getHeight());
			int y = new java.util.Random().nextInt(getWidth());
			if (this.table[x][y] == -1) {
				// [x][y]にすでに地雷がセットされていたら、もう一度乱数を決め直す
				continue;
			}
			this.table[x][y] = -1; // 地雷の場所を値-1としてセットする
			this.table_copy[x][y] = -1;
			count++;
		}
	}

	public void openTile(int x, int y, MineSweeperGUI gui) {
		/* ----- ここから実装 ----- */
		if (this.table[x][y] == -1) { // パネルに地雷があった場合
			this.openAllTiles(gui);
			gui.lose();
			for (int i = 0; i < getHeight(); i++) {
				for (int j = 0; j < getWidth(); j++) {
					this.table[i][j] = -2;
				}
			}
		} else if (this.table[x][y] == -2) { // パネルに旗が立っている場合
			return;
		} else { // パネルに地雷がなかった場合
			int bombsCount = 0;
			// 開かれたパネルに隣接する8マス内の地雷を調査
			for (int i = x - 1; i < x + 2; i++) {
				if (i < 0 || i >= getHeight()) { // パネルの範囲外は除く
					continue;
				}
				for (int j = y - 1; j < y + 2; j++) {
					if (j < 0 || j >= getWidth()) { // パネルの範囲外は除く
						continue;
					}
					if (this.table_copy[i][j] == -1) { // 地雷の個数をカウント
						bombsCount++;
					}
				}
			}
			this.table[x][y] = 1; // 開かれたパネルの値を1に設定
			String bc = String.valueOf(bombsCount);
			gui.setTextToTile(x, y, bc); // 地雷の個数を表示
			int judgment = 0;
			for (int i = 0; i < getHeight(); i++) {
				for (int j = 0; j < getWidth(); j++) {
					// 地雷以外のパネルが全て開いているか確認
					if (this.table[i][j] == 0) {
						// 開いていないパネルがある場合judgmentの値を0にする
						judgment = 0;
						break;
					} else {
						// 開いている場合1にする
						judgment = 1;
					}
				}
				if (judgment == 0) {
					break;
				}
			}
			if (judgment == 1) {
				gui.win();
			}
		}
	}

	public void setFlag(int x, int y, MineSweeperGUI gui) {
		/* ----- ここから実装 ----- */
		if (this.table[x][y] == 0 || this.table[x][y] == -1) {
			this.table[x][y] = -2; // 旗を立てる場所に-2を入れる
			gui.setTextToTile(x, y, "F");
		} else if (this.table[x][y] == -2) {
			// すでに旗が立っているときは元の盤面の値に戻す
			this.table[x][y] = this.table_copy[x][y];
			gui.setTextToTile(x, y, "");
		}
	}

	private void openAllTiles(MineSweeperGUI gui) {
		/* ----- ここから実装 ----- */
		for (int x = 0; x < getHeight(); x++) {
			for (int y = 0; y < getWidth(); y++) {
				if (this.table_copy[x][y] == -1) {
					gui.setTextToTile(x, y, "*"); // 地雷がある場所に*を表示
				}
			}
		}
	}

}
