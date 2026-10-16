#!/usr/bin/env bash
set -e

# 定位脚本所在仓库根目录
ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
OUTPUT_FILE="${ROOT_DIR}/folders_Aa.txt"

# 提取一级可见文件夹，使用 LC_ALL=C sort -f 实现不区分大小写的字母排序
find "${ROOT_DIR}" -mindepth 1 -maxdepth 1 -type d ! -name ".*" -printf "%f\n" | LC_ALL=C sort -f > "${OUTPUT_FILE}"

echo "Folders successfully exported to ${OUTPUT_FILE} (case-insensitive)"
