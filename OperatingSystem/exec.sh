#!/bin/bash

# 出力ファイルのパス
output_file="output.txt"
target="ex1.c"
executable="a.out"

# スクリプトのディレクトリに移動
script_dir=$(dirname "$0")
cd "$script_dir"

# ファイルが存在する場合は削除
if [ -e "$output_file" ]; then
    rm "$output_file"
fi

# コンパイル
if gcc "$target"; then
    echo "コンパイルが成功しました。"
		
    # 10回繰り返す
    for ((i=1; i<=10; i++)); do
		echo "===RUN$i==="
        # コマンドの実行
		./a.out
		sleep 1
    done
else
    echo "コンパイルエラーが発生しました。"
fi
