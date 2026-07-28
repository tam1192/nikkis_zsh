#!/bin/sh
set -e

BORDER="------------------------------------------------------------------------------"

# 第1引数はファイルパス（必須）
FILE_PATH="$1"
shift 1

if [ ! -f "${FILE_PATH}" ]; then
    echo "Error: File '${FILE_PATH}' not found." >&2
    exit 1
fi

# ファイルパスから自動でファイル名を取得
FILE_NAME=$(basename "${FILE_PATH}")

# ヘッダーの組み立て
HEADER="# ${BORDER}\n"
HEADER="${HEADER}# ( ${FILE_PATH} )\n"
HEADER="${HEADER}# file: ${FILE_NAME}\n"

# 第2引数以降を k/v ペアとしてループ処理
while [ $# -gt 0 ]; do
    key="$1"
    if [ $# -ge 2 ]; then
        val="$2"
        shift 2
    else
        val=""
        shift 1
    fi

    HEADER="${HEADER}# ${key}: ${val}\n"
done

HEADER="${HEADER}# ${BORDER}"

# 1. ヘッダーを出力 (%b で \n を改行に展開)
printf "%b\n" "${HEADER}"

# 2. ファイルの中身を出力
cat "${FILE_PATH}"
